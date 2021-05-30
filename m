Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6165C394FB0
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 07:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3Ffn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 May 2021 01:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhE3Ffm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 01:35:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64CD961108;
        Sun, 30 May 2021 05:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622352845;
        bh=FLn/9f8WMsIdmFnvrDv3Mglo+h1LSWEE4NFwYI9qejQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tu01rQTeK9Bh/v4eCo7w+Ip4ogwfvKVV8jD3yJSlSdusQjNnog2wrv9NoNWhfl7A5
         iF4kO2WVxan3vNWMmI3CNm3SGZDE+SKF81ZbAN2OKSneoYp2iYykoI1wK9577fzZAQ
         B3zp7YbEkujEn7vC0oZd6z2NLpDb4Mefa5D5aF/2GmKggt7oItNCMZ21JF2qwVdecM
         ZgiLMxDXXAINrydlVUZhboc92qKALqnlaNd42I/FfhwssZBv8Ppf7DqLat+9cRKu/M
         +tW7wifOivCSaShs2EuwlIIJui4Xm22K0nBxI0KKFrw7YclJGEMliQmZEh1+wV1w7S
         kkG5lBDKJ2F/A==
Received: by mail-lf1-f43.google.com with SMTP id b18so7654571lfv.11;
        Sat, 29 May 2021 22:34:05 -0700 (PDT)
X-Gm-Message-State: AOAM532Bdl/KjJ/cXHWYGaiNfZbS8SPXtv4uXlOjU+dpfo3Br6YozQMT
        lZ1HP3YZ6LNqD0/x0Gik5HDUKaJM2704TasCCCA=
X-Google-Smtp-Source: ABdhPJzXI4xVh66JGKFo7gHrm+ykGxENf72ornewHIx5uJq5t/cO3XwEwN5wOJP9Q3jcnMFdCSb8EzCc+wHXCIIJTuo=
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr10864663lfs.41.1622352843723;
 Sat, 29 May 2021 22:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <1622008161-41451-2-git-send-email-guoren@kernel.org> <mhng-60806045-5ac7-4057-b596-a4d9cb79b7be@palmerdabbelt-glaptop>
In-Reply-To: <mhng-60806045-5ac7-4057-b596-a4d9cb79b7be@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 May 2021 13:33:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSPQmWLon40GafUjEjeMfu3ZPsPREzE+4W5+0uWjj=F_A@mail.gmail.com>
Message-ID: <CAJF2gTSPQmWLon40GafUjEjeMfu3ZPsPREzE+4W5+0uWjj=F_A@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 30, 2021 at 7:42 AM <palmerdabbelt@google.com> wrote:
>
> On Tue, 25 May 2021 22:49:20 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Kernel virtual address translation should avoid to use ASIDs or it'll
> > cause more TLB-miss and TLB-refill. Because the current ASID in satp
> > belongs to the current process, but the target kernel va TLB entry's
> > ASID still belongs to the previous process.
>
> Sorry, I still can't quite figure out what this is trying to say.  I
> went ahead and re-wrote the commit text to
>
>     riscv: Use global mappings for kernel pages
>
>     We map kernel pages into all addresses spages, so they can be marked as
>     global.  This allows hardware to avoid flushing the kernel mappings when
>     moving between address spaces.
Okay

>
> LMK if I'm misunderstanding something here, it's on for-next.
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 9469f46..346a3c6 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -134,7 +134,8 @@
> >                               | _PAGE_WRITE \
> >                               | _PAGE_PRESENT \
> >                               | _PAGE_ACCESSED \
> > -                             | _PAGE_DIRTY)
> > +                             | _PAGE_DIRTY \
> > +                             | _PAGE_GLOBAL)
> >
> >  #define PAGE_KERNEL          __pgprot(_PAGE_KERNEL)
> >  #define PAGE_KERNEL_READ     __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
