Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42971296047
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900449AbgJVNr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 09:47:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900438AbgJVNr4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 09:47:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E073E101E;
        Thu, 22 Oct 2020 06:47:55 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9993F66E;
        Thu, 22 Oct 2020 06:47:54 -0700 (PDT)
Date:   Thu, 22 Oct 2020 14:47:52 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022134752.wtcdkbi4fjn2blh6@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021144112.GA17912@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 15:41, Will Deacon wrote:
> > We already expose MIDR and REVIDR via the current sysfs interface. We
> > can expand it to include _all_ the other ID_* regs currently available
> > to user via the MRS emulation and we won't have to debate what a new
> > interface would look like. The MRS emulation and the sysfs info should
> > probably match, though that means we need to expose the
> > ID_AA64PFR0_EL1.EL0 field which we currently don't.
> > 
> > I do agree that an AArch32 cpumask is an easier option both from the
> > kernel implementation perspective and from the application usability
> > one, though not as easy as automatic task placement by the scheduler (my
> > first preference, followed by the id_* regs and the aarch32 mask, though
> > not a strong preference for any).
> 
> If a cpumask is easier to implement and easier to use, then I think that's
> what we should do. It's also then dead easy to disable if necessary by
> just returning 0. The only alternative I would prefer is not having to
> expose this information altogether, but I'm not sure that figuring this
> out from MIDR/REVIDR alone is reliable.

So the mask idea is about adding a new

	/sys/devices/system/cpu/aarch32_cpus

?

I just need to make sure that Peter and Greg are happy with this arm64 specific
mask added to sysfs in this manner. Not sure if there's a precedent of archs
exporting special masks in sysfs.

Or maybe people had something else in mind about how his this mask should be
exported?

Thanks

--
Qais Yousef
