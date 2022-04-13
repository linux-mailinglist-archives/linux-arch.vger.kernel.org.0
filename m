Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5049B4FFB4D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiDMQcf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiDMQcb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 12:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529941624;
        Wed, 13 Apr 2022 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5bxNeFCNqtSiVLbQzdDfEBDhH6rbLnTelph4miGTqcI=; b=ZDD2+/SPzOdS7gIGaIEN0WYdw2
        csM5cEpfpVa4zPMV6qQMG16FX8GAc8H1eGmVn0mAyKrCmXot6li/ApLCBGfTBvms7T8/IlTqWq2rd
        cX+7Jh1S0o7VKL2iQxM+0BNlZHKrUACHDPR7gs2zVuDVpyoevItTU8TJemXQCr41HAh1Hpim+LNfs
        yY8nXcbyB2ub4RiGkg1g+qHiyg/tnrreZACe8kSk14FDiMf4TUFKJaafxLONmflJFnNsSOAxNDaBV
        JGQCMma/H2xQN3MxEre5D8cDJ5NZrCjJMYzaLHVaYF6Mwj1pYuFfulzY3NdBoTnz/PSqQXCy5o/PP
        jjAo4hOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nefsQ-00EOn1-Uf; Wed, 13 Apr 2022 16:29:55 +0000
Date:   Wed, 13 Apr 2022 17:29:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     inux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tlb/hugetlb: Add framework to handle PGDIR_SIZE HugeTLB
 pages
Message-ID: <Ylb6gvRJ27BCPv1z@casper.infradead.org>
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

Is this just completionist junk, or are there really CPUs that support
PGDIR sized pages?  We already have support for p4d (512GB), even though
at least Intel don't support pages larger than 1GB.  I think the largest
size page I've heard of is 16GB on POWER.  PGDIR_SIZE would be 256TB on
x86 which just seems ludicrous to be talking about supporting.

> ---
> This applies on v5.18-rc2, some earlier context could be found here
> 
> https://lore.kernel.org/all/20220406112124.GD2731@worktop.programming.kicks-ass.net/

Read it, doesn't talk about any real users of this.
