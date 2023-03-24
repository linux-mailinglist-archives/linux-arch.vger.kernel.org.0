Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DB6C8340
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCXRX3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXRX2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 13:23:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795E49E1;
        Fri, 24 Mar 2023 10:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 883B8B82542;
        Fri, 24 Mar 2023 17:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C44C433EF;
        Fri, 24 Mar 2023 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679678605;
        bh=hjmtTNY2LEM4m5fAZV6d3wQ06Jak42bz3CVHjflH8ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsKVbaD2ZK8EjUVu7w7khg4JYE5SqpclxxIVLUnrWJn34t4R4e49IifU3e86N10DU
         gfROvnCLRVIPVG+pXSK6xtwM/DTdk0VBjgixqiqjR1RdQve2xuPBzM7glDBqEgSZdW
         3BkR75UqI208Bccv6DtLQzHS6gwkw1a5agDlKPNo/26kxIrq3Nkt6GBndmTOrkBZY3
         am5SRH0xSCRGmxkWptjZbj26Xi4amAwLH5ORkYFp2Jd3vEfWojAJahrjTREnkX6F4w
         3HEROgCWhHFgifZ+cRwpULDf07kDyOuRR3qmCSKNHoen3ZRqUNXImBokPz/7MG6hEy
         qyHsczyCKzXwQ==
Date:   Fri, 24 Mar 2023 17:23:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <20230324172319.GA27842@willie-the-truck>
References: <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
 <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
 <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
 <20230324145828.GB27199@willie-the-truck>
 <ZB29hND1tt37dNUX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB29hND1tt37dNUX@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 03:11:00PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 24, 2023 at 02:58:29PM +0000, Will Deacon wrote:
> > Yes, please don't fault everything in as young as it has caused horrible
> > vmscan behaviour leading to app-startup slowdown in the past:
> > 
> > https://lore.kernel.org/all/20210111140149.GB7642@willie-the-truck/
> > 
> > If we have to use the same value for all the ptes, then just base them
> > all on arch_wants_old_prefaulted_pte() as iirc hardware AF was pretty
> > cheap in practice for us.
> 
> I think that's wrong, because this is a different scenario.
> 
> Before:
> 
> We faulted in N single-page folios.  Each page/folio is tracked
> independently.  That's N entries on whatever LRU list it ends up on.
> The prefaulted ones _should_ be marked old -- they haven't been
> accessed; we've just decided to put them in the page tables to
> speed up faultaround.  The unaccessed pages need to fall off the LRU
> list as quickly as possible; keeping them around only hurts if the
> workload has no locality of reference.
> 
> After:
> 
> We fault in N folios, some possibly consisting of multiple pages.
> Each folio is tracked separately, but individual pages in the folio
> are not tracked; they belong to their folio.  In this scenario, if
> the other PTEs for pages in the same folio are marked as young or old
> doesn't matter; the entire folio will be tracked as young, because we
> referenced one of the pages in this folio.  Marking the other PTEs as
> young actually helps because we don't take pagefaults on them (whether
> we have a HW or SW accessed bit).
> 
> (can i just say that i dislike how we mix up our old/young accessed/not
> terminology here?)
> 
> We should still mark the PTEs referencing unaccessed folios as old.
> No argument there, and this patch does that.  But it's fine for all the
> PTEs referencing the accessed folio to have the young bit, at least as
> far as I can tell.

Ok, thanks for the explanation. So as long as
arch_wants_old_prefaulted_pte() is taken into account for the unaccessed
folios, then I think we should be good? Unconditionally marking those
PTEs as old probably hurts x86.

Will
