Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D160B6FE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJXTPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiJXTOZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 15:14:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C3A7CE15
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 10:52:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a5so6542880qkl.6
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQzpFZcP8Coy3MtkwLvplRdsueJt1u6B3qt5xoqDDG0=;
        b=DC/JXvGYxRCs4XEoLBmqW0D0Vz2KsH2C3DgLHL1fXNfSPBwBNLhBvG1aiiz7Uuj8I5
         WmXcMVYsgZ0vNojncjGyGTEg7WfCECT/PHBTwyfOAa1wN5JjymQANnwgpOuOnPLj5cBC
         azfIciBEYryDpqGxNAu6DhUj9whA1Y6gO1Ggc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQzpFZcP8Coy3MtkwLvplRdsueJt1u6B3qt5xoqDDG0=;
        b=dsA2Aifzr3KKPFFTUVidcowBUL2QrGhEv7xDEus9vqk+r/WSfQkniRtOk8grrgQoEE
         UeuVUcgOhNB/wwDI0IGIeQwizPZ/5H3CcpFVXT2J8jfCOfT3iwNh8gJ01P77BwRfoEiq
         AtuvlTRm9T0F0ECoGdDlirwMnLsis6p9mVGq4BvxtjKE/K5g2m3jz1OLwfag027S9pd7
         Dv1kKFCIjVJnkIuQIP3lFUQ2xkjFlUKtwF9PlNlPEiPvVXUiiMWk+1ncf0f2WQAJkJM4
         +8MAVgtooWcACCQqY+LNtRcaM3AJuvmqWDMdTQfMrlSjIKjVqLl2wD9CTSVuUhnJTV5c
         zdhA==
X-Gm-Message-State: ACrzQf0sVubJo8yW0BOiJl0d8ePi2KodSwoPzQAf4F0qxhOuPrQc3/Nh
        OIcB46sGTJzDB4UbfGnyrU/uqIA3gScXNw==
X-Google-Smtp-Source: AMsMyM5QYEhOvzouTJcsbpWeYWPjWX/EPyZSrjAWpak3iruR+6u2uaZW4BGZi2KloIBu6no9mq2aew==
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id d1-20020ac85ac1000000b0039a123c9df5mr27512528qtd.27.1666631472282;
        Mon, 24 Oct 2022 10:11:12 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm321857qko.53.2022.10.24.10.11.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:11:10 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-36cbcda2157so34077827b3.11
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 10:11:09 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr30065031ywl.112.1666631469533; Mon, 24
 Oct 2022 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <Y1ZZyP4ZRBIbv+Kg@kili> <Y1ZbI4IzAOaNwhoD@kadam> <Y1a+cHkFt54gJv54@zx2c4.com>
In-Reply-To: <Y1a+cHkFt54gJv54@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 10:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
Message-ID: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 9:34 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Give these a minute to hit Lore, but patches just submitted to various
> maintainers as fixes (for 6.1), since these are already broken on some
> architecture.

Hold up a minute.

Some of those may need more thought. For example, that first one:

> https://lore.kernel.org/all/20221024163005.536097-1-Jason@zx2c4.com

looks just *strange*. As far as I can tell, no other wireless drivers
do any sign checks at all.

Now, I didn't really look around a lot, but looking at a few other
SIOCSIWESSID users, most don't even seem to treat it as a string at
all, but as just a byte dump (so memcpy() instead of strncpy())

As far as I know, there are no actual rules for SSID character sets,
and while using utf-8 or something else might cause interoperability
problems, this driver seems to be just confused. If you want to check
for "printable characters", that check is still wrong.

So I don't think this is a "assume char is signed" issue. I think this
is a "driver is confused" issue.

IOW, I don't think these are 6.1 material as some kind of obvious
fixes, at least not without driver author acks.

                Linus
