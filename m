Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452091CFAE7
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgELQhw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgELQhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED164106F;
        Tue, 12 May 2020 09:37:50 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40D3B3F305;
        Tue, 12 May 2020 09:37:50 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/14] prctl.2: ffix quotation mark tweaks
Date:   Tue, 12 May 2020 17:36:51 +0100
Message-Id: <1589301419-24459-7-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Convert quote marks used for information terms in prose to use
\(oq .. \(cq, for better graphical rendering.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Note, this can lead to misrendering on badly-configured systems.
However, many man pages do it.

In the C locale (or with -Tascii) the quotes still render as ' .
---
 man2/prctl.2 | 71 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 1611448..7a3fc5c 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -188,7 +188,7 @@ library in the form of
 If
 .I arg2
 is nonzero,
-set the "child subreaper" attribute of the calling process;
+set the \(oqchild subreaper\(cq attribute of the calling process;
 if
 .I arg2
 is zero, unset the attribute.
@@ -210,7 +210,7 @@ signal and will be able to
 .BR wait (2)
 on the process to discover its termination status.
 .IP
-The setting of the "child subreaper" attribute
+The setting of the \(oqchild subreaper\(cq attribute
 is not inherited by children created by
 .BR fork (2)
 and
@@ -231,13 +231,13 @@ employ a subreaper process for similar reasons.
 .\" prctl PR_GET_CHILD_SUBREAPER
 .TP
 .BR PR_GET_CHILD_SUBREAPER " (since Linux 3.4)"
-Return the "child subreaper" setting of the caller,
+Return the \(oqchild subreaper\(cq setting of the caller,
 in the location pointed to by
 .IR "(int\ *) arg2" .
 .\" prctl PR_SET_DUMPABLE
 .TP
 .BR PR_SET_DUMPABLE " (since Linux 2.3.20)"
-Set the state of the "dumpable" attribute,
+Set the state of the \(oqdumpable\(cq attribute,
 which determines whether core dumps are produced for the calling process
 upon delivery of a signal whose default behavior is to produce a core dump.
 .IP
@@ -263,7 +263,7 @@ for security reasons, this feature has been removed.
 in
 .BR proc (5).)
 .IP
-Normally, the "dumpable" attribue is set to 1.
+Normally, the \(oqdumpable\(cq attribue is set to 1.
 However, it is reset to the current value contained in the file
 .IR /proc/sys/fs/\:suid_dumpable
 (which by default has the value 0),
@@ -539,19 +539,19 @@ must be zero.
 .\" prctl PR_SET_KEEPCAPS
 .TP
 .BR PR_SET_KEEPCAPS " (since Linux 2.2.18)"
-Set the state of the calling thread's "keep capabilities" flag.
+Set the state of the calling thread's \(oqkeep capabilities\(cq flag.
 The effect of this flag is described in
 .BR capabilities (7).
 .I arg2
 must be either 0 (clear the flag)
 or 1 (set the flag).
-The "keep capabilities" value will be reset to 0 on subsequent calls to
+The \(oqkeep capabilities\(cq value will be reset to 0 on subsequent calls to
 .BR execve (2).
 .\" prctl PR_GET_KEEPCAPS
 .TP
 .BR PR_GET_KEEPCAPS " (since Linux 2.2.18)"
 Return (as the function result) the current state of the calling thread's
-"keep capabilities" flag.
+\(oqkeep capabilities\(cq flag.
 See
 .BR capabilities (7)
 for a description of this flag.
@@ -806,8 +806,8 @@ and a set of special instruction prefixes that tell the CPU on which
 instructions it should do bounds enforcement.
 There is a limited number of these registers and
 when there are more pointers than registers,
-their contents must be "spilled" into a set of tables.
-These tables are called "bounds tables" and the MPX
+their contents must be \(oqspilled\(cq into a set of tables.
+These tables are called \(oqbounds tables\(cq and the MPX
 .BR prctl ()
 operations control
 whether the kernel manages their allocation and freeing.
@@ -833,7 +833,8 @@ These calls fail if the CPU or kernel does not support MPX.
 Kernel support for MPX is enabled via the
 .BR CONFIG_X86_INTEL_MPX
 configuration option.
-You can check whether the CPU supports MPX by looking for the 'mpx'
+You can check whether the CPU supports MPX by looking for the
+.I mpx
 CPUID bit, like with the following command:
 .IP
 .in +4n
@@ -954,7 +955,7 @@ parent dies.
 .IP
 .IR Warning :
 .\" https://bugzilla.kernel.org/show_bug.cgi?id=43300
-the "parent" in this case is considered to be the
+the \(oqparent\(cq in this case is considered to be the
 .I thread
 that created this process.
 In other words, the signal will be sent when that thread terminates
@@ -1005,20 +1006,20 @@ in the location pointed to by
 .\" commit 2d514487faf188938a4ee4fb3464eeecfbdcf8eb
 .\" commit bf06189e4d14641c0148bea16e9dd24943862215
 This is meaningful only when the Yama LSM is enabled and in mode 1
-("restricted ptrace", visible via
+(\(oqrestricted ptrace\(cq, visible via
 .IR /proc/sys/kernel/yama/ptrace_scope ).
-When a "ptracer process ID" is passed in \fIarg2\fP,
+When a \(oqptracer process ID\(cq is passed in \fIarg2\fP,
 the caller is declaring that the ptracer process can
 .BR ptrace (2)
 the calling process as if it were a direct process ancestor.
 Each
 .B PR_SET_PTRACER
-operation replaces the previous "ptracer process ID".
+operation replaces the previous \(oqptracer process ID\(cq.
 Employing
 .B PR_SET_PTRACER
 with
 .I arg2
-set to 0 clears the caller's "ptracer process ID".
+set to 0 clears the caller's \(oqptracer process ID\(cq.
 If
 .I arg2
 is
@@ -1139,7 +1140,7 @@ without the risk that the process is killed; see
 .\" prctl PR_SET_SECUREBITS
 .TP
 .BR PR_SET_SECUREBITS " (since Linux 2.6.26)"
-Set the "securebits" flags of the calling thread to the value supplied in
+Set the \(oqsecurebits\(cq flags of the calling thread to the value supplied in
 .IR arg2 .
 See
 .BR capabilities (7).
@@ -1147,7 +1148,7 @@ See
 .TP
 .BR PR_GET_SECUREBITS " (since Linux 2.6.26)"
 Return (as the function result)
-the "securebits" flags of the calling thread.
+the \(oqsecurebits\(cq flags of the calling thread.
 See
 .BR capabilities (7).
 .\" prctl PR_GET_SPECULATION_CTRL
@@ -1289,7 +1290,7 @@ in Linux 2.6.32.
 .TP
 .BR PR_SET_THP_DISABLE " (since Linux 3.15)"
 .\" commit a0715cc22601e8830ace98366c0c2bd8da52af52
-Set the state of the "THP disable" flag for the calling thread.
+Set the state of the \(oqTHP disable\(cq flag for the calling thread.
 If
 .I arg2
 has a nonzero value, the flag is set, otherwise it is cleared.
@@ -1298,14 +1299,14 @@ for disabling transparent huge pages
 for jobs where the code cannot be modified, and using a malloc hook with
 .BR madvise (2)
 is not an option (i.e., statically allocated data).
-The setting of the "THP disable" flag is inherited by a child created via
+The setting of the \(oqTHP disable\(cq flag is inherited by a child created via
 .BR fork (2)
 and is preserved across
 .BR execve (2).
 .\" prctl PR_GET_THP_DISABLE
 .TP
 .BR PR_GET_THP_DISABLE " (since Linux 3.15)"
-Return (as the function result) the current setting of the "THP disable"
+Return (as the function result) the current setting of the \(oqTHP disable\(cq
 flag for the calling thread:
 either 1, if the flag is set, or 0, if it is not.
 .\" prctl PR_GET_TID_ADDRESS
@@ -1336,21 +1337,21 @@ this operation expects a user-space buffer of 8 (not 4) bytes on these ABIs.
 .\" See https://lwn.net/Articles/369549/
 .\" commit 6976675d94042fbd446231d1bd8b7de71a980ada
 Each thread has two associated timer slack values:
-a "default" value, and a "current" value.
-This operation sets the "current" timer slack value for the calling thread.
+a \(oqdefault\(cq value, and a \(oqcurrent\(cq value.
+This operation sets the \(oqcurrent\(cq timer slack value for the calling thread.
 .I arg2
-is an unsigned long value, then maximum "current" value is ULONG_MAX and
-the minimum "current" value is 1.
+is an unsigned long value, then maximum \(oqcurrent\(cq value is ULONG_MAX and
+the minimum \(oqcurrent\(cq value is 1.
 If the nanosecond value supplied in
 .IR arg2
-is greater than zero, then the "current" value is set to this value.
+is greater than zero, then the \(oqcurrent\(cq value is set to this value.
 If
 .I arg2
 is equal to zero,
-the "current" timer slack is reset to the
-thread's "default" timer slack value.
+the \(oqcurrent\(cq timer slack is reset to the
+thread's \(oqdefault\(cq timer slack value.
 .IP
-The "current" timer slack is used by the kernel to group timer expirations
+The \(oqcurrent\(cq timer slack is used by the kernel to group timer expirations
 for the calling thread that are close to one another;
 as a consequence, timer expirations for the thread may be
 up to the specified number of nanoseconds late (but will never expire early).
@@ -1382,11 +1383,11 @@ a real-time scheduling policy (see
 .BR sched_setscheduler (2)).
 .IP
 When a new thread is created,
-the two timer slack values are made the same as the "current" value
+the two timer slack values are made the same as the \(oqcurrent\(cq value
 of the creating thread.
-Thereafter, a thread can adjust its "current" timer slack value via
+Thereafter, a thread can adjust its \(oqcurrent\(cq timer slack value via
 .BR PR_SET_TIMERSLACK .
-The "default" value can't be changed.
+The \(oqdefault\(cq value can't be changed.
 The timer slack values of
 .IR init
 (PID 1), the ancestor of all processes,
@@ -1396,7 +1397,7 @@ The timer slack value is inherited by a child created via
 and is preserved across
 .BR execve (2).
 .IP
-Since Linux 4.6, the "current" timer slack value of any process
+Since Linux 4.6, the \(oqcurrent\(cq timer slack value of any process
 can be examined and changed via the file
 .IR /proc/[pid]/timerslack_ns .
 See
@@ -1405,7 +1406,7 @@ See
 .TP
 .BR PR_GET_TIMERSLACK " (since Linux 2.6.28)"
 Return (as the function result)
-the "current" timer slack value of the calling thread.
+the \(oqcurrent\(cq timer slack value of the calling thread.
 .\" prctl PR_SET_TIMING
 .TP
 .BR PR_SET_TIMING " (since Linux 2.6.0)"
@@ -1817,7 +1818,7 @@ is
 and the caller does not have the
 .B CAP_SETPCAP
 capability,
-or tried to unset a "locked" flag,
+or tried to unset a \(oqlocked\(cq flag,
 or tried to set a flag whose corresponding locked flag was set
 (see
 .BR capabilities (7)).
-- 
2.1.4

