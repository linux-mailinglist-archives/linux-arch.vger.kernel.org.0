Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02B65D190
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 12:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjADLhh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 06:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjADLhf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 06:37:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4CE1B9ED;
        Wed,  4 Jan 2023 03:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3158CB81629;
        Wed,  4 Jan 2023 11:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AA1C433EF;
        Wed,  4 Jan 2023 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672832250;
        bh=ifZwfrhIkTGIQJEEvqcP0bIoc8pO2AK8DydzKJqXHo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSfA2ISPrHXkRmB4FnqNjYPJVLu7CqJqDLc+3I3BJ12HetiZraycDjom0q0Xt9szC
         INZUSjxQoYcW5KJDMVxE99EAy16q5fCyYjxxjv8Fq9ZGxbbTerfjOk7FLZ5txZDA/Z
         xeANQpk7lP+aC2Lw3KmrUChI9zyfSySS4Bh6ZPxT/QwiC+ZQDrV1+MjRnh21kZWogc
         n/tsMfEoKuqteOM3xQnZdhfcqrK3aU8+84xqomL1bPiZbmUW9sgSqf27CAToNns0u/
         bWmxyxX18ZK8u/yZVcuvTWCNGDmRKlSKH4IizVmUUJxUhbWWm5jQWpGM3CrsDddiif
         OMf1yBaQH/FTw==
Date:   Wed, 4 Jan 2023 13:37:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Marc =?iso-8859-1?Q?Poulhi=E8s?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 11/25] kvx: Add memory management
Message-ID: <Y7Vk6K5GS5yCkXOZ@kernel.org>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-12-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103164359.24347-12-ysionneau@kalray.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 05:43:45PM +0100, Yann Sionneau wrote:
> Add memory management support for kvx, including: cache and tlb
> management, page fault handling, ioremap/mmap and streaming dma support.
> 
> CC: Will Deacon <will@kernel.org>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Nick Piggin <npiggin@gmail.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-kernel@vger.kernel.org
> CC: linux-arch@vger.kernel.org
> CC: linux-mm@kvack.org
> CC: linux-riscv@lists.infradead.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Co-developed-by: Jean-Christophe Pince <jcpince@gmail.com>
> Signed-off-by: Jean-Christophe Pince <jcpince@gmail.com>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Julien Hascoet <jhascoet@kalray.eu>
> Signed-off-by: Julien Hascoet <jhascoet@kalray.eu>
> Co-developed-by: Louis Morhet <lmorhet@kalray.eu>
> Signed-off-by: Louis Morhet <lmorhet@kalray.eu>
> Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
> Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
> Co-developed-by: Marius Gligor <mgligor@kalray.eu>
> Signed-off-by: Marius Gligor <mgligor@kalray.eu>
> Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  arch/kvx/include/asm/cache.h         |  46 +++
>  arch/kvx/include/asm/cacheflush.h    | 181 +++++++++
>  arch/kvx/include/asm/fixmap.h        |  47 +++
>  arch/kvx/include/asm/hugetlb.h       |  36 ++
>  arch/kvx/include/asm/l2_cache.h      |  75 ++++
>  arch/kvx/include/asm/l2_cache_defs.h |  64 ++++
>  arch/kvx/include/asm/mem_map.h       |  44 +++
>  arch/kvx/include/asm/mmu.h           | 296 +++++++++++++++
>  arch/kvx/include/asm/mmu_context.h   | 156 ++++++++
>  arch/kvx/include/asm/mmu_stats.h     |  38 ++
>  arch/kvx/include/asm/page.h          | 187 ++++++++++
>  arch/kvx/include/asm/page_size.h     |  29 ++
>  arch/kvx/include/asm/pgalloc.h       | 101 +++++
>  arch/kvx/include/asm/pgtable-bits.h  | 102 ++++++
>  arch/kvx/include/asm/pgtable.h       | 451 +++++++++++++++++++++++
>  arch/kvx/include/asm/rm_fw.h         |  16 +
>  arch/kvx/include/asm/sparsemem.h     |  15 +
>  arch/kvx/include/asm/symbols.h       |  16 +
>  arch/kvx/include/asm/tlb.h           |  24 ++
>  arch/kvx/include/asm/tlb_defs.h      | 131 +++++++
>  arch/kvx/include/asm/tlbflush.h      |  58 +++
>  arch/kvx/include/asm/vmalloc.h       |  10 +
>  arch/kvx/mm/cacheflush.c             | 154 ++++++++
>  arch/kvx/mm/dma-mapping.c            |  95 +++++
>  arch/kvx/mm/extable.c                |  24 ++
>  arch/kvx/mm/fault.c                  | 264 ++++++++++++++
>  arch/kvx/mm/hugetlbpage.c            | 317 ++++++++++++++++
>  arch/kvx/mm/init.c                   | 527 +++++++++++++++++++++++++++
>  arch/kvx/mm/kernel_rwx.c             | 228 ++++++++++++
>  arch/kvx/mm/mmap.c                   |  31 ++
>  arch/kvx/mm/mmu.c                    | 204 +++++++++++
>  arch/kvx/mm/mmu_stats.c              |  94 +++++
>  arch/kvx/mm/tlb.c                    | 433 ++++++++++++++++++++++
>  33 files changed, 4494 insertions(+)

Please strip functionality that's not essential for boot and the re-add it
after the very core code is merged. I'd say multiple page size, hugetlb and
strict RWX are not necessary to start with.

I'd also suggest to have separate patches for different parts, like cache
and tlb management, page tables and page fault fault handling, ioremap/mmap
and streaming dma support.

-- 
Sincerely yours,
Mike.
