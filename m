Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4816BE43B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCQIr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCQIrg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:47:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282931F489;
        Fri, 17 Mar 2023 01:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAF1EB824C8;
        Fri, 17 Mar 2023 08:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B0AC433D2;
        Fri, 17 Mar 2023 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679042789;
        bh=eZNvNwV6QaJLpDQt/LL3N1gO2o4a3oCnClv1PSM9XeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJzYOtsVjg8yXxg3J2EU7rYSRGVMTNdq+xiS1UKbgTt4yAo4AWLckqLIAUmAi6f/Y
         colg1stCYv54Uf1/5mYpRAwYTuuQLcZAlBo7yfcCvTDo7w3AtCDBuE/ASeou95rihG
         MlxFnldm04gfXJUCE0HKonnt6tXFsIsgy3vXERRXiKWs1638wS1pMNquvxoQb/g5av
         jBC9Ai1maPLR0XzOmDA0fZ2Ar1n86fFOdhBJE6PPU5Qm4prbB8BBChvuTuiFTsdEc8
         9tJ/NDCx4fRxgo/g8bxqh7rnJ+QGKvvqcQ1/S+MkB6g3vykNLK60/14vHCo+BU3QxI
         8dP2atFEEH+eA==
Date:   Fri, 17 Mar 2023 10:46:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] sparc/mm: Fix MAX_ORDER usage in tsb_grow()
Message-ID: <ZBQo1rUXmTrFgCsR@kernel.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
 <20230316030437.GD3092@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316030437.GD3092@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 08:04:37PM -0700, Mike Kravetz wrote:
> On 03/15/23 14:31, Kirill A. Shutemov wrote:
> > MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> > can deliver is MAX_ORDER-1.
> > 
> > Fix MAX_ORDER usage in tsb_grow().
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: sparclinux@vger.kernel.org
> > Cc: David Miller <davem@davemloft.net>
> > ---
> >  arch/sparc/mm/tsb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> > index 912205787161..dba8dffe2113 100644
> > --- a/arch/sparc/mm/tsb.c
> > +++ b/arch/sparc/mm/tsb.c
> > @@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
> >  	unsigned long new_rss_limit;
> >  	gfp_t gfp_flags;
> >  
> > -	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> > -		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> > +	if (max_tsb_size > (PAGE_SIZE << (MAX_ORDER - 1)))
> > +		max_tsb_size = (PAGE_SIZE << (MAX_ORDER - 1));
> >  
> >  	new_cache_index = 0;
> >  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
> > 
> 
> Fortunately, I think this only comes into play if MAX_ORDER <= 7.
 
I think it's unlikely that such low ARCH_FORCE_MAX_ORDER is ever used.

Judging by c88c545bf320 ("sparc64: Add FORCE_MAX_ZONEORDER and default to
13") log the option to override MAX_ORDER was added to "request large (32M)
contiguous memory during boot for creating IOTSB backing store", so it was
about to increase MAX_ORDER.

Generally, we may restrict sparc::ARCH_FORCE_MAX_ORDER to be above 7 and
drop this check entirely

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> -- 
> Mike Kravetz
> 

-- 
Sincerely yours,
Mike.
