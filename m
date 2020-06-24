Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC49A207A67
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405544AbgFXRgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:36:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405427AbgFXRgu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6931FB;
        Wed, 24 Jun 2020 10:36:49 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 636FF3F71E;
        Wed, 24 Jun 2020 10:36:48 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/2] prctl.2: Add SVE prctls (arm64)
Date:   Wed, 24 Jun 2020 18:36:01 +0100
Message-Id: <1593020162-9365-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add documentation for the the PR_SVE_SET_VL and PR_SVE_GET_VL
prctls added in Linux 4.15 for arm64.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>

---

Since v2:

 * Clarify that the arg2 enumeration for PR_SVE_SET_VL applies to the
   bith _other than_ the PR_SVE_VL_LEN_MASK bits, rather than to all the
   bits.

 * Clarify return value semantics for PR_SVE_SET_VL, to highlight that
   there is no PR_SVE_SET_VL_ONEXEC in the return value and refer to
   PR_SVE_GET_VL for the rest of the definition.  Also clarify when the
   vector length given in the return value actually takes effect.

 * Reorder some documentation cross-references to avoid ambiguity about
   what they apply to.
---
 man2/prctl.2 | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 88b791b..46ea9d2 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1370,6 +1370,158 @@ call failing with the error
 .BR ENXIO .
 For further details, see the kernel source file
 .IR Documentation/admin\-guide/kernel\-parameters.txt .
+.\" prctl PR_SVE_SET_VL
+.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
+.\" linux-5.6/Documentation/arm64/sve.rst
+.TP
+.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
+Configure the thread's SVE vector length,
+as specified by
+.IR "(int) arg2" .
+Arguments
+.IR arg3 ", " arg4 " and " arg5
+are ignored.
+.IP
+The bits of
+.I arg2
+corresponding to
+.B PR_SVE_VL_LEN_MASK
+must be set to the desired vector length in bytes.
+This is interpreted as an upper bound:
+the kernel will select the greatest available vector length
+that does not exceed the value specified.
+In particular, specifying
+.B SVE_VL_MAX
+(defined in
+.I <asm/sigcontext.h>)
+for the
+.B PR_SVE_VL_LEN_MASK
+bits requests the maximum supported vector length.
+.IP
+In addition, the other bits of
+.I arg2
+must be set to one of the following combinations of flags:
+.RS
+.TP
+.B 0
+Perform the change immediately.
+At the next
+.BR execve (2)
+in the thread,
+the vector length will be reset to the value configured in
+.IR /proc/sys/abi/sve_default_vector_length .
+.TP
+.B PR_SVE_VL_INHERIT
+Perform the change immediately.
+Subsequent
+.BR execve (2)
+calls will preserve the new vector length.
+.TP
+.B PR_SVE_SET_VL_ONEXEC
+Defer the change, so that it is performed at the next
+.BR execve (2)
+in the thread.
+Further
+.BR execve (2)
+calls will reset the vector length to the value configured in
+.IR /proc/sys/abi/sve_default_vector_length .
+.TP
+.B "PR_SVE_SET_VL_ONEXEC | PR_SVE_VL_INHERIT"
+Defer the change, so that it is performed at the next
+.BR execve (2)
+in the thread.
+Further
+.BR execve (2)
+calls will preserve the new vector length.
+.RE
+.IP
+In all cases,
+any previously pending deferred change is canceled.
+.IP
+The call fails with error
+.B EINVAL
+if SVE is not supported on the platform, if
+.I arg2
+is unrecognized or invalid, or the value in the bits of
+.I arg2
+corresponding to
+.B PR_SVE_VL_LEN_MASK
+is outside the range
+.BR SVE_VL_MIN .. SVE_VL_MAX
+or is not a multiple of 16.
+.IP
+On success,
+a nonnegative value is returned that describes the
+.I selected
+configuration.
+If
+.B PR_SVE_SET_VL_ONEXEC
+was included in
+.IR arg2 ,
+then the configuration described by the return value
+will take effect at the next
+.BR execve ().
+Otherwise, the configuration is already in effect when the
+.B PR_SVE_SET_VL
+call returns.
+In either case, the value is encoded in the same way as the return value of
+.BR PR_SVE_GET_VL .
+Note that there is no explicit flag in the return value
+corresponding to
+.BR PR_SVE_SET_VL_ONEXEC .
+.IP
+The configuration (including any pending deferred change)
+is inherited across
+.BR fork (2)
+and
+.BR clone (2).
+.IP
+For more information, see the kernel source file
+.I Documentation/arm64/sve.rst
+.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
+(or
+.I Documentation/arm64/sve.txt
+before Linux 5.3).
+.IP
+.B Warning:
+Because the compiler or run-time environment
+may be using SVE, using this call without the
+.B PR_SVE_SET_VL_ONEXEC
+flag may crash the calling process.
+The conditions for using it safely are complex and system-dependent.
+Don't use it unless you really know what you are doing.
+.\" prctl PR_SVE_GET_VL
+.TP
+.BR PR_SVE_GET_VL " (since Linux 4.15, only on arm64)"
+Get the thread's current SVE vector length configuration.
+.IP
+Arguments
+.IR arg2 ", " arg3 ", " arg4 " and " arg5
+are ignored.
+.IP
+Providing that the kernel and platform support SVE
+this operation always succeeds,
+returning a nonnegative value that describes the
+.I current
+configuration.
+The bits corresponding to
+.B PR_SVE_VL_LEN_MASK
+contain the currently configured vector length in bytes.
+The bit corresponding to
+.B PR_SVE_VL_INHERIT
+indicates whether the vector length will be inherited
+across
+.BR execve (2).
+.IP
+Note that there is no way to determine whether there is
+a pending vector length change that has not yet taken effect.
+.IP
+For more information, see the kernel source file
+.I Documentation/arm64/sve.rst
+.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
+(or
+.I Documentation/arm64/sve.txt
+before Linux 5.3).
 .\"
 .\" prctl PR_TASK_PERF_EVENTS_DISABLE
 .TP
@@ -1613,6 +1765,8 @@ On success,
 .BR PR_GET_NO_NEW_PRIVS ,
 .BR PR_GET_SECUREBITS ,
 .BR PR_GET_SPECULATION_CTRL ,
+.BR PR_SVE_GET_VL ,
+.BR PR_SVE_SET_VL ,
 .BR PR_GET_THP_DISABLE ,
 .BR PR_GET_TIMING ,
 .BR PR_GET_TIMERSLACK ,
@@ -1904,6 +2058,22 @@ See the description of
 .B PR_PAC_RESET_KEYS
 above for details.
 .TP
+.B EINVAL
+.I option
+is
+.B PR_SVE_SET_VL
+and the arguments are invalid or unsupported,
+or SVE is not available on this platform.
+See the description of
+.B PR_SVE_SET_VL
+above for details.
+.TP
+.B EINVAL
+.I option
+is
+.B PR_SVE_GET_VL
+and SVE is not available on this platform.
+.TP
 .B ENODEV
 .I option
 was
-- 
2.1.4

