Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2F20E4AF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbgF2V17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA418C033C0D;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU8-002Dt1-Pw; Mon, 29 Jun 2020 18:26:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 02/41] x86: copy_fpstate_to_sigframe(): have fpregs_soft_get() use kernel buffer
Date:   Mon, 29 Jun 2020 19:25:49 +0100
Message-Id: <20200629182628.529995-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... then copy_to_user() the results

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/fpu/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9393a445d73c..e0b832df7404 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -170,14 +170,14 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
+	if (!static_cpu_has(X86_FEATURE_FPU)) {
+		struct user_i387_ia32_struct fp;
+		fpregs_soft_get(current, NULL, 0, sizeof(fp), &fp, NULL);
+		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
+	}
+
 	if (!access_ok(buf, size))
 		return -EACCES;
-
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return fpregs_soft_get(current, NULL, 0,
-			sizeof(struct user_i387_ia32_struct), NULL,
-			(struct _fpstate_32 __user *) buf) ? -1 : 1;
-
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
-- 
2.11.0

