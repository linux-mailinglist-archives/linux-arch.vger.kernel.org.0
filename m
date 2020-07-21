Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB4227E5D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgGULIs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgGULIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:47 -0400
Message-Id: <20200721110809.215553545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YDCFKew+DHGnOoSPB7aJ/dSDh6feEe13B6/gZJNQ64c=;
        b=3MBUBo0BhT1IBBY1ttlGZZAy9DMAQpd3fJ5YPmcmpAt7F1nyau4eTfBmPaBizWTnTTQOI4
        bXv5GJ6k2APBTwsvF+HkxYXWhIhejxqtXyaXBsVq6+R8CoRMYlzfoHnZfsKPJTgsBPlTAR
        luYLuFJyDSy8QiivxFsJpI/r3+4HJ1P12eOsZsUFCRXOPRCNrWQi9/+RgZPs2+nEih4ypL
        q2BIyypT5KhlhAqalSgfqAc1jwN8sCLS/VMZg0oepLuLc1B4vyX9xyCxI7foZAqtMcknUB
        7rELfmGCbiESKpJHsluLSF+QPAhcPsIGHSQyhC6Gg9SXMHCFEW/lFid8zDszJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YDCFKew+DHGnOoSPB7aJ/dSDh6feEe13B6/gZJNQ64c=;
        b=975F8cDpmuKwTD7q2pNZ7H4Ov8VZgP1XwUE+Qt8V0Hyc4fjvTrM05IPkm3PeaTO6fuFpdW
        6kH4+GZEgQTJxsAA==
Date:   Tue, 21 Jul 2020 12:57:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 09/15] x86/ptrace: Provide pt_regs helper for entry/exit
References: <20200721105706.030914876@linutronix.de>
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

