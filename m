Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1687C8EA3
	for <lists+linux-arch@lfdr.de>; Fri, 13 Oct 2023 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJMVD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Oct 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMVDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Oct 2023 17:03:25 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3AB7;
        Fri, 13 Oct 2023 14:03:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so2385538276.0;
        Fri, 13 Oct 2023 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697231000; x=1697835800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtiOVCn2uSsz0FoSYRDQt6Ad/oEEDkzUyvmWznVzlSA=;
        b=azcdS5mk3fTak+nb/eug5AYpCwxC5kpdPWDxsTbKwRaTZsnLV+Lx6RGqcJnIyUdE7E
         i8mcurTG2K1UAzdKUEP1S6mdqR+ibq2oLmQ3X9nYbM0kG2dZD3+5jy7tWcqTlQuPlXEn
         YxekVNV3znDqK079lRSP9QXygD9u0NmyD1tg7EsKIgxZZ9rwNdXqbYT+ovXnVO/ci831
         mgB/pG84f12ARASoT4IyPoOJNm6RHJASuCu6rXvY9sR+TJqwnt77yCRbkYhGzdUBrhXd
         8X5ZM+bDS4cgt/tdAP3JdjHz4hcbnQ2wJko+oS911py/MlPJdtAAXbYPgvNL5+6cI/+s
         ivbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231000; x=1697835800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtiOVCn2uSsz0FoSYRDQt6Ad/oEEDkzUyvmWznVzlSA=;
        b=EoOdS6t9q5onboOSajiihDPwrOvD9jjmmZ0TIdOI+n9UUe11Qay6YbTt3flkCOKUJQ
         ARCPDnwSv6Bs3VDI5IxdZzbQJCIQeqxrf3xuzq1iuv5bwBBeLK+nEebUyPBjCUySqrIR
         0J68695SPTegha0BBJICgKu6KzXmAdwngFFH/rOG0W2o+RGqynfvOSZaggW1LjGxFCjS
         3yslMQT6PQGUZSF7jsbLXGalqj48rkF+6H8UV7eBkF7tvXblE7/vRwBvtycqMznRcLJh
         3l7WnU9pim0Tk9jgbHQv0qJQYzmiG5GIStf3RfL1H0Tt/MyisN30fssYiGCIRgg/Takh
         049g==
X-Gm-Message-State: AOJu0YwuMAUa/Yms10yiEquu3Ujskw3v3j1JidWpHUt+4pt3l+aT8B3W
        QwBTXNyvRLeShvHZLvHa5uEIsTYwQeSGzw8QLec=
X-Google-Smtp-Source: AGHT+IHWHj9ILTPWExZ8ekeA0/ryyRW0ZV6k5VhEVnOo+k5EpZsvEbKt/nom23K7vTTS2zHZvjjk2tEmm58T8MLLm1U=
X-Received: by 2002:a5b:64d:0:b0:d9b:3b3e:5a07 with SMTP id
 o13-20020a5b064d000000b00d9b3b3e5a07mr2004058ybq.5.1697230999223; Fri, 13 Oct
 2023 14:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230807230513.102486-1-vishal.moola@gmail.com>
 <20230807230513.102486-15-vishal.moola@gmail.com> <20231012072505.6160-A-hca@linux.ibm.com>
In-Reply-To: <20231012072505.6160-A-hca@linux.ibm.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Fri, 13 Oct 2023 14:03:08 -0700
Message-ID: <CAOzc2px-SFSnmjcPriiB3cm1fNj3+YC8S0VSp4t1QvDR0f4E2A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v9 14/31] s390: Convert various pgalloc
 functions to use ptdescs
To:     Heiko Carstens <hca@linux.ibm.com>
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
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 12, 2023 at 12:25=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Mon, Aug 07, 2023 at 04:04:56PM -0700, Vishal Moola (Oracle) wrote:
> > As part of the conversions to replace pgtable constructor/destructors w=
ith
> > ptdesc equivalents, convert various page table functions to use ptdescs=
.
> >
> > Some of the functions use the *get*page*() helper functions. Convert
> > these to use pagetable_alloc() and ptdesc_address() instead to help
> > standardize page tables further.
> >
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  arch/s390/include/asm/pgalloc.h |   4 +-
> >  arch/s390/include/asm/tlb.h     |   4 +-
> >  arch/s390/mm/pgalloc.c          | 128 ++++++++++++++++----------------
> >  3 files changed, 69 insertions(+), 67 deletions(-)
> ...
> > diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> > index d7374add7820..07fc660a24aa 100644
> > --- a/arch/s390/mm/pgalloc.c
> > +++ b/arch/s390/mm/pgalloc.c
> ...
> > @@ -488,16 +486,20 @@ static void base_pgt_free(unsigned long *table)
> >  static unsigned long *base_crst_alloc(unsigned long val)
> >  {
> >       unsigned long *table;
> > +     struct ptdesc *ptdesc;
> >
> > -     table =3D (unsigned long *)__get_free_pages(GFP_KERNEL, CRST_ALLO=
C_ORDER);
> > -     if (table)
> > -             crst_table_init(table, val);
> > +     ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, CRST_ALLO=
C_ORDER);
>
> I guess I must miss something, but what is the reason to mask out
> __GFP_HIGHMEM here? It is not part of GFP_KERNEL, nor does s390 support
> HIGHMEM.

You're not missing anything.

This was replacing __get_free_pages() which also doesn't support HIGHMEM,
so I had that in to ensure a non-HIGHMEM allocation in case a
passed-in gfp_flags
had it set. In hindsight since we're just passing in the GFP flags
directly here, we don't
actually need to mask out GFP_HIGHMEM.
