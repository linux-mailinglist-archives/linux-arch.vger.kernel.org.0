Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFDD331B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJJVA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 17:00:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35983 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfJJVA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 17:00:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so3385607plk.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ORG+HsGy3iRF0g1A3SvuSaUHioZzX6MFBQbaXv8rsek=;
        b=VO/LbGQCFTqvqDL7wZtd0QnnzymNdlzpMyVPi2Q3Im5nIx7lSuCiM7f58PJ+uMEIjI
         koX9U8d4if0Nz77wYV7FZDwfESeFSOIkf3jlTnmYWbDohkrLYYUgPGqfw/Y6hrketL3U
         KnXHyezm27STWnjXlgfGF3Sg2GPXkzdLniSOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORG+HsGy3iRF0g1A3SvuSaUHioZzX6MFBQbaXv8rsek=;
        b=AAHQRj5D5vt7VYIe1gu6jgPsUdIKRg2A37jvWJQsbQlLN8OalDCGrRjotomAHCn5rA
         XJ8ogmR3OoAL0XEtlNl5clE24NCxjy9ArKPQtVoUGqHax9JoRJWx47gYQQ0x+6yxiZxr
         L9tBcQ1KIZ5lf2+bUMJQhR9/lXJZBMgxYgyZ0p9jVKBxg3dM+pOoA97+6skSZkkwMa5v
         lCa9B1PM7A/5OjXYhpQdwg+zfp+uiWu1GzDQVBZweguQwVpwqbHoYGorLV70nRO0WhE9
         MK1vqE7EIZdM4KxIDqO1piF14V76F92/k+VazXtKmSmjg7pMxWs0F1j+rssjgEIXIKYE
         Avdg==
X-Gm-Message-State: APjAAAWQr72eTBdvNjGXKSSrDK2hwGPcV94hgvLwE3sWGLG3oT/7TzOv
        A9qej92oHSJwmU7j+FrQsPU0kQ==
X-Google-Smtp-Source: APXvYqyqdYFFugXyLXLIipZ/O7fa8NdhYSO5j+/CU441LMhNnsoOUgYoHdj+Hn3IqSCxZ9gCqhpxQw==
X-Received: by 2002:a17:902:304:: with SMTP id 4mr10659484pld.106.1570741256418;
        Thu, 10 Oct 2019 14:00:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm6745946pfj.41.2019.10.10.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:00:55 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:00:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <mark.brown@arm.com>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <201910101359.9B3B84B@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
 <20191009125913.GE27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009125913.GE27757@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 09, 2019 at 01:59:13PM +0100, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 09:34:17AM +0100, Dave Martin wrote:
> > On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> > > On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > > > ELF program properties will needed for detecting whether to enable
> > > > optional architecture or ABI features for a new ELF process.
> > > > 
> > > > For now, there are no generic properties that we care about, so do
> > > > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > > > 
> > > > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > > > phdrs entry (if any), and notify each property to the arch code.
> > > > 
> > > > For now, the added code is not used.
> > > > 
> > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Thanks for the review.
> > 
> > Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> > early-terminate the scan if we can, but my feeling so far was that the
> > scan is cheap, the number of properties is unlikely to be more than a
> > smallish integer, and the code separation benefits of just calling the
> > arch code for every property probably likely outweigh the costs of
> > having to iterate over every property.  We could always optimise it
> > later if necessary.
> > 
> > I need to double-check that there's no way we can get stuck in an
> > infinite loop with the current code, though I've not seen it in my
> > testing.  I should throw some malformed notes at it though.
> > 
> > > Note below...
> > > 
> > > > [...]
> > > > +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> > > > +			      struct arch_elf_state *arch,
> > > > +			      bool have_prev_type, u32 *prev_type)
> > > > +{
> > > > +	size_t size, step;
> > > > +	const struct gnu_property *pr;
> > > > +	int ret;
> > > > +
> > > > +	if (*off == datasz)
> > > > +		return -ENOENT;
> > > > +
> > > > +	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
> > > > +		return -EIO;
> > > > +
> > > > +	size = datasz - *off;
> > > > +	if (size < sizeof(*pr))
> > > > +		return -EIO;
> > > > +
> > > > +	pr = (const struct gnu_property *)(data + *off);
> > > > +	if (pr->pr_datasz > size - sizeof(*pr))
> > > > +		return -EIO;
> > > > +
> > > > +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> > > > +	if (step > size)
> > > > +		return -EIO;
> > > > +
> > > > +	/* Properties are supposed to be unique and sorted on pr_type: */
> > > > +	if (have_prev_type && pr->pr_type <= *prev_type)
> > > > +		return -EIO;
> > > > +	*prev_type = pr->pr_type;
> > > > +
> > > > +	ret = arch_parse_elf_property(pr->pr_type,
> > > > +				      data + *off + sizeof(*pr),
> > > > +				      pr->pr_datasz, ELF_COMPAT, arch);
> > > 
> > > I find it slightly hard to read the "cursor" motion in this parse. It
> > > feels strange, for example, to refer twice to "data + *off" with the
> > > second including consumed *pr size. Everything is fine AFAICT in the math,
> > > though, and I haven't been able to construct a convincingly "cleaner"
> > > version. Maybe:
> > > 
> > > 	data += *off;
> > > 	pr = (const struct gnu_property *)data;
> > > 	data += sizeof(*pr);
> > > 	...
> > > 	ret = arch_parse_elf_property(pr->pr_type, data,
> > > 				      pr->pr_datasz, ELF_COMPAT, arch);
> > 
> > Fair point.  The cursor is really *off, which I suppose I could update
> > as we go through this function, or cache in a local variable and assign
> > on the way out.
> > 
> > > But that feels disjoint from the "step" calculation, so... I think what
> > > you have is fine. :)
> > 
> > It's good to be as clear as possible about exactly how far we have
> > parsed, so I'll see if I can improve this when I repost.
> > 
> > 
> > Do you have any objection to merging patch 1 with this one?  For
> > upstreaming purposes, it seems overkill for that to be a separate patch.
> > 
> > I may also convert elf_gnu_property_align to upper case, since unlike
> > the other related definitions this one isn't trying to look like a
> > struct tag.
> > 
> > Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
> > so they're documenting assumptions rather than protecting against
> > anything real.  Maybe I should replace them with comments.
> 
> FYI, I'm going to be inactive for a while, so I'm not going to be able
> to push this patch further.
> 
> Mark Brown will be picking up the arm64 BTI series, so it will probably
> make sense if he pulls it into that series.
> 
> Any thoughts?

Okay, sounds good. Mark, I think these patches are in good shape. Can
you include me on CC where you pick these up?

Thanks!

-Kees

-- 
Kees Cook
