Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48B60E703
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiJZSLZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiJZSLT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 14:11:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128B83F2B
        for <linux-arch@vger.kernel.org>; Wed, 26 Oct 2022 11:11:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b25so11214712qkk.7
        for <linux-arch@vger.kernel.org>; Wed, 26 Oct 2022 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ITulc6XgqsqjNhbd41aCpior1CUyIgJHMI2V6YZSYqc=;
        b=euOzt4OtQ6r2FoqktgoiitkA8qilHqWaety7Buy4Wc/kLai3+4S/yKJ+b8cr/78vie
         65EAmm5Nk2Ou8O4UkVxUCQrdIYy4Jt0zqWrXA2jzp/FrxwIK4YXMEVDcaQQgF11XbHVL
         dUvryBX9A+1fa9gOcaAoRkiAkEUCX4yINBJmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITulc6XgqsqjNhbd41aCpior1CUyIgJHMI2V6YZSYqc=;
        b=v8srSXW9f7AEz+4vdXOzVLarK0YuPIaaP6NdbC2tt5Sx87Np9qm6TSafAR0ilT/oUO
         mTDws1fT9joDpUaxkdolnrvfq+B4pvNXz7Hot/6z1jAJFDC3tbOj061C14IhEz+8j5eh
         34x36Wtfozec6X8RxBDNneTNO+8hg5Lvt4EO+qHHSbzp+Ke4Ks6WtmqZIN9jR0khtbfR
         KI6IdzztcS9sW51MrLg6/z905HUv3LkszXzsr+OMMlzG5oQst1TPgalOy6YtyEnH4qBq
         q6ElhoAR43YoaLV6mkKMqOCShx2KGZ2ggpjkDvz4esAIyh3g93VznzyYV4sXen5mdjvu
         vMaw==
X-Gm-Message-State: ACrzQf1n/Fd85CSvx6st/7BF325POfzTE612B9WEBpo9umuGUGEBwuod
        hUTKFBDcwn+L2xh1P6Y9B1cFKasf7dCsaQ==
X-Google-Smtp-Source: AMsMyM7azato/67NhiVOxi5NJSb0r9a0Rgp3GBcnAS+Ns6LBG9TM/MmaRWNzwLDCUE20B1cDnLx6Ew==
X-Received: by 2002:a05:620a:40a:b0:6ed:2700:e080 with SMTP id 10-20020a05620a040a00b006ed2700e080mr31065111qkp.649.1666807875223;
        Wed, 26 Oct 2022 11:11:15 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id b13-20020ac86bcd000000b0039cbbcc7da8sm3523292qtt.7.2022.10.26.11.11.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:11:14 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 187so10918928ybe.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Oct 2022 11:11:14 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr3573582ybq.362.1666807873800; Wed, 26
 Oct 2022 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
 <3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk>
In-Reply-To: <3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Oct 2022 11:10:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9RNhvDyanUQnxa_xnir70TUiMgjhVhRWUuF5Ojj96Dw@mail.gmail.com>
Message-ID: <CAHk-=wg9RNhvDyanUQnxa_xnir70TUiMgjhVhRWUuF5Ojj96Dw@mail.gmail.com>
Subject: Re: make ctype ascii only? (was [PATCH] kbuild: treat char as always signed)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 25, 2022 at 5:10 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Only very tangentially related (because it has to do with chars...): Can
> we switch our ctype to be ASCII only, just as it was back in the good'ol
> mid 90s

Those US-ASCII days weren't really very "good" old days, but I forget
why we did this (it's attributed to me, but that's from the
pre-BK/pre-git days before we actually tracked things all that well,
so..)

Anyway, I think anybody using ctype.h on 8-bit chars gets what they
deserve, and I think Latin1 (or something close to it) is better than
US-ASCII, in that it's at least the same as Unicode in the low 8
chars.

So no, I'm disinclined to go back in time to what I think is an even
worse situation. Latin1 isn't great, but it sure beats US-ASCII. And
if you really want just US-ASII, then don't use the high bit, and make
your disgusting 7-bit code be *explicitly* 7-bit.

Now, if there are errors in that table wrt Latin1 / "first 256
codepoints of Unicode" too, then we can fix those.

Not that anybody has apparently cared since 2.0.1 was released back in
July of 1996 (btw, it's sad how none of the old linux git archive
creations seem to have tried to import the dates, so you have to look
those up separately)

And if nobody has cared since 1996, I don't really think it matters.

But fundamentally, I think anybody calling US-ASCII "good" is either
very very very confused, or is comparing it to EBCDIC.

                 Linus
