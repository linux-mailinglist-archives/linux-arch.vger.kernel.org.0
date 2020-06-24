Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99E207BA1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405808AbgFXShG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgFXShG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 14:37:06 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E936C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xU36C/WiUNJodzhyk8EQn6FWj5wnkbbbz+a3PgaakRo=; b=EWFa2tygln6IJibkrOIR04l1VN
        DFpaShPToa/lioJyeicFoPHR9h74piP9grxP7t70i3icz3UrsRveU8bdxf7Eb7sNhwQFwYWPdHHPf
        JynY6wE7/8oHaqVr/x9eGQsckraSkQNiFWnzRN2c7tghXgLy5wEMN7AviqSRy8Az6Jwi0ErXDHqTi
        l+xYOh7qNTaZJ4MfPk8hhgRD77TwK6NBR9nMT3jeonoKd2h4xJUWF/pHChpP/+1pi1E02eAeYx8f+
        dAUMAyenSOB/zm7SSV1NB8OqY1JibLu9cxnSRjSlorSh8bnR5ApktJsRaYh+MOTH1UY2TIB5CuBYc
        GT+d6T9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joAGN-0004fD-Ag; Wed, 24 Jun 2020 18:36:47 +0000
Date:   Wed, 24 Jun 2020 19:36:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 06/25] mm: Add PG_ARCH_2 page flag
Message-ID: <20200624183647.GU21350@casper.infradead.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-7-catalin.marinas@arm.com>
 <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:33:07AM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 18:52:25 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > From: Steven Price <steven.price@arm.com>
> > 
> > For arm64 MTE support it is necessary to be able to mark pages that
> > contain user space visible tags that will need to be saved/restored e.g.
> > when swapped out.
> > 
> > To support this add a new arch specific flag (PG_ARCH_2) that arch code
> > can opt into using ARCH_USES_PG_ARCH_2.
> > 
> > ...
> >
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
> >  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
> >  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
> >  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> > +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> > +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> > +#endif
> 
> Do we need CONFIG_ARCH_USES_PG_ARCH_2?  What would be the downside to
> giving every architecture a PG_arch_2, but only arm64 uses it (at
> present)?

32-bit architectures don't have space for it.  We could condition it on
CONFIG_64BIT instead.
