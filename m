Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2F6EA002
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 01:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjDTXdo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDTXdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 19:33:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0E7D92;
        Thu, 20 Apr 2023 16:33:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fb9b1a421so2190767b3.1;
        Thu, 20 Apr 2023 16:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033582; x=1684625582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2ixoAK9D3BuA0Ys9lwnMZMdyz2nW/UTyxM+6NXzqI=;
        b=AX4YGgPJjZWyR0kqu580/PVasSF+uNRiA7gr7gHqMdE/2vLkFpdjQpKmKbwxnvzy1W
         4jX/DWRv14Hh6L+AuqxNt9TrfsVNFOA+DMslH6msB9ssOPuKNdU5LH4UlZNRkrQgi/yF
         2C7UqT75y8+OehNqUJfsf2nClBSiv3rZRBTIf/8qXrl8xEYNdOg0mllWNN17Cw7o+BHc
         Dv7TVavT6/AGmzCH4d7Tksroa3F14WaPTNTcwjLqhrbimQGYJu8Di4n0FcYkgCSZZuxf
         BRI5CuXSQtBQDqv2Sdnh5lzey/n44xr+tGNe/P6HPq7sE+h81UtCj457v+cM+mPjpeEU
         pLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033582; x=1684625582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN2ixoAK9D3BuA0Ys9lwnMZMdyz2nW/UTyxM+6NXzqI=;
        b=OvvACIkTQL3V3IPNMoqSXIQtkpzPGin0L4TdxQ1N89DE8wHsDv3e/jzR8LV374nvgq
         Ocue5UN96GnODo/CIUEpxt+jDvaa3R56s5zFYPCM+IBRujtqlPpAbc2QBi+bCsIaO8ak
         ijMgNe40xtU2k9buOhnikzwfyCNHTJZMBzWes477KKpPUhAwIcfwwFk92c8V3nikTl9H
         VmHmWOmU73TZsOIpDUljeKs9NusprE4MTqDxpag2b7pXhNROn8nrfdV6WB+ZApx2pqHM
         6nU3jqMKduqEN7nf4Rzz0mb8Ja9XUkHofEfn6K7fQyTad7vLi73oKFnNX5601xvfueju
         ndcw==
X-Gm-Message-State: AAQBX9e7R6f7vX/vm/XdSkTHkbFM2C7+V4UXWhHf+70NGPt36DbKuYqD
        ugpJ9tduOWTU2wVmTlczoZhyTnRkEobtVvpPr7ILlrMTK1E=
X-Google-Smtp-Source: AKy350bopqnJQtT+418DUBi5UUf4Yx/MaaBIpccKeoXBRimnuUzPebu61FMjyfXCRvipIUnUp3uBwA4Azmrc32p/hx0=
X-Received: by 2002:a0d:f205:0:b0:541:8810:8d7b with SMTP id
 b5-20020a0df205000000b0054188108d7bmr466003ywf.15.1682033581993; Thu, 20 Apr
 2023 16:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com> <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
 <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com> <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
In-Reply-To: <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 20 Apr 2023 16:32:50 -0700
Message-ID: <CAOzc2pwDtn836Tf0Egh+Z258hxSTVtvwuyU2qiJa1iLa6vZFjQ@mail.gmail.com>
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 19, 2023 at 12:54=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.04.23 23:33, Vishal Moola wrote:
> > On Tue, Apr 18, 2023 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
> >>> s390 uses page->index to keep track of page tables for the guest addr=
ess
> >>> space. In an attempt to consolidate the usage of page fields in s390,
> >>> replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
> >>>
> >>> This will help with the splitting of struct ptdesc from struct page, =
as
> >>> well as allow s390 to use _pt_frag_refcount for fragmented page table
> >>> tracking.
> >>>
> >>> Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NU=
LL
> >>> before freeing the pages as well.
> >>>
> >>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >>> index 3fc9e680f174..2616d64c0e8c 100644
> >>> --- a/include/linux/mm_types.h
> >>> +++ b/include/linux/mm_types.h
> >>> @@ -144,7 +144,7 @@ struct page {
> >>>                struct {        /* Page table pages */
> >>>                        unsigned long _pt_pad_1;        /* compound_he=
ad */
> >>>                        pgtable_t pmd_huge_pte; /* protected by page->=
ptl */
> >>> -                     unsigned long _pt_pad_2;        /* mapping */
> >>> +                     unsigned long _pt_s390_gaddr;   /* mapping */
> >>>                        union {
> >>>                                struct mm_struct *pt_mm; /* x86 pgds o=
nly */
> >>>                                atomic_t pt_frag_refcount; /* powerpc =
*/
> >>
> >> The confusing part is, that these gmap page tables are not ordinary
> >> process page tables that we would ordinarily place into this section
> >> here. That's why they are also not allocated/freed using the typical
> >> page table constructor/destructor ...
> >
> > I initially thought the same, so I was quite confused when I saw
> > __gmap_segment_gaddr was using pmd_pgtable_page().
> >
> > Although they are not ordinary process page tables, since we
> > eventually want to move them out of struct page, I think shifting them
> > to be in ptdescs, being a memory descriptor for page tables, makes
> > the most sense.
>
> Seeing utilities like tlb_remove_page_ptdesc() that don't really apply
> to such page tables, I wonder if we should much rather treat such
> shadow/auxiliary/... page tables (just like other architectures like
> x86, arm, ... employ as well) as a distinct type.
>
> And have ptdesc be the common type for all process page tables.

Although I do like the idea of having a distinct type for them, I'm not sur=
e
I see the merits of having another type specifically for those types of
page tables.

As it currently is, tlb_remove_table() is only distinct from tlb_remove_pag=
e()
when an architecture defines its own removal function. I'm not too familiar
with most of their differences, but we can probably continue to let them do
that. As of now, I'm not too sure what a distinct type would look like that
could meet all their needs holistically.

> >
> > Another option is to leave pmd_pgtable_page() as is just for this case.
> > Or we can revert commit 7e25de77bc5ea which uses the function here
> > then figure out where these gmap pages table pages will go later.
>
> I'm always confused when reading gmap code, so let me have another look :=
)
>
> The confusing part is that s390x shares the lowest level page tables
> (PTE tables) between the process and gmap ("guest mapping", similar to
> EPT on x86-64). It maps these process PTE tables (covering 1 MiB) into
> gmap-specific PMD tables.

Especially in cases like this. If the architecture wants to share page tabl=
es
then everything being in form ptdesc would make that easiest, and
continue to let them define their own niche functions for their needs.

> pmd_pgtable_page() should indeed always give us a gmap-specific
> PMD-table. In fact, something allocated via gmap_alloc_table().
>
> Decoupling both concepts sounds like a good idea.

Yeah, I'm not a fan of how this gmap caller is the only external caller
using this to get a page for their own purposes. I'll update that in v2.
