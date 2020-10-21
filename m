Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4256294DF4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441928AbgJUNvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439776AbgJUNvf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:51:35 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B325A20BED;
        Wed, 21 Oct 2020 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603288294;
        bh=/nKdDyAxIqN7pIs18W8ehdQ5UJegNIz1fKfH58kmRCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=deyKgK/GdPCoahe4hN3+1KbtkkgCCBAf2nEvvarL7X0BDLvkuqvbjOE6EHn4LBhNM
         JBCLqf6giocAEb9PrkCCbV6jXagGz69BKT5ZweTNZNSzQD8vvzwpoL5drf26qcTmLx
         yQLVks7oEuz8I/Fepgr5dZ00cjgcaGX29gnE8uBg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kVEWa-0033SE-Oo; Wed, 21 Oct 2020 14:51:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Oct 2020 14:51:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] arm64: kvm: Handle Asymmetric AArch32 systems
In-Reply-To: <20201021133543.zeyghjzujivnds2d@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-2-qais.yousef@arm.com>
 <4035e634eb2bfce4b88a159b2ec2f267@kernel.org>
 <20201021133543.zeyghjzujivnds2d@e107158-lin>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <87587dbfb7bee53eca4d1b837fd8194a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qais.yousef@arm.com, catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-21 14:35, Qais Yousef wrote:
> On 10/21/20 13:02, Marc Zyngier wrote:
>> On 2020-10-21 11:46, Qais Yousef wrote:
>> > On a system without uniform support for AArch32 at EL0, it is possible
>> > for the guest to force run AArch32 at EL0 and potentially cause an
>> > illegal exception if running on the wrong core.
>> 
>> s/the wrong core/a core without AArch32/
>> 
>> >
>> > Add an extra check to catch if the guest ever does that and prevent it
>> 
>> Not "if the guest ever does that". Rather "let's hope we are lucky 
>> enough
>> to catch the guest doing that".
>> 
>> > from running again by resetting vcpu->arch.target and return
>> > ARM_EXCEPTION_IL.
>> >
>> > We try to catch this misbehavior as early as possible and not rely on
>> > PSTATE.IL to occur.
>> >
>> > Tested on Juno by instrumenting the host to:
>> >
>> > 	* Fake asym aarch32.
>> > 	* Instrument KVM to make the asymmetry visible to the guest.
>> >
>> > Any attempt to run 32bit app in the guest will produce such error on
>> > qemu:
>> 
>> Not *any* attempt. Only the ones where the guest exits whilst in
>> AArch32 EL0. It is perfectly possible for the guest to use AArch32
>> undetected for quite a while.
> 
> Thanks Marc! I'll change them all.
> 
>> >
>> > 	# ./test
>> > 	error: kvm run failed Invalid argument
>> > 	 PC=ffff800010945080 X00=ffff800016a45014 X01=ffff800010945058
>> > 	X02=ffff800016917190 X03=0000000000000000 X04=0000000000000000
>> > 	X05=00000000fffffffb X06=0000000000000000 X07=ffff80001000bab0
>> > 	X08=0000000000000000 X09=0000000092ec5193 X10=0000000000000000
>> > 	X11=ffff80001608ff40 X12=ffff000075fcde86 X13=ffff000075fcde88
>> > 	X14=ffffffffffffffff X15=ffff00007b2105a8 X16=ffff00007b006d50
>> > 	X17=0000000000000000 X18=0000000000000000 X19=ffff00007a82b000
>> > 	X20=0000000000000000 X21=ffff800015ccd158 X22=ffff00007a82b040
>> > 	X23=ffff00007a82b008 X24=0000000000000000 X25=ffff800015d169b0
>> > 	X26=ffff8000126d05bc X27=0000000000000000 X28=0000000000000000
>> > 	X29=ffff80001000ba90 X30=ffff80001093f3dc  SP=ffff80001000ba90
>> > 	PSTATE=60000005 -ZC- EL1h
>> > 	qemu-system-aarch64: Failed to get KVM_REG_ARM_TIMER_CNT
>> 
>> It'd be worth working out:
>> - why does this show an AArch64 mode it we caught the vcpu in AArch32?
>> - why does QEMU shout about the timer register?
> 
> /me puts a monocular on
> 
> Which bit is the AArch64?

It clearly spits out "EL1h", and PSTATE.M is 5, also consistent with 
EL1h.

> It did surprise me that it is shouting about the timer. My guess was 
> that
> a timer interrupt at the guest between exit/reentry caused the state 
> change and
> the failure to read the timer register? Since the target is no longer 
> valid it
> falls over, hopefully as expected. I could have been naive of course. 
> That
> explanation made sense to my mind so I didn't dig further.

Userspace is never involved with the timer interrupt, unless you've 
elected
to have the interrupt controller in userspace, which I seriously doubt.

As we are introducing a change to the userspace ABI, it'd be interesting
to find out what is happening here.

         M.
-- 
Jazz is not dead. It just smells funny...
