Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6D1A6740
	for <lists+linux-arch@lfdr.de>; Mon, 13 Apr 2020 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgDMNlO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Apr 2020 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgDMNlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2020 09:41:13 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Apr 2020 06:41:08 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B6C0A3BDC;
        Mon, 13 Apr 2020 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXr19U1fgLFA690aiYcKrrCMpq73umlTXiDnSKGqGOU=; b=AS59FWW5J2xkZJ9kAYmjKnECFC
        BLSjvKBPwhifmVm0b5v4PfawQRVu5DP0tQGTKPn6KCVJMt7KdvBxQpzRQnHyk4LAWKvUfkYN+RLcV
        n/pjOAShKf8BL2G3umFK2CB5KD4whLLIBC3Tw8s+tBTw8ia9togBAWZhVArgb67NY36Lsv3wSNc7H
        PwUWigJp4ffAivNapErEQqgf9qRfC0XGFRp5sSkQkw0J0y3Ou64R3DRZ3kgJuUanyLiHXv6t9uvpB
        RYquPuIThmO9pQiFXNaeVJAe5rkXt9G2Xe8fCsiX0tRh/cMK+w3C4nXGQ+lewhZRyZBD7oybQW222
        Mtlbo1Hg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNzKk-0001yI-VC; Mon, 13 Apr 2020 13:41:06 +0000
Date:   Mon, 13 Apr 2020 06:41:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200413134106.GN21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> +static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
> +				    pgprot_t prot, struct page **pages,
> +				    unsigned int page_shift)
> +{
> +	if (page_shift == PAGE_SIZE) {

... I think you meant 'page_shift == PAGE_SHIFT'

Overall I like this series, although it's a bit biased towards CPUs
which have page sizes which match PMD/PUD sizes.  It doesn't offer the
possibility of using 64kB page sizes on ARM, for example.  But it's a
step in the right direction.
