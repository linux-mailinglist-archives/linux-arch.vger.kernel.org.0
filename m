Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7722A1D4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 00:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbgGVWLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 18:11:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733138AbgGVWLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:35 -0400
Message-Id: <20200722220520.258511584@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A3JiScAV66HloAWwCQ/sFgNPUnLZ+Banxe8R954+Z5E=;
        b=o6lsUBKSZPYc2rvxUOLw2pilcUiJE4kHSEJZzcE+/7rTXXlZSEdrhduMwxmKfvnNh9CIZj
        CDAg/7YOhD3C6KPnUh2GRPFgPr2dVoHrBlqaEc/g92Lpg8FmiiPmjL8g9h9vRLQ1MgIjVl
        NiSabKledFo9NRv7xXwO2orGYPA5WP/cspVbi/Iut0vKEKY6g/A6vjZ/oETASg6AW1AHeS
        4uqr5+baoATnRRGJov8wg3k88syekJaGfk1aEJMkhb/85Qp7PTeX1aflWYo1/NFF/HX+3E
        DYD9z9Pwi4G6GgucVA/R2ZJZvPIqPF8DFgFLJ9ZZFuc4GQWbdqSnoFCwaxR3GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A3JiScAV66HloAWwCQ/sFgNPUnLZ+Banxe8R954+Z5E=;
        b=YgduB5QLNoWSoIxGc11a1PbzCW0AkWC1WRywZ7E6SEEiV5WXxe0yWHaF+yE9NVgCanmkoR
        kAK6LqtIGtEuglBQ==
Date:   Thu, 23 Jul 2020 00:00:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 09/15] x86/ptrace: Provide pt_regs helper for entry/exit
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

As a preparatory step for moving the syscall and interrupt entry/exit
handling into generic code, provide a pt_regs helper which retrieves the
interrupt state from pt_regs. This is required to check whether interrupts
are reenabled by return from interrupt/exception.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
V4: Remove the syscall nr and return value helpers as they alredy exist
---
 arch/x86/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,11 @@ static inline void user_stack_pointer_se
 	regs->sp = val;
 }
 
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);


