Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76022251728
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHYLLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 07:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYLLI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 07:11:08 -0400
Received: from C02TF0J2HF1T.local (unknown [213.205.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FEE20715;
        Tue, 25 Aug 2020 11:11:03 +0000 (UTC)
Date:   Tue, 25 Aug 2020 12:10:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 27/28] arm64: mte: Kconfig entry
Message-ID: <20200825111059.GB22233@C02TF0J2HF1T.local>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-28-catalin.marinas@arm.com>
 <2e73f87b-f5fe-5ccf-1b5f-c916703356e0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e73f87b-f5fe-5ccf-1b5f-c916703356e0@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 11:44:50AM -0700, Randy Dunlap wrote:
> On 8/24/20 11:27 AM, Catalin Marinas wrote:
> > index 6d232837cbee..10cf81d70657 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1664,6 +1664,37 @@ config ARCH_RANDOM
> >  	  provides a high bandwidth, cryptographically secure
> >  	  hardware random number generator.
> >  
> > +config ARM64_AS_HAS_MTE
> > +	# Binutils gained initial support for MTE in 2.32.0. However, a
> > +	# late architecture addition (LDGM/STGM) is only supported in
> > +	# the newer 2.32.x and 2.33 versions.
> > +	def_bool $(as-instr,.arch armv8.5-a+memtag\nstgm xzr$(comma)[x0])
> 
> Would you mind translating that for me?
> Yes, I read the v7 Notes, but that only helped a little bit.

The initial MTE support in binutils 2.32.0, testable above with ".arch
armv8.5-a+memtag", was incomplete. Historically, I think it was based on
a beta version of the architecture but before the final architecture
release (ARMv8.5), MTE gained a couple of new instructions: STGM/LDGM.

Since there are binutils versions out there which don't understand STGM
even though they claim to support .arch armv8.5-a+memtag, it's better
for the above check to include the STGM instruction.

I'll see if I can make the comment above clearer.

> > +	bool "Memory Tagging Extension support"
> > +	default y
> > +	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> > +	help
> > +	  Memory Tagging (part of the ARMv8.5 Extensions) provides
> > +	  architectural support for run-time, always-on detection of
> 
> 	                            runtime,
> as is used below.

Thanks.

-- 
Catalin
