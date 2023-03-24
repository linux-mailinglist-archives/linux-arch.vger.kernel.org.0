Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5006C808C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 15:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjCXO6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjCXO6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 10:58:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B5BBBB;
        Fri, 24 Mar 2023 07:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5215B824CE;
        Fri, 24 Mar 2023 14:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A12C433D2;
        Fri, 24 Mar 2023 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679669914;
        bh=IPP98xkEGCS26RS7zBBVCYa/If1hBwvykU9UME9Sd7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jT3AM6bfW/hZrebKexLOI2EXvMKsrwnQPoq4KUl14cM/kv9AkBq0fFB4PPIOnNJ+1
         +iabW6SWEMiee5ThCRpLvZjILgEf6M0UqONHrcE8FluvoTBACt6nxjsrr47wBCB3D3
         gemJQlLCSDzmfTSKyzzL9X8li2Cwa34DFjL0LqUllttmolWbF0WcPD4+P3b5lm5Qxe
         OeQpJfXCFU2kkQPSpnurx43pKm3PSEYs75ffRlLZQ16XD0VIfAaqrBLUyEt6mgzAPu
         66mDPfyUXV2xEWnfsBTSYlmpwQMBmlrBL/K85qAq9lxs4muYYtn1hkJ7jsAFRjFDDt
         /OjAXMJuNBNqw==
Date:   Fri, 24 Mar 2023 14:58:29 +0000
From:   Will Deacon <will@kernel.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <20230324145828.GB27199@willie-the-truck>
References: <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
 <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
 <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 04:19:44PM +0800, Yin, Fengwei wrote:
> 
> 
> On 3/17/2023 4:00 PM, Ryan Roberts wrote:
> > On 17/03/2023 06:33, Yin, Fengwei wrote:
> >>
> >>
> >> On 3/17/2023 11:44 AM, Matthew Wilcox wrote:
> >>> On Fri, Mar 17, 2023 at 09:58:17AM +0800, Yin, Fengwei wrote:
> >>>>
> >>>>
> >>>> On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
> >>>>> On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
> >>>>>> On 16/03/2023 16:23, Yin, Fengwei wrote:
> >>>>>>>> I think you are changing behavior here - is this intentional? Previously this
> >>>>>>>> would be evaluated per page, now its evaluated once for the whole range. The
> >>>>>>>> intention below is that directly faulted pages are mapped young and prefaulted
> >>>>>>>> pages are mapped old. But now a whole range will be mapped the same.
> >>>>>>>
> >>>>>>> Yes. You are right here.
> >>>>>>>
> >>>>>>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
> >>>>>>> can avoid to handle vmf->address == addr specially. It's OK to 
> >>>>>>> drop prefault and change the logic here a little bit to:
> >>>>>>>   if (arch_wants_old_prefaulted_pte())
> >>>>>>>       entry = pte_mkold(entry);
> >>>>>>>   else
> >>>>>>>       entry = pte_sw_mkyong(entry);
> >>>>>>>
> >>>>>>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
> >>>>>>> because HW will set the ACCESS bit in page table entry.
> >>>>>>>
> >>>>>>> Add Will Deacon in case I missed something here. Thanks.
> >>>>>>
> >>>>>> I'll defer to Will's response, but not all arm HW supports HW access flag
> >>>>>> management. In that case it's done by SW, so I would imagine that by setting
> >>>>>> this to old initially, we will get a second fault to set the access bit, which
> >>>>>> will slow things down. I wonder if you will need to split this into (up to) 3
> >>>>>> calls to set_ptes()?
> >>>>>
> >>>>> I don't think we should do that.  The limited information I have from
> >>>>> various microarchitectures is that the PTEs must differ only in their
> >>>>> PFN bits in order to use larger TLB entries.  That includes the Accessed
> >>>>> bit (or equivalent).  So we should mkyoung all the PTEs in the same
> >>>>> folio, at least initially.
> >>>>>
> >>>>> That said, we should still do this conditionally.  We'll prefault some
> >>>>> other folios too.  So I think this should be:
> >>>>>
> >>>>>         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
> >>>>>
> >>>> According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
> >>>> flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
> >>>> If we change prefault like above, the PTEs is set as "yong" which loose benefit
> >>>> on ARM64 with hardware access flag.
> >>>>
> >>>> ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
> >>>> and let hardware to update it to "yong"?
> >>>
> >>> Because we're tracking the entire folio as a single entity.  So we're
> >>> better off avoiding the extra pagefaults to update the accessed bit,
> >>> which won't actually give us any information (vmscan needs to know "were
> >>> any of the accessed bits set", not "how many of them were set").
> >> There is no extra pagefaults to update the accessed bit. There are three cases here:
> >> 1. hardware support access flag and cheap from "old" to "yong" without extra fault
> >> 2. hardware support access flag and expensive from "old" to "yong" without extra fault
> >> 3. no hardware support access flag (extra pagefaults from "old" to "yong". Expensive)
> >>
> >> For #2 and #3, it's expensive from "old" to "yong", so we always set PTEs "yong" in
> >> page fault.
> >> For #1, It's cheap from "old" to "yong", so it's OK to set PTEs "old" in page fault.
> >> And hardware will set it to "yong" when access memory. Actually, ARM64 with hardware
> >> access bit requires to set PTEs "old".
> > 
> > Your logic makes sense, but it doesn't take into account the HPA
> > micro-architectural feature present in some ARM CPUs. HPA can transparently
> > coalesce multiple pages into a single TLB entry when certain conditions are met
> > (roughly; upto 4 pages physically and virtually contiguous and all within a
> > 4-page natural alignment). But as Matthew says, this works out better when all
> > pte attributes (including access and dirty) match. Given the reason for setting
> > the prefault pages to old is so that vmscan can do a better job of finding cold
> > pages, and given vmscan will now be looking for folios and not individual pages
> > (I assume?), I agree with Matthew that we should make whole folios young or old.
> > It will marginally increase our chances of the access and dirty bits being
> > consistent across the whole 4-page block that the HW tries to coalesce. If we
> > unconditionally make everything old, the hw will set accessed for the single
> > page that faulted, and we therefore don't have consistency for that 4-page block.
> My concern was that the benefit of "old" PTEs for ARM64 with hardware access bit
> will be lost. The workloads (application launch latency and direct reclaim according
> to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80) can show regression with this
> series. Thanks.

Yes, please don't fault everything in as young as it has caused horrible
vmscan behaviour leading to app-startup slowdown in the past:

https://lore.kernel.org/all/20210111140149.GB7642@willie-the-truck/

If we have to use the same value for all the ptes, then just base them
all on arch_wants_old_prefaulted_pte() as iirc hardware AF was pretty
cheap in practice for us.

Cheers,

Will
