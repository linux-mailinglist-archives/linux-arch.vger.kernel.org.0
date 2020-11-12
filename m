Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC82B0B5E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Nov 2020 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKLRgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Nov 2020 12:36:50 -0500
Received: from foss.arm.com ([217.140.110.172]:54822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgKLRgu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Nov 2020 12:36:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76EB6169C;
        Thu, 12 Nov 2020 09:36:49 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 264773F73C;
        Thu, 12 Nov 2020 09:36:48 -0800 (PST)
Date:   Thu, 12 Nov 2020 17:36:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201112173645.7jdq3gtwisiryscd@e107158-lin.cambridge.arm.com>
References: <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
 <20201106130007.GA10605@willie-the-truck>
 <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
 <20201109135259.GA14526@willie-the-truck>
 <20201111162700.p4sem2fup5qjjbqz@e107158-lin.cambridge.arm.com>
 <20201112102424.GB19506@willie-the-truck>
 <20201112115555.65sfsod6uf6xm5gy@e107158-lin.cambridge.arm.com>
 <20201112164943.7kdskvxcnuodphow@e107158-lin.cambridge.arm.com>
 <901a3fe0c600d81d6097fe31b0b9b02b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <901a3fe0c600d81d6097fe31b0b9b02b@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/12/20 17:06, Marc Zyngier wrote:
> On 2020-11-12 16:49, Qais Yousef wrote:
> > On 11/12/20 11:55, Qais Yousef wrote:
> > > On 11/12/20 10:24, Will Deacon wrote:
> > > > On Wed, Nov 11, 2020 at 04:27:00PM +0000, Qais Yousef wrote:
> > > > > On 11/09/20 13:52, Will Deacon wrote:
> > > > > > On Fri, Nov 06, 2020 at 02:48:35PM +0000, Qais Yousef wrote:
> > > > > > > On 11/06/20 13:00, Will Deacon wrote:
> > > > > > > > On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> > > > > > > > > FWIW I have my v3 over here in case it's of any help. It solves the problem of
> > > > > > > > > HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> > > > > > > > > with 32bit features then.
> > > > > > > > >
> > > > > > > > > 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3
> > > > > > > >
> > > > > > > > Cheers, I've done something similar. I was hoping to post it today, but I've
> > > > > > > > been side-tracked with bug fixing this morning. The main headache I ended up
> > > > > > > > with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
> > > > > > > > are 32-bit capable. What do you do in that case?
> > > > > > >
> > > > > > > Do you mean if CPUs 0-3 were 32bit capable and we boot with maxcpus=4 then
> > > > > > > attempt to bring the remaining 64bit-only cpus online later?
> > > > > >
> > > > > > Right. I think we will refuse to online them. I'll post my attempt at
> > > > > > handling that shortly.
> > > > >
> > > > > Sorry for the delayed response.
> > > > >
> > > > > You're right, I tried that and they refuse to come online. We missed that tbh.
> > > > >
> > > > > Haven't thought what we should do yet. I tried your v2 and it failed similarly.
> > > >
> > > > Hmm, it shouldn't do. Please could you provide the log? My hunch is that you
> > > > are blatting 32-bit EL1 support as well, and we can't handle a mismatch for
> > > > that with a late CPU. Do you know if the CPUs being integrated into these
> > > > broken designs have a mismatch at EL1 as well?
> > > 
> > > Hmm my test could have been invalid then. We shouldn't have mismatch
> > > at EL1,
> > > for ease of testing I used a hacked up patch to fake asymmetry on
> > > Juno. Testing
> > > on FVP now, it takes time to boot up though..
> > > 
> > > Let me re-run this and get you the log from proper environment.
> > > Assuming it
> > > still fails.
> > 
> > Still fails the same on FVP. dmesg attached. There's a splat shortly
> > after
> > attempting to online CPU 4.
> > 
> > 	# cat /sys/devices/system/cpu/online
> > 	0-3
> > 	# cat /sys/devices/system/cpu/aarch32_el0
> > 	0-3
> > 
> > Now while writing this I just realized I tell the FVP to disable aarch32
> > support at EL0. So this might still make the kernel thinks there's
> > AArch32
> > support at EL1 - which seems is what makes your series get confused?
> 
> You can't have AArch32 at EL1 and not have it at EL0.
> 
> > Anyway. No real hardware to test on and not sure if I can tell the FVP
> > to
> > disable AArch32 support at EL1.
> > 
> > /me goes and dig
> 
>         -C cluster0.max_32bit_el=-1     # no 32bit support whatsoever
>         -C cluster1.max_32bit_el=0      # 32bit support at EL0 only

Ah okay. That's the option I use. I must have misinterpreted Will's words then
'blatting 32-bit EL1'. Blame my English :-)

Thanks

--
Qais Yousef
