Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863F2E1A87
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391353AbfJWMbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbfJWMbj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFnb-00016z-Hd; Wed, 23 Oct 2019 14:31:35 +0200
Message-Id: <20191023123117.779277679@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 02/17] x86/entry/64: Remove pointless jump in paranoid_exit
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jump directly to restore_regs_and_return_to_kernel instead of making
a pointless extra jump through .Lparanoid_exit_restore

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1272,12 +1272,11 @@ ENTRY(paranoid_exit)
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
-	jmp	.Lparanoid_exit_restore
+	jmp	restore_regs_and_return_to_kernel
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-.Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
 


