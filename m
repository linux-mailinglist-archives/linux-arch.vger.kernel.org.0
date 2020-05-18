Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F391D7F36
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgERQw1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 12:52:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQw1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A1D3106F;
        Mon, 18 May 2020 09:52:27 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EE723F305;
        Mon, 18 May 2020 09:52:25 -0700 (PDT)
Date:   Mon, 18 May 2020 17:52:23 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>, nd@arm.com,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200518165223.GB5031@arm.com>
References: <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
 <20200515120433.GE27289@arm.com>
 <20200515121343.GC22393@gaia>
 <20200515125332.GF27289@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515125332.GF27289@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 01:53:32PM +0100, Szabolcs Nagy wrote:
> The 05/15/2020 13:13, Catalin Marinas wrote:
> > On Fri, May 15, 2020 at 01:04:33PM +0100, Szabolcs Nagy wrote:
> > > The 05/15/2020 12:27, Catalin Marinas wrote:
> > > > Thanks Szabolcs. While we are at this, no-one so far asked for the
> > > > GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> > > > Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> > > > thought there isn't much point in exposing this configuration to the
> > > > user. The only advantage of RRND=0 I see is that the kernel can change
> > > 
> > > it seems RRND=1 is the impl specific algorithm.
> > 
> > Yes, that's the implementation specific algorithm which shouldn't be
> > worse than the standard one.
> > 
> > > > the seed randomly but, with only 4 bits per tag, it really doesn't
> > > > matter much.
> > > > 
> > > > Anyway, mentioning it here in case anyone is surprised later about the
> > > > lack of RRND configurability.
> > > 
> > > i'm not familiar with how irg works.
> > 
> > It generates a random tag based on some algorithm.
> > 
> > > is the seed per process state that's set up at process startup in some
> > > way? or shared (and thus effectively irg is non-deterministic in
> > > userspace)?
> > 
> > The seed is only relevant if the standard algorithm is used (RRND=0).
> 
> i wanted to understand if we can get deterministic
> irg behaviour in user space (which may be useful
> for debugging to get reproducible tag failures).
> 
> i guess if no control is exposed that means non-
> deterministic irg. i think this is fine.

Hmmm, I guess this might eventually be wanted.  But it's probably OK not
to have it to begin with.

Things like CRIU restores won't be reproducible unless the seeds can be
saved/restored.

Doesn't seem essential from day 1 though.

Cheers
---Dave
