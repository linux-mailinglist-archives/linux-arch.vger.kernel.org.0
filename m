Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1713688ACE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 00:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBBX2y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 18:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjBBX2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 18:28:48 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE42B0BB
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 15:28:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 347215C006D;
        Thu,  2 Feb 2023 18:27:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 Feb 2023 18:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675380475; x=1675466875; bh=yb
        AOl0im+zyVAqNQleQtVluip4OoVhxd17oXs8vM8R8=; b=WIDjweNWaBkEKh36iY
        Bs/bvDg32HW6CVt2rk0He3XdsUEiXaXAqXX4oQjAgowAyl7drdGCzzq0C9zCiaCx
        ki2OauPFdPtz/t21AinsLfper8c8zZ3LRx54nBtmPIRYUqpQd/utpGHzFkq5n0E3
        zCjhiRmObI87vurwr+Lxxtj6+Q6EWXq2rnl8TJMl3h0AHqnieSw2BJMfQD0o4q+9
        v16pkcEkBQq6PR+SSFa011DCwNd3KOVaPPO8boD0fpRhfII9I4E/yDaXqn4vBCAY
        4jmhPmDGPtPqy9f3thXJokpBvOISDIVSqP56JIdlnGhVXWTK3Hrh2d/Hzrf3nt+7
        hFDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675380475; x=1675466875; bh=ybAOl0im+zyVAqNQleQtVluip4Oo
        Vhxd17oXs8vM8R8=; b=ShMKKYThevm6xA3F+MaiDv1wU8njjVTm4afr6jlU7EDm
        bGhwYsF9CcCiOAQ8Man/yZAPZZ7AW+XbTMZ7LoMu7mKMl/dOEHWs3/36qU4RkyjA
        WJ82QLrgh9g7R4YLVXrps9hL3WtzaQMNYB9RmSJJhv3tSiUUjq3HBYayyMAPdxx1
        WBp6yDD9nJbG2Nsn8zb82GFwpNffc2fsNPIKyoIlj3ygRShOlrBhYcNIJGjLnYWK
        K1dFJDmZFoLNjwTUn0RW1dj0mz+OhFqEARHsayZrUUXmOAXAi5H3cJ7ga1jwmW69
        7h99o1VySFyRC5jjcry3fziYRAtaWXBwQv0qQ7q/4w==
X-ME-Sender: <xms:-0bcY7bAXwyD--y2_CIxUfd8Ln23IriqgKZML9XbXHeIbklcWuCrrg>
    <xme:-0bcY6atpg8c3MmPF4sbQpx2I6f9d5rGJ1C_u9qzI3u05wllJ9VS34WuQx0FVJHTe
    VgAOKelicYUwXo-LTc>
X-ME-Received: <xmr:-0bcY99rY2rslJ4JybZby3XKVk0Dn80RpHBtmJyizq14Ze9rF3HgOUKPlX63Y5SQ14XvZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:-0bcYxq0trc7v8GWBtLy4_YyxBdtwE9q1ASHB9oVcYjWGgDNBbag5A>
    <xmx:-0bcY2rP1S6DLvsdJ63bxPecykQ9iLS0tGBaMfPNqhQmCOpaePUklw>
    <xmx:-0bcY3QoAawzoi21rD-cmsQ2qmzkKv6HLkVIWPXzSxo9ynLFwuk79w>
    <xmx:-0bcY92ff2L4TD2R7BMZ_ldwHJhBMNsEV7bHWH9WHIMiPIhnBZmFjw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 18:27:54 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C14DA10E388; Fri,  3 Feb 2023 02:27:51 +0300 (+03)
Date:   Fri, 3 Feb 2023 02:27:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, Yin Fengwei <fengwei.yin@intel.com>,
        linux-mm@kvack.org
Subject: Re: API for setting multiple PTEs at once
Message-ID: <20230202232751.q4qfm2qrauwtz5bs@box.shutemov.name>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <20230202214858.btrzrcevzxjfk6wg@box.shutemov.name>
 <Y9w+AppNv+i1o/o3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9w+AppNv+i1o/o3@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 10:49:38PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 03, 2023 at 12:48:58AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
> > > For those of you not subscribed, linux-mm is currently discussing
> > > how best to handle page faults on large folios.  I simply made it work
> > > when adding large folio support.  Now Yin Fengwei is working on
> > > making it fast.
> > > 
> > > https://lore.kernel.org/linux-mm/Y9qjn0Y+1ir787nc@casper.infradead.org/
> > > is perhaps the best place to start as it pertains to what the
> > > architecture will see.
> > > 
> > > At the bottom of that function, I propose
> > > 
> > > +       for (i = 0; i < nr; i++) {
> > > +               set_pte_at(vma->vm_mm, addr, vmf->pte + i, entry);
> > > +               /* no need to invalidate: a not-present page won't be cached */
> > > +               update_mmu_cache(vma, addr, vmf->pte + i);
> > > +               addr += PAGE_SIZE;
> > > +		entry = pte_next(entry);
> > > +	}
> > > 
> > > (or I would have, had I not forgotten that pte_t isn't an integral type)
> > > 
> > > But I think that some architectures want to mark PTEs specially for
> > > "This is part of a contiguous range" -- ARM, perhaps?  So would you like
> > > an API like:
> > > 
> > > 	arch_set_ptes(mm, addr, vmf->pte, entry, nr);
> > 
> > Maybe just set_ptes(). arch_ doesn't contribute much.
> 
> Sure.
> 
> > > 	update_mmu_cache_range(vma, addr, vmf->pte, nr);
> > > 
> > > There are some challenges here.  For example, folios may be mapped
> > > askew (ie not naturally aligned).  Another problem is that folios may
> > > be unmapped in part (eg mmap(), fault, followed by munmap() of one of
> > > the pages in the folio), and I presume you'd need to go and unmark the
> > > other PTEs in that case.  So it's not as simple as just checking whether
> > > 'addr' and 'nr' are in some way compatible.
> > 
> > I think the key question is who is responsible for 'nr' being safe. Like
> > is it caller or set_ptes() need to check that it belong to the same PTE
> > page table, folio, VMA, etc.
> > 
> > I think it has to be done by caller and set_pte() has to be as simple as
> > possible.
> 
> Caller guarantees that 'nr' is bounded by all of (vma, PMD table, folio).

Also caller is responsible for taking all relevant locks.

> We don't currently allocate folios larger than PMD size, but perhaps we
> should prepare for that and as part of this same exercise define
> 
> 	set_pmds(mm, addr, vmf->pmd, entry, nr);
> 
> ... where 'nr' is the number of PMDs to set, not number of pages.

Sounds good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
