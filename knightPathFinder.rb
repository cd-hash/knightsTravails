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
        debugger
        possibleMoves = self.class.validMoves(posArray)
        possibleMoves = possibleMoves.select do |move|
            @consideredPositions.any? {|ele| ele != move}
        end
        possibleMoves.each {|move| @consideredPositions << move}
        return possibleMoves
    end

    def findPath(finalPosition)
    end

    def buildMoveTree()
        #use  FIFO node creation method
        queue = [@rootNode]
        #possibleMoves = newMovePositions(@rootNode.value)
        debugger
        until queue.empty?
            moveNode = queue.pop()
            possibleMoves = newMovePositions(moveNode.value)
            possibleMoves.each_index do |index|
                possibleMoves[index] = PolyTreeNode.new(possibleMoves[index])
                moveNode.add_child(possibleMoves[index])
            end
            possibleMoves.each {|node| queue.unshift(node)}
        end
    end
end