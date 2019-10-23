Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E8E1A85
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbfJWMbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbfJWMbk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFna-00016r-NM; Wed, 23 Oct 2019 14:31:34 +0200
Message-Id: <20191023122705.198339581@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 00/17] entry: Provide generic implementation for host and
 guest entry/exit work
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When working on a way to move out the posix cpu timer expiry out of the
timer interrupt context, I noticed that KVM is not handling pending task
work before entering a guest. A quick hack was to add that to the x86 KVM
handling loop. The discussion ended with a request to make this a generic
infrastructure possible with also moving the per arch implementations of
the enter from and return to user space handling generic.

  https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net

The series implements the syscall enter/exit and the general exit to
userspace work handling along with the pre guest enter functionality.

Changes vs. RFC version:

  - Dropped ARM64 conversion as requested by ARM64 folks

  - Addressed various review comments (Peter, Andy, Mike, Paolo, Josh,
    Miroslav)

  - Picked up, fixed and completed Peter's patch which makes interrupt
    enable/disable symmetric in trap handlers

  - Completed the removal of irq disabling / irq tracing from low level
    ASM code

  - Moved KVM specific parts of the enter guest mode handling to KVM
    (Paolo)

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP/core.entry

Thanks,

        tglx

RFC version: https://lore.kernel.org/r/20190919150314.054351477@linutronix.de

---
 /Makefile                             |    3 
 arch/Kconfig                          |    3 
 arch/x86/Kconfig                      |    1 
 arch/x86/entry/calling.h              |   12 +
 arch/x86/entry/common.c               |  264 ++------------------------------
 arch/x86/entry/entry_32.S             |   41 ----
 arch/x86/entry/entry_64.S             |   32 ---
 arch/x86/entry/entry_64_compat.S      |   30 ---
 arch/x86/include/asm/irqflags.h       |    8 
 arch/x86/include/asm/paravirt.h       |    9 -
 arch/x86/include/asm/signal.h         |    1 
 arch/x86/include/asm/thread_info.h    |    9 -
 arch/x86/kernel/signal.c              |    2 
 arch/x86/kernel/traps.c               |   33 ++--
 arch/x86/kvm/x86.c                    |   17 --
 arch/x86/mm/fault.c                   |    7 
 b/arch/x86/include/asm/entry-common.h |  104 ++++++++++++
 b/arch/x86/kvm/Kconfig                |    1 
 b/include/linux/entry-common.h        |  280 ++++++++++++++++++++++++++++++++++
 b/kernel/entry/common.c               |  184 ++++++++++++++++++++++
 include/linux/kvm_host.h              |   64 +++++++
 kernel/Makefile                       |    1 
 virt/kvm/Kconfig                      |    3 
 23 files changed, 735 insertions(+), 374 deletions(-)



