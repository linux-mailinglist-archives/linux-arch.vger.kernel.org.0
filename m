Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41992391C9A
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhEZQCA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234833AbhEZQCA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 12:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6003D613D3;
        Wed, 26 May 2021 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622044828;
        bh=GMrxEkqQtBsqG4xbv4zJPQYEf5zKU65KN8uhmCqvKnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNOCNs4rdcNd40jifS0wBWkDQX8sn36ZWEkwjCN5CxhtYYhCTEOPxH4FU/g915two
         6Utre0HKoDT2G8AgzkUTzZ/jAcpx/C1y6ORhCiVRmMkTjwW5Rs7GRs0FdecekzUJOy
         UW3rwkqMr2hjh8ScSvMLdfhLn4mjtvdIqVfPHKs8aqL0nqF6IaXWkzEZl2i7JU30fG
         DMtO/e4hS/KB8ckDUGW6yU8/y7mmrFVDa5qm5k446Wj4DQsSxU1qfKcj32xDHqV/TL
         YvDE+Vh2iOFGHfYkfd+V0tQMQVaDW6tQMSbQsAR5LXPiIfK75VN0bCH8xXfUfAn5jP
         zZx4IqUTCGp+A==
Date:   Wed, 26 May 2021 17:00:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 22/22] Documentation: arm64: describe asymmetric
 32-bit support
Message-ID: <20210526160021.GA19691@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-23-will@kernel.org>
 <877djmwxbd.wl-maz@kernel.org>
 <20210525172703.GA17250@willie-the-truck>
 <875yz6wun3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yz6wun3.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 07:11:44PM +0100, Marc Zyngier wrote:
> On Tue, 25 May 2021 18:27:03 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, May 25, 2021 at 06:13:58PM +0100, Marc Zyngier wrote:
> > > On Tue, 25 May 2021 16:14:32 +0100,
> > > Will Deacon <will@kernel.org> wrote:
> > > > 
> > > > Document support for running 32-bit tasks on asymmetric 32-bit systems
> > > > and its impact on the user ABI when enabled.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         |   3 +
> > > >  Documentation/arm64/asymmetric-32bit.rst      | 154 ++++++++++++++++++
> > > >  Documentation/arm64/index.rst                 |   1 +
> > > >  3 files changed, 158 insertions(+)
> > > >  create mode 100644 Documentation/arm64/asymmetric-32bit.rst
> > > >
> > > 
> > > [...]
> > > 
> > > > +KVM
> > > > +---
> > > > +
> > > > +Although KVM will not advertise 32-bit EL0 support to any vCPUs on an
> > > > +asymmetric system, a broken guest at EL1 could still attempt to execute
> > > > +32-bit code at EL0. In this case, an exit from a vCPU thread in 32-bit
> > > > +mode will return to host userspace with an ``exit_reason`` of
> > > > +``KVM_EXIT_FAIL_ENTRY``.
> > > 
> > > Nit: there is a bit more to it. The vcpu will be left in a permanent
> > > non-runnable state until KVM_ARM_VCPU_INIT is issued to reset the vcpu
> > > into a saner state.
> > 
> > Thanks, I'll add "and will remain non-runnable until re-initialised by a
> > subsequent KVM_ARM_VCPU_INIT operation".
> 
> Looks good.

Cheers.

> > Can the VMM tell that it needs to do that? I wonder if we should be
> > setting 'hardware_entry_failure_reason' to distinguish this case.
> 
> The VMM should be able to notice that something is amiss, as any
> subsequent KVM_RUN calls will result in -ENOEXEC being returned, and
> we document this as "the vcpu hasn't been initialized or the guest
> tried to execute instructions from device memory (arm64)".
> 
> However, there is another reason to get a "FAILED_ENTRY", and that if
> we get an Illegal Exception Return exception when entering the
> guest. That one should always be a KVM bug.
> 
> So yeah, maybe there is some ground to populate that structure with
> the appropriate nastygram (completely untested).
> 
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 24223adae150..cf50051a9412 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -402,6 +402,10 @@ struct kvm_vcpu_events {
>  #define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
>  #define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
>  
> +/* KVM_EXIT_FAIL_ENTRY reasons */
> +#define KVM_ARM64_FAILED_ENTRY_NO_AARCH32_ALLOWED	0xBADBAD32
> +#define KVM_ARM64_FAILED_ENTRY_INTERNAL_ERROR		0xE1215BAD

Heh, you and your magic numbers ;)

I'll leave it up to you as to whether you want to populate this -- I just
spotted it and thought it might help to indicate what went wrong. This is a
pretty daft situation to end up in so whether anybody would realistically
try to recover from it is another question entirely.

Will
