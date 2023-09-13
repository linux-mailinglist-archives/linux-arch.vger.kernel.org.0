Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91D79E19E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjIMIKm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 13 Sep 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbjIMIKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:10:05 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6424719B4;
        Wed, 13 Sep 2023 01:09:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bbdb435bfso6342307b3.3;
        Wed, 13 Sep 2023 01:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592563; x=1695197363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCz1YqPLlml0me4QSAkCQsY8FV1Cudx91zoZbXBVMOA=;
        b=BeElRkB1CATd6mKPq8RoLrRadz6xAOfpPbZUjhJx+t+OvoODubPyT7xtzMrwXDquuY
         EqM72LdAfemAyocjOLzauU4WeD8Spk644nCSFWeNKHEiW7FVf9qtjOBaqF7usX/H4WI3
         tmzY/jGNLEiQUYUALASJTJLMyplXy/5Ge5xVaAw4KBnFT5m3bHgqq/GjDDqE/vbKzNNn
         5GLnEvJwr0xHD1ppdAUB8qf4XVrLc3D0si/ZDyW6FPUEhVzTT3I8fphWghju6iilZPCx
         2r+tgYB+ejvBNyWyRzJ3ZVAeRbQ1pFnW9dpA3Gu9qRqMFIeCN4Zt0BnzHARSaStb6fvn
         Gzsg==
X-Gm-Message-State: AOJu0YxG8mRZKy37YSJj0nLTpWUyDTO6VVKoS5hsMkge7rShJbwbq35i
        ZarEv/7cEPaLP/8Aeztlt6hFPj+JFd8YgA==
X-Google-Smtp-Source: AGHT+IFO+rvt4ojVBQ2tebVg0XDEybdj1FyTPO36buG4UjXjdMhv6eYEqWKAgfV6plEnsus/Iyw4yg==
X-Received: by 2002:a81:6c04:0:b0:594:e4d1:bd7e with SMTP id h4-20020a816c04000000b00594e4d1bd7emr1644354ywc.5.1694592563414;
        Wed, 13 Sep 2023 01:09:23 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x83-20020a0dd556000000b0058c4e33b2d6sm3002279ywd.90.2023.09.13.01.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:09:22 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7d50ba994eso5677604276.1;
        Wed, 13 Sep 2023 01:09:22 -0700 (PDT)
X-Received: by 2002:a25:9844:0:b0:d81:4e98:4f5c with SMTP id
 k4-20020a259844000000b00d814e984f5cmr1178332ybo.47.1694592562230; Wed, 13 Sep
 2023 01:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912135050.17155-1-tzimmermann@suse.de> <20230912135050.17155-3-tzimmermann@suse.de>
In-Reply-To: <20230912135050.17155-3-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 10:09:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU66MLdWM9Qjk-2qmHUZA6F8L-W1iAoc73-HvSB1n-drg@mail.gmail.com>
Message-ID: <CAMuHMdU66MLdWM9Qjk-2qmHUZA6F8L-W1iAoc73-HvSB1n-drg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] fbdev: Replace fb_pgprotect() with pgprot_framebuffer()
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de, linuxppc-dev@lists.ozlabs.org,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Tue, Sep 12, 2023 at 5:32 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Rename the fbdev mmap helper fb_pgprotect() to pgprot_framebuffer(
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory.
>
> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset
> in the underlying device memory rsp file. Return the new page-access
> flags. These changes align pgprot_framebuffer() with other pgprot_()
> functions.
>
> v4:
>         * fix commit message (Christophe)
> v3:
>         * rename fb_pgprotect() to pgprot_framebuffer() (Arnd)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

>  arch/m68k/include/asm/fb.h           | 19 ++++++++++---------

Looks like you forgot to apply my
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
given on v1.

I didn't notice before, as I never received v2 and v3 due to the
gmail/vger email issues.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
