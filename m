Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3823A2F6C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFJPh1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 11:37:27 -0400
Received: from foss.arm.com ([217.140.110.172]:34732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhFJPh0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 11:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173C2106F;
        Thu, 10 Jun 2021 08:35:30 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89CF3F719;
        Thu, 10 Jun 2021 08:35:28 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:34:28 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2 2/3] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210610153426.GP4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-3-broonie@kernel.org>
 <20210609151713.GL4187@arm.com>
 <YMIRSSMnP3UMwdRy@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMIRSSMnP3UMwdRy@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 02:19:05PM +0100, Mark Brown wrote:
> On Wed, Jun 09, 2021 at 04:17:13PM +0100, Dave Martin wrote:
> > On Fri, Jun 04, 2021 at 12:24:49PM +0100, Mark Brown wrote:
> 
> > > -		if (system_supports_bti() && has_interp == is_interp &&
> > > -		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
> > > -			arch->flags |= ARM64_ELF_BTI;
> > > +		if (system_supports_bti() &&
> > > +		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> > > +			if (is_interp) {
> > > +				arch->flags |= ARM64_ELF_INTERP_BTI;
> > > +			} else {
> > > +				arch->flags |= ARM64_ELF_EXEC_BTI;
> > > +			}
> 
> > Nit: surplus curlies? (coding-style.rst does actually say to drop them
> > when all branches of an if are single-statement one-liners -- I had
> > presumed I was just being pedantic...)
> 
> I really think this hurts readability with the nested if inside
> another if with a multi-line condition.

So long as there is a reason rather than it being purely an accident of
editing, that's fine.

(Though if the nested if can be flattened so that this becomes a non-
issue, that's good too :)

> > > -	if (prot & PROT_EXEC)
> > > -		prot |= PROT_BTI;
> > > +		if (state->flags & ARM64_ELF_EXEC_BTI && !is_interp)
> > > +			prot |= PROT_BTI;
> > > +	}
> 
> > Is it worth adding () around the bitwise-& expressions?  I'm always a
> > little uneasy about the operator precedence of binary &, although
> > without looking it up I think you're correct.
> 
> Sure.  I'm fairly sure the compiler would've complained about
> this case if it were ambiguous, I'm vaguely surprised it didn't
> already.

I was vaguely surprised too -- though I didn't try to compile this
myself yet.  Anyway, not a huge deal.  Adding a helper to generate the
appropriate mask would make this issue go away in any case, but so long
as you're confident this is being evaluated as intended I can take your
word for it.

> > Feel free to adopt if this appeals to you, otherwise I'm also fine with
> > your version.)
> 
> I'll see what I think when I get back to looking at this
> properly.

Ack -- again, this was just a suggestion.  I can also live with your
original code if you ultimately decide to stick with that.

Cheers
---Dave
