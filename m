Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56E2960F1
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368176AbgJVObI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 10:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368175AbgJVObI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 10:31:08 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6751524171;
        Thu, 22 Oct 2020 14:31:05 +0000 (UTC)
Date:   Thu, 22 Oct 2020 15:31:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022143102.GH1229@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201022134752.wtcdkbi4fjn2blh6@e107158-lin>
 <20201022135559.GB1788090@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022135559.GB1788090@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 22, 2020 at 03:55:59PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2020 at 02:47:52PM +0100, Qais Yousef wrote:
> > On 10/21/20 15:41, Will Deacon wrote:
> > > > We already expose MIDR and REVIDR via the current sysfs interface. We
> > > > can expand it to include _all_ the other ID_* regs currently available
> > > > to user via the MRS emulation and we won't have to debate what a new
> > > > interface would look like. The MRS emulation and the sysfs info should
> > > > probably match, though that means we need to expose the
> > > > ID_AA64PFR0_EL1.EL0 field which we currently don't.
> > > > 
> > > > I do agree that an AArch32 cpumask is an easier option both from the
> > > > kernel implementation perspective and from the application usability
> > > > one, though not as easy as automatic task placement by the scheduler (my
> > > > first preference, followed by the id_* regs and the aarch32 mask, though
> > > > not a strong preference for any).
> > > 
> > > If a cpumask is easier to implement and easier to use, then I think that's
> > > what we should do. It's also then dead easy to disable if necessary by
> > > just returning 0. The only alternative I would prefer is not having to
> > > expose this information altogether, but I'm not sure that figuring this
> > > out from MIDR/REVIDR alone is reliable.
> > 
> > So the mask idea is about adding a new
> > 
> > 	/sys/devices/system/cpu/aarch32_cpus
> > 
> > ?
> 
> Is this a file, a directory, or what?  What's the contents?
> 
> Without any of that, I have no idea if it's "ok" or not...

I don't know what Qais thinks but a file matching the syntax of the
present/online/offline/possible files (e.g. 0-3) would look more
consistent.

-- 
Catalin
