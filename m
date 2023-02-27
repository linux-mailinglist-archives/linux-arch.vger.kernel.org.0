Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5576A42C3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjB0Nd7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 08:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjB0Ndh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 08:33:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079B95
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2023 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lYtdb3OvoePD9FKa/wblmpog8oSZWnWeDVgUCfTs9As=; b=I0RZYM2uTHooxcHaCkgIjRt6S4
        Q+Cio3xlxnE2D8zBu9EwrwmOHggoJ4gPAUNYZLjzw6o6dohV+xL162RX8FtA3I/WRk1wFdNPEm/yr
        yrKFjbWHC1ZMcqj/0irRPq39VpTS5bCGOh+VFsbhmQUAls+W6xDUTrdPqBkP6MdJ6Rvt2Hjd19xYC
        9leBtPob2IRbId2+FqrKY9fTkZ6D+RbZusAK7d7eGmHpRP7Hxvnw1VZqOvC4MIc5pzaGzxjDYi/yr
        tlalojHEEtgTFimWnPIYIitNI7zGfGggSUik5O456sxE5vEq3hLP19ZxR53wd51AF/rpo5SH2HOqY
        3ZlKpOkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWdcq-00EEZC-0g;
        Mon, 27 Feb 2023 13:33:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9E8300293;
        Mon, 27 Feb 2023 14:33:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2942823B24806; Mon, 27 Feb 2023 14:33:06 +0100 (CET)
Date:   Mon, 27 Feb 2023 14:33:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 5/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Message-ID: <Y/yxEnCcPmUk89Jp@hirez.programming.kicks-ass.net>
References: <20230203071837.1136453-1-npiggin@gmail.com>
 <20230203071837.1136453-6-npiggin@gmail.com>
 <20230226141238.6ec5fdf7d75dcf2cd4c58ba0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226141238.6ec5fdf7d75dcf2cd4c58ba0@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 26, 2023 at 02:12:38PM -0800, Andrew Morton wrote:
> On Fri,  3 Feb 2023 17:18:37 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > On a 16-socket 192-core POWER8 system, the context_switch1_threads
> > benchmark from will-it-scale (see earlier changelog), upstream can
> > achieve a rate of about 1 million context switches per second, due to
> > contention on the mm refcount.
> > 
> > 64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so enable
> > the option. This increases the above benchmark to 118 million context
> > switches per second.
> 
> Is that the best you can do ;)
> 
> > This generates 314 additional IPI interrupts on a 144 CPU system doing
> > a kernel compile, which is in the noise in terms of kernel cycles.
> > 
> > ...
> >
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -265,6 +265,7 @@ config PPC
> >  	select MMU_GATHER_PAGE_SIZE
> >  	select MMU_GATHER_RCU_TABLE_FREE
> >  	select MMU_GATHER_MERGE_VMAS
> > +	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
> >  	select MODULES_USE_ELF_RELA
> >  	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
> >  	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
> 
> Can we please have a summary of which other architectures might benefit
> from this, and what must they do?
> 
> As this is powerpc-only, I expect it won't get a lot of testing in
> mm.git or in linux-next.  The powerpc maintainers might choose to merge
> in the mm-stable branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm if this is a
> concern.

I haven't really had time to page all of this back in, but x86 is very
close to be able to use this, it mostly just needs cleaning up some
accidental active_mm usage.

I've got a branch here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy

That's mostly Nick's patches with a bunch of Andy's old patches stuck on
top. I also have a pile of notes, but alas, not finished in any way.
