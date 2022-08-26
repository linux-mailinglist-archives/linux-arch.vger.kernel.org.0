Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F55A25B2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiHZKRY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbiHZKRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 06:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760D9AFE7;
        Fri, 26 Aug 2022 03:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0834E61495;
        Fri, 26 Aug 2022 10:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63525C433C1;
        Fri, 26 Aug 2022 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661509041;
        bh=p78Wg7gKlUmKu/uPYjSTRS7XNkVmblFGqs5RQx0zpIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rNzcIAHJOBUlkVmhw2qeW+WZZAWjpcvuuYdGBiqZ6Eb8RjDGgMr9EwefgIEod0sDT
         nqzTR+AJf/9rRHhz80R87DFa+abRS/v770JiWBGJebPlWNr9Ch3NmY9G730c6BZSvg
         a50UCxonxSirKurrjW2ls4lLGQXbuq47RstKyGeH/7ttj7zb4vS8xTfIt8NC+XbYoN
         ec28/QFiqMxByDSxyOPmXa5ytgjFQQY6lI/gT3dnc2NOtSVFRhgvGTKSxrUQ65F0FQ
         FSu5Q14mmbYHeSKV82nzu9PXV+9btHDpUpcJSjgh5Bu7oZUjB2EbQqKEmyRkGtP/ve
         H4sdSOAjZkrgw==
Received: by mail-wm1-f52.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3908740wms.0;
        Fri, 26 Aug 2022 03:17:21 -0700 (PDT)
X-Gm-Message-State: ACgBeo1TIBPqEbPnqR2SD200WlwlvdUEIEOtnSagGofgVxwEf4DEPyGl
        GSVeCVgjGa9R6q7gu6O7BhoJS96xEmw9M9ybljA=
X-Google-Smtp-Source: AA6agR6krOKB5v97QLI3e4zgvTAZismklQDu5htbhIUY+mV6hlO9PiurjuV0k4rUeaz32lFqxKb4+lyByEmp/VeM4VY=
X-Received: by 2002:a1c:3b55:0:b0:3a6:7b62:3901 with SMTP id
 i82-20020a1c3b55000000b003a67b623901mr4797379wma.113.1661509039643; Fri, 26
 Aug 2022 03:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu> <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
 <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
In-Reply-To: <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 Aug 2022 12:17:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
Message-ID: <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Aug 2022 at 20:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
> On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
> > > Well, I am not completely sure about that. See my cover letter, previous
> > > mechanism for symbol CRC was actually enforcing the section alignment to
> > > 4 bytes boundary as well.
>
> Yes, because else it may become 2-byte aligned on m68k.
>
> > > Also, I'm not sure it is forbidden for an architecture/compiler
> > > implementation to actually enforce a stronger alignment on u32, which in
> > > theory would not break anything.
> > >
> >
> > u32 is a Linux type, and Linux expects natural alignment (and padding).
>
> Is it? You probably mean its alignment should not be larger than
> 4 bytes? Less has been working since basically forever.
>

You are quite right. of course. And indeed, the issue here is padding
not alignment.


> > So if your toolchain/architecture violates this rule, I suggest you
> > typedef u32 to 'unsigned int __aligned(4)' explicitly. so that things
> > don't break in other places.
> >
> > However, even then, I am highly skeptical. This really seems like an
> > issue in your toolchain that could cause problems all over the place.
> >
> > > But in this precise case it does break something since it will cause
> > > "gaps" in the end result vmlinux binary segment. For this to work I
> > > think we really want to enforce a 4 bytes alignment on the section.
> >
> > You are addressing one of many potential issues that could be caused
> > by this, so I don't think this patch is a good idea tbh.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
