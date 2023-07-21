Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60B875CD30
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGUQIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGUQIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 12:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EB2D50;
        Fri, 21 Jul 2023 09:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2434261D22;
        Fri, 21 Jul 2023 16:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C445C433CB;
        Fri, 21 Jul 2023 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689955730;
        bh=aFVATYbnHbXl+l/aXY946VlByUUM/RJ2gC+IwOCTwNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tzdHW6zWPwp4AgsuyQ5HxWoNFyI7xT0WtDW/oT93THjgq9F1kGpoUHW6PHgpX/Dbv
         cHrGuupwj2nmxqlceLkgfOIK4mjW5sQXt6ZsDOj7xZhptco1KtiUCNLTikflDgoW4S
         xtmCvfJofarYh4i3g7YUHeTGSlasGWyKrnhBuCDC+3q95a1OtsEhiDXCYBpAJK/9Z2
         pZ67cgiULI8dFMNzALoJ0pbgoyLtw3c1sjpGkDlC/vi/+ZhY28dwd0p29UAoQE7wSw
         YAmhntfEm/bbOrRYIrdGbFg1AuIBjwKO+/hS0/s8LRAISAU3oSAs+CAWrBn47JTYl4
         Au1gehkWyrvaw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-992f15c36fcso331908366b.3;
        Fri, 21 Jul 2023 09:08:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLZy4I+o5DxZp4VlvCZXgIAEOaO4nx4Exc9rKmLx94A2//z13oov
        LUiyU1ibPaFQxabI+0dyWmt4NjUSVqpQnTp8trg=
X-Google-Smtp-Source: APBJJlFzx8ZYFFr2o+NPKH3p58vjaLT9QNxTJBi8tIkxzVzR9iKmIT333myWzMMGD/LRl9RKizHNRUsBu66ZOvoJM5M=
X-Received: by 2002:a17:906:100c:b0:99b:518a:9de with SMTP id
 12-20020a170906100c00b0099b518a09demr1982530ejm.42.1689955728742; Fri, 21 Jul
 2023 09:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230721145121.1854104-1-guoren@kernel.org> <5e5be2d4-c563-6beb-b5f5-df47edeebc83@ghiti.fr>
In-Reply-To: <5e5be2d4-c563-6beb-b5f5-df47edeebc83@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 22 Jul 2023 00:08:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQMAVUtC6_ftEwp=EeYR_O7yzfGYmxwrqcO6+hn2J32bA@mail.gmail.com>
Message-ID: <CAJF2gTQMAVUtC6_ftEwp=EeYR_O7yzfGYmxwrqcO6+hn2J32bA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Fixup spurious fault of kernel vaddr
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 11:19=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
>
> On 21/07/2023 16:51, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > RISC-V specification permits the caching of PTEs whose V (Valid)
> > bit is clear. Operating systems must be written to cope with this
> > possibility, but implementers are reminded that eagerly caching
> > invalid PTEs will reduce performance by causing additional page
> > faults.
> >
> > So we must keep vmalloc_fault for the spurious page faults of kernel
> > virtual address from an OoO machine.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   arch/riscv/mm/fault.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 85165fe438d8..f662c9eae7d4 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -258,8 +258,7 @@ void handle_page_fault(struct pt_regs *regs)
> >        * only copy the information from the master page table,
> >        * nothing more.
> >        */
> > -     if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
> > -         unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) {
> > +     if (unlikely(addr >=3D TASK_SIZE)) {
> >               vmalloc_fault(regs, code, addr);
> >               return;
> >       }
>
>
> Can you share what you are trying to fix here?
We met a spurious page fault panic on an OoO machine.

1. The processor speculative execution brings the V=3D0 entries into the
TLB in the kernel virtual address.
2. Linux kernel installs the kernel virtual address with the page, and V=3D=
1
3. When kernel code access the kernel virtual address, it would raise
a page fault as the V=3D0 entry in the tlb.
4. No vmalloc_fault, then panic.

>
> I have a fix (that's currently running our CI) for commit 7d3332be011e
> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") that
> implements flush_cache_vmap() since we lost the vmalloc_fault.
Could you share that patch?

>


--=20
Best Regards
 Guo Ren
