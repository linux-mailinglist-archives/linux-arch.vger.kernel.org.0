Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B711DE492
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEVKhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 06:37:21 -0400
Received: from foss.arm.com ([217.140.110.172]:32958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgEVKhU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 06:37:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E358D6E;
        Fri, 22 May 2020 03:37:19 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2FC23F305;
        Fri, 22 May 2020 03:37:17 -0700 (PDT)
Date:   Fri, 22 May 2020 11:37:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Daly <pdaly@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200522103714.GA26492@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522055710.GA25791@pdaly-linux.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Patrick,

On Thu, May 21, 2020 at 10:57:10PM -0700, Patrick Daly wrote:
> On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> > On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > index f2a93c8679e8..7436e7462b85 100644
> > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > @@ -373,6 +373,10 @@
> > > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > > >  			Format: <io>,<irq>,<nodeID>
> > > > >  
> > > > > +	arm64.mte_disable=
> > > > > +			[ARM64] Disable Linux support for the Memory
> > > > > +			Tagging Extension (both user and in-kernel).
> > > > > +
> > > > 
> > > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > > 
> > > I don't think "performance analysis" is a good justification for this
> > > parameter tbh. We don't tend to add these options for other architectural
> > > features, and I don't see why MTE is any different in this regard.
> > 
> > There is an expectation of performance impact with MTE enabled,
> > especially if it's running in synchronous mode. For the in-kernel MTE,
> > we could add a parameter which sets sync vs async at boot time rather
> > than a big disable knob. It won't affect user space however.
> > 
> > The other 'justification' is if your hardware has weird unexpected
> > behaviour but I'd like this handled via errata workarounds.
> > 
> > I'll let the people who asked for this to chip in ;). I agree with you
> > that we rarely add these (and I rejected a similar option a few weeks
> > ago on the AMU patchset).
> 
> We've been looking into other ways this on/off behavior could be achieved.

The actual question here is what the on/off behaviour is needed for. We
can figure out the best mechanism for this once we know what we want to
achieve. My wild guess above was performance analysis but that can be
toggled by either kernel boot parameter or run-time sysctl (or just the
Kconfig option).

If it is about forcing user space not to use MTE, we may look into some
other sysctl controls (we already have one for the tagged address ABI).

If it is for working around hardware not supporting MTE (i.e. no
allocation tag storage), this should be handled differently, not by
kernel parameter.

> The "arm,armv8.5-memtag" DT flag already provides what we want - meaning
> that this flag could be removed if the system did not support MTE.
> 
> I did see your remark on "arm64: mte: Check the DT memory nodes for MTE support"
> questioning whether it was the right approach - is this still the case?

My plan is to remove the DT patch altogether _if_ I get confirmation
from the CPU designers. The idea is that if ID_AA64PFR1_EL1.MTE > 1,
Linux can assume system-wide MTE support. If an MTE-capable CPU is
deployed in an SoC without tag storage, a tie-off should change the ID
field to 1 (or 0). If we do find hardware with an ID field > 1 and no
tag storage, it will be handled as an SoC erratum in the kernel,
probably tied to the new SoC Id advertised by firmware (Sudeep had some
patches recently).

Thanks.

-- 
Catalin
