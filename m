Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B51CFAF6
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgELQh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:58 -0400
Received: from foss.arm.com ([217.140.110.172]:58250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgELQh6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D1012FC;
        Tue, 12 May 2020 09:37:58 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BFC83F305;
        Tue, 12 May 2020 09:37:57 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Date:   Tue, 12 May 2020 17:36:58 +0100
Message-Id: <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
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

I wrote the SVE support originally, so I probably have this one
halfway right.

The explantion added is not exhaustive, but I didn't want it to be too
verbose.  I may trim it a bit and move the detail to a dedicated page
later on, but this is better than nothing in the meantime.
---
 man2/prctl.2 | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7f511d2..dd16227 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1291,6 +1291,104 @@ call failing with the error
 .BR ENXIO .
 For further details, see the kernel source file
 .IR Documentation/admin-guide/kernel-parameters.txt .
+.\" prctl PR_SVE_SET_VL
+.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
+.\" linux-5.6/Documentation/arm64/sve.rst
+.TP
+.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
+Configure the thread's SVE vector length,
+as specified by
+.IR arg2 .
+Arguments
+.IR arg3 ", " arg4 " and " arg5
+are ignored.
+.IP
+The bits of
+.I arg2
+corresponding to
+.B SVE_VL_LEN_MASK
+must be set to the desired vector length in bytes.
+In addition,
+.I arg2
+may include zero or more of the following flags:
+.RS
+.TP
+.B PR_SVE_VL_INHERIT
+Inherit the configured vector length across
+.BR execve (2).
+.TP
+.B PR_SVE_SET_VL_ONEXEC
+Defer the change until the next
+.BR execve (2)
+in this thread.
+If
+.B PR_SVE_VL_INHERIT
+is also included in
+.IR arg2 ,
+it takes effect
+.I after
+this deferred change.
+.RE
+.IP
+On success, the vector length and flags are set as requested,
+and any deferred change that was pending immediately before the
+.B PR_SVE_SET_VL
+call is canceled.
+If
+.B PR_SVE_SET_VL_ONEXEC
+was included in
+.IR arg2 ,
+the returned value describes the configuration
+scheduled to take effect at the next
+.BR execve (2).
+Otherwise, the effect is immediate and
+the returned value describes the new configuration.
+The returned value is encoded in the same way as the return value of
+.BR PR_SVE_GET_VL .
+.IP
+If neither of the above flags is included in
+.IR arg2 ,
+a subsequent
+.BR execve (2)
+resets the vector length to the default value configured in
+.IR /proc/sys/abi/sve_default_vector_length .
+.IP
+The actual vector length configured by this operation
+is the greatest vector length supported by the platform
+that does not exceed
+.I arg2
+&
+.BR PR_SVE_VL_LEN_MASK .
+.IP
+The configuration (including any pending deferred change)
+is inherited across
+.BR fork (2)
+and
+.BR clone (2).
+.\" prctl PR_SVE_GET_VL
+.TP
+.BR PR_SVE_GET_VL " (since Linux 4.15, only on arm64)"
+Get the thread's current SVE vector length configuration,
+as configured by
+.BR PR_SVE_SET_VL .
+.IP
+If successful, the return value describes the
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
+Note that there is no way determine whether there is
+a pending vector length change that has not yet taken effect.
+.IP
+Providing that the kernel and platform support SVE,
+this operation always succeeds.
 .\"
 .\" prctl PR_TASK_PERF_EVENTS_DISABLE
 .TP
@@ -1534,6 +1632,8 @@ On success,
 .BR PR_GET_NO_NEW_PRIVS ,
 .BR PR_GET_SECUREBITS ,
 .BR PR_GET_SPECULATION_CTRL ,
+.BR PR_SVE_GET_VL ,
+.BR PR_SVE_SET_VL ,
 .BR PR_GET_THP_DISABLE ,
 .BR PR_GET_TIMING ,
 .BR PR_GET_TIMERSLACK ,
@@ -1817,6 +1917,18 @@ and unused arguments to
 .BR prctl ()
 are not 0.
 .TP
+.B EINVAL
+.I option
+was
+.B PR_SVE_SET_VL
+and
+.I arg2
+contains invalid flags, or
+.I arg2
+&
+.B SVE_VL_LEN_MASK
+is not a valid vector length.
+.TP
 .B ENODEV
 .I option
 was
-- 
2.1.4

