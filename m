Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EA57C838
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGUJzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGUJzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 05:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558A2CC9B;
        Thu, 21 Jul 2022 02:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AD2161F82;
        Thu, 21 Jul 2022 09:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF00C3411E;
        Thu, 21 Jul 2022 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658397336;
        bh=OXWed5vpkzsz0jYpBxkXQrbeEPRaqZHtgrQjnkoQfp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NC8h0OOaZSdyUOlE3739Y6vphXUDOgoHE3XwrBc918ss0UlL9dXGVHA25hGA+YvJe
         XDyM1G5B4/gIgjuL9yHAfq50wfWyrsue7EAa4hzVgkc8J49XYm4oZsTRCnT/Iup/bb
         6qswWRDqunoZYVGbDCv5P2i0fsHAStNaFkeDGzL54j8uFSnLgic3tnDtT9Vpgn7hkJ
         oYBzPUqjW3zMG1+9f+PZKQOVaD8m8uLO8Ni0YWpdWYY5mPbAr9nhVAAG1HiGqHeUK3
         zheBGryvqfamq9a5biiKz1jcuE5YG4pdpY0sgA+a6dU49ZxY8WaZjt7JtIsO1uoUZD
         xtdX/Hb/ah02w==
Date:   Thu, 21 Jul 2022 10:55:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: Re: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Message-ID: <20220721095527.GB17088@willie-the-truck>
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-4-chenhuacai@loongson.cn>
 <20220705092937.GA552@willie-the-truck>
 <CAAhV-H5r8HDaxt8fkO97in5-eH8X9gokVNervmUWn6km4S0e-w@mail.gmail.com>
 <20220706161736.GC3204@willie-the-truck>
 <CAAhV-H7uY_KiLJRRjj4+8mewcWbuhvC=zDp5VAs03=BLdSMKLw@mail.gmail.com>
 <CAAhV-H6EziBQ=3SveRvaPxHfbsGpmYrhVHfuBkpLJXn-t-uTZA@mail.gmail.com>
 <4216f48f-fdf1-ec1e-b963-6f7fe6ba0f63@redhat.com>
 <CAAhV-H5chctqBLayAJZOker_Li1db2NTcT9qwMCUYK44tBHVSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5chctqBLayAJZOker_Li1db2NTcT9qwMCUYK44tBHVSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 10:08:10AM +0800, Huacai Chen wrote:
> On Wed, Jul 20, 2022 at 5:34 PM David Hildenbrand <david@redhat.com> wrote:
> > On 14.07.22 14:34, Huacai Chen wrote:
> > > On Fri, Jul 8, 2022 at 5:47 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >> On Thu, Jul 7, 2022 at 12:17 AM Will Deacon <will@kernel.org> wrote:
> > >>> On Tue, Jul 05, 2022 at 09:07:59PM +0800, Huacai Chen wrote:
> > >>>> On Tue, Jul 5, 2022 at 5:29 PM Will Deacon <will@kernel.org> wrote:
> > >>>>> On Mon, Jul 04, 2022 at 07:25:25PM +0800, Huacai Chen wrote:
> > >>>>>> +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > >>>>>> +                                      int node, struct vmem_altmap *altmap)
> > >>>>>> +{
> > >>>>>> +     unsigned long addr;
> > >>>>>> +     unsigned long next;
> > >>>>>> +     pgd_t *pgd;
> > >>>>>> +     p4d_t *p4d;
> > >>>>>> +     pud_t *pud;
> > >>>>>> +     pmd_t *pmd;
> > >>>>>> +
> > >>>>>> +     for (addr = start; addr < end; addr = next) {
> > >>>>>> +             next = pmd_addr_end(addr, end);
> > >>>>>> +
> > >>>>>> +             pgd = vmemmap_pgd_populate(addr, node);
> > >>>>>> +             if (!pgd)
> > >>>>>> +                     return -ENOMEM;
> > >>>>>> +
> > >>>>>> +             p4d = vmemmap_p4d_populate(pgd, addr, node);
> > >>>>>> +             if (!p4d)
> > >>>>>> +                     return -ENOMEM;
> > >>>>>> +
> > >>>>>> +             pud = vmemmap_pud_populate(p4d, addr, node);
> > >>>>>> +             if (!pud)
> > >>>>>> +                     return -ENOMEM;
> > >>>>>> +
> > >>>>>> +             pmd = pmd_offset(pud, addr);
> > >>>>>> +             if (pmd_none(READ_ONCE(*pmd))) {
> > >>>>>> +                     void *p;
> > >>>>>> +
> > >>>>>> +                     p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> > >>>>>> +                     if (p) {
> > >>>>>> +                             vmemmap_set_pmd(pmd, p, node, addr, next);
> > >>>>>> +                             continue;
> > >>>>>> +                     } else if (altmap)
> > >>>>>> +                             return -ENOMEM; /* no fallback */
> > >>>>>
> > >>>>> Why do you return -ENOMEM if 'altmap' here? That seems to be different to
> > >>>>> what we currently have on arm64 and it's not clear to me why we're happy
> > >>>>> with an altmap for the pmd case, but not for the pte case.
> > >>>> The generic version is the same as X86. It seems that ARM64 always
> > >>>> fallback whether there is an altmap, but X86 only fallback in the no
> > >>>> altmap case. I don't know the reason of X86, can Dan Williams give
> > >>>> some explaination?
> > >>>
> > >>> Right, I think we need to understand the new behaviour here before we adopt
> > >>> it on arm64.
> > >> Hi, Dan,
> > >> Could you please tell us the reason? Thanks.
> > >>
> > >> And Sudarshan,
> > >> You are the author of adding a fallback mechanism to ARM64,  do you
> > >> know why ARM64 is different from X86 (only fallback in no altmap
> > >> case)?
> >
> > I think that's a purely theoretical issue: I assume that in any case we
> > care about, the altmap should be reasonably sized and aligned such that
> > this will always succeed.
> >
> > To me it even sounds like the best idea to *consistently* fail if there
> > is no more space in the altmap, even if we'd have to fallback to PTE
> > (again, highly unlikely that this is relevant in practice). Could
> > indicate an altmap-size configuration issue.
> 
> Does David's explanation make things clear? Moreover, I think Dan's
> dedicated comments "no fallback" implies that his design is carefully
> considered. So I think the generic version using the X86 logic is just
> OK.

I think the comment isn't worth the metaphorical paper that it's written
on! If you can bulk it up a bit based on David's reasoning, then that would
help. But yes, I'm happy with the code now, thanks both.

Will
