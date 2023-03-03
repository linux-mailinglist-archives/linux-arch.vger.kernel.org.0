Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE156A9900
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCCOCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCCOCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:02:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761C222D9;
        Fri,  3 Mar 2023 06:02:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E84261828;
        Fri,  3 Mar 2023 14:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F1AC433EF;
        Fri,  3 Mar 2023 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852134;
        bh=D2lATwcmN4e22YZ5aHLO1Pv+OgVSoP6nsGri2C6eY78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aW4ocQYBp4uogb72z4sv47K6g3fT9l+F4mRbGdRLzIKGvY21PnFHBkN13xd1wWH85
         3Au16CfOJrrkSmTPBoGE3q2RFFf/mC1S2lfOAZ4U7pyMUpK/qT9T5nMMmGIcjE5V7r
         ilBNJZQmYAm+inSqsXGSVMxGH11OnAx1qp2xzqCwDgYPR4VcV4n0ryrN4FPDG9IFwp
         ZA2qUwhmgYHDzNWMPyjZsa0+fog7PVxQ5yh3usUCzseq2o4nKCU0BxgxBdWxZJJWMX
         tAczGM5E7R94IVlsjyhupZCDS3aGxmeGrwEkUc2dGN6DQJ3NDEMZfR5AKQc3eXHHVk
         A9dcEcS52Lvlw==
Date:   Fri, 3 Mar 2023 16:02:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 30/34] mm: Use flush_icache_pages() in do_set_pmd()
Message-ID: <ZAH92UJ+vObeGsG/@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-31-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:33PM +0000, Matthew Wilcox (Oracle) wrote:
> Push the iteration over each page down to the architectures (many
> can flush the entire THP without iteration).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bfa3100ec5a3..69e844d5f75c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4222,8 +4222,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (unlikely(!pmd_none(*vmf->pmd)))
>  		goto out;
>  
> -	for (i = 0; i < HPAGE_PMD_NR; i++)
> -		flush_icache_page(vma, page + i);
> +	flush_icache_pages(vma, page, HPAGE_PMD_NR);
>  
>  	entry = mk_huge_pmd(page, vma->vm_page_prot);
>  	if (write)
> -- 
> 2.39.1

I get this:

  CC      mm/memory.o
/home/mike/git/linux/mm/memory.c: In function 'do_set_pmd':
/home/mike/git/linux/mm/memory.c:4191:13: warning: unused variable 'i' [-Wunused-variable]
 4191 |         int i;
      |             ^

And the patch here makes it go away:

diff --git a/mm/memory.c b/mm/memory.c
index cc7845ff09ba..c359fb8643e5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4188,7 +4188,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
-	int i;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (!transhuge_vma_suitable(vma, haddr))

-- 
Sincerely yours,
Mike.
