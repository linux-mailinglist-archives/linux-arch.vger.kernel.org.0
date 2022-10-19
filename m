Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB5605072
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJSTbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiJSTbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 15:31:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86F16C222
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:31:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r19so12374094qtx.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SfmIq/KsseXkXGtgL/kNTADzR8nUzxj3FoT5DEC/Nzo=;
        b=X0bTSQDVigCsGSNgiew3B/3pbsp2ciGVZzYaoUwX27U3MUaI1cRc3mpMYk36lod3le
         PZeYdP/7vmxRFYoWQgPrD48IT8dIrD0IZA3+6io9VnGCbLbD1BneL65qRDHRGninF1si
         o+6Qmn1KAsm4NEKuh2u1NvPTsyG+1+K5JKoxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfmIq/KsseXkXGtgL/kNTADzR8nUzxj3FoT5DEC/Nzo=;
        b=19V8jUI7e3BEampFVFvagUAGSkndHJfi3GNEVbD4u5jp4Dv0lrwiIMo2lCERjR6YSc
         AsbJZgvY+eHGXdPdSj3nMBRjzzcYrz4I7KBfCqNGWwYR3YiH23mjh2UHpA1iW4k1ZIfa
         nPprfCLEaEosrnWojQgPRDLfNtKW08MFNGovaWRf/KuT9iEL/uifOB7iCFqSjx5Vcp5p
         ahCDJBjT4deAXolmw6SrH6DClB6YYSu9oyfmhCvO+rZSHD1LCyV0qzVj1QyvcUt+4BJX
         3sdgRj1ysYvtVmb5vITrw4RHMh9wNk/X7N+h72ty1NzzYnZO2jdtp/UbScVF1vacz9lb
         KctA==
X-Gm-Message-State: ACrzQf0vHKVNwv82RXnVm3a4zPpGkVaUyKNm5X/NvgGSarLcg11CODGq
        Y3e0VjiYztb2F7qNMZ1l/edWRdjrAOeefg==
X-Google-Smtp-Source: AMsMyM4PTsAyYQhxyyJkkyi7xVHdZwO/LfBUa8+uRpVCj801tVqUQkarA159lKO+XdE8ebD425+AvA==
X-Received: by 2002:a05:622a:34e:b0:39c:8965:549 with SMTP id r14-20020a05622a034e00b0039c89650549mr8138923qtw.268.1666207878416;
        Wed, 19 Oct 2022 12:31:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a448c00b006ec5238eb97sm5541703qkp.83.2022.10.19.12.31.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:31:16 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j130so1802504ybj.9
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:31:16 -0700 (PDT)
X-Received: by 2002:a05:6902:1147:b0:6c3:ff50:565e with SMTP id
 p7-20020a056902114700b006c3ff50565emr7551417ybu.362.1666207876006; Wed, 19
 Oct 2022 12:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
 <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com> <202210191209.919149F4@keescook>
In-Reply-To: <202210191209.919149F4@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 12:30:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com>
Message-ID: <CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
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

On Wed, Oct 19, 2022 at 12:11 PM Kees Cook <keescook@chromium.org> wrote:
> Yeah, I've had to fight these casts in fortify-string.h from time to
> time. I'd love to see the patch you used -- I bet it would keep future
> problems at bay.

Heh. The fortify-source patch was just literally

  -       unsigned char *__p = (unsigned char *)(p);              \
  +       char *__p = (char *)(p);                                \

in __compiletime_strlen(), just to make the later

        __ret = __builtin_strlen(__p);

happy.

I didn't see any reason that code was using 'unsigned char *', but I
didn't look very closely.

But honestly, while fixing that was just a local thing, a lot of other
cases most definitely weren't.

The crypto code uses 'unsigned char *' a lot - which makes a lot of
sense, since the crypto code really does work basically with a "byte
array", and 'unsigned char *' tends to really be a good way to do
that.

But then a lot of the *users* of the crypto code may have other ideas,
ie they may have strings as the source, where 'char *' is a lot more
natural.

And as mentioned, some of it really is just fairly fundamental
compiler confusion. The fact that you can't use a regular string
literals with 'unsigned char' is just crazy. There's no *advantage* to
that, it's literally just an annoyance.

(And yes, there's u"hello word", but and yes, that's actually
"unsigned char" compatible as of C23, but not because the 'u' is
'unsigned', but because the 'u' stands for 'utf8', and it seems that
the C standard people finally decided that 'unsigned char[]' was the
right type for UTF8. But in C11, it's actually still just 'char *',
and I think that you get that completely broken sign warning unless
you do an explicit cast).

No sane person should think that any of this is reasonable, and C23
actually makes things *WORSE* - not because C23 made the right choice,
but because it just makes the whole signedness even messier.

IOW, signedness is C is such a mess that -Wpointer-sign is actively
detrimental as things are right now. And look above - it's not even
getting better, it's just getting even more confusing and odd.

              Linus
