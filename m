Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6F605082
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJSTgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJSTgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 15:36:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A731BF86F
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:36:20 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h24so12048781qta.7
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJrk5u73GSSntjHDSFWZPm3W+d2NptLnsl4jnQ6aTBs=;
        b=dyDRWkQ5VqKw/n/QUOQkovOpnXZICQosgvfGHTMEB24PTjukMWkEQb6WiGZ3AaswEh
         VYAjmCHm81UDyKGwrRTK4pqVsKdfk4eywGlq59bCDPl2XFFHJiWrSIA1mEV0BH0Um7H8
         GojY9blG/jEQqPFxqq14doFT4faiTGwkuzpcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJrk5u73GSSntjHDSFWZPm3W+d2NptLnsl4jnQ6aTBs=;
        b=RNl1aOiK44b94s0ANLkHeHX/CgS/CocxlRWgaKjFmeNJFJS38Txqo3dZiJP976jJrh
         9RJc6ta2wYD4jeVpndE/ormmyZDpRiK+PYsHtZH32IELQC8f+3uJvENvOHHH5g0zNTz6
         xgdPTvU1Ei0bBEgiSZKHGs7TY4sMr9xr7XN2gmUa+Fn++IwAcQjJ5eJJCcYXq5Kycdf7
         vFKEPj9QCUuenHkFr17L6IG9xs7O/8KNI29oJ/qX+c7MLAJWlrouItjajYCDNaOilDUZ
         T6ZKwh5Tu973ZsntNBJR8Jxzi9w871pxiRbvOlEaQDa/i2Gy78iBEGcMe6/h23DBsaAO
         qXRg==
X-Gm-Message-State: ACrzQf35q6Q7mYPCijnxU4vKayUyc7y+W/AY4TvmFouvijhtv1qizQ2Z
        ohV6oKNmIYHXiVKGeCMKRsZZ8W50bNEdJg==
X-Google-Smtp-Source: AMsMyM4+g8KLPTsIFJ/rcRwyXa1ORW1hXUSeVt/yfMQOaNCN6O2dpUbbzlSP8JGLkythZ/gKWd0Qsg==
X-Received: by 2002:ac8:5994:0:b0:39d:9b6:69a2 with SMTP id e20-20020ac85994000000b0039d09b669a2mr411067qte.316.1666208179009;
        Wed, 19 Oct 2022 12:36:19 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05622a1c0800b00394fce5fa64sm4593433qtb.9.2022.10.19.12.36.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:36:17 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-35befab86a4so177985107b3.8
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:36:17 -0700 (PDT)
X-Received: by 2002:a81:1007:0:b0:357:45e3:304c with SMTP id
 7-20020a811007000000b0035745e3304cmr8223552ywq.340.1666208177358; Wed, 19 Oct
 2022 12:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
 <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
 <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com> <Y1BOtMpS5KtL4blg@smile.fi.intel.com>
In-Reply-To: <Y1BOtMpS5KtL4blg@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 12:36:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoH_rZiv84-53dGF5btC-1FPZc9nFJM=48NVAmR1p7Sw@mail.gmail.com>
Message-ID: <CAHk-=wgoH_rZiv84-53dGF5btC-1FPZc9nFJM=48NVAmR1p7Sw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Oct 19, 2022 at 12:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > We do have a couple of signed bitfields in the kernel, but they are
> > unusual enough that it's actually a good thing that sparse just made
> > people be explicit about it.
>
> At least drivers/media/usb/msi2500/msi2500.c:289 can be converted
> to use sign_extend32() I believe.

Heh. I didn't even look at that one - I did check that yeah, the MIPS
ones made sense (I say "ones", because while my grep pattern only
finds one, there are several others that have spacing that just made
my grep miss them).

You're right, that msi2500 use is a very odd use of bitfields for just
sign extension.

That's hilariously odd code, but not exactly wrong. And using "signed
int x:14" does make it very explicit that the bitfield wants that
sign.

And that code does actually have a fair number of comments to explain
each step, so I think it's all ok. Strange, but ok.

                  Linus
