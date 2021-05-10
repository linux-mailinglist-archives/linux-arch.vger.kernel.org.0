Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56979377C73
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhEJGkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 02:40:51 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:36515 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhEJGkv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 02:40:51 -0400
Received: by mail-ua1-f46.google.com with SMTP id x9so4898906uao.3;
        Sun, 09 May 2021 23:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88Ilm7Flv2wT81QtnUpmPqsLyEiLP/hNQ6e6DIypvF8=;
        b=K6W8HKJx59RQTDZYtfrpD9TBufFbMwSPx0C/z/2FXOrNYvEbP1Y3eWc0PESju2+nHL
         sYngEOrwI2uyxaM1NU4fEiqvgIMUXqa4MYH9OagdfBskKBQ0OxpMGRHRe45zIyBpr2Gc
         lFXJk608wipaCR+2Jx8X+7k0zevZ4gMQfGFQbh7W2xkEMI34gxcuqbXR8f7oUe+mjCz3
         F5sQWFLBZZL7fAJ1oJieYaEM3S58SIbHpHMO/oISvWJQqMYeiMm9MlSbCF8bnkeldn0q
         1KuHgSY7LZxdcJrWf1ZayZwESeX9sjUUPw53tIGW99dhjC1iQXocnzdqrJQeFZnhDHow
         aRmQ==
X-Gm-Message-State: AOAM533KVsSdrkbKzQwLe4s4TxjZpN2lIXhUAgQPyhdYsJqe/4+51xDM
        BRQba4/Z7/xbDxK50JWObv1UxrywCSLTQsdbkvgdRJgO
X-Google-Smtp-Source: ABdhPJx9aX2w0srOx4Ut30nBYM1wWKO8fDI93D0cYhc7YNORjnnYGTtPGGZLM+lrSx0up2luWduXp+HPTWfTLyC13lU=
X-Received: by 2002:ab0:59cb:: with SMTP id k11mr3832034uad.100.1620628786270;
 Sun, 09 May 2021 23:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-13-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 May 2021 08:39:35 +0200
Message-ID: <CAMuHMdUuFPy8F8xwuZys7zdH_nRGQcrjgTSC0UTdcGMv+wEwRg@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Sat, May 8, 2021 at 12:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> The get_unaligned()/put_unaligned() implementations are much more complex
> than necessary, now that all architectures use the same code.
>
> Move everything into one file and use a much more compact way to express
> the same logic.
>
> I've compared the binary output using gcc-11 across defconfig builds for
> all architectures and found this patch to make no difference, except for
> a single function on powerpc that needs two additional register moves
> because of random differences in register allocation.
>
> There are a handful of callers of the low-level __get_unaligned_cpu32,
> so leave that in place for the time being even though the common code
> no longer uses it.
>
> This adds a warning for any caller of get_unaligned()/put_unaligned()
> that passes in a single-byte pointer, but I've sent patches for all
> instances that show up in x86 and randconfig builds. It would be nice
> to change the arguments of the endian-specific accessors to take the
> matching __be16/__be32/__be64/__le16/__le32/__le64 arguments instead of
> a void pointer, but that requires more changes to the rest of the kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> @@ -6,20 +6,132 @@
>   * This is the most generic implementation of unaligned accesses
>   * and should work almost anywhere.
>   */
> +#include <linux/unaligned/packed_struct.h>
>  #include <asm/byteorder.h>
>
> -#if defined(__LITTLE_ENDIAN)
> -# include <linux/unaligned/le_struct.h>
> -# include <linux/unaligned/generic.h>
> -# define get_unaligned __get_unaligned_le
> -# define put_unaligned __put_unaligned_le
> -#elif defined(__BIG_ENDIAN)
> -# include <linux/unaligned/be_struct.h>
> -# include <linux/unaligned/generic.h>
> -# define get_unaligned __get_unaligned_be
> -# define put_unaligned __put_unaligned_be
> -#else
> -# error need to define endianess
> -#endif
> +#define __get_unaligned_t(type, ptr) ({                                                \
> +       const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
> +       __pptr->x;                                                              \

Space before tab (cfr. checkpatch).

> +})
> +
> +#define get_unaligned(ptr) ({                                                  \
> +       __auto_type __ptr = (ptr);                                              \
> +       __get_unaligned_t(typeof(*__ptr), __ptr);                               \
> +})
> +
> +#define __put_unaligned_t(type, val, ptr) ({                                   \
> +       struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);            \
> +       __pptr->x = (val);                                                      \

Likewise

> +})
>
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
