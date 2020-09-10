Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457AC265476
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIJVm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 17:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbgIJLzZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 07:55:25 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6FA20C09;
        Thu, 10 Sep 2020 11:55:22 +0000 (UTC)
Date:   Thu, 10 Sep 2020 12:55:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 09/29] arm64: mte: Clear the tags when a page is
 mapped in user-space with PROT_MTE
Message-ID: <20200910115519.GB4030@gaia>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-10-catalin.marinas@arm.com>
 <5c2ebe16-2ac9-6cff-3456-6d8ac96b5fb7@arm.com>
 <20200910105258.GA4030@gaia>
 <19137fdc-64c6-a5c2-d6f6-ebcf4f553816@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19137fdc-64c6-a5c2-d6f6-ebcf4f553816@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 12:12:27PM +0100, Steven Price wrote:
> On 10/09/2020 11:52, Catalin Marinas wrote:
> > On Thu, Sep 10, 2020 at 11:23:33AM +0100, Steven Price wrote:
> > > On 04/09/2020 11:30, Catalin Marinas wrote:
> > > > --- /dev/null
> > > > +++ b/arch/arm64/lib/mte.S
> > > > @@ -0,0 +1,34 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (C) 2020 ARM Ltd.
> > > > + */
> > > > +#include <linux/linkage.h>
> > > > +
> > > > +#include <asm/assembler.h>
> > > > +#include <asm/sysreg.h>
> > > > +
> > > > +	.arch	armv8.5-a+memtag
> > > > +
> > > > +/*
> > > > + * multitag_transfer_size - set \reg to the block size that is accessed by the
> > > > + * LDGM/STGM instructions.
> > > > + */
> > > > +	.macro	multitag_transfer_size, reg, tmp
> > > > +	mrs_s	\reg, SYS_GMID_EL1
> > > > +	ubfx	\reg, \reg, #SYS_GMID_EL1_BS_SHIFT, #SYS_GMID_EL1_BS_SIZE
> > > > +	mov	\tmp, #4
> > > > +	lsl	\reg, \tmp, \reg
> > > > +	.endm
> > > > +
> > > > +/*
> > > > + * Clear the tags in a page
> > > > + *   x0 - address of the page to be cleared
> > > > + */
> > > > +SYM_FUNC_START(mte_clear_page_tags)
> > > > +	multitag_transfer_size x1, x2
> > > > +1:	stgm	xzr, [x0]
> > > > +	add	x0, x0, x1
> > > > +	tst	x0, #(PAGE_SIZE - 1)
> > > > +	b.ne	1b
> > > > +	ret
> > > > +SYM_FUNC_END(mte_clear_page_tags)
> > > 
> > > Could the value of SYS_GMID_EL1 vary between CPUs and do we therefore need a
> > > preempt_disable() around mte_clear_page_tags() (and other functions in later
> > > patches)?
> > 
> > If they differ, disabling preemption here is not sufficient. We'd have
> > to trap the GMID_EL1 access at EL2 as well and emulate it (we do this
> > for CTR_EL0 in dcache_line_size).
> 
> Hmm, good point. It's actually not possible to properly emulate this - EL2
> can trap GMID_EL1 to provide a different (presumably smaller) size, but
> LDGM/STGM will still read/store the number of tags of the underlying
> hardware. While simple loops like we've got at the moment won't care (we'll
> just end up doing useless work), it won't be architecturally correct. The
> guest can always deduce the underlying value. So I think we can safely
> consider this broken hardware.

I think that's similar to the DC ZVA (and DCZID_EL0.BS) case where
faking it could lead to data corruption if the software assumes it
writes a maximum number of bytes.

(I meant to raise a ticket with the architects to make this a
requirement in the ARM ARM but forgot about it)

> > I don't want to proactively implement this just in case we'll have
> > broken hardware (I feel a bit more optimistic today ;)).
> 
> Given the above I think if we do have broken hardware the only sane thing to
> do would be to provide a way of overriding multitag_transfer_size to return
> the smallest size of all CPUs. Which works well enough for the uses we've
> currently got.

If we do have such broken hardware, we should probably drop the STGM
instructions in favour of STG or ST2G. Luckily, STGM/LDGM are not
available in user space.

-- 
Catalin
