Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D980E6FF1A6
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjEKMgK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 11 May 2023 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEKMgJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 08:36:09 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9449D5;
        Thu, 11 May 2023 05:36:05 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-55cc8aadc97so129620217b3.3;
        Thu, 11 May 2023 05:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808565; x=1686400565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bccEgTIv+NuBZ7b0m7HvDAcmdwRNosK16KRrDt/LqxI=;
        b=ETTJ+OiTtXJfHU0H8zC9XYPptrR7SbfSaCKz3kAUdAwmrQm8YSSCbpS7KzGjWWsYdM
         3zru8cLnV+48wFCJeUwuab1iDoMFhxzfSYkYCS2AstM9wP2MAY3NZMTWvfKgchOnib+1
         XbLYIaBx3p7D6z9o0NHMg0Rx2sPjd+kYgvuc8dHE0qAubjRJ7DNygagAlUN0kb9pm9qn
         rc9bxiaSQZ0njl6UsKny9SwDdnx4yaSC4OMLYro+TizRTlch2HDaw7gK7WwU8Kcaxf4w
         d4BHyepOnb5vudwGKfIVn+QbHJ6U6lC5NVs01FH+0GnPzQU1DkUOcIGHv9dN7OB9MnIk
         Qh+w==
X-Gm-Message-State: AC+VfDxPILetLcOxejK4w/ufFYCZumLYVDRuIswMmc4Q6EtZm1dF8gGc
        12K7dZEwm4rt8Jca/Z0P1v83kaWebqPalg==
X-Google-Smtp-Source: ACHHUZ6pDnDg+GTvqUUHABK5MSiTEEvVuUUgAUmhfkGQ8dFPPL1kgFPZ7FI+zNw5uuikafb7Gvgctg==
X-Received: by 2002:a0d:ffc7:0:b0:560:bb81:6e8 with SMTP id p190-20020a0dffc7000000b00560bb8106e8mr8302214ywf.51.1683808564725;
        Thu, 11 May 2023 05:36:04 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w78-20020a0dd451000000b0055a92559260sm4916023ywd.34.2023.05.11.05.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 05:36:04 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-55a26b46003so129629487b3.1;
        Thu, 11 May 2023 05:36:03 -0700 (PDT)
X-Received: by 2002:a81:8a05:0:b0:556:1b32:343b with SMTP id
 a5-20020a818a05000000b005561b32343bmr19413336ywg.45.1683808563363; Thu, 11
 May 2023 05:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230510110557.14343-6-tzimmermann@suse.de> <202305102136.eMjTSPwH-lkp@intel.com>
 <f6b2d541-d235-4e98-afcc-9137fb8afa35@app.fastmail.com> <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
 <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
In-Reply-To: <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 14:35:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
Message-ID: <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vineet Gupta <vgupta@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Sam Ravnborg <sam@ravnborg.org>, suijingfeng@loongson.cn,
        oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Rojek <contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

CC Artur, who's working on HP Jornada 680.

On Wed, May 10, 2023 at 5:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 10, 2023, at 16:27, Thomas Zimmermann wrote:
> > Am 10.05.23 um 16:15 schrieb Arnd Bergmann:
> >> On Wed, May 10, 2023, at 16:03, kernel test robot wrote:
>
> >> I think that's a preexisting bug and I have no idea what the
> >> correct solution is. Looking for HD64461 shows it being used
> >> both with inw/outw and readw/writew, so there is no way to have
> >> the correct type. The sh __raw_readw() definition hides this bug,
> >> but that is a problem with arch/sh and it probably hides others
> >> as well.
> >
> > The constant HD64461_IOBASE is defined as integer at
> >
> >
> > https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/hd64461.h#L17
> >
> > but fb_readw() expects a volatile-void pointer. I guess we could add a
> > cast somewhere to silence the problem. In the current upstream code,
> > that appears to be done by sh's __raw_readw() internally:
> >
> >
> > https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L35
>
> Sure, that would make it build again, but that still doesn't make the
> code correct, since it's completely unclear what base address the
> HD64461_IOBASE is relative to. The hp6xx platform code only passes it
> through inw()/outw(), which take an offset relative to sh_io_port_base,
> but that is not initialized on hp6xx. I tried to find in the history
> when it broke, apparently that was in 2007 commit 34a780a0afeb ("sh:
> hp6xx pata_platform support."), which removed the custom inw/outw
> implementations.

See also commit 4aafae27d0ce73f8 ("sh: hd64461 tidying."), which
claims they are no longer needed.

Don't the I/O port macros just treat the port as an absolute base address
when sh_io_port_base isn't set?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
