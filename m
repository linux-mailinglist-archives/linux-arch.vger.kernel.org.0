Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FE65AE1B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 09:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjABI3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 03:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjABI3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 03:29:18 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D52111A;
        Mon,  2 Jan 2023 00:29:17 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id x11so21999960qtv.13;
        Mon, 02 Jan 2023 00:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zbtsyLDE+wPwkATs9/xlAjvp9QCBVfBrqTl0t3/H28=;
        b=zfVJfUjJxfNZFm+fOAIIQDoF1RPJiXlZlW5r2BTlyzO27voUQ1/MPbJNKpkgQZHYO6
         ncitw7pzRBRkH+7xZXhcuAdhUcoA1Yt//GUvpWoSth7622YCysgcJEFnP8uZIrnZ8WkB
         bIfHd49SB8mvX/npu9WpCbqWqjS+6g5UH1HiZhcSQgdlozlYX4bI5rpOQeUXTv+ab3Vm
         hawHhN3d4s0h9Nsoh2c1BbsiDMK+hi2Dbjz0tuK4mZOWKSX4JM5slFQqwLAs9w3G9Ls0
         TXT+jqRAoNulOGJousjyr7NWO7Si4V5jPvSO4ZJwn0gh+Q1zNepILDCldod8iDUt4Z1R
         zL5w==
X-Gm-Message-State: AFqh2kowEi0V7KhonuEmjBN822pb4/zLjbhXewOD8EPMI5cH4xYw5PoF
        tM536n18Pl7EYrhg9a9uctC54z4i5EnsnA==
X-Google-Smtp-Source: AMrXdXt5NNg88dVwyDDq9UVgnkvvrW5e4RSfkCI0CSHATZNQdL+Ckbog6yU9V7eC2vg3rUrjCTHTcA==
X-Received: by 2002:ac8:7389:0:b0:3a5:264c:5f38 with SMTP id t9-20020ac87389000000b003a5264c5f38mr64140324qtp.63.1672648155889;
        Mon, 02 Jan 2023 00:29:15 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id z18-20020ac875d2000000b003995f6513b9sm17131473qtq.95.2023.01.02.00.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:29:15 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 188so13214228ybi.9;
        Mon, 02 Jan 2023 00:29:14 -0800 (PST)
X-Received: by 2002:a25:aae1:0:b0:6fc:1c96:c9fe with SMTP id
 t88-20020a25aae1000000b006fc1c96c9femr5228868ybi.36.1672648154519; Mon, 02
 Jan 2023 00:29:14 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
 <b2144334261246aa8dc5004c5f1a58c9@AcuMS.aculab.com> <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
 <357cbd67260040e4bcf17d519aaafdcb@AcuMS.aculab.com>
In-Reply-To: <357cbd67260040e4bcf17d519aaafdcb@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jan 2023 09:29:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWP2GoBU8nwwDP2m_SUxV2sD67nTPyKjQ0Skjc7q7bcNw@mail.gmail.com>
Message-ID: <CAMuHMdWP2GoBU8nwwDP2m_SUxV2sD67nTPyKjQ0Skjc7q7bcNw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     David Laight <David.Laight@aculab.com>
Cc:     Holger Lubitz <holger.lubitz@t-online.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi David,

On Fri, Dec 30, 2022 at 12:39 PM David Laight <David.Laight@aculab.com> wrote:
> Thinking further the fastest strcmp() probably uses big-endian word compares
> with a check for a zero byte.
> Especially on 64 bit systems that support misaligned loads.
> But I'd need to think hard about the actual details.

arch/arc/lib/strcmp-archs.S
arch/csky/abiv2/strcmp.S

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
