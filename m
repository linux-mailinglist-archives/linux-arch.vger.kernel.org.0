Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2668C294EDE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441941AbgJUOiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 10:38:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441928AbgJUOiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 10:38:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25481D6E;
        Wed, 21 Oct 2020 07:38:18 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C94013F66B;
        Wed, 21 Oct 2020 07:38:16 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:38:14 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] arm64: kvm: Handle Asymmetric AArch32 systems
Message-ID: <20201021143814.vpad2dfg7gplvghy@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-2-qais.yousef@arm.com>
 <4035e634eb2bfce4b88a159b2ec2f267@kernel.org>
 <20201021133543.zeyghjzujivnds2d@e107158-lin>
 <87587dbfb7bee53eca4d1b837fd8194a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87587dbfb7bee53eca4d1b837fd8194a@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 14:51, Marc Zyngier wrote:
> On 2020-10-21 14:35, Qais Yousef wrote:
> > On 10/21/20 13:02, Marc Zyngier wrote:
> > > On 2020-10-21 11:46, Qais Yousef wrote:
> > > > On a system without uniform support for AArch32 at EL0, it is possible
> > > > for the guest to force run AArch32 at EL0 and potentially cause an
> > > > illegal exception if running on the wrong core.
> > > 
> > > s/the wrong core/a core without AArch32/
> > > 
> > > >
> > > > Add an extra check to catch if the guest ever does that and prevent it
> > > 
> > > Not "if the guest ever does that". Rather "let's hope we are lucky
> > > enough
> > > to catch the guest doing that".
> > > 
> > > > from running again by resetting vcpu->arch.target and return
> > > > ARM_EXCEPTION_IL.
> > > >
> > > > We try to catch this misbehavior as early as possible and not rely on
> > > > PSTATE.IL to occur.
> > > >
> > > > Tested on Juno by instrumenting the host to:
> > > >
> > > > 	* Fake asym aarch32.
> > > > 	* Instrument KVM to make the asymmetry visible to the guest.
> > > >
> > > > Any attempt to run 32bit app in the guest will produce such error on
> > > > qemu:
> > > 
> > > Not *any* attempt. Only the ones where the guest exits whilst in
> > > AArch32 EL0. It is perfectly possible for the guest to use AArch32
> > > undetected for quite a while.
> > 
> > Thanks Marc! I'll change them all.
> > 
> > > >
> > > > 	# ./test
> > > > 	error: kvm run failed Invalid argument
> > > > 	 PC=ffff800010945080 X00=ffff800016a45014 X01=ffff800010945058
> > > > 	X02=ffff800016917190 X03=0000000000000000 X04=0000000000000000
> > > > 	X05=00000000fffffffb X06=0000000000000000 X07=ffff80001000bab0
> > > > 	X08=0000000000000000 X09=0000000092ec5193 X10=0000000000000000
> > > > 	X11=ffff80001608ff40 X12=ffff000075fcde86 X13=ffff000075fcde88
> > > > 	X14=ffffffffffffffff X15=ffff00007b2105a8 X16=ffff00007b006d50
> > > > 	X17=0000000000000000 X18=0000000000000000 X19=ffff00007a82b000
> > > > 	X20=0000000000000000 X21=ffff800015ccd158 X22=ffff00007a82b040
> > > > 	X23=ffff00007a82b008 X24=0000000000000000 X25=ffff800015d169b0
> > > > 	X26=ffff8000126d05bc X27=0000000000000000 X28=0000000000000000
> > > > 	X29=ffff80001000ba90 X30=ffff80001093f3dc  SP=ffff80001000ba90
> > > > 	PSTATE=60000005 -ZC- EL1h
> > > > 	qemu-system-aarch64: Failed to get KVM_REG_ARM_TIMER_CNT
> > > 
> > > It'd be worth working out:
> > > - why does this show an AArch64 mode it we caught the vcpu in AArch32?
> > > - why does QEMU shout about the timer register?
> > 
> > /me puts a monocular on
> > 
> > Which bit is the AArch64?
> 
> It clearly spits out "EL1h", and PSTATE.M is 5, also consistent with EL1h.
> 
> > It did surprise me that it is shouting about the timer. My guess was
> > that
> > a timer interrupt at the guest between exit/reentry caused the state
> > change and
> > the failure to read the timer register? Since the target is no longer
> > valid it
> > falls over, hopefully as expected. I could have been naive of course.
> > That
> > explanation made sense to my mind so I didn't dig further.
> 
> Userspace is never involved with the timer interrupt, unless you've elected
> to have the interrupt controller in userspace, which I seriously doubt.
> 
> As we are introducing a change to the userspace ABI, it'd be interesting
> to find out what is happening here.

Sure. Let me educate myself more about this and find a way to interrogate qemu
and KVM.

Thanks

--
Qais Yousef
