Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288CF28892B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgJIMsY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 08:48:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbgJIMsW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 08:48:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D35F01063;
        Fri,  9 Oct 2020 05:48:21 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE083F70D;
        Fri,  9 Oct 2020 05:48:20 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:48:18 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
Message-ID: <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63e379d1399b5c898828f6802ce3dca5@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/20 13:34, Marc Zyngier wrote:
> On 2020-10-09 10:58, Qais Yousef wrote:
> 
> [...]
> 
> > > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > > index b588c3b5c2f0..22ff3373d855 100644
> > > > --- a/arch/arm64/kvm/arm.c
> > > > +++ b/arch/arm64/kvm/arm.c
> > > > @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > > >  	struct kvm_run *run = vcpu->run;
> > > >  	int ret;
> > > >
> > > > +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> > > > +		kvm_err("Illegal AArch32 mode at EL0, can't run.");
> > > 
> > > No, we don't scream on the console in an uncontrolled way based on
> > > illegal user input (yes, the VM *is* userspace).
> > 
> > It seemed kind to print a good reason of what just happened.
> 
> I'm afraid it only serves as an instrument to spam the console. Userspace
> gave you an illegal state, you respond with an error. The error is, on
> its own, descriptive enough. In general, we only print on the console
> when KVM is faced with an internal error of some sort. That's not the
> case here.

Fair enough.

> 
> > 
> > > 
> > > Furthermore, you seem to deal with the same problem *twice*. See
> > > below.
> > 
> > It's done below because we could loop back into the guest again, so we
> > force an
> > exit then. Here to make sure if the VMM ignores the error value we
> > returned
> > earlier it can't force its way back in again.
> 
> Which we already handle if you do what I hinted at below.
> 
> > > 
> > > > +		return -ENOEXEC;
> > > > +	}
> > > > +
> > > >  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
> > > >  		return -ENOEXEC;
> > > >
> > > > @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > > >
> > > >  		preempt_enable();
> > > >
> > > > +		/*
> > > > +		 * For asym aarch32 systems we present a 64bit only system to
> > > > +		 * the guest. But in case it managed somehow to escape that and
> > > > +		 * enter 32bit mode, catch that and prevent it from running
> > > > +		 * again.
> > > 
> > > The guest didn't *escape* anything. It merely used the CPU as
> > > designed.
> > > The fact that the hypervisor cannot prevent the guest from using
> > > AArch32
> > > is an architectural defect.
> > 
> > Happy to change the wording if you tell me what you prefer :-)
> 
> "The ARMv8 architecture doesn't give the hypervisor a mechanism to prevent
>  a guest from dropping to AArch32 EL0 if implemented by the CPU. If we spot
>  the guest in such state and that we decided it wasn't supposed to do so
>  (like with the asymmetric AArch32 case), return to userspace with a fatal
>  error."

Thanks.

> > Because I probably didn't navigate my way correctly around the code.
> > Mind
> > expanding how to mark the vcpu as uninitialized? I have tried 2 ways
> > in that effect but they were really horrible, so will abstain from
> > sharing :-)
> 
> You can try setting vcpu->arch.target to -1, which is already caught by
> kvm_vcpu_initialized() right at the top of this function. This will
> prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.

That's actually one of the things I tried before ending with this patch.
I thought it's really aggressive and unfriendly.

It does indeed cause qemu to abort out completely.

> +                       /* Reset target so it won't run again */
> +                       vcpu->arch.target = -1;
>
>       # ./test
>       error: kvm run failed Invalid argument
>        PC=ffff80001093ad64 X00=ffff80001686d014 X01=ffff80001093ad40
>       X02=3fa71c3de1990200 X03=0000000000000030 X04=0000000000000000
>       X05=0000000000000000 X06=ffff0000767d3c06 X07=74246e6873716875
>       X08=7f7f7f7f7f7f7f7f X09=0400000000000001 X10=0101010101010101
>       X11=0000000000000001 X12=ffff800016887000 X13=ffff0000767d3c07
>       X14=ffff0000767d3c08 X15=ffff80001618a988 X16=000000000000000e
>       X17=0000000000000000 X18=ffffffffffffffff X19=ffff00007ad99800
>       X20=ffff8000163d20b8 X21=0000000000000000 X22=ffff00007ad99810
>       X23=ffff8000163d2270 X24=ffff8000163d22d0 X25=0000000000000000
>       X26=ffff800012bb5b80 X27=ffff800012cc1068 X28=0000000000000007
>       X29=ffff80001668bab0 X30=ffff8000109367c8  SP=ffff80001668bab0
>       PSTATE=80000005 N--- EL1h
>       qemu-system-aarch64: Failed to get KVM_REG_ARM_TIMER_CNT
>       Aborted

Thanks

--
Qais Yousef
