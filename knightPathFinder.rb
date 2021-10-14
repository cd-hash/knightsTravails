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

    def initialize(startingPosition)
        @startingPosition = startingPosition
        @rootNode = PolyTreeNode.new(startingPosition)
        @consideredPositions = [startingPosition]
    end

    def newMovePositions(posArray)
        #debugger
        possibleMoves = self.class.validMoves(posArray)
        possibleMoves = possibleMoves.select do |move|
            @consideredPositions.any? {|ele| ele != move}
        end
        return possibleMoves
    end

    def findPath(finalPosition)
    end

    def buildMoveTree()
        #use  FIFO node creation method
        queue = []
        possibleMoves = newMovePositions(@rootNode.value)
        possibleMoves.each {|node| queue.unshift(node)}
        until queue.empty?
            moveNode = queue.pop()
            node = PolyTreeNode.new(moveNode)
            node.parent = # how do i call the previous parent?
            possibleMoves = newMovePositions(node.value)
        end
    end
end