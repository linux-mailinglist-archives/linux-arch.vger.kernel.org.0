Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7E733B84
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbjFPV27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPV25 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 17:28:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F235A5;
        Fri, 16 Jun 2023 14:28:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57012b2973eso14367907b3.2;
        Fri, 16 Jun 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686950935; x=1689542935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8f4Qp7cwj4O2kdf7qLqLnrTRkxhB0m+8FmgrZaxSBc=;
        b=kDqKbU7P9edSk/BgMH9xSstpKqVCZCkotk48bdhsv9CQedo7tgzNx594G7ZL6GQuxg
         jA1o2JPcz0QDYMp8Gk7IfVIBu/Qb0pO39azZ5F7HLfZC1IgCGAp3b3idtV3rR/BwTQDN
         x0xETay6eu3ghZcxBbeBHYOXCm+0UdQ18fM+kmxKxAuiYRqF/zWkw4LlfaXk/Ol9POup
         f5e5C/WGoi8jmqXjJwP7rx3T/q8TLMKNW53qsepy7E0u9eKRuHWvS7CgQ60QFJLvcMrS
         P+YDUzuxecN+sqBu1rA+X9cuH9CB9q1H/97ksOSagJnc4ZVXc8JgbNn89oLF/7saT6Tn
         z99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686950935; x=1689542935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8f4Qp7cwj4O2kdf7qLqLnrTRkxhB0m+8FmgrZaxSBc=;
        b=ZrXo6OGWoVcQQbpgSbyYmx/wep0NhiK1CbM5FA33HDEZhjFAYw6cpaTSwH2pl4EIZ4
         uqHvBSbe+yg5iRF4pulMPHrmfDZqn82BubWlNex2re7YRiI8fSyoROaFxuEegUAgLIz5
         1/zBxI6dFB6mvJR8PSP+kM0XLTJIh8bae3D1kf8uZ0BmPLVWZYISOGk6jEO+5Psy3jDG
         XAHZosySLp+lcb3KgOOHA/4cP3Jrw6t/W7sYW16eKnJQXS4c6t014uDv3qve/2HHLULL
         7UX2qrrpfztAc2KkUnBkfSpKyo7ntriTw10HOnd3UKus2hnk0CtDDJjrdk0NxXNxeExU
         0hEw==
X-Gm-Message-State: AC+VfDxXqdrtJTkK2x9HIV+45N/Muj9IZabhuAv0GNkviw0qbN2+vX37
        3pSRG1hCidM3bEqy7HTqAnD5MASoi8d1d9cH3fNMh2CJTIoP+A==
X-Google-Smtp-Source: ACHHUZ7/iv7DGmrSbI7dWoycmh8dvViREYGBrKV5KnrTS1VkZy/HhcudLLxyAMIf5U1P44XX8eoY39CR0V8jmRNeXMA=
X-Received: by 2002:a81:6c02:0:b0:56c:f684:b4f0 with SMTP id
 h2-20020a816c02000000b0056cf684b4f0mr2990065ywc.27.1686950935072; Fri, 16 Jun
 2023 14:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
