Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906D57D8A2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGVCbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 22:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVCbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 22:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74665B781;
        Thu, 21 Jul 2022 19:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E5D61CBF;
        Fri, 22 Jul 2022 02:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB279C341CB;
        Fri, 22 Jul 2022 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658457095;
        bh=Bv0Z0FICQOdzzZtOmPdN9kewP9G1tSHtsQYkNggSg78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MMvbxJwtjZ9V+sqiaRsQuUKY/ISMau4BT48l/9uFI4RlTtKRbDfwGoEnGIDec2oFF
         QsvMHrsn7rD4hbliYT6LlYrb8w6oakHAbPl5X+JqsHSNdtYKtSuJQEQT+aNZiT2WA6
         Q4lsCypsfsTaYZxVNkUgfl4JcDSYJ2T9VWtEC3wiW2mGBdmxtj+2LBNY+3kMVRKPN7
         nrzSuDHTSJfSkuwhmJqfW8U1t+frEn4lxOzYahDZ196iq0ZNC3fZnOZOdu+anLCUrD
         iOdIx8BFSISFoFMOvzGSfJUcJpsegVbMhK7UsbeTr5RNZKxV+iz8KP1FWqfqTJoV3f
         HRbcQM6atx0hQ==
Received: by mail-vk1-f176.google.com with SMTP id t23so1535122vkm.7;
        Thu, 21 Jul 2022 19:31:35 -0700 (PDT)
X-Gm-Message-State: AJIora9QSjYmdVbqnq1gmXXBcwjUVaqpp6KFL0l3+VwjC2JHvrNkxMto
        bZVUwtsxMp1wpfIkK80cXeDiyvDpGevbFV4EplM=
X-Google-Smtp-Source: AGRyM1tdBR05heJlN2wID/U6oZAUcOW0xT5eOmboleIrnkZv/wMyjrGAPxc0swFv2LQB8zOUvp7dMgST5m1wpZ0A9hQ=
X-Received: by 2002:a1f:9b90:0:b0:374:f09c:876f with SMTP id
 d138-20020a1f9b90000000b00374f09c876fmr481937vke.12.1658457094710; Thu, 21
 Jul 2022 19:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-4-chenhuacai@loongson.cn>
 <20220705092937.GA552@willie-the-truck> <CAAhV-H5r8HDaxt8fkO97in5-eH8X9gokVNervmUWn6km4S0e-w@mail.gmail.com>
 <20220706161736.GC3204@willie-the-truck> <CAAhV-H7uY_KiLJRRjj4+8mewcWbuhvC=zDp5VAs03=BLdSMKLw@mail.gmail.com>
 <CAAhV-H6EziBQ=3SveRvaPxHfbsGpmYrhVHfuBkpLJXn-t-uTZA@mail.gmail.com>
 <4216f48f-fdf1-ec1e-b963-6f7fe6ba0f63@redhat.com> <CAAhV-H5chctqBLayAJZOker_Li1db2NTcT9qwMCUYK44tBHVSg@mail.gmail.com>
 <20220721095527.GB17088@willie-the-truck> <CAAhV-H5LednXDPzPm80f9N-MfcT1B+SThO+ngNHS1365dGxk4A@mail.gmail.com>
 <62d9cb2579602_1f553629442@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d9cb2579602_1f553629442@dwillia2-xfh.jf.intel.com.notmuch>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 22 Jul 2022 10:31:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76oGJ_o4Ek0F95zgDLe=uL1=s4Zf0r9utv8bsm2pymOA@mail.gmail.com>
Message-ID: <CAAhV-H76oGJ_o4Ek0F95zgDLe=uL1=s4Zf0r9utv8bsm2pymOA@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Dan,

