Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE7713418
	for <lists+linux-arch@lfdr.de>; Sat, 27 May 2023 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjE0KmM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 May 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjE0KmL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2023 06:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF110A;
        Sat, 27 May 2023 03:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF3F60B67;
        Sat, 27 May 2023 10:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE11AC433EF;
        Sat, 27 May 2023 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685184129;
        bh=Z4TeIapFpeS1e5WxOMUpOrDg87Rxe8ydQavxJsO0vug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtjpACU3i7FVjLT023Ddg5iX1Sm9mYGyR9BAcAldcZGtkGi1IgPSjR20Gkom5YVFi
         9GqwWTqSe6aCGE+Jk6r1lk9ASI1BqwfpG0h2HSrQ1BaMlG84/DZwyIoKGVbNuFJs46
         KM/CX4KgN01bs8ctMAmNzdH3P/7vJMOVtl/spQpp1NeNWLVBfmoG8tubTTHEz78nbM
         Mi5TzSK4O/LtfJpDtvhI5QLWzSn68VROvh7bVsKVmfCA0L8DXw2EUj7uC78b19+5Rx
         6iPjAV5tMRrgS7SBBOhhGo75UiSObo7waKqxJ5uuMYjPYcI7MRtTbdg+ba8TB9jNgs
         b+IpYHQpsYW9A==
Date:   Sat, 27 May 2023 13:41:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Message-ID: <20230527104144.GH4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 01:53:24PM -0700, Vishal Moola wrote:
> On Thu, May 25, 2023 at 1:26 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, May 25, 2023 at 11:04:28AM -0700, Vishal Moola wrote:
> > > On Thu, May 25, 2023 at 2:10 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > +
> > > > > +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int order)
> > > > > +{
> > > > > +     struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > > > > +
> > > > > +     return page_ptdesc(page);
> > > > > +}
> > > > > +
> > > > > +static inline void ptdesc_free(struct ptdesc *pt)
> > > > > +{
> > > > > +     struct page *page = ptdesc_page(pt);
> > > > > +
> > > > > +     __free_pages(page, compound_order(page));
> > > > > +}
> > > >
> > > > The ptdesc_{alloc,free} API does not sound right to me. The name
> > > > ptdesc_alloc() implies the allocation of the ptdesc itself, rather than
> > > > allocation of page table page. The same goes for free.
> > >
> > > I'm not sure I see the difference. Could you elaborate?
> >
> > I read ptdesc_alloc() as "allocate a ptdesc" rather than as "allocate a
> > page for page table and return ptdesc pointing to that page". Seems very
> > confusing to me already and it will be even more confusion when we'll start
> > allocating actual ptdescs.
> 
> Hmm, I see what you're saying. I'm envisioning this function evolving into
> one that allocates a ptdesc later. I don't see why we would need to have both a
> page table page AND ptdesc at any point, but that may be a lack of knowledge
> from my part.

Sorry if I wasn't clear, by "page table page" I meant the page (or memory
for that matter) for actual page table rather than struct page describing
that memory.

So what we allocate here is the actual memory for the page tables and not
the memory for the metadata. That's why I think the name ptdesc_alloc is
confusing.
 
> I was thinking later, if necessary, we could make another function
> (only to be used internally) to allocate page table pages.

-- 
Sincerely yours,
Mike.
