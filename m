Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5D4FF49B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiDMKWI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDMKWH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 06:22:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF520193;
        Wed, 13 Apr 2022 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OggZMh8O4zEKPckOudrhN3JRDyCy0vauypVuYeaqK4I=; b=nAlnW4dhQVSVbSYpf3hgwQhEK5
        75vK37thV31ok8rHuktYL+JVNnRqQMz3Fi79j1ADY5rGnqVIsohugwp9uQGsMMkbB/G3S7goS5FEQ
        SdMFZ6nNxnplWyHCYlAKATFdPVLo1yPwp6SUi9qIZcPm9L94NnlHHzaEwrXNu/wdCL4rGR1c4BEu2
        287QIHRZC3cL54yMgs3OCQgUrZNl8HlCP22xKK7H1xN44H7OsSTKlaL0kJLuQ8NZAdPKC6Jk8vvxW
        fAWQP213waD3wK8f1otrtZHbqjpJqo8B1StP92Ilw21Lt5SuuERplrRR3wafkGpKhpwFRXteP7/Kw
        rYZ/wALw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nea5x-004cZg-3Y; Wed, 13 Apr 2022 10:19:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8E5198623C; Wed, 13 Apr 2022 12:19:26 +0200 (CEST)
Date:   Wed, 13 Apr 2022 12:19:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     inux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tlb/hugetlb: Add framework to handle PGDIR_SIZE HugeTLB
 pages
Message-ID: <20220413101926.GX2731@worktop.programming.kicks-ass.net>
References: <20220413100714.509888-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413100714.509888-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 13, 2022 at 03:37:14PM +0530, Anshuman Khandual wrote:
> Change tlb_remove_huge_tlb_entry() to accommodate larger PGDIR_SIZE HugeTLB
> pages via adding a new helper tlb_flush_pgd_range(). While here also update
> struct mmu_gather as required, that is add a new member cleared_pgds.

I'm assuming Power will use this? Perhaps best to include it in a series
that actually makes use of it.

Other than that, looks good.