On Fri, Jul 22, 2022 at 5:54 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Huacai Chen wrote:
> > Hi, Will,
> >
> > On Thu, Jul 21, 2022 at 5:55 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Jul 21, 2022 at 10:08:10AM +0800, Huacai Chen wrote:
> > > > On Wed, Jul 20, 2022 at 5:34 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > On 14.07.22 14:34, Huacai Chen wrote:
> > > > > > On Fri, Jul 8, 2022 at 5:47 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >> On Thu, Jul 7, 2022 at 12:17 AM Will Deacon <will@kernel.org> wrote:
> > > > > >>> On Tue, Jul 05, 2022 at 09:07:59PM +0800, Huacai Chen wrote:
> > > > > >>>> On Tue, Jul 5, 2022 at 5:29 PM Will Deacon <will@kernel.org> wrote:
> > > > > >>>>> On Mon, Jul 04, 2022 at 07:25:25PM +0800, Huacai Chen wrote:
> > > > > >>>>>> +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > > > > >>>>>> +                                      int node, struct vmem_altmap *altmap)
> > > > > >>>>>> +{
> > > > > >>>>>> +     unsigned long addr;
> > > > > >>>>>> +     unsigned long next;
> > > > > >>>>>> +     pgd_t *pgd;
> > > > > >>>>>> +     p4d_t *p4d;
> > > > > >>>>>> +     pud_t *pud;
> > > > > >>>>>> +     pmd_t *pmd;
> > > > > >>>>>> +
> > > > > >>>>>> +     for (addr = start; addr < end; addr = next) {
> > > > > >>>>>> +             next = pmd_addr_end(addr, end);
> > > > > >>>>>> +
> > > > > >>>>>> +             pgd = vmemmap_pgd_populate(addr, node);
> > > > > >>>>>> +             if (!pgd)
> > > > > >>>>>> +                     return -ENOMEM;
> > > > > >>>>>> +
> > > > > >>>>>> +             p4d = vmemmap_p4d_populate(pgd, addr, node);
> > > > > >>>>>> +             if (!p4d)
> > > > > >>>>>> +                     return -ENOMEM;
> > > > > >>>>>> +
> > > > > >>>>>> +             pud = vmemmap_pud_populate(p4d, addr, node);
> > > > > >>>>>> +             if (!pud)
> > > > > >>>>>> +                     return -ENOMEM;
> > > > > >>>>>> +
> > > > > >>>>>> +             pmd = pmd_offset(pud, addr);
> > > > > >>>>>> +             if (pmd_none(READ_ONCE(*pmd))) {
> > > > > >>>>>> +                     void *p;
> > > > > >>>>>> +
> > > > > >>>>>> +                     p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> > > > > >>>>>> +                     if (p) {
> > > > > >>>>>> +                             vmemmap_set_pmd(pmd, p, node, addr, next);
> > > > > >>>>>> +                             continue;
> > > > > >>>>>> +                     } else if (altmap)
> > > > > >>>>>> +                             return -ENOMEM; /* no fallback */
> > > > > >>>>>
> > > > > >>>>> Why do you return -ENOMEM if 'altmap' here? That seems to be different to
> > > > > >>>>> what we currently have on arm64 and it's not clear to me why we're happy
> > > > > >>>>> with an altmap for the pmd case, but not for the pte case.
> > > > > >>>> The generic version is the same as X86. It seems that ARM64 always
> > > > > >>>> fallback whether there is an altmap, but X86 only fallback in the no
> > > > > >>>> altmap case. I don't know the reason of X86, can Dan Williams give
> > > > > >>>> some explaination?
> > > > > >>>
> > > > > >>> Right, I think we need to understand the new behaviour here before we adopt
> > > > > >>> it on arm64.
> > > > > >> Hi, Dan,
> > > > > >> Could you please tell us the reason? Thanks.
> > > > > >>
> > > > > >> And Sudarshan,
> > > > > >> You are the author of adding a fallback mechanism to ARM64,  do you
> > > > > >> know why ARM64 is different from X86 (only fallback in no altmap
> > > > > >> case)?
> > > > >
> > > > > I think that's a purely theoretical issue: I assume that in any case we
> > > > > care about, the altmap should be reasonably sized and aligned such that
> > > > > this will always succeed.
> > > > >
> > > > > To me it even sounds like the best idea to *consistently* fail if there
> > > > > is no more space in the altmap, even if we'd have to fallback to PTE
> > > > > (again, highly unlikely that this is relevant in practice). Could
> > > > > indicate an altmap-size configuration issue.
> > > >
> > > > Does David's explanation make things clear? Moreover, I think Dan's
> > > > dedicated comments "no fallback" implies that his design is carefully
> > > > considered. So I think the generic version using the X86 logic is just
> > > > OK.
> > >
> > > I think the comment isn't worth the metaphorical paper that it's written
> > > on! If you can bulk it up a bit based on David's reasoning, then that would
> > > help. But yes, I'm happy with the code now, thanks both.
> > OK, I will add a detailed comment here.
>
> Apologies for coming late to the party here, original ping came while I
> was on vacation and I only just now noticed the direct questions. All
> resolved now or is a question still pending?
I updated the patch and added a detailed comment based on David's
explanation [1]. If that description is correct, I think there are no
more questions. Thank you.
[1] https://lore.kernel.org/loongarch/20220721130419.1904711-4-chenhuacai@loongson.cn/T/#u

Huacai
>
