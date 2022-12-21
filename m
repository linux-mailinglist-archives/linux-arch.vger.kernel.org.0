Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D865348E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiLURHD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 12:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiLURHC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 12:07:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DC19000
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 09:07:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a16so14113575qtw.10
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 09:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYOKcpVH/CwZxAmDD07aAMcukw6jGJ7fZk2tWZQJ5Co=;
        b=EmYCuGZi1aBhi0+7PLOQjdb/1nrr3I38sgxXNpnj2Ob5gPWVW+wHeaOB0rT2rW9ia1
         2eC+kMDfVwn1Aw6vUx9l+Y+mROuW36ElXsnZxVtkTOtX3gWfd+EaTqrQgaKdEDoFyGkW
         RPvMC8bGtPA+mM+/6Yrg5RydYu4wMK+vVcANc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYOKcpVH/CwZxAmDD07aAMcukw6jGJ7fZk2tWZQJ5Co=;
        b=YQF3Lv0zhy+e99FAU0XTLbaqcGRin5WwUUi6a24osuQ6g9tiaAVhvpsnP74PznPo6O
         OLx4mJJcA961Jl5mXEEtPIMlsaH6LkNwfWJr5IX7qGwfAzuFE5hMa/zaOnysgUv9IpGO
         VBnw4ZJGdBH2SOBRHFVKrWy0HJrN6qTp4nlnoXED2yM9jHiBKCjVtLgCpJ/EOMYr+K0d
         /6wG6E51YjXAMDN5qOj+wp8swmbrKePNFJ6c8WaBhwCGNmteXitnueNX+7nc/lH93Bh4
         bZrfa9oi/hjy1LjaagIK3vFktuYo2xpHL/zKkpuJbjaL5qSpp5FdrBswtUKYGQ4F9BeC
         JuHg==
X-Gm-Message-State: AFqh2kp+dji2HF20/LLg08S2aEicM7IXouLT+OMmUmro2cNUFWvQE9rE
        OyuzSjRcnpMVoAdsFyDjY6gbSHAiG60Pw0tA
X-Google-Smtp-Source: AMrXdXs+wVpyRnMNJ9s2LgrYZ4P+zwFJxkpECfBuYLXdssuqPN3mrocm+iXPAvBuOTl5RbQpWwIpPg==
X-Received: by 2002:ac8:6999:0:b0:3a7:ee15:d94c with SMTP id o25-20020ac86999000000b003a7ee15d94cmr2671694qtq.47.1671642420815;
        Wed, 21 Dec 2022 09:07:00 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id w7-20020ac843c7000000b003a8163c1c96sm9310938qtn.14.2022.12.21.09.06.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:06:58 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id k3so7063937qki.13
        for <linux-arch@vger.kernel.org>; Wed, 21 Dec 2022 09:06:58 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr84873qkg.594.1671642417917; Wed, 21 Dec
 2022 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
In-Reply-To: <20221221155641.GB2468105@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 09:06:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
Message-ID: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 7:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The above assumes an unsigned char as input to strcmp(). I consider that
> a hypothetical problem because "comparing" strings with upper bits
> set doesn't really make sense in practice (How does one compare G=C3=BCnt=
er
> against Gunter ? And how about G=C7=96nter ?). On the other side, the pro=
blem
> observed here is real and immediate.

POSIX does actually specify "G=C3=BCnter" vs "Gunter".

The way strcmp is supposed to work is to return the sign of the
difference between the byte values ("unsigned char").

But that sign has to be computed in 'int', not in 'signed char'.

So yes, the m68k implementation is broken regardless, but with a
signed char it just happened to work for the US-ASCII case that the
crypto case tested.

I think the real fix is to just remove that broken implementation
entirely, and rely on the generic one.

I'll commit that, and see what happens.

               Linus
