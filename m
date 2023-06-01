Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367671F40D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 22:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjFAUnf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjFAUne (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 16:43:34 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617FF189;
        Thu,  1 Jun 2023 13:43:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565a63087e9so13253237b3.2;
        Thu, 01 Jun 2023 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685652211; x=1688244211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1D8lVOaAVBWbT9t2RmOD+26281abLHxtrNSt32Ap24=;
        b=qLgbJbj5g8WGk9vr+h5GU3VAGYoZuUQfYy+Jk03a6BWdaBQStekzq99EEhSRb/apVE
         r1wG5klq4xTuvlp4fzfvGwGvXsPOH5Z+EGzZ3xDm5VuokYBfnX2Z7EeXpvrNqoMOmFfA
         JBLO6CGLz8pEI44d71tWawLxUIyiVrcZLnzOInnX4NDx0adjPFt4WqdjoFpvwTeJeP42
         YdR8VtfFc5+TjUwWFHzsShyWmg/NGqDFZTc1nDT9EKaeGOrhYp9pTMhkn6c++xEXcw0Z
         7/JenW6z+3FLVb69Ur5a6g5NHDXYEBFsl6KltuWvHl5pgiI7Ar5zj9KICtB4zwOfTiPP
         PMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652211; x=1688244211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1D8lVOaAVBWbT9t2RmOD+26281abLHxtrNSt32Ap24=;
        b=GOowg9yn12Q6SQlCdXA40g08sLFst1a8mGzJYQc/D+ZC9Cv2U4KHw5O8JXgIdyIf6t
         CkDgwYmWXjjIQLVN66g8S46iRGAxfgeuACOMOXb1rjo+Nk38gC9zvNnX8Mu6Mtn7rOCK
         60f9rGemU06TnD/1OlFLxVftsIaKncCha4VSdmCCYFyn7Cr0LAXaFscluQveBYHF8+Qw
         jV8yv5Gjekgy4HnL13fOiqaUFg4vhGAs4al+h7471Q1JJ+74hIQyZo4ofSMyl3D+Zkdz
         8JvBwdKQbUVTivEbq50q6u9owP0DcP1eS0gnbqbQ2fVxAvU2zI50G7f+mhB6C5Lr/RAS
         axEg==
X-Gm-Message-State: AC+VfDxPOzX26sLB2wS6GTh3JDg9tVa9nUNjVyyIL/vXD17t+m+HgPcY
        of+dXb9FtqMQ8lyQ6dtTMD1JbR2mgvDN2u0MMj8olTx8p5Y=
X-Google-Smtp-Source: ACHHUZ5DfuhGus+PqmBDfDw3I8CUwiopOPmtEZnOXp6mFa4otjE0OnORW5aklQp2qVjtyKAx2ImFFxSDC1ok71Q6xew=
X-Received: by 2002:a0d:e84b:0:b0:565:f045:18c3 with SMTP id
 r72-20020a0de84b000000b00565f04518c3mr10614817ywe.20.1685652211220; Thu, 01
 Jun 2023 13:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-4-vishal.moola@gmail.com> <20230601151900.6f184e8c@thinkpad-T15>
In-Reply-To: <20230601151900.6f184e8c@thinkpad-T15>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 1 Jun 2023 13:43:20 -0700
Message-ID: <CAOzc2pyjLh_GV1PL7CPkkPGcASHULhir_rJgB+UhwzPgQZD8Bw@mail.gmail.com>
Subject: Re: [PATCH v3 03/34] s390: Use pt_frag_refcount for pagetables
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
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
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
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

On Thu, Jun 1, 2023 at 6:19=E2=80=AFAM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
>  On Wed, 31 May 2023 14:30:01 -0700
> "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
>
> > s390 currently uses _refcount to identify fragmented page tables.
> > The page table struct already has a member pt_frag_refcount used by
> > powerpc, so have s390 use that instead of the _refcount field as well.
> > This improves the safety for _refcount and the page table tracking.
> >
> > This also allows us to simplify the tracking since we can once again us=
e
> > the lower byte of pt_frag_refcount instead of the upper byte of _refcou=
nt.
>
> This would conflict with s390 impact of pte_free_defer() work from Hugh D=
ickins
> https://lore.kernel.org/lkml/35e983f5-7ed3-b310-d949-9ae8b130cdab@google.=
com/
> https://lore.kernel.org/lkml/6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.c=
om/
>
> There he uses pt_frag_refcount, or rather pt_mm in the same union, to sav=
e
> the mm_struct for deferred pte_free().
>
> I still need to look closer into both of your patch series, but so far it
> seems that you have no hard functional requirement to switch from _refcou=
nt
> to pt_frag_refcount here, for s390.
>
> If this is correct, and you do not e.g. need this to make some other use
> of _refcount, I would suggest to drop this patch.

The goal of this preparation patch is to consolidate s390's usage of
struct page fields so that struct ptdesc can be smaller. Its not particular=
ly
mandatory; leaving _refcount in ptdesc only increases the struct by
8 bytes and can always be changed later.

However it is a little annoying since s390 is the only architecture
that egregiously uses space throughout struct page for their page
tables, rather than just the page table struct. For example, s390
gmap uses page->index which also aliases with pt_mm and
pt_frag_refcount. I'm not sure if/how gmap page tables interact
with s390 process page tables at all, but if it does that could
potentially cause problems with Hugh's patch as well :(

I can add _refcount to ptdesc if we would like, but I still
prefer if s390 could be simplified instead.
