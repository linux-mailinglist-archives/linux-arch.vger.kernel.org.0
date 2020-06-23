Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2258620576E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbgFWQms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 12:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732953AbgFWQmr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 12:42:47 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6788C2070E;
        Tue, 23 Jun 2020 16:42:44 +0000 (UTC)
Date:   Tue, 23 Jun 2020 17:42:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 20/22] arm64: mte: Allow user control of the excluded
 tags via prctl()
Message-ID: <20200623164211.GA5180@gaia>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-21-catalin.marinas@arm.com>
 <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
 <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
 <20200622171716.GC10226@gaia>
 <CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 12:00:48PM -0700, Peter Collingbourne wrote:
> On Mon, Jun 22, 2020 at 10:17 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Mon, Dec 16, 2019 at 09:30:36AM -0800, Peter Collingbourne wrote:
> > > On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > > > In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> > > > After some more discussions, Branislav and I think that it would be better to start
> > > > with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).
> > > >
> > > > This should simplify the MTE setup in the early C runtime quite a bit. Indeed, if all
> > > > tags can be generated, doing any heap or stack tagging before the
> > > > PR_SET_TAGGED_ADDR_CTRL prctl() is issued can cause problems, notably because tagged
> > > > addresses could end up being passed to syscalls. Conversely, if IRG and ADDG never
> > > > set the top byte by default, then tagging operations should be no-ops until the
> > > > prctl() is issued. This would be particularly useful given that it may not be
> > > > straightforward for the C runtime to issue the prctl() before doing anything else.
> > > >
> > > > Additionally, since the default tag checking mode is PR_MTE_TCF_NONE, it would make
> > > > perfect sense not to generate tags by default.
> > >
> > > This would indeed allow the early C runtime startup code to pass
> > > tagged addresses to syscalls,
[...]
> > > but I don't think it would entirely free
> > > the code from the burden of worrying about stack tagging. Either way,
> > > any stack frames that are active at the point when the prctl() is
> > > issued would need to be compiled without stack tagging, because
> > > otherwise those stack frames may use ADDG to rematerialize a stack
> > > object address, which may produce a different address post-prctl.
[...]
> > > Setting the exclude mask to 0xffff would at least make it more likely
> > > for this problem to be detected, though.
> >
> > I thought it would be detected if we didn't have a 0xffff default
> > exclude mask. With only tag 0 generated, any such problem could be
> > hidden.
> 
> I don't think that's the case, as long as you aren't using 0 as a
> catch-all tag. Imagine that you have some hypothetical startup code
> that looks like this:
> 
> void init() {
>   bool called_prctl = false;
>   prctl(PR_SET_TAGGED_ADDR_CTRL, ...); // effect is to change
> GCR_EL1.Excl from 0xffff to 1
>   called_prctl = true;
> }
> 
> This may be compiled as something like (well, a real compiler wouldn't
> compile it like this but rather use sp-relative stores or eliminate
> the dead stores entirely, but imagine that the stores to called_prctl
> are obfuscated somehow, e.g. in another translation unit):
> 
> sub x19, sp, #16
> irg x19, x19 // compute a tag base for the function
> addg x0, x19, #0, #1 // add tag offset for "called_prctl"
> stzg x0, [x0]
> bl prctl
> addg x0, x19, #0, #1 // rematerialize "called_prctl" address
> mov w1, #1
> strb w1, [x0]
> ret
> 
> The first addg will materialize a tag of 0 due to the default Excl
> value, so the stzg will set the memory tag to 0. However, the second
> addg will materialize a tag of 1 because of the new Excl value, which
> will result in a tag fault in the strb instruction.
> 
> This problem is less likely to be detected if we transition Excl from
> 0 to 1. It will only be detected in the case where the irg instruction
> produces a tag of 0xf, which would be incremented to 0 by the first
> addg but to 1 by the second one.

Thanks for the explanation. For some reason I thought ADDG would only be
used once (per variable or frame). I now agree that a default exclude
mask of 0xffff would catch such issues early.

> > > If we change the default in this way, maybe it would be worth
> > > considering flipping the meaning of the tag mask and have it be a mask
> > > of tags to allow. That would be consistent with the existing behaviour
> > > where userspace sets bits in tagged_addr_ctrl in order to enable
> > > tagging features.
> >
> > The first question is whether the C runtime requires a default
> > GCR_EL1.Excl mask of 0xffff (or 0xfffe) so that IRG, ADDG, SUBG always
> > generate tag 0. If the runtime is fine with a default exclude mask of 0,
> > I'm tempted to go back to an exclude mask for prctl().
> >
> > (to me it feels more natural to use an exclude mask as it matches the
> > ARM ARM definition but maybe I stare too much at the hardware specs ;))
> 
> I think that would be fine with me. With the transition from 0 to 1
> the above problem would still be detected, but only 1/16 of the time.
> But if the problem exists in the early startup code which will be
> executed many times during a typical system boot, it makes it likely
> that the problem will be detected eventually.

I'm not a big fan of hitting a problem 1/16 times, it makes debugging
harder. So I'll stick to a default exclude mask of 0xffff, in which case
it makes sense to invert the polarity for prctl() and make it an include
mask (as in v4 of the patchset).

Thanks.

-- 
Catalin
