Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788C65417F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiLVNFq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiLVNFn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 08:05:43 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479553AA;
        Thu, 22 Dec 2022 05:05:41 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-45ef306bd74so26219397b3.2;
        Thu, 22 Dec 2022 05:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLCFjw9XIBAbu93dkTI6RLAmkXvVW4axCY2krlbo1Ww=;
        b=AkgVq2KBYpb4dUz0BEny9VGKMx98sCEpomruDdErtQTfod0SDz1QtGYEm+OIDWZNIO
         vlQLLC1fLfHsGwkEMryIAhStNEw19kGCriTIwXdKo95+rHg27uqTDoD6QrDwgrjhAgBv
         5OeSsvpqWZOhT0hvQccLl9BV1fCCIImERWNC1N9nam8oaJUg1FQIZ6s63aMqMTkhZU9B
         Nhmoxqt6o1fxNucfYYoBZ3BShgbfc0DN6a0xFeFUrsGyLrsrvRdSYCDDHEsCTSl3p8Ev
         WPKEvWt8gavBdlzigJ0+ZZnAsFQc7zDLvD122e7t4/offEodIPmuNFBZ0mp9AtbYgERN
         cO6A==
X-Gm-Message-State: AFqh2kpLkKL29cnfwWmnCpz/b074K+GOwYpImBNnzYyFXgJZEq8laVWx
        Md3ffQKeQVsohYzvrIFmq39t0Ljs9iEWBQ==
X-Google-Smtp-Source: AMrXdXv+fd3oxdp37Kj0lM82VJ47EaSdU2higWi9k+R5qohKiq7HGGEAXGMRjmfGmAOqmoIqZFfDxg==
X-Received: by 2002:a05:7500:5c05:b0:ea:6682:469c with SMTP id fd5-20020a0575005c0500b000ea6682469cmr392958gab.12.1671714340243;
        Thu, 22 Dec 2022 05:05:40 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a095a00b006fc6529abaesm231627qkw.101.2022.12.22.05.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 05:05:39 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-45c11d1bfc8so25845717b3.9;
        Thu, 22 Dec 2022 05:05:39 -0800 (PST)
X-Received: by 2002:a05:690c:d84:b0:437:febc:6583 with SMTP id
 da4-20020a05690c0d8400b00437febc6583mr536308ywb.384.1671714339227; Thu, 22
 Dec 2022 05:05:39 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
 <20221221171922.GA2470607@roeck-us.net> <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
In-Reply-To: <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Dec 2022 14:05:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwNv-xzrsckMab_eAtZZ-ybDFPyxG9f9ndHBgXjLAayQ@mail.gmail.com>
Message-ID: <CAMuHMdWwNv-xzrsckMab_eAtZZ-ybDFPyxG9f9ndHBgXjLAayQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Wed, Dec 21, 2022 at 7:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 21, 2022 at 9:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Dec 21, 2022 at 09:06:41AM -0800, Linus Torvalds wrote:
> > > I think the real fix is to just remove that broken implementation
> > > entirely, and rely on the generic one.
> >
> > Perfectly fine with me.
>
> That got pushed out as commit 7c0846125358 ("m68k: remove broken
> strcmp implementation") but it's obviously entirely untested. I don't
> do m68k cross-compiles, much less boot tests.
>
> Just FYI for everybody - I may have screwed something up for some very
> non-obvious reason.
>
> But it looked very obvious indeed, and I hate having buggy code that
> is architecture-specific when we have generic code that isn't buggy.

Thank you for being proactive!
It works fine (and slightly reduced kernel size, too ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
