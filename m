Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4D1D20AD
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEMVMA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 17:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgEMVMA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 17:12:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F7020575;
        Wed, 13 May 2020 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589404319;
        bh=NB238MLfyhbZzQnDf+p0MJLkeyGVTyJL/894A4j8O3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usjBTM53z14/XldTXUHg1fDyfhm3RaLqPkhQietnIClnGrdlv3YHpe7sb0QQoNL0q
         1ZhqQg/sYfEhdvxlcq8wt98mmsHQmgtb8ZplpJMHDM51HNzS1/+uMOrkp0t7lTfSz7
         nGYbxkpB0EXjt5khIcLOcFXf+YwH65zW9aLRgFvk=
Date:   Wed, 13 May 2020 22:11:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200513211153.GB28594@willie-the-truck>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
 <20200513084351.GB18196@willie-the-truck>
 <20200513104635.GD21779@arm.com>
 <a01fc572-cac8-1932-c3e5-c70184417ca3@gmail.com>
 <20200513140200.GP21779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513140200.GP21779@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 03:02:00PM +0100, Dave Martin wrote:
> On Wed, May 13, 2020 at 01:01:12PM +0200, Michael Kerrisk (man-pages) wrote:
> > On 5/13/20 12:46 PM, Dave Martin wrote:
> > > On Wed, May 13, 2020 at 09:43:52AM +0100, Will Deacon wrote:
> > >> On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:
> > > glibc explicitly has
> > > 
> > > 	extern int prctl (int __option, ...);
> > > 
> > > (and nobody has to write _exit(0, 0, 0, 0, 0, 0) after all.)
> > > 
> > > Is there some agreed rationale for requiring redundant arguments to be
> > > supplied explicitly as zero?  For now there are likely to be few users
> > > of this, so we _might_ get away with changing the behaviour here if it's
> > > considered important enough.
> > 
> > See above.
> 
> So there is no bulletproof rationale for either approach, but the main
> concern is inconsistency?  Have I understood that right?

I think it's all just an extension of "make sure unused parameters are 0"
idiom which allows those bits to be safely repurposed for flags and things
later on without the worry of existing applications getting away with
passing junk.

> I'll propose to get that written down in the kernel source somewhere
> if so.

That would be a really good idea, actually!

> (From my end, the pros and cons of the two approaches seem superficial
> but the inconsistency is indeed annoying.  For PR_SVE_SET_VL, I think
> the first example I looked at didn't zero the trailing arguments, so I
> didn't either... but it's been upstream for several releases, so most
> likely we're stuck with it.)

FWIW, I wasn't blaming you for this. Just that these oversights aren't
always apparent when reviewing patches, but become more clear when
reviewing the documentation.

> > > There is no forwards compatibility problem with this prctl though,
> > > because there are spare bits in arg2 which can "turn on" additional
> > > args if needed.
> > > 
> > > Also, it's implausible that PR_SVE_GET_VL will ever want an argument.
> > > 
> > > There are still 2 billion unallocated prctl numbers, so new prctls can
> > > always be added if there's ever a need to work around these limitations,
> > > but it seems extremely unlikely.

Oh, there are ways out, but had I noticed this during code review it
would've been very easy just to enforce zero for the other args and be done
with it.

> > >>> +If
> > >>> +.B PR_SVE_VL_INHERIT
> > >>> +is also included in
> > >>> +.IR arg2 ,
> > >>> +it takes effect
> > >>> +.I after
> > >>> +this deferred change.
> > >>
> > >> I find this a bit hard to follow, since it's not clear to me whether the
> > >> INHERIT flag is effectively set before or after the next execve(). In other
> > >> words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
> > >> is the vector length preserved or reset on the next execve()?
> > > 
> > > It makes no difference, because the ONEXEC handling takes priority over
> > > the INHERIT handling. But either way INHERIT is never cleared by execve()
> > > and will apply at subsequent execs().
> > > 
> > > Explaining all this properly seems out of scope here.  Maybe this should
> > > be trimmed down rather than elaborated?  Or perhaps just explain it in
> > > terms of what the kernel does instead of futile attempts to make it
> > > intuitive?

Hmm, if we don't explain it in the man page then we should at least point
people to somewhere where they can get the gory details, because I think
they're necessary in order to use the prctl() request correctly. I'm still
not confident that I understand the semantics of setting both
PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT without reading the code, which
may change.

(I concede on all the spelling/grammar discussions ;)

Will
