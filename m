Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B96D752418
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jul 2023 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjGMNme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjGMNmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 09:42:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF150E4F;
        Thu, 13 Jul 2023 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eqRFjEfnQpKX3SCwpqVqk5MwPZ2HabqrXxJtbeOAy2Y=; b=Xpm1APX1flTFZG414QOtZyFKnZ
        XZBeRsaIEzyZfvFraA3stqUA2/UbL54AdKEFB+YFck5dODAOwA4k41eWWwLWsgZwoL1ESKsTR+JEB
        qPXiqSPVl4SVXOItL3fULoS6vqFOJRZkbdE2j9PPZ9qSq5PDb1pocBH6M6GYG3ZDPueKcKm/8/uPg
        lOGhsoeZM+ARDzp4/K+xXoJlYN9P3BMDpvKX5OnSNFOFq8PDZNz4Zc2ZO1YrEtObG2IUwAVSYIYXJ
        g43md3NOFX+J50BWHA43iAphI20mVnWgzi+bR/i913Yh0j0WnfUcmaRqX2QPr7bvlBolFXHd79J4X
        rjzKr0XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJwaQ-000Bur-DA; Thu, 13 Jul 2023 13:42:26 +0000
Date:   Thu, 13 Jul 2023 14:42:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <ZK//Qnfhx+ihtvlO@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
 <ZK1My5hQYC2Kb6G1@casper.infradead.org>
 <56ca93af-67dc-9d10-d27e-00c8d7c20f1b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ca93af-67dc-9d10-d27e-00c8d7c20f1b@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 13, 2023 at 12:42:44PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 11.07.23 um 14:36 schrieb Matthew Wilcox:
> > On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
> > > Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
> > > > This patchset changes the API used by the MM to set up page table entries.
> > > > The four APIs are:
> > > >       set_ptes(mm, addr, ptep, pte, nr)
> > > >       update_mmu_cache_range(vma, addr, ptep, nr)
> > > >       flush_dcache_folio(folio)
> > > >       flush_icache_pages(vma, page, nr)
> > > > 
> > > > flush_dcache_folio() isn't technically new, but no architecture
> > > > implemented it, so I've done that for them.  The old APIs remain around
> > > > but are mostly implemented by calling the new interfaces.
> > > > 
> > > > The new APIs are based around setting up N page table entries at once.
> > > > The N entries belong to the same PMD, the same folio and the same VMA,
> > > > so ptep++ is a legitimate operation, and locking is taken care of for
> > > > you.  Some architectures can do a better job of it than just a loop,
> > > > but I have hesitated to make too deep a change to architectures I don't
> > > > understand well.
> > > > 
> > > > One thing I have changed in every architecture is that PG_arch_1 is now a
> > > > per-folio bit instead of a per-page bit.  This was something that would
> > > > have to happen eventually, and it makes sense to do it now rather than
> > > > iterate over every page involved in a cache flush and figure out if it
> > > > needs to happen.
> > > 
> > > I think we do use PG_arch_1 on s390 for our secure page handling and
> > > making this perf folio instead of physical page really seems wrong
> > > and it probably breaks this code.
> > 
> > Per-page flags are going away in the next few years, so you're going to
> > need a new design.  s390 seems to do a lot of unusual things.  I wish
> > you'd talk to the rest of us more.
> 
> I understand you point from a logical point of view, but a 4k page frame
> is also a hardware defined memory region. And I think not only for us.
> How do you want to implement hardware poisoning for example?
> Marking the whole folio with PG_hwpoison seems wrong.

For hardware poison, we can't use the page for any other purpose any more.
So one of the 16 types of pointer is for hardware poison.  That doesn't
seem like it's a solution that could work for secure/insecure pages?

But what I'm really wondering is why you need to transition pages
between secure/insecure on a 4kB boundary.  What's the downside to doing
it on a 16kB or 64kB boundary, or whatever size has been allocated?

