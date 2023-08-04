Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AAF76F87F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHDDu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHDDuV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 23:50:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB84684;
        Thu,  3 Aug 2023 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F+lJKFltZ+yQxd96NjAiSlGEaIJzdn+HIXjUUFBSS5c=; b=UKi7MCXmu/eFaLtMvBvufRKVdU
        DaCDf7FpNDWKsVmLjSyGc6/yxeFqe3Y81Jv2wMiXxhN/acrrYIe+cLWVA8Ngm3flCWpw67hZ8Cq4h
        8XatmpxPtkcPu+sDGM5Cv6LLrV48z7za5rh77704UnbEhMUUkjRA9o79maxq1G6k7Ln4V5cixK8H2
        a3fsMVVuWgMsVAnQo2mUm+DynVTptf6Dewygne5j2FslBjF8LOOfG+zqFWNk2xZgABdUpXOFJoksb
        QfmLEyGJDj8wEgWRD3ZdYiXVJzfDHWttImP7dp1vRY5vAlUPDEydhyidN3Jx5OrS6NKXkVdN48mXp
        yq8AMDtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRlpN-007del-Ap; Fri, 04 Aug 2023 03:50:13 +0000
Date:   Fri, 4 Aug 2023 04:50:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 21/38] powerpc: Implement the new page table range API
Message-ID: <ZMx1daYwvD9EM7Cv@casper.infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-22-willy@infradead.org>
 <20230803233814.GA2515372@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803233814.GA2515372@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 03, 2023 at 04:38:14PM -0700, Nathan Chancellor wrote:
> > -EXPORT_SYMBOL(flush_dcache_icache_page);
> 
> Apologies if this has already been fixed or reported, I searched lore
> and did not find anything. The dropping of this export in combination
> with the conversion above appears to cause ARCH=powerpc allmodconfig to
> fail with:
> 
>   ERROR: modpost: "flush_dcache_icache_folio" [arch/powerpc/kvm/kvm-pr.ko] undefined!
> 
> I don't know if this should be re-exported or not but that does
> obviously resolve the issue.

Well, that was clumsy of me.  I (and the Intel build bot) did test several
build combos, but clearly didn't manage to find a config that showed
this problem.  Andrew, a fix patch for you to integrate, if you would:

diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index 8760d2223abe..15189592da09 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -172,6 +172,7 @@ void flush_dcache_icache_folio(struct folio *folio)
 			flush_dcache_icache_phys((pfn + i) * PAGE_SIZE);
 	}
 }
+EXPORT_SYMBOL(flush_dcache_icache_folio);
 
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
