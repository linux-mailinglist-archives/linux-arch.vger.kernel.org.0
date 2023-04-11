Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52616DD4C3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 10:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDKIJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Apr 2023 04:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDKIJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 04:09:05 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA030D6;
        Tue, 11 Apr 2023 01:09:01 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id z9so7150298ybs.9;
        Tue, 11 Apr 2023 01:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681200541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hALJfm4jnccIo090MDgna4b/Z74t0kji7w+cuP7uYXI=;
        b=diOdfJ+5MEbvvS+d4irokqTEqdfQy/cDAeLGlnQpYEBJRVx+fwr91Clxi5Dbl6Zbd2
         KQynU9XXtmCnAGJ3FSZbWyMsCNJtu+w8vFeb28fqPFiWd6a7zgA6o31yc/3oQ+gRwtRb
         CT9C+lVrZuo0vT5ewGl2ycmwjIQG8zCH0Vz02aIpfTFliF7t8CEzd1uDL1M4V3vMen1y
         6uKN6mi4lnW0WG45shxTfttZUwN8rzLoWzTDAMWrWDj5HQufTEvCZZEzgKxtfrGI8EgM
         SEl5isF62Hn/ozwwKCAG5V4c3Epb/4gg785CaSH9hSn7mwTaoT6gen9fIJFQlTkcKVIx
         9U9A==
X-Gm-Message-State: AAQBX9eR0O7zjPzIIyfdViK5jTktrSRJ/1x278OX0tGZPITcw259ZK4n
        eoL5i+jnbaPwfqwDZ54cnicJOMp+zztoUg==
X-Google-Smtp-Source: AKy350ZKl290x9Uv5XUDA4jbcsgDvbpvRrqTTEJs0QkosRLBLV3Bj5NjStNJthQd6VGt+sQ4vVGl0Q==
X-Received: by 2002:a05:6902:102c:b0:b8c:4e00:2136 with SMTP id x12-20020a056902102c00b00b8c4e002136mr8450910ybt.27.1681200540827;
        Tue, 11 Apr 2023 01:09:00 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id d191-20020a25e6c8000000b00b784b00772esm3503422ybh.50.2023.04.11.01.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:09:00 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54ee108142eso146195987b3.2;
        Tue, 11 Apr 2023 01:09:00 -0700 (PDT)
X-Received: by 2002:a81:e401:0:b0:54c:19a6:480 with SMTP id
 r1-20020a81e401000000b0054c19a60480mr7173247ywl.4.1681200539960; Tue, 11 Apr
 2023 01:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230406143019.6709-1-tzimmermann@suse.de> <20230406143019.6709-2-tzimmermann@suse.de>
In-Reply-To: <20230406143019.6709-2-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 10:08:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>
Message-ID: <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] fbdev: Prepare generic architecture helpers
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Thu, Apr 6, 2023 at 4:30 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Generic implementations of fb_pgprotect() and fb_is_primary_device()
> have been in the source code for a long time. Prepare the header file
> to make use of them.
>
> Improve the code by using an inline function for fb_pgprotect()
> and by removing include statements. The default mode set by
> fb_pgprotect() is now writecombine, which is what most platforms
> want.
>
> Symbols are protected by preprocessor guards. Architectures that
> provide a symbol need to define a preprocessor token of the same
> name and value. Otherwise the header file will provide a generic
> implementation. This pattern has been taken from <asm/io.h>.
>
> v2:
>         *  use writecombine mappings by default (Arnd)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/include/asm-generic/fb.h
> +++ b/include/asm-generic/fb.h
> @@ -1,13 +1,32 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
>  #ifndef __ASM_GENERIC_FB_H_
>  #define __ASM_GENERIC_FB_H_
> -#include <linux/fb.h>
>
> -#define fb_pgprotect(...) do {} while (0)
> +/*
> + * Only include this header file from your architecture's <asm/fb.h>.
> + */
> +
> +#include <asm/page.h>
> +
> +struct fb_info;
> +struct file;
> +
> +#ifndef fb_pgprotect
> +#define fb_pgprotect fb_pgprotect
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> +                               unsigned long off)

Does this affect any noMMU platforms that relied on fb_pgprotect()
doing nothing before?
Perhaps the body below should be protected by "#ifdef CONFIG_MMU"?

> +{
> +       vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);

Shouldn't this use the pgprot_val() wrapper?

> +}
> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
