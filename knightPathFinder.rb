require 'byebug'
require_relative './polyTree.rb'

class KnightPathFinder
    def self.validMoves(posArray)
        moveList = {'upLeft' => [-1,-2], 'upRight' => [1,-2],
        'leftUp' => [-2,-1], 'rightUp' => [2,-1], 'downLeft' => [-1,2], 'downRight' => [1,2],
        'leftDown' => [-2,1], 'rightDown'=> [2,1]}
        validMoves = []
        for move in moveList.keys
            xCoord, yCoord = posArray
            xCoord += moveList[move][0]
            yCoord += moveList[move][1]
            if xCoord < 0 || xCoord > 7 || yCoord < 0 || yCoord > 7
                next
            else
                validMoves << [xCoord, yCoord]
            end
        end
        return validMoves
    end

    attr_reader :consideredPositions

    def initialize(startingPosition)
        @startingPosition = startingPosition
        @rootNode = PolyTreeNode.new(startingPosition)
        @consideredPositions = [startingPosition]
    end

    def newMovePositions(posArray)
        # debugger
        possibleMoves = self.class.validMoves(posArray)
        possibleMoves.select! do |node|
            !@consideredPositions.include?(node)
        end
        possibleMoves.each {|move| @consideredPositions << move}
        return possibleMoves
    end

    def findPathBFS(finalPosition)
        #first implementation using BFS
        queue = [@rootNode]
        until queue.empty?
            currentNode = queue.pop()
            if currentNode.value == finalPosition
                return tracePathBack(currentNode)
            else
                currentNode.children.each do |child|
                    queue.unshift(child)
                end
            end
        end
    end

    def tracePathBack(finalNode)
        #take the final node as a param and follow parent line back to root to show path
        currentNode = finalNode.parent
        path = [finalNode.value]
        while currentNode && currentNode.parent
            # debugger
            path.unshift(currentNode.value)
            currentNode = currentNode.parent
            if !currentNode.parent
                path.unshift(currentNode)
            end
        end
        return path
    end

    def buildMoveTree()
        #use  FIFO node creation method
        queue = [@rootNode]
        #possibleMoves = newMovePositions(@rootNode.value)
        # debugger
        until queue.empty?
            moveNode = queue.pop()
            possibleMoves = newMovePositions(moveNode.value)
            possibleMoves.each_index do |index|
                possibleMoves[index] = PolyTreeNode.new(possibleMoves[index])
                moveNode.add_child(possibleMoves[index])
            end
            possibleMoves.each {|node| queue.unshift(node)}
        end
        return true
    end
end