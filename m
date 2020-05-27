Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C604F1E3E1F
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgE0JzM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 05:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgE0JzL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 05:55:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECDD20B80;
        Wed, 27 May 2020 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590573311;
        bh=fus0z074K2+v5viezNh5aSTINzkfZlDW5gDLPTcN3rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0E4osRJDeF5F9676q35dVh44ubGc76fAsV838gxtkC0dMpGT+R8yCAz744kJTI6vv
         +omcCl+atGm3jy4pKReRU4Gg0HdBFfoVtavYZR/imqGupWJKP+XANkpWp3pTqLJqtM
         N5eQfGrHl4rf9HtHLPDBh8apf64eXXFp2aLbdclc=
Date:   Wed, 27 May 2020 10:55:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Patrick Daly <pdaly@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200527095504.GB11111@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
 <20200522103714.GA26492@gaia>
 <20200527021153.GA24439@pdaly-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527021153.GA24439@pdaly-linux.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 26, 2020 at 07:11:53PM -0700, Patrick Daly wrote:
> On Fri, May 22, 2020 at 11:37:15AM +0100, Catalin Marinas wrote:
> > On Thu, May 21, 2020 at 10:57:10PM -0700, Patrick Daly wrote:
> > > On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> > > > On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > > > > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > > > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > index f2a93c8679e8..7436e7462b85 100644
> > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > @@ -373,6 +373,10 @@
> > > > > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > > > > >  			Format: <io>,<irq>,<nodeID>
> > > > > > >  
> > > > > > > +	arm64.mte_disable=
> > > > > > > +			[ARM64] Disable Linux support for the Memory
> > > > > > > +			Tagging Extension (both user and in-kernel).
> > > > > > > +
> > > > > > 
> > > > > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > > > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > > > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > > > > 
> > > > > I don't think "performance analysis" is a good justification for this
> > > > > parameter tbh. We don't tend to add these options for other architectural
> > > > > features, and I don't see why MTE is any different in this regard.
> > > > 
> > > > There is an expectation of performance impact with MTE enabled,
> > > > especially if it's running in synchronous mode. For the in-kernel MTE,
> > > > we could add a parameter which sets sync vs async at boot time rather
> > > > than a big disable knob. It won't affect user space however.
> > > > 
> > > > The other 'justification' is if your hardware has weird unexpected
> > > > behaviour but I'd like this handled via errata workarounds.
> > > > 
> > > > I'll let the people who asked for this to chip in ;). I agree with you
> > > > that we rarely add these (and I rejected a similar option a few weeks
> > > > ago on the AMU patchset).
> > > 
> > > We've been looking into other ways this on/off behavior could be achieved.
> > 
> > The actual question here is what the on/off behaviour is needed for. We
> > can figure out the best mechanism for this once we know what we want to
> > achieve. My wild guess above was performance analysis but that can be
> > toggled by either kernel boot parameter or run-time sysctl (or just the
> > Kconfig option).
> > 
> > If it is about forcing user space not to use MTE, we may look into some
> > other sysctl controls (we already have one for the tagged address ABI).
> 
> We want to allow the end user to be able to easily "opt out" of MTE in favour
> of better power, perf and battery life.

Who is "the end user" in this case?

If MTE is bad enough for power, performance and battery life that we need a
kill switch, then perhaps we shouldn't enable it by default and the few
people that want to use it can build a kernel with it enabled. However, then
I don't really see what MTE buys you over the existing KASAN implementations.

I thought the general idea was that you could run in the (cheap) "async"
mode, and then re-run in the more expensive "sync" mode to further diagnose
any failures. That model seems to work well with these patches, since
reporting is disabled by default. Are you saying that there is a
significant penalty incurred even when reporting is not enabled?

Anyway, we don't offer global runtime/cmdline switches for the vast majority
of other architectural features -- instead, we choose a sensible default,
and I think we should do the same here.

Will
