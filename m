Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE10E222C36
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgGPTuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:50:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgGPTuw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:52 -0400
Message-Id: <20200716185424.658427667@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594929050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hm0SGxiCrQHQkfsKjql/X4GV7MtYKpxZQquxBECJJ+c=;
        b=YeQdEmXMSr+7kwj1h20ury1vxph6Q6pGLKfN+hqR8tt3X+gpEl2WrRnzWDnQ4cGVr9kfxm
        l9wR98GBPWzbuwagUsnnRV2CUsF98ikw/dkyC71WzapqKcUbY1dn/yI67H3Mgik7xyRTbV
        M34D86bV+Xn4xLBgeISfJDx257UPywjz5ZFPVL1AZ2b1OPpgRz+iGUjMq5O8lkyhYBQUJK
        L6Ks1ejANygnOjnDsiOwrEKf/7/CHf8V/JwUDLOx+TIs5uP9fecILD/q4Fb/8ezQEL4GpT
        VsD/PWFh13CohjW+/PYf04pLpg/Cpv2V1xFU1EvDNG5ocGzxxBVydQB38Jp/Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594929050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hm0SGxiCrQHQkfsKjql/X4GV7MtYKpxZQquxBECJJ+c=;
        b=obtkJwyTzhno54Ob6seTeBpsV8ZwaKtWMbLcbRpMottNV3jZA1ohI6wiRhCD5os6fHRcwK
        IqjKsa04C0hlFcAg==
Date:   Thu, 16 Jul 2020 20:22:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for entry/exit
References: <20200716182208.180916541@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a preparatory step for moving the syscall and interrupt entry/exit
handling into generic code, provide pt_regs helpers which allow to:

  - Retrieve the syscall number from pt_regs
  - Retrieve the syscall return value from pt_regs
  - Retrieve the interrupt state from pt_regs to check whether interrupts
    are reenabled by return from interrupt/exception.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/ptrace.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,21 @@ static inline void user_stack_pointer_se
 	regs->sp = val;
 }
 
+static inline unsigned long regs_syscall_nr(struct pt_regs *regs)
+{
+	return regs->orig_ax;
+}
+
+static inline long regs_syscall_retval(struct pt_regs *regs)
+{
+	return regs->ax;
+}
+
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);

