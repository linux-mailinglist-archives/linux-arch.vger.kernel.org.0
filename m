Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE617D317
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 10:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCHJxu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 05:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCHJxt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:49 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AFD2084E;
        Sun,  8 Mar 2020 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661228;
        bh=vOPL8owgSgHX9PhVmLyiyNWhrKKGWBWr9Xmd6jc428Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILwKeyhsd6982qjaUQJRvl39FmYnrOLOuWH1SlhJ59HzVUtZHnuy6I0NtkIEOY4lf
         iVTai79VidqtS7UMB2Zyi7M4n9NYwRYygwzj+eQOFfqCdD4I+himIPosKG8D2XwBiz
         hd8KYJJxgSShjgWRn+8BwX2MjB3PNCgz0xugvjfY=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 11/11] riscv: Add sigcontext save/restore
Date:   Sun,  8 Mar 2020 17:49:54 +0800
Message-Id: <20200308094954.13258-12-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch add sigcontext save/restore and it's very similar to
fpu.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/sigcontext.h |  1 +
 arch/riscv/kernel/signal.c               | 40 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index 84f2dfcfdbce..f74b3c814423 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -17,6 +17,7 @@
 struct sigcontext {
 	struct user_regs_struct sc_regs;
 	union __riscv_fp_state sc_fpregs;
+	struct __riscv_v_state sc_vregs;
 };
 
 #endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 17ba190e84a5..4295c00e8934 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -83,6 +83,40 @@ static long save_fp_state(struct pt_regs *regs,
 #define restore_fp_state(task, regs) (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+static long restore_v_state(struct pt_regs *regs,
+			    struct __riscv_v_state *sc_vregs)
+{
+	long err;
+	struct __riscv_v_state __user *state = sc_vregs;
+
+	err = __copy_from_user(&current->thread.vstate, state, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	vstate_restore(current, regs);
+
+	return err;
+}
+
+static long save_v_state(struct pt_regs *regs,
+			 struct __riscv_v_state *sc_vregs)
+{
+	long err;
+	struct __riscv_v_state __user *state = sc_vregs;
+
+	vstate_save(current, regs);
+	err = __copy_to_user(state, &current->thread.vstate, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	return err;
+}
+#else
+#define save_v_state(task, regs) (0)
+#define restore_v_state(task, regs) (0)
+#endif
+
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
 {
@@ -92,6 +126,9 @@ static long restore_sigcontext(struct pt_regs *regs,
 	/* Restore the floating-point state. */
 	if (has_fpu)
 		err |= restore_fp_state(regs, &sc->sc_fpregs);
+	/* Restore the vector state. */
+	if (has_vector)
+		err |= restore_v_state(regs, &sc->sc_vregs);
 	return err;
 }
 
@@ -145,6 +182,9 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	/* Save the floating-point state. */
 	if (has_fpu)
 		err |= save_fp_state(regs, &sc->sc_fpregs);
+	/* Save the vector state. */
+	if (has_vector)
+		err |= save_v_state(regs, &sc->sc_vregs);
 	return err;
 }
 
-- 
2.17.0

