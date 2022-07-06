Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C8568E1D
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiGFPui (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiGFPuX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 11:50:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB890222B8;
        Wed,  6 Jul 2022 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMPiGOu1gsOrP+OcjmrgLm7lfQsrjdxIxBZ6JkHGY4s=; b=Igpy4Ztjw6EHxP2kGcUQABTJik
        ouxzd2xaG1VFa/TwwQyX8nCf+NZbuPs26JHzK8ELixfm2UjEcG99xdhcY0ijhI1LtxN1TtWXXB1wL
        QBSZiM37PnQUgp8ys5M4sk1urMtXH3tFmEn9tXn80WEy5ywwwpHY/B24cPAjwB804VrzcVjUODNMU
        REYwWnm8SDyYQhQI+K8NRNdHOXn/LjDqfABaVA7ReWa7TfKrCSZdNUB/0bU3yR8JvVOT6qXB4SQlS
        6cZwAeAkpFg6LyYLh9cFFeOAo0nQow7O0grI47Vbdv0rczao6tql2aINzX6orwdtuyV46iQV7irPy
        1bIWikBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o97DI-001lBg-0s; Wed, 06 Jul 2022 15:45:16 +0000
Date:   Wed, 6 Jul 2022 16:45:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, kernel@xen0n.name,
        tsbogend@alpha.franken.de, dave.hansen@linux.intel.com,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arnd@arndb.de, guoren@kernel.org,
        monstr@monstr.eu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: Add kernel PTE level pagetable pages account
Message-ID: <YsWuC9+b3JaEAr0Q@casper.infradead.org>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 06, 2022 at 04:59:17PM +0800, Baolin Wang wrote:
> Now the kernel PTE level ptes are always protected by mm->page_table_lock
> instead of split pagetable lock, so the kernel PTE level pagetable pages
> are not accounted. Especially the vmalloc()/vmap() can consume lots of
> kernel pagetable, so to get an accurate pagetable accounting, calling new
> helpers page_{set,clear}_pgtable() when allocating or freeing a kernel
> PTE level pagetable page.
> 
> Meanwhile converting architectures to use corresponding generic PTE pagetable
> allocation and freeing functions.
> 
> Note this patch only adds accounting to the page tables allocated after boot.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>

What does this Reported-by: even mean?  the kernel test robot told you
that the page tables weren't being accounted?

I don't understand why we want to start accounting kernel page tables.
an we have a *discussion* about that with a sensible thread name instead
of just trying to sneak it in as patch 3/3?
