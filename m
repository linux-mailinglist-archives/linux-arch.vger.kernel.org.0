Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A151E5225
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE1AOo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 20:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgE1AOn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 20:14:43 -0400
Received: from guoren-Inspiron-7460.lan (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A67B208C3;
        Thu, 28 May 2020 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590624883;
        bh=c+8hU4QGjJmmyXzl1rblMiEkuyhlWvbgj/aJLfZ++Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=hb3/IUfRgLGleGmjj71E0M2pwcxGmVpkwViXEen7Twst7uvTO5KrpC9a5HfMK/pBR
         5szAueHCGrxgmoBzmjFIR+JlAJt1goK+AQc5FZPw/DrzRqpFRxJZlCORD65Bb2uNQS
         juEapUSzCV+t5/HUV8vmD9TD3BHe3m7+svdJfcUw=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Fixup CONFIG_DEBUG_RSEQ
Date:   Thu, 28 May 2020 08:14:29 +0800
Message-Id: <1590624869-6594-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Put the rseq_syscall check point at the prologue of the syscall
will break the a0 ... a7. This will casue system call bug when
DEBUG_RSEQ is enabled.

So move it to the epilogue of syscall, but before syscall_trace.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/entry.S | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 9595e86..f138003 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -128,15 +128,11 @@ tlbop_end 1
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
-#ifdef CONFIG_RSEQ_DEBUG
-	mov	a0, sp
-	jbsr	rseq_syscall
-#endif
 	psrset  ee, ie
 
 	lrw     r9, __NR_syscalls
 	cmphs   syscallid, r9		/* Check nr of syscall */
-	bt      ret_from_exception
+	bt      1f
 
 	lrw     r9, sys_call_table
 	ixw     r9, syscallid
@@ -162,6 +158,11 @@ ENTRY(csky_systemcall)
 	jsr     syscallid
 #endif
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
+1:
+#ifdef CONFIG_DEBUG_RSEQ
+	mov	a0, sp
+	jbsr	rseq_syscall
+#endif
 	jmpi    ret_from_exception
 
 csky_syscall_trace:
@@ -187,6 +188,10 @@ csky_syscall_trace:
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
+#ifdef CONFIG_DEBUG_RSEQ
+	mov	a0, sp
+	jbsr	rseq_syscall
+#endif
 	mov     a0, sp                  /* right now, sp --> pt_regs */
 	jbsr    syscall_trace_exit
 	br	ret_from_exception
-- 
2.7.4

