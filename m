Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560174EF16
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGKMho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGKMhm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 08:37:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD33171B;
        Tue, 11 Jul 2023 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlnB2tfvK6zA01tMfE90usFEigtkyKBwlIV/RGlhbEc=; b=CkKrD0bRwFnd4JjbmnZV9d1FGE
        NFbm5ssns3ISKSsdZDQ5sCU7+tQkCpLVQbHcT0E/1gtjNJkJTIevFzmqkbyZuf1Mj4AqYOmSED1oY
        umjsfhCQO+J+P/dyQz4emavUaIQwzN4mUBFwsi/OFX3cVouA7VRKiagiMcPVCvFMD7FjQfkcDwm25
        tWFIT6suFiVLnOgPzk18GpdH6f+xuVcN9BSpLD1MAVUNtarIxQMweeF7hG7KZ/7x361aB1MTP5PJw
        uVeSSiX9aso+xhA1lEWInzX6tudKcEoN9mbD8Gb7qNTipA3Ko7qBwt9lK1qJVIWREeGv+eZ3IukD8
        dskKbcOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJCbT-00Fid1-AK; Tue, 11 Jul 2023 12:36:27 +0000
Date:   Tue, 11 Jul 2023 13:36:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <ZK1My5hQYC2Kb6G1@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
> Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
> > This patchset changes the API used by the MM to set up page table entries.
> > The four APIs are:
> >      set_ptes(mm, addr, ptep, pte, nr)
> >      update_mmu_cache_range(vma, addr, ptep, nr)
> >      flush_dcache_folio(folio)
> >      flush_icache_pages(vma, page, nr)
> > 
> > flush_dcache_folio() isn't technically new, but no architecture
> > implemented it, so I've done that for them.  The old APIs remain around
> > but are mostly implemented by calling the new interfaces.
> > 
> > The new APIs are based around setting up N page table entries at once.
> > The N entries belong to the same PMD, the same folio and the same VMA,
> > so ptep++ is a legitimate operation, and locking is taken care of for
> > you.  Some architectures can do a better job of it than just a loop,
> > but I have hesitated to make too deep a change to architectures I don't
> > understand well.
> > 
> > One thing I have changed in every architecture is that PG_arch_1 is now a
> > per-folio bit instead of a per-page bit.  This was something that would
> > have to happen eventually, and it makes sense to do it now rather than
> > iterate over every page involved in a cache flush and figure out if it
> > needs to happen.
> 
> I think we do use PG_arch_1 on s390 for our secure page handling and
> making this perf folio instead of physical page really seems wrong
> and it probably breaks this code.

Per-page flags are going away in the next few years, so you're going to
need a new design.  s390 seems to do a lot of unusual things.  I wish
you'd talk to the rest of us more.
