Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF46A3476
	for <lists+linux-arch@lfdr.de>; Sun, 26 Feb 2023 23:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBZWMp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Feb 2023 17:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBZWMo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Feb 2023 17:12:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC931041D
        for <linux-arch@vger.kernel.org>; Sun, 26 Feb 2023 14:12:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3BDEB80C94
        for <linux-arch@vger.kernel.org>; Sun, 26 Feb 2023 22:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B3C433EF;
        Sun, 26 Feb 2023 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677449559;
        bh=58rHNWziKG5F+1xvClRR26TGR/kzgtphh1+ss0F3o1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UiT+0xxuBn3xEDjfKMhE+S6nA/FuZ+LuP5xkiXmr+Z26p7zBTGouYiQnhVvpMNQe4
         72VgieV739lydXF/yzCq6+namJMMvgD8JJR9Z49ozGh6Bsy6ZoXgzNAL7cPtbQkAKe
         Yw2Hdqhy91RjOwm5mv0YwB7I/7qyguOod5YPTNVs=
Date:   Sun, 26 Feb 2023 14:12:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 5/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Message-Id: <20230226141238.6ec5fdf7d75dcf2cd4c58ba0@linux-foundation.org>
In-Reply-To: <20230203071837.1136453-6-npiggin@gmail.com>
References: <20230203071837.1136453-1-npiggin@gmail.com>
        <20230203071837.1136453-6-npiggin@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri,  3 Feb 2023 17:18:37 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> On a 16-socket 192-core POWER8 system, the context_switch1_threads
> benchmark from will-it-scale (see earlier changelog), upstream can
> achieve a rate of about 1 million context switches per second, due to
> contention on the mm refcount.
> 
> 64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enable
> the option. This increases the above benchmark to 118 million context
> switches per second.

Is that the best you can do ;)

> This generates 314 additional IPI interrupts on a 144 CPU system doing
> a kernel compile, which is in the noise in terms of kernel cycles.
> 
> ...
>
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -265,6 +265,7 @@ config PPC
>  	select MMU_GATHER_PAGE_SIZE
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select MMU_GATHER_MERGE_VMAS
> +	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64

Can we please have a summary of which other architectures might benefit
from this, and what must they do?

As this is powerpc-only, I expect it won't get a lot of testing in
mm.git or in linux-next.  The powerpc maintainers might choose to merge
in the mm-stable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm if this is a
concern.
