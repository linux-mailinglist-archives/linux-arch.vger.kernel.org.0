Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92FB93C5
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2019 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbfITPMp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Sep 2019 11:12:45 -0400
Received: from foss.arm.com ([217.140.110.172]:46192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfITPMp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 11:12:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC94337;
        Fri, 20 Sep 2019 08:12:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4343F575;
        Fri, 20 Sep 2019 08:12:42 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:12:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20190920151240.GB55224@lakrids.cambridge.arm.com>
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150314.054351477@linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

As a heads-up, I'm going to be away next week, and I likely won't have
the chance to look at this in detail before October.

On Thu, Sep 19, 2019 at 05:03:14PM +0200, Thomas Gleixner wrote:
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
> 
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
> 
> You asked for it, so don't complain that you have to review it :)

I never asked for this! ;)

> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
> 
> The series converts x86 and ARM64. x86 is fully tested including selftests
> etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
> available right now.

I've been working on converting the arm64 entry code to C for a while
now [1], gradually upstreaming the bits I can.

James has picked up some of that [2] as a prerequisite for some RAS
error handling, and I think building the arm64 bits atop of that would
be preferable. IIUC that should get posted as a series come -rc1.

Since there's immense scope for subtle breakage, I'd prefer that we do
the arm64-specific asm->C conversion before migrating arm64 to generic
code. That way us arm64 folk can ensure the asm->C conversion retains
the existing behaviour, and it'll be easier for everyone to compare the
arm64 and generic C implementations.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
[2] git://linux-arm.org/linux-jm.git -b deasm_sync_only/v1

> 
> Thanks,
> 
> 	tglx
> 
> ---
>  /Makefile                               |    3 
>  arch/Kconfig                            |    3 
>  arch/arm64/Kconfig                      |    1 
>  arch/arm64/include/asm/kvm_host.h       |    1 
>  arch/arm64/kernel/entry.S               |   18 -
>  arch/arm64/kernel/ptrace.c              |   65 ------
>  arch/arm64/kernel/signal.c              |   45 ----
>  arch/arm64/kernel/syscall.c             |   49 ----
>  arch/x86/Kconfig                        |    1 
>  arch/x86/entry/common.c                 |  265 +-------------------------
>  arch/x86/entry/entry_32.S               |   13 -
>  arch/x86/entry/entry_64.S               |   12 -
>  arch/x86/entry/entry_64_compat.S        |   21 --
>  arch/x86/include/asm/signal.h           |    1 
>  arch/x86/include/asm/thread_info.h      |    9 
>  arch/x86/kernel/signal.c                |    2 
>  arch/x86/kvm/x86.c                      |   17 -
>  b/arch/arm64/include/asm/entry-common.h |   76 +++++++
>  b/arch/x86/include/asm/entry-common.h   |  104 ++++++++++
>  b/include/linux/entry-common.h          |  324 ++++++++++++++++++++++++++++++++
>  b/kernel/entry/common.c                 |  220 +++++++++++++++++++++
>  kernel/Makefile                         |    1 
>  22 files changed, 776 insertions(+), 475 deletions(-)
> 
> 
