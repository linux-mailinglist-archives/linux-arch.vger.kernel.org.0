Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07196FDDDE
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjEJMfG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 10 May 2023 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjEJMet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 08:34:49 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A47EE6;
        Wed, 10 May 2023 05:34:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-559e2051d05so103544817b3.3;
        Wed, 10 May 2023 05:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722087; x=1686314087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGY/0htSfGIvsVgPn7bx+ykp3agguIOsAu0irnl44Xg=;
        b=b3fqZuX/o+l+JPHZU/oNUSUIQokf+iQ2h3VQEGv3wrlo+2YoF6yE+8nEDaj7BWOhnd
         cwTS69SgVDeoXoeZLP/jbDPVB+WNcBOU+WONdfvVcZXsyu12BwDxZwkGinMDzrYLzX4n
         NxshY0P63163cpZuhl1EgjowDnHhEQHxbQzsuA5AJy/k9eClGFPpRn9BHMoqLvbD54IL
         9nvcvALf4lKWFcLg5QExmogZZCDYmR+OWMJWLQr1NraLVdDS3suQGv4dlKqnVdGx5Ic2
         qBHxGYEU0t6NHbpqnH08RrwyMYuQ9mYYX/HPaFgOFQWVwDT5gqNDZ/jLozQf0Cox+Ald
         lTOA==
X-Gm-Message-State: AC+VfDxNs7/QlEEhfPMQYEq6TlXAz88Pa31bBT0oi5sGf5iI+xpRMfvV
        wvVZEsRqePzxl3RxtASaIrucPFmJoPnirA==
X-Google-Smtp-Source: ACHHUZ4IgCsZzVyln8keZ1hl6teCvscT6HCafQroCO5qDcfhcANm4gjeIOVoxSMTBZodjSK9mGXFJw==
X-Received: by 2002:a25:50c1:0:b0:ba1:b7e4:e0dd with SMTP id e184-20020a2550c1000000b00ba1b7e4e0ddmr18447949ybb.56.1683722087169;
        Wed, 10 May 2023 05:34:47 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id b2-20020a251b02000000b00b7767ca7485sm3742166ybb.34.2023.05.10.05.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:34:45 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-559de1d36a9so103567617b3.1;
        Wed, 10 May 2023 05:34:45 -0700 (PDT)
X-Received: by 2002:a0d:ead7:0:b0:55a:ae08:163f with SMTP id
 t206-20020a0dead7000000b0055aae08163fmr22367018ywe.32.1683722085095; Wed, 10
 May 2023 05:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230510110557.14343-1-tzimmermann@suse.de> <20230510110557.14343-6-tzimmermann@suse.de>
In-Reply-To: <20230510110557.14343-6-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 14:34:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
Message-ID: <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, suijingfeng@loongson.cn,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Wed, May 10, 2023 at 1:06 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Implement framebuffer I/O helpers, such as fb_read*() and fb_write*(),
> in the architecture's <asm/fb.h> header file or the generic one.
>
> The common case has been the use of regular I/O functions, such as
> __raw_readb() or memset_io(). A few architectures used plain system-
> memory reads and writes. Sparc used helpers for its SBus.
>
> The architectures that used special cases provide the same code in
> their __raw_*() I/O helpers. So the patch replaces this code with the
> __raw_*() functions and moves it to <asm-generic/fb.h> for all
> architectures.
>
> v6:
>         * fix fb_readq()/fb_writeq() on 64-bit mips (kernel test robot)
> v5:
>         * include <linux/io.h> in <asm-generic/fb>; fix s390 build
> v4:
>         * ia64, loongarch, sparc64: add fb_mem*() to arch headers
>           to keep current semantics (Arnd)
> v3:
>         * implement all architectures with generic helpers
>         * support reordering and native byte order (Geert, Arnd)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> add mips fb_q()

> --- a/arch/mips/include/asm/fb.h
> +++ b/arch/mips/include/asm/fb.h
> @@ -12,6 +12,28 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>  }
>  #define fb_pgprotect fb_pgprotect
>
> +/*
> + * MIPS doesn't define __raw_ I/O macros, so the helpers
> + * in <asm-generic/fb.h> don't generate fb_readq() and
> + * fb_write(). We have to provide them here.

MIPS does not include <asm-generic/io.h>,  nor define its own
__raw_readq() and __raw_writeq()...

> + *
> + * TODO: Convert MIPS to generic I/O. The helpers below can
> + *       then be removed.
> + */
> +#ifdef CONFIG_64BIT
> +static inline u64 fb_readq(const volatile void __iomem *addr)
> +{
> +       return __raw_readq(addr);

... so how can this call work?

> +}
> +#define fb_readq fb_readq
> +
> +static inline void fb_writeq(u64 b, volatile void __iomem *addr)
> +{
> +       __raw_writeq(b, addr);
> +}
> +#define fb_writeq fb_writeq
> +#endif
> +
>  #include <asm-generic/fb.h>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
