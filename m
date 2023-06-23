Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39E073AF1E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 05:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFWDjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 23:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFWDjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 23:39:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2510F4;
        Thu, 22 Jun 2023 20:39:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6300f6ab032so2275386d6.2;
        Thu, 22 Jun 2023 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687491543; x=1690083543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQCkd4lI+x6yZWQGbIGjk8nvglDFNi+aN+K8MOcwH6c=;
        b=obkzvxCGresnf5FRfVrvj4b/znqPUmGMMwKvIvfk8JFNu1deF5iG2IClXFSs/hqBes
         0DchAnN9jcxuJK+1+ZKd23RORLAtCB1aaCRRAW/OhJcfqCqUQNLBzTBpbxJmpuWbKfjS
         GHJW8WsTLXwJYS5PMKJOMqwGF/WhlRObHMiD0r0si8DOzKdhQ3DRjzuP54tE28VCyLvh
         LV9mOcap4BQfgiSa4vCLx3tJr5yWQgnZ2UsTStLz9NxYkxX8IS7oFayaE3MrbO0dEpB/
         K0gDAaORiA1jbA+zNdWb4SjSRPyF9Y1hEdIFkFam1bjGmw9MYsZEQu4LxQURWeFd5nOn
         uaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687491543; x=1690083543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQCkd4lI+x6yZWQGbIGjk8nvglDFNi+aN+K8MOcwH6c=;
        b=ZfJrInugmkS/UKtvFOlT79aPxal+88tkbnvrasUdO+GOBbGPPJJJ2jMdcDXCRbLuBe
         /xy+dLj90SvvjkBFBhmliS5sjwTd60+3VzF1n2qt9xGpJZp+lfS4zjJ7dzR8WNeq3Xi8
         p9LcnC1v+HtWvLXjKLqIreDv9YxYSFW5rHqQz2W8ayMR5sP1rN8PE7qBI5zNQGdKV0Ax
         IQwrNKkdURvrnI6wketgPOucEDQrUHP0dp/MB4KBtpGXoF4BAdRqKy5yakGdPXbDTIVm
         Q1VTFI/3Kktk/R3MeInRbcQZupZKoFmLvmI2B8S/T6vjz8aTI6asgM/s0/dSS3ikXhy2
         bZeg==
X-Gm-Message-State: AC+VfDw2TN1V+6uv5bzAbj+dVg8oKFrfG7i09+o86M08c3V4gG4Jfvye
        aPnRUfpwyHQnyMw5F3Y/dreR6fsdQ8Ui4yrO3F4=
X-Google-Smtp-Source: ACHHUZ4TEnCYuyVXkOaJkrxqOvUh5TaEibt2frAQVMu4v4pRBqRYzpLpvZ5Z+pdQLYqT/hxYRfdn3rRiaTS4M+MnTIo=
X-Received: by 2002:a05:6214:29c8:b0:62d:f35c:a477 with SMTP id
 gh8-20020a05621429c800b0062df35ca477mr28990227qvb.1.1687491542761; Thu, 22
 Jun 2023 20:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230620144618.125703-1-ypodemsk@redhat.com> <20230620144618.125703-3-ypodemsk@redhat.com>
 <10050BB1-15A4-4E84-B900-B21500B2079B@gmail.com>
In-Reply-To: <10050BB1-15A4-4E84-B900-B21500B2079B@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 22 Jun 2023 20:38:51 -0700
Message-ID: <CAHbLzko2rNj8jdHVUw+kxF8Pz7b3o4im1ndoLbW611e2T3-LzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
To:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, mtosatti@redhat.com,
        ppandit@redhat.com, David Hildenbrand <david@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        svens@linux.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        Arnd Bergmann <arnd@arndb.de>, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, linus.walleij@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        sebastian.reichel@collabora.com, Mike Rapoport <rppt@kernel.org>,
        aneesh.kumar@linux.ibm.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 11:02=E2=80=AFAM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>
> >
> > On Jun 20, 2023, at 7:46 AM, Yair Podemsky <ypodemsk@redhat.com> wrote:
> >
> > @@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct mm_struc=
t *mm, struct vm_area_struct *v
> >                               addr + HPAGE_PMD_SIZE);
> >       mmu_notifier_invalidate_range_start(&range);
> >       pmd =3D pmdp_collapse_flush(vma, addr, pmdp);
> > -     tlb_remove_table_sync_one();
> > +     tlb_remove_table_sync_one(mm);
>
> Can=E2=80=99t pmdp_collapse_flush() have one additional argument =E2=80=
=9Cfreed_tables=E2=80=9D
> that it would propagate, for instance on x86 to flush_tlb_mm_range() ?
> Then you would not need tlb_remove_table_sync_one() to issue an additiona=
l
> IPI, no?
>
> It just seems that you might still have 2 IPIs in many cases instead of
> one, and unless I am missing something, I don=E2=80=99t see why.

The tlb_remove_table_sync_one() is used to serialize against fast GUP
for the architectures which don't broadcast TLB flush by IPI, for
example, arm64, etc. It may incur one extra IPI for x86 and some
others, but x86 virtualization needs this since the guest may not
flush TLB by sending IPI IIUC. So if the one extra IPI is really a
problem, we may be able to define an arch-specific function to deal
with it, for example, a pv ops off the top of my head. But I'm not a
virtualization expert, I'm not entirely sure whether it is the best
way or not.  But the complexity seems overkilling TBH since khugepaged
is usually not called that often.

>
>
