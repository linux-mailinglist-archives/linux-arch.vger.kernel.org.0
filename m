Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F41D0F59
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgEMKJb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgEMKJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:09:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF1C061A0C;
        Wed, 13 May 2020 03:09:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so20098309wrx.10;
        Wed, 13 May 2020 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+GjY72yA1xPGwnDbUNI8eLmRDugqmcvDfX06Ol9JGdg=;
        b=DDBZrC6nw7sl8U5W6rO2kKDJVkq0Rj8nt64GVIuCuLgI2Ia8cgv3m/P8J4ZbUx5Hsy
         eofjYRiC40PWZg9IcxzP3CWEoob6vpG3gzYDWYQNA5XXNDmD5qSLZ95Yv6+GewD6XDqQ
         wQNm0ysNBms53VpW5cMgTZ9p+UXw+h3IYkdVajZRA/LEw8I6h9+ng/MTKsm1tLKt3X/E
         0qnlSC09UBmKZsnsTdQcQ+aOf72gKa/qFY+U6n5QVwCAqL0+rye6w3sSgCM9I5uQ0Rez
         oUbG5F4ItfSlaidHQYrCdXhuVJnLZ+TEtOF+O2NuXT2kedFkPgMiojlSN3yvQoW/xoyO
         Vcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GjY72yA1xPGwnDbUNI8eLmRDugqmcvDfX06Ol9JGdg=;
        b=qUiPWXYmvFzs+MuDKrWwNtpPAUgczB3tmlut99HuiTedsVGaV1Sei94ofryIJi2QcR
         5mIkW1mNlWdqPtzU9wX0tuftKa+zNBs4vcwYnfnCWh3aXFjiv2UYKN0Oqm1A0ouDC/Jq
         tk8VB3mVBL5rqcJdusntXNzBD9hLg46SP+NfBOqwAOA1CdcSYooeKhadOEBEzYx8769J
         3m6C3lw6K7+ecRDLAmHO5dOKrAjrS5C1hIgu6pCQ4Oui5N0P1tT4UOXDlbAbpGxG7RZ/
         qEbM9yQrq0KH+VdFRxsGiUj+Zp3h9tEakCiwZsPscsy9botphV02Mvvd/qwqmUTuGHg1
         cCWg==
X-Gm-Message-State: AGi0PubUSTp/P5+spiDBtN6tJVSIgeas64sbWG1ERKMEhl1N6GtTt5oV
        lzRsQYvmo9V9907GLHiG+lU9Gc7Y
X-Google-Smtp-Source: APiQypLl/9H8IiSaNNGBhPLPWFimQZnlEOO2PRCYwukvlQXJayB1ovAAcazK/uXzaluUbZSePYST6g==
X-Received: by 2002:adf:e489:: with SMTP id i9mr22006059wrm.373.1589364568580;
        Wed, 13 May 2020 03:09:28 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id j1sm14949741wrm.40.2020.05.13.03.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:09:28 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] prctl.2: srcfix add comments for navigation
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
Date:   Wed, 13 May 2020 12:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> The prctl.2 source is unnecessarily hard to navigate, not least
> because prctl option flags are traditionally named PR_* and so look
> just like prctl names.
> 
> For each actual prctl, add a comment of the form
> 
> 	.\" prctl PR_FOO
> 
> to make it move obvious where each top-level prctl starts.
> 
> Of course, we could add some clever macros, but let's not confuse
> dumb parsers.

A patch like this, which makes sweeping changes across the page,
should be best placed at the end of a series, I think.
The reason is that if I fail to apply this patch (and I am a
little dubious about it), then probably the rest of the patches
in the series won't apply. (Furthermore, it also forced me to
apply patch 02 already, which I wanted to reflect on a little.)

That said, I'll apply it, so that the remaining patches
apply cleanly. I'll consider later whether to keep this
change. For example, I wonder if a visually distinctive 
source line that is always the same would be better than
these comments that repeat the PR_* names. For example, 
something like

.\" ==========================

I'll circle back to this later.

Thanks,

Michael


> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 9736434..e5b2b4b 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -77,6 +77,7 @@ is called with a first argument describing what to do
>  arguments with a significance depending on the first one.
>  The first argument can be:
>  .\"
> +.\" prctl PR_CAP_AMBIENT
>  .TP
>  .BR PR_CAP_AMBIENT " (since Linux 4.3)"
>  .\" commit 58319057b7847667f0c9585b9de0e8932b0fdb08
> @@ -130,6 +131,7 @@ library in the form of
>  .BR cap_set_ambient (3),
>  and
>  .BR cap_reset_ambient (3).
> +.\" prctl PR_CAPBSET_READ
>  .TP
>  .BR PR_CAPBSET_READ " (since Linux 2.6.25)"
>  Return (as the function result) 1 if the capability specified in
> @@ -152,6 +154,7 @@ A higher-level interface layered on top of this operation is provided in the
>  .BR libcap (3)
>  library in the form of
>  .BR cap_get_bound (3).
> +.\" prctl PR_CAPBSET_DROP
>  .TP
>  .BR PR_CAPBSET_DROP " (since Linux 2.6.25)"
>  If the calling thread has the
> @@ -178,6 +181,7 @@ A higher-level interface layered on top of this operation is provided in the
>  .BR libcap (3)
>  library in the form of
>  .BR cap_drop_bound (3).
> +.\" prctl PR_SET_CHILD_SUBREAPER
>  .TP
>  .BR PR_SET_CHILD_SUBREAPER " (since Linux 3.4)"
>  .\" commit ebec18a6d3aa1e7d84aab16225e87fd25170ec2b
> @@ -224,11 +228,13 @@ Some
>  frameworks (e.g.,
>  .BR systemd (1))
>  employ a subreaper process for similar reasons.
> +.\" prctl PR_GET_CHILD_SUBREAPER
>  .TP
>  .BR PR_GET_CHILD_SUBREAPER " (since Linux 3.4)"
>  Return the "child subreaper" setting of the caller,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_DUMPABLE
>  .TP
>  .BR PR_SET_DUMPABLE " (since Linux 2.3.20)"
>  Set the state of the "dumpable" attribute,
> @@ -297,6 +303,7 @@ the ownership of files in the process's
>  .IR /proc/[pid]
>  directory is affected as described in
>  .BR proc (5).
> +.\" prctl PR_GET_DUMPABLE
>  .TP
>  .BR PR_GET_DUMPABLE " (since Linux 2.3.20)"
>  Return (as the function result) the current state of the calling
> @@ -304,6 +311,7 @@ process's dumpable attribute.
>  .\" Since Linux 2.6.13, the dumpable flag can have the value 2,
>  .\" but in 2.6.13 PR_GET_DUMPABLE simply returns 1 if the dumpable
>  .\" flags has a nonzero value.  This was fixed in 2.6.14.
> +.\" prctl PR_SET_ENDIAN
>  .TP
>  .BR PR_SET_ENDIAN " (since Linux 2.6.18, PowerPC only)"
>  Set the endian-ness of the calling process to the value given
> @@ -314,11 +322,13 @@ in \fIarg2\fP, which should be one of the following:
>  or
>  .B PR_ENDIAN_PPC_LITTLE
>  (PowerPC pseudo little endian).
> +.\" prctl PR_GET_ENDIAN
>  .TP
>  .BR PR_GET_ENDIAN " (since Linux 2.6.18, PowerPC only)"
>  Return the endian-ness of the calling process,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_FP_MODE
>  .TP
>  .BR PR_SET_FP_MODE " (since Linux 4.0, only on MIPS)"
>  .\" commit 9791554b45a2acc28247f66a5fd5bbc212a6b8c8
> @@ -425,6 +435,7 @@ The arguments
>  and
>  .IR arg5
>  are ignored.
> +.\" prctl PR_GET_FP_MODE
>  .TP
>  .BR PR_GET_FP_MODE " (since Linux 4.0, only on MIPS)"
>  Return (as the function result)
> @@ -442,6 +453,7 @@ The arguments
>  and
>  .IR arg5
>  are ignored.
> +.\" prctl PR_SET_FPEMU
>  .TP
>  .BR PR_SET_FPEMU " (since Linux 2.4.18, 2.5.9, only on ia64)"
>  Set floating-point emulation control bits to \fIarg2\fP.
> @@ -452,11 +464,13 @@ to silently emulate floating-point operation accesses, or
>  to not emulate floating-point operations and send
>  .B SIGFPE
>  instead.
> +.\" prctl PR_GET_FPEMU
>  .TP
>  .BR PR_GET_FPEMU " (since Linux 2.4.18, 2.5.9, only on ia64)"
>  Return floating-point emulation control bits,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_FPEXC
>  .TP
>  .BR PR_SET_FPEXC " (since Linux 2.4.21, 2.5.32, only on PowerPC)"
>  Set floating-point exception mode to \fIarg2\fP.
> @@ -470,11 +484,13 @@ Pass \fBPR_FP_EXC_SW_ENABLE\fP to use FPEXC for FP exception enables,
>  \fBPR_FP_EXC_NONRECOV\fP for async nonrecoverable exception mode,
>  \fBPR_FP_EXC_ASYNC\fP for async recoverable exception mode,
>  \fBPR_FP_EXC_PRECISE\fP for precise exception mode.
> +.\" prctl PR_GET_FPEXC
>  .TP
>  .BR PR_GET_FPEXC " (since Linux 2.4.21, 2.5.32, only on PowerPC)"
>  Return floating-point exception mode,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_KEEPCAPS
>  .TP
>  .BR PR_SET_KEEPCAPS " (since Linux 2.2.18)"
>  Set the state of the calling thread's "keep capabilities" flag.
> @@ -485,6 +501,7 @@ must be either 0 (clear the flag)
>  or 1 (set the flag).
>  The "keep capabilities" value will be reset to 0 on subsequent calls to
>  .BR execve (2).
> +.\" prctl PR_GET_KEEPCAPS
>  .TP
>  .BR PR_GET_KEEPCAPS " (since Linux 2.2.18)"
>  Return (as the function result) the current state of the calling thread's
> @@ -492,6 +509,7 @@ Return (as the function result) the current state of the calling thread's
>  See
>  .BR capabilities (7)
>  for a description of this flag.
> +.\" prctl PR_MCE_KILL
>  .TP
>  .BR PR_MCE_KILL " (since Linux 2.6.32)"
>  Set the machine check memory corruption kill policy for the calling thread.
> @@ -532,6 +550,7 @@ The policy is inherited by children.
>  The remaining unused
>  .BR prctl ()
>  arguments must be zero for future compatibility.
> +.\" prctl PR_MCE_KILL_GET
>  .TP
>  .BR PR_MCE_KILL_GET " (since Linux 2.6.32)"
>  Return (as the function result)
> @@ -539,6 +558,7 @@ the current per-process machine check kill policy.
>  All unused
>  .BR prctl ()
>  arguments must be zero.
> +.\" prctl PR_SET_MM
>  .TP
>  .BR PR_SET_MM " (since Linux 3.3)"
>  .\" commit 028ee4be34a09a6d48bdf30ab991ae933a7bc036
> @@ -716,6 +736,7 @@ This feature is available only if the kernel is built with the
>  .BR CONFIG_CHECKPOINT_RESTORE
>  option enabled.
>  .RE
> +.\" prctl PR_MPX_ENABLE_MANAGEMENT
>  .TP
>  .BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19) "
>  .\" commit fe3d197f84319d3bce379a9c0dc17b1f48ad358c
> @@ -791,6 +812,7 @@ had been called.
>  .IP
>  For further information on Intel MPX, see the kernel source file
>  .IR Documentation/x86/intel_mpx.txt .
> +.\" prctl PR_SET_NAME
>  .TP
>  .BR PR_SET_NAME " (since Linux 2.6.9)"
>  Set the name of the calling thread,
> @@ -819,6 +841,7 @@ in the buffer pointed to by
>  .IR "(char\ *) arg2" .
>  The buffer should allow space for up to 16 bytes;
>  the returned string will be null-terminated.
> +.\" prctl PR_SET_NO_NEW_PRIVS
>  .TP
>  .BR PR_SET_NO_NEW_PRIVS " (since Linux 3.5)"
>  Set the calling thread's
> @@ -862,6 +885,7 @@ For more information, see the kernel source file
>  before Linux 4.13).
>  See also
>  .BR seccomp (2).
> +.\" prctl PR_GET_NO_NEW_PRIVS
>  .TP
>  .BR PR_GET_NO_NEW_PRIVS " (since Linux 3.5)"
>  Return (as the function result) the value of the
> @@ -873,6 +897,7 @@ behavior.
>  A value of 1 indicates
>  .BR execve (2)
>  will operate in the privilege-restricting mode described above.
> +.\" prctl PR_SET_PDEATHSIG
>  .TP
>  .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
>  Set the parent-death signal
> @@ -922,11 +947,13 @@ or a binary that has associated capabilities (see
>  .BR capabilities (7));
>  otherwise, this value is preserved across
>  .BR execve (2).
> +.\" prctl PR_GET_PDEATHSIG
>  .TP
>  .BR PR_GET_PDEATHSIG " (since Linux 2.3.15)"
>  Return the current value of the parent process death signal,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_PTRACER
>  .TP
>  .BR PR_SET_PTRACER " (since Linux 3.4)"
>  .\" commit 2d514487faf188938a4ee4fb3464eeecfbdcf8eb
> @@ -959,6 +986,7 @@ For further information, see the kernel source file
>  (or
>  .IR Documentation/security/Yama.txt
>  before Linux 4.13).
> +.\" prctl PR_SET_SECCOMP
>  .TP
>  .BR PR_SET_SECCOMP " (since Linux 2.6.23)"
>  .\" See http://thread.gmane.org/gmane.linux.kernel/542632
> @@ -1035,6 +1063,7 @@ For further information, see the kernel source file
>  (or
>  .IR Documentation/prctl/seccomp_filter.txt
>  before Linux 4.13).
> +.\" prctl PR_GET_SECCOMP
>  .TP
>  .BR PR_GET_SECCOMP " (since Linux 2.6.23)"
>  Return (as the function result)
> @@ -1061,18 +1090,21 @@ field of the
>  file provides a method of obtaining the same information,
>  without the risk that the process is killed; see
>  .BR proc (5).
> +.\" prctl PR_SET_SECUREBITS
>  .TP
>  .BR PR_SET_SECUREBITS " (since Linux 2.6.26)"
>  Set the "securebits" flags of the calling thread to the value supplied in
>  .IR arg2 .
>  See
>  .BR capabilities (7).
> +.\" prctl PR_GET_SECUREBITS
>  .TP
>  .BR PR_GET_SECUREBITS " (since Linux 2.6.26)"
>  Return (as the function result)
>  the "securebits" flags of the calling thread.
>  See
>  .BR capabilities (7).
> +.\" prctl PR_GET_SPECULATION_CTRL
>  .TP
>  .BR PR_GET_SPECULATION_CTRL " (since Linux 4.17)"
>  Return (as the function result)
> @@ -1119,6 +1151,7 @@ and
>  .I arg5
>  arguments must be specified as 0; otherwise the call fails with the error
>  .BR EINVAL .
> +.\" prctl PR_SET_SPECULATION_CTRL
>  .TP
>  .BR PR_SET_SPECULATION_CTRL " (since Linux 4.17)"
>  .\" commit b617cfc858161140d69cc0b5cc211996b557a1c7
> @@ -1174,6 +1207,7 @@ call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
>  .IR Documentation/admin-guide/kernel-parameters.txt .
> +.\" prctl PR_SET_THP_DISABLE
>  .TP
>  .BR PR_SET_THP_DISABLE " (since Linux 3.15)"
>  .\" commit a0715cc22601e8830ace98366c0c2bd8da52af52
> @@ -1191,6 +1225,7 @@ The setting of the "THP disable" flag is inherited by a child created via
>  and is preserved across
>  .BR execve (2).
>  .\"
> +.\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP
>  .BR PR_TASK_PERF_EVENTS_DISABLE " (since Linux 2.6.31)"
>  Disable all performance counters attached to the calling process,
> @@ -1207,6 +1242,7 @@ Originally called
>  renamed (retaining the same numerical value)
>  in Linux 2.6.32.
>  .\"
> +.\" prctl PR_TASK_PERF_EVENTS_ENABLE
>  .TP
>  .BR PR_TASK_PERF_EVENTS_ENABLE " (since Linux 2.6.31)"
>  The converse of
> @@ -1220,11 +1256,13 @@ renamed
>  .\" commit cdd6c482c9ff9c55475ee7392ec8f672eddb7be6
>  in Linux 2.6.32.
>  .\"
> +.\" prctl PR_GET_THP_DISABLE
>  .TP
>  .BR PR_GET_THP_DISABLE " (since Linux 3.15)"
>  Return (as the function result) the current setting of the "THP disable"
>  flag for the calling thread:
>  either 1, if the flag is set, or 0, if it is not.
> +.\" prctl PR_GET_TID_ADDRESS
>  .TP
>  .BR PR_GET_TID_ADDRESS " (since Linux 3.5)"
>  .\" commit 300f786b2683f8bb1ec0afb6e1851183a479c86d
> @@ -1246,6 +1284,7 @@ system call does not have a compat implementation for
>  the AMD64 x32 and MIPS n32 ABIs,
>  and the kernel writes out a pointer using the kernel's pointer size,
>  this operation expects a user-space buffer of 8 (not 4) bytes on these ABIs.
> +.\" prctl PR_SET_TIMERSLACK
>  .TP
>  .BR PR_SET_TIMERSLACK " (since Linux 2.6.28)"
>  .\" See https://lwn.net/Articles/369549/
> @@ -1316,10 +1355,12 @@ can be examined and changed via the file
>  .IR /proc/[pid]/timerslack_ns .
>  See
>  .BR proc (5).
> +.\" prctl PR_GET_TIMERSLACK
>  .TP
>  .BR PR_GET_TIMERSLACK " (since Linux 2.6.28)"
>  Return (as the function result)
>  the "current" timer slack value of the calling thread.
> +.\" prctl PR_SET_TIMING
>  .TP
>  .BR PR_SET_TIMING " (since Linux 2.6.0)"
>  .\" Precisely: Linux 2.6.0-test4
> @@ -1338,11 +1379,13 @@ is not currently implemented
>  .\" PR_TIMING_TIMESTAMP doesn't do anything in 2.6.26-rc8,
>  .\" and looking at the patch history, it appears
>  .\" that it never did anything.
> +.\" prctl PR_GET_TIMING
>  .TP
>  .BR PR_GET_TIMING " (since Linux 2.6.0)"
>  .\" Precisely: Linux 2.6.0-test4
>  Return (as the function result) which process timing method is currently
>  in use.
> +.\" prctl PR_SET_TSC
>  .TP
>  .BR PR_SET_TSC " (since Linux 2.6.26, x86 only)"
>  Set the state of the flag determining whether the timestamp counter
> @@ -1356,12 +1399,14 @@ to allow it to be read, or
>  to generate a
>  .B SIGSEGV
>  when the process tries to read the timestamp counter.
> +.\" prctl PR_GET_TSC
>  .TP
>  .BR PR_GET_TSC " (since Linux 2.6.26, x86 only)"
>  Return the state of the flag determining whether the timestamp counter
>  can be read,
>  in the location pointed to by
>  .IR "(int\ *) arg2" .
> +.\" prctl PR_SET_UNALIGN
>  .TP
>  .B PR_SET_UNALIGN
>  (Only on: ia64, since Linux 2.3.48; parisc, since Linux 2.6.15;
> @@ -1385,6 +1430,7 @@ flag in
>  operation of the
>  .BR setsysinfo ()
>  system call on Tru64).
> +.\" prctl PR_GET_UNALIGN
>  .TP
>  .B PR_GET_UNALIGN
>  (See
> @@ -1392,6 +1438,7 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.\" prctl PR_SET_IO_FLUSHER
>  .TP
>  .BR PR_SET_IO_FLUSHER " (since Linux 5.6)"
>  If a user process is involved in the block layer or filesystem I/O path,
> @@ -1420,6 +1467,7 @@ and is preserved across
>  Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
>  emulation daemons, and daemons that perform error handling like multipath
>  path recovery applications.
> +.\" prctl PR_GET_IO_FLUSHER
>  .TP
>  .B PR_GET_IO_FLUSHER (Since Linux 5.6)
>  Return (as the function result) the IO_FLUSHER state of the caller.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
