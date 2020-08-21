Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12224CD57
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHUFp0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUFpZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 01:45:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991CC061385;
        Thu, 20 Aug 2020 22:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mrGKbmJ1c7ngURPGL3BPovml0cJwz1Kq/Us/whxD7Sc=; b=HXYIu1bnNW/qWXAehQRzq4ZK6I
        V9RA92llGQm+y5SLxiKLrH7jpItu9BFP0M8CUS+vmD/8vQZkR5ZCMkpI+/PFmr3GKApoigmRzl+Jw
        R+q4a1c7tXY/q5zqu/9M8FAIp/AWhUfj7G825d7RMQ4XZdILn+y5JrhQ9hevQTAR7Wwzl9HDhDlei
        GzFX6TlE/eeYqrx7+uDlbdF/YPbcCWIKIHWzS53CvpmH2CQ+9Ivl1NlXJwDvV/HFgX/vSLZr7ME8k
        oAXdDCBZSzovPItK/QL3IzGObSAN723G0X6pt9VTLgUo8Dxyqr6CFCaeprsKkOYgXfGHtJwj4uIBr
        jorGF3Kw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8zrd-0007WC-Mn; Fri, 21 Aug 2020 05:45:21 +0000
Date:   Fri, 21 Aug 2020 06:45:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 4/8] lib/ioremap: rename ioremap_*_range to
 vmap_*_range
Message-ID: <20200821054521.GB28291@infradead.org>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-5-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 02:44:23PM +1000, Nicholas Piggin wrote:
> This will be moved to mm/ and used as a generic kernel virtual mapping
> function, so re-name it in preparation.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/ioremap.c | 55 ++++++++++++++++++++++------------------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 5fa1ab41d152..6016ae3227ad 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -61,9 +61,8 @@ static inline int ioremap_pud_enabled(void) { return 0; }
>  static inline int ioremap_pmd_enabled(void) { return 0; }
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
> -static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
> -		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
> -		pgtbl_mod_mask *mask)
> +static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> +			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)

Same here.
