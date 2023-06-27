Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD074042B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjF0T4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF0T4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 15:56:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDBFA;
        Tue, 27 Jun 2023 12:56:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56ff9cc91b4so55098767b3.0;
        Tue, 27 Jun 2023 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687895796; x=1690487796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdquro6/1dmVZnYjtrQgFcMxkU4TUJVZmkWoLqAkDfs=;
        b=f28I8lHAi89ozlaNg/BctKdKMs3ZV6m8KXjBDM6pClsFtWadf95y0x4g3i//E8BwZz
         W+z8+saIIFbmoUgBUaIpSnUEoRcLDnuqLYQnOFRS+j34fc48uptWzZzEtuGsHAJp24eW
         schrHDJX1LmM4MqcKy9Kl1+LnP3eq11QJcl+8rxobGaBQBGKgLHNc4OHDPWjyNPyHr8O
         3NCVuR4QFNH+Qpn6H6NXaags2ruLb1/5mkhPFAz5CmyBZqkztlzk4kjRiIcxN74282q0
         ok16c0PiSUSoXbXu9Py6nAmtPZ8zTkEwR31ZaDkNSc5taFwAdZNAWg6IT3kt5o5vZVZ6
         A8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895796; x=1690487796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdquro6/1dmVZnYjtrQgFcMxkU4TUJVZmkWoLqAkDfs=;
        b=PWsaC6CchUPYsFAuGecf168GZJ0wxhLMAsOz6+0DlcA8hhoC0Ng8CV5+SZqSfSi316
         hBAw0p5KmE4cTCNdISmehpMwdaD+tBCGTD0EPz5/e2OTEqUPzUG98eITheAIGOKkE2DS
         P82GeiURw33efDkv1eqGQnQ2HFV7F5e8uBM4BgC1Q6eVKVlchKq2HgO2jjwdmw9kPPkt
         N7l0K59bu0gqEythVBgqyeZ/CyqLhd+T7nl5cjLcvjfngGXTagRUm14lHgbfOYMh+LFY
         SikvGUb33ycGxK/MOUDBOMnKdJuG3IDoqEgV2foyfaCKeOxb923QxRnRiOoAOctlav6w
         UpnQ==
X-Gm-Message-State: AC+VfDwh3BQc5W9FfzjCeNGW6PlfD8Wl+duu7S/Dl7Z6m6ve2GqFbxkv
        3KE108NxbzG61oVhagSl9ngC22k+BN313w5l5/mlCcVawxY=
X-Google-Smtp-Source: ACHHUZ5reIcGnTN97W0IND8v2qM1C2Qu4uLolES6NdKMr/CmT1WqgUFXujo/fo7+ykti4Dwr2zsHLXj/ugW36Uy1oLg=
X-Received: by 2002:a0d:de45:0:b0:576:e678:21d6 with SMTP id
 h66-20020a0dde45000000b00576e67821d6mr4351768ywe.12.1687895796450; Tue, 27
 Jun 2023 12:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com> <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net> <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
In-Reply-To: <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 27 Jun 2023 12:56:25 -0700
Message-ID: <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
To:     Guenter Roeck <linux@roeck-us.net>
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
        Dinh Nguyen <dinguyen@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Tue, Jun 27, 2023 at 12:14=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 6/27/23 12:10, Guenter Roeck wrote:
> > On 6/27/23 10:42, Vishal Moola wrote:
> >> On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> >>>
> >>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote=
:
> >>>> Part of the conversions to replace pgtable constructor/destructors w=
ith
> >>>> ptdesc equivalents.
> >>>>
> >>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> >>>
> >>> This patch causes all nios2 builds to fail.
> >>
> >> It looks like you tried to apply this patch on its own. This patch dep=
ends
> >> on patches 01-12 of this patchset to compile properly. I've cross-comp=
iled
> >> this architecture and it worked, but let me know if something fails
> >> when its applied on top of those patches (or the rest of the patchset)=
.
> >
> >
> > No, I did not try to apply this patch on its own. I tried to build yest=
erday's
> > pending-fixes branch of linux-next.
> >
>
> A quick check shows that the build fails with next-20230627. See log belo=
w.

Ah it looks like this one slipped into -next on its own somehow? Stephen, p=
lease
drop this patch from -next; it shouldn't be in without the rest of the
patchset which
I intend to have Andrew take through the mm tree.

> Guenter
>
> ---
>
> $ git describe
> next-20230627
> $ git describe --match 'v*'
> v6.4-12601-g53cdf865f90b
>
> Build reference: v6.4-12601-g53cdf865f90b
> Compiler version: nios2-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
>
> Building nios2:allnoconfig ... failed
> --------------
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from mm/memory.c:86:
> mm/memory.c: In function 'free_pte_range':
> arch/nios2/include/asm/pgalloc.h:33:17: error: implicit declaration of fu=
nction 'pagetable_pte_dtor'; did you mean 'pgtable_pte_page_dtor'? [-Werror=
=3Dimplicit-function-declaration]
>     33 |                 pagetable_pte_dtor(page_ptdesc(pte));           =
        \
>        |                 ^~~~~~~~~~~~~~~~~~
> include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free=
_tlb'
>    666 |                 __pte_free_tlb(tlb, ptep, address);             =
\
>        |                 ^~~~~~~~~~~~~~
> mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
>    194 |         pte_free_tlb(tlb, token, addr);
>        |         ^~~~~~~~~~~~
> arch/nios2/include/asm/pgalloc.h:33:36: error: implicit declaration of fu=
nction 'page_ptdesc' [-Werror=3Dimplicit-function-declaration]
>     33 |                 pagetable_pte_dtor(page_ptdesc(pte));           =
        \
>        |                                    ^~~~~~~~~~~
> include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free=
_tlb'
>    666 |                 __pte_free_tlb(tlb, ptep, address);             =
\
>        |                 ^~~~~~~~~~~~~~
> mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
>    194 |         pte_free_tlb(tlb, token, addr);
>        |         ^~~~~~~~~~~~
> arch/nios2/include/asm/pgalloc.h:34:17: error: implicit declaration of fu=
nction 'tlb_remove_page_ptdesc'; did you mean 'tlb_remove_page_size'? [-Wer=
ror=3Dimplicit-function-declaration]
>     34 |                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte))=
);      \
>        |                 ^~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free=
_tlb'
>    666 |                 __pte_free_tlb(tlb, ptep, address);             =
\
>        |                 ^~~~~~~~~~~~~~
> mm/memory.c:194:9: note: in expansion of macro 'pte_free_tlb'
>    194 |         pte_free_tlb(tlb, token, addr);
>        |         ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:243: mm/memory.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:477: mm] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile:2022: .] Error 2
> make: *** [Makefile:226: __sub-make] Error 2
