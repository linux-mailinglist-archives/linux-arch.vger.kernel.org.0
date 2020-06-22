Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1BD203DA7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFVRRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 13:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgFVRRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 13:17:38 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0A120707;
        Mon, 22 Jun 2020 17:17:36 +0000 (UTC)
Date:   Mon, 22 Jun 2020 18:17:34 +0100
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
Message-ID: <20200622171716.GC10226@gaia>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-21-catalin.marinas@arm.com>
 <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
 <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Revisiting the gcr_excl vs gcr_incl decision, so reviving an old thread.

On Mon, Dec 16, 2019 at 09:30:36AM -0800, Peter Collingbourne wrote:
> On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> > After some more discussions, Branislav and I think that it would be better to start
> > with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).
> >
> > This should simplify the MTE setup in the early C runtime quite a bit. Indeed, if all
> > tags can be generated, doing any heap or stack tagging before the
> > PR_SET_TAGGED_ADDR_CTRL prctl() is issued can cause problems, notably because tagged
> > addresses could end up being passed to syscalls. Conversely, if IRG and ADDG never
> > set the top byte by default, then tagging operations should be no-ops until the
> > prctl() is issued. This would be particularly useful given that it may not be
> > straightforward for the C runtime to issue the prctl() before doing anything else.
> >
> > Additionally, since the default tag checking mode is PR_MTE_TCF_NONE, it would make
> > perfect sense not to generate tags by default.
> 
> This would indeed allow the early C runtime startup code to pass
> tagged addresses to syscalls,

I guess you meant that early C runtime code won't get tagged stack
addresses, hence they can be passed to syscalls. Prior to the prctl(),
the kernel doesn't accept tagged addresses anyway.

> but I don't think it would entirely free
> the code from the burden of worrying about stack tagging. Either way,
> any stack frames that are active at the point when the prctl() is
> issued would need to be compiled without stack tagging, because
> otherwise those stack frames may use ADDG to rematerialize a stack
> object address, which may produce a different address post-prctl.

If you want to guarantee that ADDG always returns tag 0, I guess that's
only possible with a default exclude mask of 0xffff (or if you are
careful enough with the start tag and offset passed).

> Setting the exclude mask to 0xffff would at least make it more likely
> for this problem to be detected, though.

I thought it would be detected if we didn't have a 0xffff default
exclude mask. With only tag 0 generated, any such problem could be
hidden.

> If we change the default in this way, maybe it would be worth
> considering flipping the meaning of the tag mask and have it be a mask
> of tags to allow. That would be consistent with the existing behaviour
> where userspace sets bits in tagged_addr_ctrl in order to enable
> tagging features.

The first question is whether the C runtime requires a default
GCR_EL1.Excl mask of 0xffff (or 0xfffe) so that IRG, ADDG, SUBG always
generate tag 0. If the runtime is fine with a default exclude mask of 0,
I'm tempted to go back to an exclude mask for prctl().

(to me it feels more natural to use an exclude mask as it matches the
ARM ARM definition but maybe I stare too much at the hardware specs ;))

-- 
Catalin
