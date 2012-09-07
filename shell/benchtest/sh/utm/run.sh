#!/bin/bash
# auto run regular benchmark test
# When user press Ctrl+C then clear the environment

function RunAT6()
{
	# Config Running Environment    ---- env.sh
	AT6_UTM
#	AT8_Red_UTM
	
	# Run Test
#	RunUTM25_Test $1
#	RunUTM25_T $1
	RunUTM25_Stable $1

	# Finish Run, Save results of the whole test.
	FinishTest
}

function RunAT8()
{
	# Config Running Environment    ---- env.sh
	AT8_White_UTM
	
	# Run Test
	RunUTM25_Test $1
#	RunUTM25_T $1
#	RunUTM_Stable $1

	# Finish Run, Save results of the whole test.
	FinishTest
}

function RunStable()
{
	# Config Running Environment    ---- env.sh
	AT6_UTM
	
	# Run Test
#	RunUTM_Test $1
#	RunUTM_T $1
	RunUTM_Stable $1

	# Finish Run, Save results of the whole test.
	FinishTest
}

function RunAllAtAT7()
{
	# Config Running Environment    ---- env.sh
	AT7_UTM
#	AT8_Red_UTM
	
	# Run Test
	RunUTM_Test $1
#	RunUTM_T $1
#	RunUTM_Stable $1

	# Finish Run, Save results of the whole test.
	FinishTest
}





