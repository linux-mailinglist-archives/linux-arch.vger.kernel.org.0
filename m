Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5638A32AF
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfH3IeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 04:34:23 -0400
Received: from foss.arm.com ([217.140.110.172]:55984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3IeW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 04:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D533A344;
        Fri, 30 Aug 2019 01:34:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5243F718;
        Fri, 30 Aug 2019 01:34:20 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:34:18 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <20190830083415.GI27757@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908292224.007EB4D5@keescook>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > ELF program properties will needed for detecting whether to enable
> > optional architecture or ABI features for a new ELF process.
> > 
> > For now, there are no generic properties that we care about, so do
> > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > 
> > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > phdrs entry (if any), and notify each property to the arch code.
> > 
> > For now, the added code is not used.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the review.

Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
early-terminate the scan if we can, but my feeling so far was that the
scan is cheap, the number of properties is unlikely to be more than a
smallish integer, and the code separation benefits of just calling the
arch code for every property probably likely outweigh the costs of
having to iterate over every property.  We could always optimise it
later if necessary.

I need to double-check that there's no way we can get stuck in an
infinite loop with the current code, though I've not seen it in my
testing.  I should throw some malformed notes at it though.

> Note below...
> 
> > [...]
> > +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> > +			      struct arch_elf_state *arch,
> > +			      bool have_prev_type, u32 *prev_type)
> > +{
> > +	size_t size, step;
> > +	const struct gnu_property *pr;
> > +	int ret;
> > +
> > +	if (*off == datasz)
> > +		return -ENOENT;
> > +
> > +	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
> > +		return -EIO;
> > +
> > +	size = datasz - *off;
> > +	if (size < sizeof(*pr))
> > +		return -EIO;
> > +
> > +	pr = (const struct gnu_property *)(data + *off);
> > +	if (pr->pr_datasz > size - sizeof(*pr))
> > +		return -EIO;
> > +
> > +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> > +	if (step > size)
> > +		return -EIO;
> > +
> > +	/* Properties are supposed to be unique and sorted on pr_type: */
> > +	if (have_prev_type && pr->pr_type <= *prev_type)
> > +		return -EIO;
> > +	*prev_type = pr->pr_type;
> > +
> > +	ret = arch_parse_elf_property(pr->pr_type,
> > +				      data + *off + sizeof(*pr),
> > +				      pr->pr_datasz, ELF_COMPAT, arch);
> 
> I find it slightly hard to read the "cursor" motion in this parse. It
> feels strange, for example, to refer twice to "data + *off" with the
> second including consumed *pr size. Everything is fine AFAICT in the math,
> though, and I haven't been able to construct a convincingly "cleaner"
> version. Maybe:
> 
> 	data += *off;
> 	pr = (const struct gnu_property *)data;
> 	data += sizeof(*pr);
> 	...
> 	ret = arch_parse_elf_property(pr->pr_type, data,
> 				      pr->pr_datasz, ELF_COMPAT, arch);

Fair point.  The cursor is really *off, which I suppose I could update
as we go through this function, or cache in a local variable and assign
on the way out.

> But that feels disjoint from the "step" calculation, so... I think what
> you have is fine. :)

It's good to be as clear as possible about exactly how far we have
parsed, so I'll see if I can improve this when I repost.


Do you have any objection to merging patch 1 with this one?  For
upstreaming purposes, it seems overkill for that to be a separate patch.

I may also convert elf_gnu_property_align to upper case, since unlike
the other related definitions this one isn't trying to look like a
struct tag.

Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
so they're documenting assumptions rather than protecting against
anything real.  Maybe I should replace them with comments.

Cheers
---Dave
