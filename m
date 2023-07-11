Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8A74F617
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGKQwh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGKQwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 12:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8390E75;
        Tue, 11 Jul 2023 09:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3B661578;
        Tue, 11 Jul 2023 16:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66564C433C7;
        Tue, 11 Jul 2023 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689094354;
        bh=tPUlfpdEgVeWU0fEHmbznxG/fGtFy4lDdLUuzVWVgqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ifj3AekL98UeHTVQ1xETMb3/VKh08B5fL854XmdDUd9ksG2I7VYkY1ZcVn/9Sb/o4
         rHd70rHd4B6iP9MbnqQa+A8/Jn/zkdH/rHsGz7ViYLrSxCXhSl4G4alFIgvCeF4YbB
         0SCL1lbtyu6s3X2g84bDvTB/gZumLGBIdOMqY1jE=
Date:   Tue, 11 Jul 2023 09:52:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-Id: <20230711095233.aa74320d729c1da818a6a4ed@linux-foundation.org>
In-Reply-To: <20230711172440.77504856@p-imbrenda>
References: <20230710204339.3554919-1-willy@infradead.org>
        <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
        <ZK1My5hQYC2Kb6G1@casper.infradead.org>
        <20230711172440.77504856@p-imbrenda>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jul 2023 17:24:40 +0200 Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue, 11 Jul 2023 13:36:27 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
> > > Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):  
> > > > This patchset changes the API used by the MM to set up page table entries.
> > > > The four APIs are:
> > > >      set_ptes(mm, addr, ptep, pte, nr)
> > > >      update_mmu_cache_range(vma, addr, ptep, nr)
> > > >      flush_dcache_folio(folio)
> > > >      flush_icache_pages(vma, page, nr)
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
> 
> For each 4k physical page frame, we need to keep track whether it is
> secure or not.
> 
> A bit in struct page seems the most logical choice. If that's not
> possible anymore, how would you propose we should do?
> 
> > need a new design.  s390 seems to do a lot of unusual things.  I wish
> 
> s390 is an unusual architecture. we are working on un-weirding our
> code, but it takes time
> 

This issue sounds fatal for this version of this patchset?
