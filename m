Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC43A2F8B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFJPnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 11:43:06 -0400
Received: from foss.arm.com ([217.140.110.172]:34884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhFJPnD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 11:43:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A207B1396;
        Thu, 10 Jun 2021 08:41:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502E23F719;
        Thu, 10 Jun 2021 08:41:05 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:40:04 +0100
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
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <20210610154004.GQ4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org>
 <20210609151724.GM4187@arm.com>
 <YMIUy3oMQNboKoeg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMIUy3oMQNboKoeg@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 02:34:03PM +0100, Mark Brown wrote:
> On Wed, Jun 09, 2021 at 04:17:24PM +0100, Dave Martin wrote:
> > On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:
> 
> > > Since we have added an is_interp flag to arch_parse_elf_property() we can
> > > drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> > > the arm64 code which no longer needs it and any future users will be able
> > > to use arch_parse_elf_properties() to determine if an interpreter is in
> > > use.
> 
> > So far so good, but can we also drop the has_interp argument from
> > arch_parse_elf_properties()?
> 
> > Cross-check with Yu-Cheng Yu's series, but I don't see this being used
> > any more (except for passthrough in binfmt_elf.c).
> 
> > Since we are treating the interpreter and main executable orthogonally
> > to each other now, I don't think we should need a has_interp argument to
> > pass knowledge between the interpreter and executable handling phases
> > here.
> 
> My thinking was that it might be useful for handling of some
> future property in the architecture code to know if there is an
> interpreter, providing the information at parse time would let it
> set up whatever is needed.  We've been doing this with the arm64
> BTI handling and while we're moving away from doing that I could
> imagine that there may be some other case where it makes sense,
> and it sounds like CET is one.

It might be useful, but if the use cases are purely hypothetical then it
would still seem preferable to remove it so that it doesn't just hang
around forever as cruft.

I guess we need to wait and see whether x86 really needs this, or just
uses it as a side-effect of following the arm64 code initially.

If it is quicker to stabilise this series heeping the has_interps in,
then I guess we have the option to do that and remove them later on once
we're satisfied they're unlikely to be useful (or not).

Cheers
---Dave
