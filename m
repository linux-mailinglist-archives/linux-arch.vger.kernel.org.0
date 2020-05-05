Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF31C53E3
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEELFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 07:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgEELFX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 07:05:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD1CD30E;
        Tue,  5 May 2020 04:05:22 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABBB23F305;
        Tue,  5 May 2020 04:05:21 -0700 (PDT)
Date:   Tue, 5 May 2020 12:05:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505110519.GM30377@arm.com>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505104454.GC19710@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Mon, May 04, 2020 at 04:32:35PM +0100, Dave Martin wrote:
> > I considering trying to plug some gaps in the arch-specific ABI
> > documentation in the linux man-pages, specifically for arm64 (and
> > possibly arm, where compat means we have some overlap).
> > 
> > For arm64, there are now significant new extensions (Pointer
> > authentication, SVE, MTE etc.)  Currently there is some user-facing
> > documentation mixed in with the kernel-facing documentation in the
> > kernel tree, but this situation isn't ideal.
> > 
> > Do you have an opinion on where in the man-pages documentation should be
> > added, and how to structure it?
> > 
> > 
> > Affected areas include:
> > 
> >  * exec interface
> >  * aux vector, hwcaps
> >  * arch-specific signals
> >  * signal frame
> >  * mmap/mprotect extensions
> >  * prctl calls
> >  * ptrace quirks and extensions
> >  * coredump contents
> > 
> > 
> > Not everything has an obvious home in an existing page, and adding
> > specifics for every architecture could make some existing manpages very
> > unwieldy.
> > 
> > I think for some arch features, we really need some "overview" pages
> > too: just documenting the low-level details is of limited value
> > without some guide as to how to use them together.
> > 
> > 
> > Does the following sketch look reasonable?
> > 
> >  * man7/arm64.7: new page: overview of arm64-specific ABI extensions
> > 
> >  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
> >    overview of arm64 SVE ABI
> > 
> >  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
> >    arm64 ptrace extensions
> 
> Michael has been nagging me on and off about that for, what, 10 years now?
> I would therefore be very much in favour of having our ptrace extensions
> documented!
> 
> We could even put this stuff under Documentation/arm64/man/ if it's deemed
> too CPU-specific for the man-pages project, but my preference would still
> be for it to be hosted there alongside all the other man pages.

Heh, perhaps we could build that into the kernel and mount it somewhere.


Seriously though,

I guess I can start off with straightforward small things for which the
documentation has an obvious home (like prctls[*]) and then move on to
the bigger stuff like ptrace.

If people start shouting about a page getting too big or messy I can try
to split it up.

Make sense?

Cheers
---Dave


[*] "straightforward" was a joke, obviously
