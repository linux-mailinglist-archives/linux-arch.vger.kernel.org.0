Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5338E237
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEXIYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 04:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232279AbhEXIYa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 04:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8CA661151;
        Mon, 24 May 2021 08:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621844582;
        bh=+TDQoVOokc8WBAFuv0fWAuKnZ09Bvva98Z+VkeSiyYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V7BHr2cHba8OquErjEX+iEHS40AtGDmaVhe5QzR9Csdt4vq7ORsDL78UFibSuLxk/
         8vEePM0DgKoR0c8ymNZ16ZtQHrnAbKGMYgi6jLqivEGbLUXOPcpup3aQf21ixsPYuR
         3Jy2uUBrj47v2RTPFhuuaKLOphOCOGFlnt9rc/bJVo5S35GOmMZxy3eJ9PL/Ez7972
         9HJ+ks6cJRZQ1u3k7GEOKKRX6ee9BGoy2ruJCIWZdP2TgAeNLSRy2HLPA98BZFDOl7
         NAHUuEoWM/DAfVqIlYp1FWYlAyUvA71alreGu1DM66bKGrZ4IUqJJyDPb7NbXxqCoX
         Jxec/u3jfcm9Q==
Received: by mail-lj1-f176.google.com with SMTP id e2so26135834ljk.4;
        Mon, 24 May 2021 01:23:02 -0700 (PDT)
X-Gm-Message-State: AOAM530bNhRnRnhBfzAZ77EaS/C4dSOgjMo5JIIIAPwqY9uNfQzh1/27
        uO7gO08HsWZDqyKtT11Ob5QYdUvwWFb/CN4qesk=
X-Google-Smtp-Source: ABdhPJy3T3I9cqfLxcQ7H+a6WA92Atu9K4L0xECjGYqHAmb3IFmhkBTnK9bvoOswUChqlODJlN6h0jYJZUhV36hqF2Q=
X-Received: by 2002:a2e:b557:: with SMTP id a23mr16493146ljn.238.1621844581046;
 Mon, 24 May 2021 01:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <1621839068-31738-1-git-send-email-guoren@kernel.org> <CAAhSdy3ORUGqyL-9oMQCKYCXnG8M=xrZ8q+AiWg8s+v6zsk=_A@mail.gmail.com>
In-Reply-To: <CAAhSdy3ORUGqyL-9oMQCKYCXnG8M=xrZ8q+AiWg8s+v6zsk=_A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 May 2021 16:22:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQOimKQR8nL3SKgC6OP8OcsagFCADfehg4TEt96D9xVpQ@mail.gmail.com>
Message-ID: <CAJF2gTQOimKQR8nL3SKgC6OP8OcsagFCADfehg4TEt96D9xVpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anup,

On Mon, May 24, 2021 at 4:03 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, May 24, 2021 at 12:22 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Kernel virtual address translation should avoid care asid or it'll
> > cause more TLB-miss and TLB-refill. Because the current asid in satp
> > belongs to the current process, but the target kernel va TLB entry's
> > asid still belongs to the previous process.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>
> First of all thanks for doing this series, I had similar changes in mind
> as follow-up to the ASID allocator.
>
> I went through all three patches and at least I don't see any
> obvious issue but I think we should try testing it more on a few
> existing platforms.
We've tested it on Allwinner D1 C906 and C910 SMP*4 for a long time,
just hope it won't affect u540.

(In fact, C910 has used ASID allocator for more than two years with
our own kernel-tree. I remember we've talked about it in 2019
plumber.)

>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 78f2323..017da15 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -135,6 +135,7 @@
> >                                 | _PAGE_PRESENT \
> >                                 | _PAGE_ACCESSED \
> >                                 | _PAGE_DIRTY \
> > +                               | _PAGE_GLOBAL \
> >                                 | _PAGE_CACHE)
> >
> >  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
> > --
> > 2.7.4
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
