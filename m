Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3116294D62
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395011AbgJUNU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:20:59 -0400
Received: from foss.arm.com ([217.140.110.172]:35300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390968AbgJUNU7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:20:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBB4831B;
        Wed, 21 Oct 2020 06:20:58 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632AC3F66B;
        Wed, 21 Oct 2020 06:20:57 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:20:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021132054.3eg2vtietk6x6occ@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021121559.GB3976@gaia>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 13:15, Catalin Marinas wrote:
> On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> > On 2020-10-21 11:46, Qais Yousef wrote:
> > > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > > printed out
> > > although it's set as FTR_HIDDEN.

                           ^^^^^^^^^

> > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 
> > > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > > 
> > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > 0x0000000000000011
> > > 0x0000000000000011
> > > 0x0000000000000012
> > > 0x0000000000000012
> > > 0x0000000000000011
> > > 0x0000000000000011
> > 
> > This looks like a terrible userspace interface. It exposes unrelated
> > features,
> 
> Not sure why the EL1 field ended up in here, that's not relevant to the
> user.

I was surprised by this too. Not sure a bug at my end or a bug in the way
arm64_ftr_reg stores reg->user_val and reg->user_mask.

FWIW, I did highlight the problem above.

It is something to fix indeed.

Thanks

--
Qais Yousef
