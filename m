Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83836BDFBF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 04:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCQDpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 23:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCQDpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 23:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC95FE3;
        Thu, 16 Mar 2023 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qF107+j6GAuH3RxQoYDUVv0pRB+DB/rZIKen3lbmswM=; b=j2Tw26G+DFxuBZBc4zZKT+J3s5
        XwHQAq/SUUtueB9ucrLUZGtRcylwrC1NL/krcmZJ8pyvmt8o1ZcPc4z00d04PqjMJcjmAv3UXmFEi
        feGW57C3Drx32F5AxFrfXuLSE4kxIGcUdZ+BK/kuTNqNrMWp6etYlsxByrcyV+XpwHqqlaLOhEykB
        Ky1LoJIzkA9iOriueRGr5f6dCxrC+Z3aacWogDjbaItbf4cgFtFt5CY839Y4Q9nuq1CVgr2kzuBnE
        Ibi3sqp5verctmlRGpvbvMtbsWvv705ub64mujX3P4zqdBVMMnPHiNEBAwFn4T5BfdeF+swpVmV96
        82+RY54Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pd11W-00FT7F-6g; Fri, 17 Mar 2023 03:44:58 +0000
Date:   Fri, 17 Mar 2023 03:44:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-arch@vger.kernel.org,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <ZBPiOgYDLYBmVwOc@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 09:58:17AM +0800, Yin, Fengwei wrote:
> 
> 
> On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
> > On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
> >> On 16/03/2023 16:23, Yin, Fengwei wrote:
> >>>> I think you are changing behavior here - is this intentional? Previously this
> >>>> would be evaluated per page, now its evaluated once for the whole range. The
> >>>> intention below is that directly faulted pages are mapped young and prefaulted
> >>>> pages are mapped old. But now a whole range will be mapped the same.
> >>>
> >>> Yes. You are right here.
> >>>
> >>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
> >>> can avoid to handle vmf->address == addr specially. It's OK to 
> >>> drop prefault and change the logic here a little bit to:
> >>>   if (arch_wants_old_prefaulted_pte())
> >>>       entry = pte_mkold(entry);
> >>>   else
> >>>       entry = pte_sw_mkyong(entry);
> >>>
> >>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
> >>> because HW will set the ACCESS bit in page table entry.
> >>>
> >>> Add Will Deacon in case I missed something here. Thanks.
> >>
> >> I'll defer to Will's response, but not all arm HW supports HW access flag
> >> management. In that case it's done by SW, so I would imagine that by setting
> >> this to old initially, we will get a second fault to set the access bit, which
> >> will slow things down. I wonder if you will need to split this into (up to) 3
> >> calls to set_ptes()?
> > 
> > I don't think we should do that.  The limited information I have from
> > various microarchitectures is that the PTEs must differ only in their
> > PFN bits in order to use larger TLB entries.  That includes the Accessed
> > bit (or equivalent).  So we should mkyoung all the PTEs in the same
> > folio, at least initially.
> > 
> > That said, we should still do this conditionally.  We'll prefault some
> > other folios too.  So I think this should be:
> > 
> >         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
> > 
> According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
> flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
> If we change prefault like above, the PTEs is set as "yong" which loose benefit
> on ARM64 with hardware access flag.
> 
> ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
> and let hardware to update it to "yong"?

Because we're tracking the entire folio as a single entity.  So we're
better off avoiding the extra pagefaults to update the accessed bit,
which won't actually give us any information (vmscan needs to know "were
any of the accessed bits set", not "how many of them were set").

Anyway, hopefully Ryan can test this and let us know if it fixes the
regression he sees.
