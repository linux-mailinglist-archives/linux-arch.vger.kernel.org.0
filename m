Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0D4D055B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbiCGRi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 12:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbiCGRiZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 12:38:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E62DE9;
        Mon,  7 Mar 2022 09:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57D4EB8166B;
        Mon,  7 Mar 2022 17:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10B1C340EF;
        Mon,  7 Mar 2022 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646674646;
        bh=yW1LLFgt1eD8m0p0l5v2PYdxc1QHIWZY2uI4QX2lZU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MraUV01e2qxAhLJGToTlICAopVwdZ+PiTKGmH59R4ROB4tnETEd/CwhqQZskHAi8r
         p+G0Re70/df9+yEbNe0XzS5yHU5TGE9WB/M7rMEzRC4PCXGEmpjcNp5no67/yedFJF
         O7dy97RC/5m79C7AHvLF0+lGq5NQsjdHFdi3l9rY/ozOcSYbstFbjfCFhoB/X1w9+w
         J/8+We9fthy8+YIKCWrhSLPwiSWhtNei2/7G7IA7OKWwaJ2AKkArlYjlDeGIciI20r
         O/XQhOj6hWoMm5XRiftlhDx/tQ0q3oyEORS9YjBsWWc/LT/HN26Nz2+ta2cn9SBPUE
         QmC3sTSxk8eFA==
Date:   Mon, 7 Mar 2022 19:37:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
Message-ID: <YiZCypeuJ+0FCJ+w@kernel.org>
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn>
 <YiCpYRwoUSmd/GE3@kernel.org>
 <CAAhV-H4-zVjjUkoVFw4ppg_tsM-wxBZmPr-2q8zuoLDHTWAE0w@mail.gmail.com>
 <YiHuuyqW8KSAri/M@kernel.org>
 <CAAhV-H6z3H3QbzvG6=fgVJF1z2qEvKVGnyqb--bkqomH3jTXJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6z3H3QbzvG6=fgVJF1z2qEvKVGnyqb--bkqomH3jTXJQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Fri, Mar 04, 2022 at 08:43:03PM +0800, Huacai Chen wrote:
> Hi, Mike,
> 
> On Fri, Mar 4, 2022 at 6:49 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi,
> >
> >
> > So ideally, the physical memory detection and registration should follow
> > something like:
> >
> > * memblock_reserve() the memory used by firmware, kernel and initrd
> > * detect NUMA topology
> > * add memory regions along with their node ids to memblock.
> >
> > s390::setup_arch() is a good example of doing early reservations:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/setup.c#n988
> I have a fast reading of S390, and I think we can do some adjust:
> 1, call memblock_set_node(0, ULONG_MAX, &memblock.memory, 0) in
> early_memblock_init().
> 2, move memblock_reserve(PHYS_OFFSET, 0x200000) and
> memblock_reserve(__pa_symbol(&_text), __pa_symbol(&_end) -
> __pa_symbol(&_text)) to early_memblock_init().
> 3, Reserve initrd memory in the first place.
> It is nearly the same as the S390, then.

It does not have to look like the same as s390 :)
The important thing is to reserve all the memory before memblock
allocations are possible. 

> > > > > +early_param("memmap", early_parse_memmap);
> > > >
> > > > The memmap= processing is a hack indented to workaround bugs in firmware
> > > > related to the memory detection. Please don't copy if over unless there is
> > > > really strong reason.
> > >
> > > Hmmm, I have read the documents, most archs only support mem=limit,
> > > but MIPS support mem=limit@base. memmap not only supports
> > > memmap=limit@base, but also a lot of advanced syntax. LoongArch needs
> > > both limit and limit@base syntax. So can we make our code to support
> > > only mem=limit and memmap=limit@base, and remove all other syntax
> > > here?
> >
> > The documentation describes what was there historically and both these
> > options tend not to play well with complex memory layouts.
> >
> > If you must have them it's better to use x86 as an example rather than
> > MIPS, just take into the account that on x86 memory always starts from 0,
> > so they never needed to have a different base.
> >
> > For what use-cases LoongArch needs options?
>
> The use-case of limit@base syntax is kdump, because our kernel is not
> relocatable. I'll use X86 as an example.

I missed that mem= can be used several times, so with MIPS implementation
it's possible to define something like "mem=limit0@base0 mem=limit1@base1"
and this will create two contiguous memory regions.
 
> Huacai

-- 
Sincerely yours,
Mike.
