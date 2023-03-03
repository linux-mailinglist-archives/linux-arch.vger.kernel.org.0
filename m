Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAA6A9B4D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCCQCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCCQCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 11:02:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F81ACCF;
        Fri,  3 Mar 2023 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a61vCLGPtw7ytsuivCnnaSA8TTux/ew1GXnO2PIM6zc=; b=sl1U8UXpCLNhOfwHysl9WpB/2H
        xt/mbpCW2+7f+sFCHI0rLgv00mzL/mURYeMG2TtC4kp4zXgm6G1Ftyc8IaQotvjv0y7dlzwv5FN1a
        mQgNBRi2fdsQ4cJspqff8wgITzcyblPbLTUFwihxnZhLXa2rmTRvqERmbOr0Mw/8mappWNymP9sz/
        34yLwES7mduMh72ypGwnGe1tOEuANrIakykmNSN8XfFU5hnu2sMmb6AkYzxAI2DrKLMlKVwyjxzdf
        wm+Z2zqcRqAxAdxLRAGP5Oskesw6Kt8hZTRid0cH/lM2FaYAQ/vZrCbsnJ4cKUMqZl9ze9Kk7s+IK
        7/olMkqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY7rH-003Dre-IC; Fri, 03 Mar 2023 16:02:11 +0000
Date:   Fri, 3 Mar 2023 16:02:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 30/34] mm: Use flush_icache_pages() in do_set_pmd()
Message-ID: <ZAIaA8YaZrxE7HZe@casper.infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-31-willy@infradead.org>
 <ZAH92UJ+vObeGsG/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAH92UJ+vObeGsG/@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 03, 2023 at 04:02:01PM +0200, Mike Rapoport wrote:
> On Tue, Feb 28, 2023 at 09:37:33PM +0000, Matthew Wilcox (Oracle) wrote:
> > Push the iteration over each page down to the architectures (many
> > can flush the entire THP without iteration).
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/memory.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index bfa3100ec5a3..69e844d5f75c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4222,8 +4222,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> >  	if (unlikely(!pmd_none(*vmf->pmd)))
> >  		goto out;
> >  
> > -	for (i = 0; i < HPAGE_PMD_NR; i++)
> > -		flush_icache_page(vma, page + i);
> > +	flush_icache_pages(vma, page, HPAGE_PMD_NR);
> >  
> >  	entry = mk_huge_pmd(page, vma->vm_page_prot);
> >  	if (write)
> > -- 
> > 2.39.1
> 
> I get this:
> 
>   CC      mm/memory.o
> /home/mike/git/linux/mm/memory.c: In function 'do_set_pmd':
> /home/mike/git/linux/mm/memory.c:4191:13: warning: unused variable 'i' [-Wunused-variable]
>  4191 |         int i;

Yep, caught that one last night.  My build test must have been with a
config that didn't include THP.  Thanks.
