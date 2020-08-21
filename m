Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E609824CD59
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgHUFqF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUFqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 01:46:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04CC061385;
        Thu, 20 Aug 2020 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ajUzawCVIQRA44N5aFKVmBYYI1IH9hA0rQus2v7jm1M=; b=TfwEFqBs960BsRA5hvI0O4oCNZ
        dAoIyHAY/Igg+63+8szSobAbssRbiHC5YFIKCWsegv9dVWY0K7Ydgdl96G7DyhjmIOpdziAZXt24P
        SnP4MEK+sNxXbJYhwZ2hTH6ke8Gl+rN5IPxwEmQrm+Yp0GumVOGwNCs+mXaf3k5y2w34NH2v1TEzj
        7j9P578Yh55WK6ukWn0T81tLv8mXcQ8NzPmDTnkhZDHqPKrtzOjoLztcIUWOhS84Vd3NTta36LHsI
        SbgVtdCEdAbFD5jtjm73/9nHsffP1rZLt7uTaHKbupFRxrzmNmsvjCPbAIGn5hdxXBRH9307b0p4N
        1oJ58huA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8zsI-0007XR-9F; Fri, 21 Aug 2020 05:46:02 +0000
Date:   Fri, 21 Aug 2020 06:46:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 5/8] mm: HUGE_VMAP arch support cleanup
Message-ID: <20200821054602.GC28291@infradead.org>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-6-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>  static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
>  {

... and here.
