Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184D6BD792
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCPRxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCPRw5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 13:52:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DB1D918;
        Thu, 16 Mar 2023 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hFPx9TUNmTQG74RYarcXKwNrKhnz4iqXeYksYgX+F24=; b=rj/4Gv1GK+hzFTvQLUVmniIiK2
        uKg8NvI/KXXTbHaYomzmgaFWtcFSbqMWHZqCUhAGD3OpMUylncQqv2m3NPAz5EWnPlHOaItIGphxr
        JDdr8SP6jeGCRzIR9aVM6PhHMZCLKyDQZMSq/wyzFYb7nVhCvHjh4KXnSnlW7VYeomkdwIfH0CtzU
        r5dbYMUrKL3TeVhK/qlfS5xuhHephALmPvHDiKuW3qKsAyUVElwBF0cp9zY2nYHF7z1fHNX2Za/YV
        mp6ddhoh/M2zs0zHzohBYNXAWG4XLTSMaXuUUSn0oc+ncqcykYR2gT5HHqFlWpvcqlUF9drYd6KZD
        1sBqB4+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcrmV-00F3N7-0b; Thu, 16 Mar 2023 17:52:51 +0000
Date:   Thu, 16 Mar 2023 17:52:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>, linux-arch@vger.kernel.org,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <ZBNXcmOrrOS4Rydg@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
> On 16/03/2023 16:23, Yin, Fengwei wrote:
> >> I think you are changing behavior here - is this intentional? Previously this
> >> would be evaluated per page, now its evaluated once for the whole range. The
> >> intention below is that directly faulted pages are mapped young and prefaulted
> >> pages are mapped old. But now a whole range will be mapped the same.
> > 
> > Yes. You are right here.
> > 
> > Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
> > can avoid to handle vmf->address == addr specially. It's OK to 
> > drop prefault and change the logic here a little bit to:
> >   if (arch_wants_old_prefaulted_pte())
> >       entry = pte_mkold(entry);
> >   else
> >       entry = pte_sw_mkyong(entry);
> > 
> > It's not necessary to use pte_sw_mkyong for vmf->address == addr
> > because HW will set the ACCESS bit in page table entry.
> > 
> > Add Will Deacon in case I missed something here. Thanks.
> 
> I'll defer to Will's response, but not all arm HW supports HW access flag
> management. In that case it's done by SW, so I would imagine that by setting
> this to old initially, we will get a second fault to set the access bit, which
> will slow things down. I wonder if you will need to split this into (up to) 3
> calls to set_ptes()?

I don't think we should do that.  The limited information I have from
various microarchitectures is that the PTEs must differ only in their
PFN bits in order to use larger TLB entries.  That includes the Accessed
bit (or equivalent).  So we should mkyoung all the PTEs in the same
folio, at least initially.

That said, we should still do this conditionally.  We'll prefault some
other folios too.  So I think this should be:

        bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);

