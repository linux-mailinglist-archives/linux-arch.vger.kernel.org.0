Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69540544B9A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiFIMTQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiFIMTL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 08:19:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD431BC149;
        Thu,  9 Jun 2022 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Py1XbeQYoV2WaLT1b7PoYSfrJY33ukYR++1ZCekWrA=; b=d5SJnp5L55UkGo1Z+IupQH6lgu
        0gkbpMt2/QZ4OvDi8xybTKth8gEqRWU3azU0NGb1gQMBIoYHblgP9l8SkGX1G9+uUvRgki1kHPZmD
        6XVTPqS9TRmXEXTB/cP7I5WpebsIfo0D8yDIjbhDPKbkwDEcrpdXEzyFK5LOOhF4TDAvwAbVriqgq
        2nfUW9+XjyizpJOLyVruQBK7PFEZw9ImhShAnMgiQJWk5tPYJ67cio1VNzFHTkPrq4mh2yoNjhjIf
        m1aQOc+E/U/brKoYAysMB07FpTjrAY185m9Q3ofZoZeouVvl/NHMBmjpwYXYi1QBrv3vTQjT0dhZG
        FSY7wkRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzH7i-00DXRv-7v; Thu, 09 Jun 2022 12:18:50 +0000
Date:   Thu, 9 Jun 2022 13:18:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-arch@vger.kernel.org,
        lkp@lists.01.org, akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
Message-ID: <YqHlKj5LbmtYGWUy@casper.infradead.org>
References: <20220608143819.GA31193@xsang-OptiPlex-9020>
 <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 09, 2022 at 12:42:16PM +0800, Baolin Wang wrote:
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 6cccf52e156a..cae74e972426 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -858,6 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>         /* INVLPG to clear all paging-structure caches */
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
> 
> +       pgtable_clear_and_dec(virt_to_page(pte));
>         free_page((unsigned long)pte);
> 
>         return 1;

If you're going to call virt_to_page() here, you may as well cache the
result and call __free_page(page) to avoid calling virt_to_page() twice.
