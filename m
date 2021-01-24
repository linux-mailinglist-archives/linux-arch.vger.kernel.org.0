Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1E301B64
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhAXLdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 06:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXLdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 06:33:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67FC061573;
        Sun, 24 Jan 2021 03:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mqa32asZZp18V8r6vs5C2A7h2wwBEtaIVqomz3yUGRQ=; b=qk0PisdW5PxD45qYqKoEnTKmPp
        WGAn2tGrYEtYqZX8q3ah10/j0LWTe7sSPmfEdXvB3YKoYQ0vxAe7okj1TOJRunIoR+6fUu2WF28MC
        0bL9lqlRSvq0StcMloP9NdW/uEOT3Jp0xT9dKU7nQucG42BYoSJz9VhYEZFwmZ3aTNPMBkr2yrd0A
        qxU9gyj6ymumpsfwl4hKJeqOR7IYpzWiqfTGj1GL/PMQyhGKgdRMscNKersh3RXZa4v4Dtuh1ZuDJ
        Jegr4m4bq4urBmJht4IP+XpPMAVwgO8whUdwl8n3wRPWOoBQGcjdJET4eWP/p4IHpsuXCBst5RQLm
        nWNb4tCA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3dcN-002udt-CX; Sun, 24 Jan 2021 11:31:46 +0000
Date:   Sun, 24 Jan 2021 11:31:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v10 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Message-ID: <20210124113143.GA694255@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-2-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 24, 2021 at 06:22:19PM +1000, Nicholas Piggin wrote:
> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
> 
> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.

Maybe enable instead of fix would be better in the subject line?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
