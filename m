Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534B4737589
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFTUBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTUBw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 16:01:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28F1726;
        Tue, 20 Jun 2023 13:01:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b5853a140cso1903733a34.2;
        Tue, 20 Jun 2023 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291309; x=1689883309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4F3qXm8x1AVi+0TrKGx40m/sFxYrt6Lj9IeE/BrpeU=;
        b=g8Wha6YZBIQ4F35wQ8P6Y0c98+3LfOEjAen8YviDIN/VpMlvLwu/TwEQtEhwi2wLbk
         4/b97qENpIhbKycIE1G3aUVCeb+vz/rCN/gI0l10ch7iG8C6c3ywB5bQ5tQe6ryGYXul
         5XkEWnvnLWIaJ1vsJQRh6tPgKWpuL7AyPHBFZQZGhCATWoDKR1D2YRUNFvvEx6dCnM6X
         zMyQcs2OOhmWkXYBbd2Z3eHBKxjZIMZIeFLBGw0YYdvfY15fMS5Ra2rC/awJj+k/fir6
         OMXeho7/p64d1/Gcc6dtEtZlx65PVhnR78rxvmM8tH1fn8015FZgY0Ml6WWkfDm6BXzA
         dR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291309; x=1689883309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4F3qXm8x1AVi+0TrKGx40m/sFxYrt6Lj9IeE/BrpeU=;
        b=JQLKRzwQ7nZhKyR6Ozm4YrJP4sRWt23EaikeHuf4S1Z0Op843eoHbLLGN8Wna9YdTh
         1lrwwOypHlcPXDzhFblTdVU9ddkbvjV4S5qYufCOlbwZIdTA6v5sbENpdmP8fJ7i1PIu
         BTFcMdi/5piXgvOaDNlIaVdMZaE5mMJB4Wp0IpGU/LAxHPWhgFCKAQ8GGnQQsv67B6uI
         5xxxvSQzoFEF24E2HX4BxivM2wuNl+z1wvsSpwxlLmEZuguGrLrZFIzpzTicdvDFvj5A
         tNT8Rea/ULBdqckZ6kL/0rkCSo7e3bESeM21f4gbxdFzC1J1Gu/R3XAN5hJ+fz8qmCCy
         h8pg==
X-Gm-Message-State: AC+VfDxMXl+I7JyUgVRyXYGYsnxIeO9OUuQAsPZTPW5Fi0Fkb5jvVdlt
        Y24iengrTZF5lNy88ri4sXDe9KcJir/Sg78vvxEpwokn
X-Google-Smtp-Source: ACHHUZ4Hj3uSYs4sk8lvmBdlBVPXrs6qDttIob0+AqgPuiIWdgPfm9A1hihEUgTK87y6a2gHhIBkt791vtKGzbzprm8=
X-Received: by 2002:a05:6358:f0e:b0:12b:ed05:18bb with SMTP id
 b14-20020a0563580f0e00b0012bed0518bbmr8612256rwj.27.1687291309110; Tue, 20
 Jun 2023 13:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <ZIxXw9ERkYv+ipdd@nvidia.com>
In-Reply-To: <ZIxXw9ERkYv+ipdd@nvidia.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 20 Jun 2023 13:01:39 -0700
Message-ID: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 16, 2023 at 5:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote:
> > Currently, page table information is stored within struct page. As part
> > of simplifying struct page, create struct ptdesc for page table
> > information.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index c5a51481bbb9..330de96ebfd6 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struct =
vm_area_struct *vma,
> >  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> >  #endif /* CONFIG_MMU */
> >
> > +
> > +/**
> > + * struct ptdesc - Memory descriptor for page tables.
> > + * @__page_flags: Same as page flags. Unused for page tables.
> > + * @pt_list: List of used page tables. Used for s390 and x86.
> > + * @_pt_pad_1: Padding that aliases with page's compound head.
> > + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> > + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap on=
ly.
> > + * @pt_mm: Used for x86 pgds.
> > + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and =
s390 only.
> > + * @ptl: Lock for the page table.
> > + *
> > + * This struct overlays struct page for now. Do not modify without a g=
ood
> > + * understanding of the issues.
> > + */
> > +struct ptdesc {
> > +     unsigned long __page_flags;
> > +
> > +     union {
> > +             struct list_head pt_list;
> > +             struct {
> > +                     unsigned long _pt_pad_1;
> > +                     pgtable_t pmd_huge_pte;
> > +             };
> > +     };
> > +     unsigned long _pt_s390_gaddr;
> > +
> > +     union {
> > +             struct mm_struct *pt_mm;
> > +             atomic_t pt_frag_refcount;
> > +     };
> > +
> > +#if ALLOC_SPLIT_PTLOCKS
> > +     spinlock_t *ptl;
> > +#else
> > +     spinlock_t ptl;
> > +#endif
> > +};
>
> I think you should include the memcg here too? It needs to be valid
> for a ptdesc, even if we don't currently deref it through the ptdesc
> type.

Yes, thanks for catching that! I'll add it to v5.

> Also, do you see a way to someday put a 'struct rcu_head' into here?

Eventually, when they're being dynamically allocated independent of
struct page. Although at that point I'm not sure if we'll need one.

> Thanks,
> Jason
