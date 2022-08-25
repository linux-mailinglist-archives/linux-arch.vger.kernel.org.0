Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68C5A183D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiHYSBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiHYSBt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 14:01:49 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FE6BCCC7;
        Thu, 25 Aug 2022 11:01:42 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id j17so15841906qtp.12;
        Thu, 25 Aug 2022 11:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sZF77EP0OB4ryxifh08aWFRo/juIX3VksGRtnaASBkw=;
        b=VC3V5l/VbXJj3CsOccYD4NTrv52sK/2di0K/jXbozxa86+KWRObP8JNe6LoI2YeEEb
         SXQ/pZ3Pc+WxHMBc0f5GY/tVaaca7ozh+FapSJcGquubjeXO5dL7x0YjkClFA2w3Mu04
         S8cxIAG4xw7m0hyhff8k8SRBncnm/ycP9p/TY4zw0trWg5hQnAUTsV+3JBibEjZ2zsWc
         b/hMGpnl0z2v91h/1B1QtlyOrKmiaDMV+D2jJHjRC9dnP1xGB1z6tqf3dtnKC7GN3VCq
         alTGdMS3fWsq8kuRWbARgdfgvGxbcuqehA0/QAPlDyGJp5I1M9jVo6RipiSvVq8cNdE0
         bFgA==
X-Gm-Message-State: ACgBeo1XLdVkQ4nGM7xDDEDgqDuMUVBlrsDhqDzbRynBFjPPaZifyf2R
        iKzFYDhGcw6OJqcxUrCo3Ouyc6axfoOh3Q==
X-Google-Smtp-Source: AA6agR6gxodp6Gp+BZARAet53tBPgjyhFMkt+C2EpkjwiG0nMkwuuH1gdBCN4eMlWw7/909nYkrpKQ==
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr4676889qtw.32.1661450501137;
        Thu, 25 Aug 2022 11:01:41 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id do14-20020a05620a2b0e00b006bb11f9a859sm58344qkb.122.2022.08.25.11.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 11:01:40 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-33dce2d4bc8so2343527b3.4;
        Thu, 25 Aug 2022 11:01:40 -0700 (PDT)
X-Received: by 2002:a81:658:0:b0:334:a23e:6caa with SMTP id
 85-20020a810658000000b00334a23e6caamr4785589ywg.283.1661450500481; Thu, 25
 Aug 2022 11:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu> <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
In-Reply-To: <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Aug 2022 20:01:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
Message-ID: <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ard,

On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
> > Well, I am not completely sure about that. See my cover letter, previous
> > mechanism for symbol CRC was actually enforcing the section alignment to
> > 4 bytes boundary as well.

Yes, because else it may become 2-byte aligned on m68k.

> > Also, I'm not sure it is forbidden for an architecture/compiler
> > implementation to actually enforce a stronger alignment on u32, which in
> > theory would not break anything.
> >
>
> u32 is a Linux type, and Linux expects natural alignment (and padding).

Is it? You probably mean its alignment should not be larger than
4 bytes? Less has been working since basically forever.

> So if your toolchain/architecture violates this rule, I suggest you
> typedef u32 to 'unsigned int __aligned(4)' explicitly. so that things
> don't break in other places.
>
> However, even then, I am highly skeptical. This really seems like an
> issue in your toolchain that could cause problems all over the place.
>
> > But in this precise case it does break something since it will cause
> > "gaps" in the end result vmlinux binary segment. For this to work I
> > think we really want to enforce a 4 bytes alignment on the section.
>
> You are addressing one of many potential issues that could be caused
> by this, so I don't think this patch is a good idea tbh.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
