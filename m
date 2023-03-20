Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B116C145F
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 15:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCTOIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCTOIs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 10:08:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603A49FB;
        Mon, 20 Mar 2023 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MJxCjOddyT7A7I/gLOdqBjGGzMXJDL0bQXHZfHiA2i4=; b=tpRr5kRvwQtlBuB+YU/YMpXZFe
        KxoTKMD3RPkaZixl8ji082MY6W6IC05IZ5EVl+lm4vGGDvWSL0bMXHKu8zsqz0Wf3qmNN5p8nt+3R
        2PXoaoQjnkfGBIrOCSH8IK0DlDCSOmgrvTMKbfGmtNSkU8QyKRWpU1hRap8MXPW3V/Rb13adp/kI9
        nnBl+L484LzrirsbKQ2hjfIMqec40/FLok8E9n6gVmiAT1dkoFC2UyAs48Ng2YXO3CaNZPA0uJ/zr
        Mdlom7lZgT+JQeJUG7UEdSoxs0jMdSjuWVbAKg3DLuAwFsO7E8tUB73N94rCPMgH7WYqWkLR6d2xW
        K1/AU9Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peGBl-0015zY-V2; Mon, 20 Mar 2023 14:08:41 +0000
Date:   Mon, 20 Mar 2023 14:08:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-arch@vger.kernel.org,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Message-ID: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <483fd440-df7b-fab3-b138-f3789f2dc078@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483fd440-df7b-fab3-b138-f3789f2dc078@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 09:38:55PM +0800, Yin, Fengwei wrote:
> Thanks a lot to Ryan for helping to test the debug patch I made.
> 
> Ryan confirmed that the following change could fix the kernel build regression:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index db86e459dde6..343d6ff36b2c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3557,7 +3557,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> 
>                 ret |= filemap_map_folio_range(vmf, folio,
>                                 xas.xa_index - folio->index, addr, nr_pages);
> -               xas.xa_index += nr_pages;
> +               xas.xa_index += folio_test_large(folio) ? nr_pages : 0;
> 
>                 folio_unlock(folio);
>                 folio_put(folio);
> 
> I will make upstream-able change as "xas.xa_index += nr_pages - 1;"

Thanks to both of you!

Really, we shouldn't need to interfere with xas.xa_index at all.
Does this work?

diff --git a/mm/filemap.c b/mm/filemap.c
index 8e4f95c5b65a..e40c967dde5f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3420,10 +3420,10 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	return false;
 }
 
-static struct folio *next_uptodate_page(struct folio *folio,
-				       struct address_space *mapping,
-				       struct xa_state *xas, pgoff_t end_pgoff)
+static struct folio *next_uptodate_folio(struct xa_state *xas,
+		struct address_space *mapping, pgoff_t end_pgoff)
 {
+	struct folio *folio = xas_next_entry(xas, end_pgoff);
 	unsigned long max_idx;
 
 	do {
@@ -3461,22 +3461,6 @@ static struct folio *next_uptodate_page(struct folio *folio,
 	return NULL;
 }
 
-static inline struct folio *first_map_page(struct address_space *mapping,
-					  struct xa_state *xas,
-					  pgoff_t end_pgoff)
-{
-	return next_uptodate_page(xas_find(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
-}
-
-static inline struct folio *next_map_page(struct address_space *mapping,
-					 struct xa_state *xas,
-					 pgoff_t end_pgoff)
-{
-	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
-}
-
 /*
  * Map page range [start_page, start_page + nr_pages) of folio.
  * start_page is gotten from start by folio_page(folio, start)
@@ -3552,7 +3536,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	int nr_pages = 0;
 
 	rcu_read_lock();
-	folio = first_map_page(mapping, &xas, end_pgoff);
+	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
@@ -3574,11 +3558,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 		ret |= filemap_map_folio_range(vmf, folio,
 				xas.xa_index - folio->index, addr, nr_pages);
-		xas.xa_index += nr_pages;
 
 		folio_unlock(folio);
 		folio_put(folio);
-	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
+		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
+	} while (folio);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();

> Ryan and I also identify some other changes needed. I am not sure how to
> integrate those changes to this series. Maybe an add-on patch after this
> series? Thanks.

Up to you; I'm happy to integrate fixup patches into the current series
or add on new ones.