In-Reply-To: <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Fri, 16 Jun 2023 14:28:44 -0700
Message-ID: <CAOzc2pwhoF=XNCoe-+w2Z5MRoRJGvTfSr56HV00OGitEBMtPcw@mail.gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 15, 2023 at 12:57=E2=80=AFAM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Mon, 12 Jun 2023, Vishal Moola (Oracle) wrote:
>
> > Currently, page table information is stored within struct page. As part
> > of simplifying struct page, create struct ptdesc for page table
> > information.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>
> Vishal, as I think you have already guessed, your ptdesc series and
> my pte_free_defer() "mm: free retracted page table by RCU" series are
> on a collision course.
>
> Probably just trivial collisions in most architectures, which either
> of us can easily adjust to the other; powerpc likely to be more awkward,
> but fairly easily resolved; s390 quite a problem.
>
> I've so far been unable to post a v2 of my series (and powerpc and s390
> were stupidly wrong in the v1), because a good s390 patch is not yet
> decided - Gerald Schaefer and I are currently working on that, on the
> s390 list (I took off most Ccs until we are settled and I can post v2).
>
> As you have no doubt found yourself, s390 has sophisticated handling of
> free half-pages already, and I need to add rcu_head usage in there too:
> it's tricky to squeeze it all in, and ptdesc does not appear to help us
> in any way (though mostly it's just changing some field names, okay).
>
> If ptdesc were actually allowing a flexible structure which architectures
> could add into, that would (in some future) be nice; but of course at
> present it's still fitting it all into one struct page, and mandating
> new restrictions which just make an architecture's job harder.

A goal of ptdescs is to make architecture's jobs simpler and standardized.
Unfortunately, ptdescs are nowhere near isolated from struct page yet.
This version of struct ptdesc contains the exact number of fields architect=
ures
need right now, just reorganized to be located next to each other. It *prob=
ably*
shouldn't make an architectures job harder, aside from discouraging their u=
se
of yet even more members of struct page.

> Some notes on problematic fields below FYI.
>
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
>
> I shall be needing struct rcu_head rcu_head (or pt_rcu_head or whatever,
> if you prefer) in this union too.  Sharing the lru or pt_list with rcu_he=
ad
> is what's difficult to get right and efficient on s390 - and if ptdesc ga=
ve
> us an independent rcu_head for each page table, that would be a blessing!
> but sadly not, it still has to squeeze into a struct page.

I can add a pt_rcu_head along with a comment to deter aliasing issues :)
Independent rcu_heads aren't coming any time soon though :(

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
>
> Whether s390 will want pt_mm is not yet decided: I want to use it,
> Gerald prefers to go without it; but if we do end up using it,
> then pt_frag_refcount is a luxury we would have to give up.

I don't like the use of pt_mm for s390 either. s390 uses space equivalent
to all five words allocated in the page table struct (albeit in various pla=
ces
of struct page). Using extra space (especially allocated for unrelated
reasons) just because it exists makes things more complicated and
confusing, and s390 is already confusing enough as a result of that.

If having access to pt_mm is necessary I can drop the
pt_frag_refcount patch, but I'd rather avoid it.

> s390 does very well already with its _refcount tricks, and I'd expect
> powerpc's simpler but more wasteful implementation to work as well
> with _refcount too - I know that a few years back, powerpc did misuse
> _refcount (it did not allow for speculative accesses, thought it had
> sole ownership of that field); but s390 copes well with that, and I
> expect powerpc can do so too, without the luxury of pt_frag_refcount.
>
> But I've no desire to undo powerpc's use of pt_frag_refcount:
> just warning that we may want to undo any use of it in s390.
>
> I thought I had more issues to mention, probably Gerald will
> remind me of a whole new unexplored dimension! gmap perhaps.
>
> Hugh
>
> > +     };
> > +
> > +#if ALLOC_SPLIT_PTLOCKS
> > +     spinlock_t *ptl;
> > +#else
> > +     spinlock_t ptl;
> > +#endif
> > +};
> > +
> > +#define TABLE_MATCH(pg, pt)                                          \
> > +     static_assert(offsetof(struct page, pg) =3D=3D offsetof(struct pt=
desc, pt))
> > +TABLE_MATCH(flags, __page_flags);
> > +TABLE_MATCH(compound_head, pt_list);
> > +TABLE_MATCH(compound_head, _pt_pad_1);
> > +TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
> > +TABLE_MATCH(mapping, _pt_s390_gaddr);
> > +TABLE_MATCH(pt_mm, pt_mm);
> > +TABLE_MATCH(ptl, ptl);
> > +#undef TABLE_MATCH
> > +static_assert(sizeof(struct ptdesc) <=3D sizeof(struct page));
> > +
> >  /*
> >   * No-op macros that just return the current protection value. Defined=
 here
> >   * because these macros can be used even if CONFIG_MMU is not defined.
> > --
> > 2.40.1
