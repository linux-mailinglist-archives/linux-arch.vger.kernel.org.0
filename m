Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1150207A66
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405427AbgFXRgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:36:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405456AbgFXRgu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1020D31B;
        Wed, 24 Jun 2020 10:36:50 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60E443F71E;
        Wed, 24 Jun 2020 10:36:49 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 2/2] prctl.2: Add tagged address ABI control prctls (arm64)
Date:   Wed, 24 Jun 2020 18:36:02 +0100
Message-Id: <1593020162-9365-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add documentation for the the PR_SET_TAGGED_ADDR_CTRL and
PR_GET_TAGGED_ADDR_CTRL prctls added in Linux 5.4 for arm64.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>

---

Kept Catalin's Reviewed-by, since the changes are pretty minor.

Changes since v2:

 * Clarified type of PR_SET_TAGGED_ADDR_CTRL arg2.

 * Added Linux commit where enforecement of zeroing reserved args was
   added for PR_SET_TAGGED_ADDR_CTRL.

 * Added explicit text regarding how to disable the tagged-address ABI
   globally through sysctl.

 * Rearrange the tagged argument syscall exclusion list so that shmdt()
   isn't called out specially.  The reader probably doesn't care about
   this history here.

 * Minor rewordings.
---
 man2/prctl.2 | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 46ea9d2..cf92f3b 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1522,6 +1522,148 @@ For more information, see the kernel source file
 (or
 .I Documentation/arm64/sve.txt
 before Linux 5.3).
+.\" prctl PR_SET_TAGGED_ADDR_CTRL
+.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
+.TP
+.BR PR_SET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
+Controls support for passing tagged userspace addresses to the kernel
+(i.e., addresses where bits 56\(em63 are not all zero).
+.IP
+The level of support is selected by
+.IR "arg2" ,
+which can be one of the following:
+.RS
+.TP
+.B 0
+Addresses that are passed
+for the purpose of being dereferenced by the kernel
+must be untagged.
+.TP
+.B PR_TAGGED_ADDR_ENABLE
+Addresses that are passed
+for the purpose of being dereferenced by the kernel
+may be tagged, with the exceptions summarized below.
+.RE
+.IP
+The remaining arguments
+.IR arg3 ", " arg4 " and " arg5
+must all be zero.
+.\" Enforcement added in
+.\" commit 3e91ec89f527b9870fe42dcbdb74fd389d123a95
+.IP
+On success, the mode specified in
+.I arg2
+is set for the calling thread and the the return value is 0.
+If the arguments are invalid,
+the mode specified in
+.I arg2
+is unrecognized,
+or if this feature is unsupported by the kernel
+or disabled via
+.IR /proc/sys/abi/tagged_addr_disabled ,
+the call fails with
+.BR EINVAL .
+.IP
+In particular, if
+.BR prctl ( PR_SET_TAGGED_ADDR_CTRL ,
+0, 0, 0, 0)
+fails with
+.B EINVAL
+then all addresses passed to the kernel must be untagged.
+.IP
+Irrespective of which mode is set,
+addresses passed to certain interfaces
+must always be untagged:
+.RS
+.IP \(em
+.BR brk (2),
+.BR mmap (2),
+.BR shmat (2),
+.BR shmdt (2),
+and the
+.I new_address
+argument of
+.BR mremap (2).
+.IP
+(Prior to Linux 5.6 these accepted tagged addresses,
+but the behaviour may not be what you expect.
+Don't rely on it.)
+.IP \(em
+\(oqpolymorphic\(cq interfaces
+that accept pointers to arbitrary types cast to a
+.I void *
+or other generic type, specifically
+.BR prctl (2),
+.BR ioctl (2),
+and in general
+.BR setsockopt (2)
+(only certain specific
+.BR setsockopt (2)
+options allow tagged addresses).
+.RE
+.IP
+This list of exclusions may shrink
+when moving from one kernel version to a later kernel version.
+While the kernel may make some guarantees
+for backwards compatibility reasons,
+for the purposes of new software
+the effect of passing tagged addresses to these interfaces
+is unspecified.
+.IP
+The mode set by this call is inherited across
+.BR fork (2)
+and
+.BR clone (2).
+The mode is reset by
+.BR execve (2)
+to 0
+(i.e., tagged addresses not permitted in the user/kernel ABI).
+.IP
+For more information, see the kernel source file
+.IR Documentation/arm64/tagged\-address\-abi.rst .
+.IP
+.B Warning:
+This call is primarily intended for use by the run-time environment.
+A successful
+.B PR_SET_TAGGED_ADDR_CTRL
+call elsewhere may crash the calling process.
+The conditions for using it safely are complex and system-dependent;
+Don't use it unless you know what you are doing.
+.\" prctl PR_GET_TAGGED_ADDR_CTRL
+.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
+.TP
+.BR PR_GET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
+Returns the current tagged address mode
+for the calling thread.
+.IP
+Arguments
+.IR arg2 ", " arg3 ", " arg4 " and " arg5
+must all be zero.
+.IP
+If the arguments are invalid
+or this feature is disabled or unsupported by the kernel,
+the call fails with
+.BR EINVAL .
+In particular, if
+.BR prctl ( PR_GET_TAGGED_ADDR_CTRL ,
+0, 0, 0, 0)
+fails with
+.BR EINVAL ,
+then this feature is definitely either unsupported,
+or disabled via
+.IR /proc/sys/abi/tagged_addr_disabled .
+In this case,
+all addresses passed to the kernel must be untagged.
+.IP
+Otherwise, the call returns a nonnegative value
+describing the current tagged address mode,
+encoded in the same way as the
+.I arg2
+argument of
+.BR PR_SET_TAGGED_ADDR_CTRL .
+.IP
+For more information, see the kernel source file
+.IR Documentation/arm64/tagged\-address\-abi.rst .
 .\"
 .\" prctl PR_TASK_PERF_EVENTS_DISABLE
 .TP
@@ -1767,6 +1909,7 @@ On success,
 .BR PR_GET_SPECULATION_CTRL ,
 .BR PR_SVE_GET_VL ,
 .BR PR_SVE_SET_VL ,
+.BR PR_GET_TAGGED_ADDR_CTRL ,
 .BR PR_GET_THP_DISABLE ,
 .BR PR_GET_TIMING ,
 .BR PR_GET_TIMERSLACK ,
@@ -2074,6 +2217,24 @@ is
 .B PR_SVE_GET_VL
 and SVE is not available on this platform.
 .TP
+.B EINVAL
+.I option
+is
+.BR PR_SET_TAGGED_ADDR_CTRL
+and the arguments are invalid or unsupported.
+See the description of
+.B PR_SET_TAGGED_ADDR_CTRL
+above for details.
+.TP
+.B EINVAL
+.I option
+is
+.BR PR_GET_TAGGED_ADDR_CTRL
+and the arguments are invalid or unsupported.
+See the description of
+.B PR_GET_TAGGED_ADDR_CTRL
+above for details.
+.TP
 .B ENODEV
 .I option
 was
-- 
2.1.4

