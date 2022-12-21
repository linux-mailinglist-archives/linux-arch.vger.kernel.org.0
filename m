Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA5653680
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiLUSq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiLUSq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 13:46:28 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBCEF000
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 10:46:28 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h26so10542429qtu.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0sODeRBjvPETeUrYPz7JbnedMQB/IxCocAx1FoaszTU=;
        b=Wy0Sz3Rojhc+tOVGf8KvjRmRjEZJqCHd1i96YwhlFe4AQJBhrynZfO6wMunqOJzcXp
         OtAxmPiWamNa669nglrJtYL1LY751fImTMMRlSeC3y0bx2EEI6E+E52yb1KBO5mdAHbC
         maEreRZaysRS4E6MKmemJDVUZ/OrXE9mHf/EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sODeRBjvPETeUrYPz7JbnedMQB/IxCocAx1FoaszTU=;
        b=6etUpO49UC7TiZg9ksBBodR0oKh5yQH070cPtE2yjAZEcj/VPY3qfRKpTkunUvgAJ/
         64WdJdQVB98ph+kCIw+LEk95771fckkmS0yjGBtDdURYOJ6P4EGi/Sigqf+pGVzhhdhA
         8HX+ZaR57gy+O/w/x8KXkoHy8lRGCRY0G6//OjlVn5uJday28UjKen5na7ZyM11DQQMX
         XnAPHDaHQ+J0l1Cvrah0JugGJMYaWDyVf7NJKhifE3sDu7DuWKs9JRB4CCp73FAWvf6p
         DB6zc9omL0d3Vwcp0uUIp3rWoXcKrDN+qGOTm4HuiG1AHaiC5hh7Dh9cfJftac7QFCBF
         V+Mw==
X-Gm-Message-State: AFqh2koz7zt5jZBeUmu8jBwd7kP0laDZ6XbCx4nyVEED1Jq6GzfLq6qJ
        HffxxsN9NQu0BmhbQW9fM037MJO2yb1EZvbu
X-Google-Smtp-Source: AMrXdXt/jh430Bc+FXqt8t4/csTmmrN64V9/agU1zlXqzfB7dEuh7MYPRQRQzeyog38DetQAHgkpsg==
X-Received: by 2002:ac8:4b4e:0:b0:3a9:6cff:e1a6 with SMTP id e14-20020ac84b4e000000b003a96cffe1a6mr3398688qts.0.1671648387016;
        Wed, 21 Dec 2022 10:46:27 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006fc2b672950sm11226613qko.37.2022.12.21.10.46.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:46:25 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id a16so14357353qtw.10
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 10:46:24 -0800 (PST)
X-Received: by 2002:ac8:4e26:0:b0:3a7:648d:23d4 with SMTP id
 d6-20020ac84e26000000b003a7648d23d4mr140158qtw.180.1671648384706; Wed, 21 Dec
 2022 10:46:24 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com> <20221221171922.GA2470607@roeck-us.net>
In-Reply-To: <20221221171922.GA2470607@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 10:46:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
Message-ID: <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 9:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Dec 21, 2022 at 09:06:41AM -0800, Linus Torvalds wrote:
> >
> > I think the real fix is to just remove that broken implementation
> > entirely, and rely on the generic one.
>
> Perfectly fine with me.

That got pushed out as commit 7c0846125358 ("m68k: remove broken
strcmp implementation") but it's obviously entirely untested. I don't
do m68k cross-compiles, much less boot tests.

Just FYI for everybody - I may have screwed something up for some very
non-obvious reason.

But it looked very obvious indeed, and I hate having buggy code that
is architecture-specific when we have generic code that isn't buggy.

                   Linus
