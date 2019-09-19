Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F461B7DCE
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfISPLP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:11:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfISPJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy3w-0006n0-31; Thu, 19 Sep 2019 17:09:40 +0200
Message-Id: <20190919150314.054351477@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 00/15] entry: Provide generic implementation for host and
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

You asked for it, so don't complain that you have to review it :)

The series implements the syscall enter/exit and the general exit to
userspace work handling along with the pre guest enter functionality.

The series converts x86 and ARM64. x86 is fully tested including selftests
etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
available right now.

Thanks,

	tglx

---
 /Makefile                               |    3 
 arch/Kconfig                            |    3 
 arch/arm64/Kconfig                      |    1 
 arch/arm64/include/asm/kvm_host.h       |    1 
 arch/arm64/kernel/entry.S               |   18 -
 arch/arm64/kernel/ptrace.c              |   65 ------
 arch/arm64/kernel/signal.c              |   45 ----
 arch/arm64/kernel/syscall.c             |   49 ----
 arch/x86/Kconfig                        |    1 
 arch/x86/entry/common.c                 |  265 +-------------------------
 arch/x86/entry/entry_32.S               |   13 -
 arch/x86/entry/entry_64.S               |   12 -
 arch/x86/entry/entry_64_compat.S        |   21 --
 arch/x86/include/asm/signal.h           |    1 
 arch/x86/include/asm/thread_info.h      |    9 
 arch/x86/kernel/signal.c                |    2 
 arch/x86/kvm/x86.c                      |   17 -
 b/arch/arm64/include/asm/entry-common.h |   76 +++++++
 b/arch/x86/include/asm/entry-common.h   |  104 ++++++++++
 b/include/linux/entry-common.h          |  324 ++++++++++++++++++++++++++++++++
 b/kernel/entry/common.c                 |  220 +++++++++++++++++++++
 kernel/Makefile                         |    1 
 22 files changed, 776 insertions(+), 475 deletions(-)


