Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4569B39079D
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEYR2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 13:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhEYR2k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 13:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB5A061059;
        Tue, 25 May 2021 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621963630;
        bh=Py8o9CpBdeHqkrPglGRVHtpKGSFKgoBf9UwTlNommvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlJVOP5HjP6X7p8+sAHbrLWIDwGzcdXySE+klKG1rX1/eGWcXcx6JZBK91dIkPD9c
         kX99nnqLMCzVeNrxkUWho5UAKkHMdpUFanZeWK0PoKDXZZlTKKB1ctei7V3AO2lkSl
         gqfPRbxSeEeWxTjimVy1kemYb/Ds5GuWfgl7ZZDG0ibTdlhhJcu3d/kVKbq4ce1fyQ
         K8gYNZA6Uc3jUNc5Yp0ftZsLy8CWhELiFQFL6Qt6+soa0gjTgryne4cauQmxRfCwlo
         /1Jo9dGP+HLN5A1uJWMtUcR8okTTNkEBaQCzPFnAJtPTfmtVKb2O1J5ygtlrcWBxWi
         /T3ezz3tcdrmw==
Date:   Tue, 25 May 2021 18:27:03 +0100
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
Message-ID: <20210525172703.GA17250@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-23-will@kernel.org>
 <877djmwxbd.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877djmwxbd.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 06:13:58PM +0100, Marc Zyngier wrote:
> On Tue, 25 May 2021 16:14:32 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > Document support for running 32-bit tasks on asymmetric 32-bit systems
> > and its impact on the user ABI when enabled.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   3 +
> >  Documentation/arm64/asymmetric-32bit.rst      | 154 ++++++++++++++++++
> >  Documentation/arm64/index.rst                 |   1 +
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 Documentation/arm64/asymmetric-32bit.rst
> >
> 
> [...]
> 
> > +KVM
> > +---
> > +
> > +Although KVM will not advertise 32-bit EL0 support to any vCPUs on an
> > +asymmetric system, a broken guest at EL1 could still attempt to execute
> > +32-bit code at EL0. In this case, an exit from a vCPU thread in 32-bit
> > +mode will return to host userspace with an ``exit_reason`` of
> > +``KVM_EXIT_FAIL_ENTRY``.
> 
> Nit: there is a bit more to it. The vcpu will be left in a permanent
> non-runnable state until KVM_ARM_VCPU_INIT is issued to reset the vcpu
> into a saner state.

Thanks, I'll add "and will remain non-runnable until re-initialised by a
subsequent KVM_ARM_VCPU_INIT operation".

Can the VMM tell that it needs to do that? I wonder if we should be
setting 'hardware_entry_failure_reason' to distinguish this case.

Will
