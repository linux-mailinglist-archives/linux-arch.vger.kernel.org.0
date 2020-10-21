Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65F294D4B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437414AbgJUNPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:15:08 -0400
Received: from foss.arm.com ([217.140.110.172]:35160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437413AbgJUNPI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E16131B;
        Wed, 21 Oct 2020 06:15:08 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA733F66B;
        Wed, 21 Oct 2020 06:15:06 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:15:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Message-ID: <20201021131504.vc3nbf2vt5dtiuva@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021112656.GB1141598@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021112656.GB1141598@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg

On 10/21/20 13:26, Greg Kroah-Hartman wrote:
> On Wed, Oct 21, 2020 at 11:46:07AM +0100, Qais Yousef wrote:
> > This series adds basic support for Asymmetric AArch32 systems. Full rationale
> > is in v1's cover letter.
> > 
> > 	https://lore.kernel.org/linux-arch/20201008181641.32767-1-qais.yousef@arm.com/
> 
> That is not good, provide full rational in each place, not everyone has
> web access at all time.

Sorry. I usually copy the whole thing but for the first time I do this as
I thought it'd be better to be less wordy. I'll copy the whole thing again next
time.

> Also, you forgot to document this in Documentation/ABI/ like is required
> for sysfs files, and I thought I asked for last time.

Last time there was no sysfs info. It's introduced for the first time here.
There's still no consensus on which direction to go, that is fix it in the
scheduler or let user space handle it all.

> > Changes in v2:
> > 
> > 	* We now reset vcpu->arch.target to force re-initialized for KVM patch.
> > 	  (Marc)
> > 
> > 	* Fix a bug where this_cpu_has_cap() must be called with preemption
> > 	  disabled in check_aarch32_cpumask().
> > 
> > 	* Add new sysctl.enable_asym_32bit. (Catalin)
> > 
> > 	* Export id_aar64fpr0 register in sysfs which allows user space to
> > 	  discover which cpus support 32bit@EL0. The sysctl must be enabled for
> > 	  the user space to discover the asymmetry. (Will/Catalin)
> > 
> > 	* Fixing up affinity in the kernel approach was dropped. The support
> > 	  assumes the user space that wants to enable this support knows how to
> > 	  guarantee correct affinities for 32bit apps by using cpusets.
> 
> I asked you to work with Intel to come up with an agreement of how this
> is going to be represented in userspace.  Why did you not do that?

I did chip in to that thread. AFAIU they're doing something completely
different and unrelated. Their goal is unclear too. They care about big.LITTLE
type of support for Intel and collating already existing information in
a different/new place. I don't see the point. I saw they had several similar
comments from others. They need to send a new version to see if anything
changes.

> Without even looking at the patch set, this is not ok...

Sorry about that. Please keep in mind we're still debating if we want to
support this upstream. And if we do, what shape this should take. My first
version highlighted how things could look like if scheduler took care of the
problem. Now this RFC tries to highlight how things could look like if we go
with pure user space based solution. It's to help maintainers get a better
appreciation of what implementation details incurred in either direction.

At least that was my intention.

I'll improve on the cover letter next time.

Thanks

--
Qais Yousef
