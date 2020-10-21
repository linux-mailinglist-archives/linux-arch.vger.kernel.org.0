Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03286294D5D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394594AbgJUNSO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:18:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394432AbgJUNSO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:18:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 878BE31B;
        Wed, 21 Oct 2020 06:18:13 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334AC3F66B;
        Wed, 21 Oct 2020 06:18:12 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:18:09 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021131809.icoxcu2ngzcznw2d@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021112519.GA1141598@kroah.com>
 <a534ade95315a55c4ab3048727d846a1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a534ade95315a55c4ab3048727d846a1@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 12:46, Marc Zyngier wrote:
> On 2020-10-21 12:25, Greg Kroah-Hartman wrote:
> > On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> > > On 2020-10-21 11:46, Qais Yousef wrote:
> > > > So that userspace can detect if the cpu has aarch32 support at EL0.
> > > >
> > > > CPUREGS_ATTR_RO() was renamed to CPUREGS_RAW_ATTR_RO() to better reflect
> > > > what it does. And fixed to accept both u64 and u32 without causing the
> > > > printf to print out a warning about mismatched type. This was caught
> > > > while testing to check the new CPUREGS_USER_ATTR_RO().
> > > >
> > > > The new CPUREGS_USER_ATTR_RO() exports a Sanitised or RAW sys_reg based
> > > > on a @cond to user space. The exported fields match the definition in
> > > > arm64_ftr_reg so that the content of a register exported via MRS and
> > > > sysfs are kept cohesive.
> > > >
> > > > The @cond in our case is that the system is asymmetric aarch32 and the
> > > > controlling sysctl.enable_asym_32bit is enabled.
> > > >
> > > > Update Documentation/arm64/cpu-feature-registers.rst to reflect the
> > > > newly visible EL0 field in ID_AA64FPR0_EL1.
> > > >
> > > > Note that the MRS interface will still return the sanitized content
> > > > _only_.
> > > >
> > > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > > ---
> > > >
> > > > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > > > printed out
> > > > although it's set as FTR_HIDDEN.
> > > >
> > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > >
> > > > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > > >
> > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000012
> > > > 0x0000000000000012
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > 
> > > This looks like a terrible userspace interface.
> > 
> > It's also not allowed, sorry.  sysfs is "one value per file", which is
> > NOT what is happening at all.
> 
> I *think* Qais got that part right, though it is hard to tell without
> knowing how many CPUs this system has (cpu/cpu* is ambiguous).

Correct. This interface already exists for other registers and reads a single
value for each CPU. I just added the ability to read a new register. Though it
has a slightly different behavior: reads Sanitized vs RAW info.

Thanks

--
Qais Yousef
