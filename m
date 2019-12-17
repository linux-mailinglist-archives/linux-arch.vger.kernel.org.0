Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6331233FD
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQR4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 12:56:15 -0500
Received: from foss.arm.com ([217.140.110.172]:43866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfLQR4P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 12:56:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC65230E;
        Tue, 17 Dec 2019 09:56:14 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C283F67D;
        Tue, 17 Dec 2019 09:56:13 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:56:11 +0000
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
        Branislav Rankov <Branislav.Rankov@arm.com>
Subject: Re: [PATCH 20/22] arm64: mte: Allow user control of the excluded
 tags via prctl()
Message-ID: <20191217175610.GN5624@arrakis.emea.arm.com>
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

On Mon, Dec 16, 2019 at 09:30:36AM -0800, Peter Collingbourne wrote:
> On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> > After some more discussions, Branislav and I think that it would be better to start
> > with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).

So with mask 0xff, IRG generates only tag 0? This seems to be the case
reading the pseudocode in the ARM ARM.

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
> >
> > Any thoughts?
> 
> This would indeed allow the early C runtime startup code to pass
> tagged addresses to syscalls, but I don't think it would entirely free
> the code from the burden of worrying about stack tagging. Either way,
> any stack frames that are active at the point when the prctl() is
> issued would need to be compiled without stack tagging, because
> otherwise those stack frames may use ADDG to rematerialize a stack
> object address, which may produce a different address post-prctl.
> Setting the exclude mask to 0xffff would at least make it more likely
> for this problem to be detected, though.
> 
> If we change the default in this way, maybe it would be worth
> considering flipping the meaning of the tag mask and have it be a mask
> of tags to allow. That would be consistent with the existing behaviour
> where userspace sets bits in tagged_addr_ctrl in order to enable
> tagging features.

Either option works for me. It's really for the libc people to decide
what they need. I think an "include" rather than "exclude" mask makes
sense with the default 0 meaning only generate tag 0.

Thanks.

-- 
Catalin
