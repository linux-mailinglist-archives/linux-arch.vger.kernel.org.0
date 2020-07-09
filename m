Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78FC21A6B2
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGISNv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGISNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 14:13:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F8C08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 11:13:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so3455373ljn.8
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ4MFwKX0KeW+zmPJf6dh6Z4HEUniPj2BzYhpEhaY5c=;
        b=H4yZEP+ReHmnQ8pPy85R6Z5AGImyoEWgzVC2r2MdX2eTlEN06eDA4bs8kmZRPf8ir7
         nONwubENi3D4CIY0RGHiJrUqJ5uDrjE78F1DvfhsN5lZUpuci6eD15V+qTw0bDmuQk3U
         UFPBqV2teYZxvPtlwDGq03SOGObHpMBpQnzm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ4MFwKX0KeW+zmPJf6dh6Z4HEUniPj2BzYhpEhaY5c=;
        b=UmTfCUtx8jXWYxx8bl3cuuzrO73NzYBAaoIwxqrl7nndtY0obNfsbzf1PpyXLuOWNd
         s6NqX0haaQ6qYrw9tm8FvQBgjQHMPzoHqaX39KYfXmawlDG3Hqy+I5coRAU3Ucz9ACcW
         S/diVVrx/D4AslZuA5DJE3f4dKOwZkZjziVkwk29r1/gIhv8D5RRAWbI0UKyJkVPceDi
         qJP/SKHQGuceTeJ83kHZN9QV5Q2YR6FuDLBnHOcV3IA6DMNGc4lyewdM90nAIShFlnRH
         fKMQ6SR76MZRe+oP4mQRYFjEDVhaN2TTRRuMlCeMyUnEv2aUmAG2A2fTdh2OHTetaerF
         3drw==
X-Gm-Message-State: AOAM533KrFQrOgJZiA812XNx4a/MNERyfwVRdDmXlMtOJ5rSLTs1ojJM
        MuhHaC65zRWyWaLX1ww9aJMql1vfsbs=
X-Google-Smtp-Source: ABdhPJyWtu8Qk8WDsSPptM2tjtNPJWLjfCFYJNa/3Zr6euXnUTdYf/dDHMV5CapWSQKnUhaeXQ4mgw==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr29464332ljo.39.1594318429265;
        Thu, 09 Jul 2020 11:13:49 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b16sm1032215ljp.124.2020.07.09.11.13.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:13:48 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m26so1691983lfo.13
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 11:13:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr40988629lfq.125.1594318427258;
 Thu, 09 Jul 2020 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054210.14804-1-rikard.falkeborn@gmail.com> <20200709123011.GA18734@gondor.apana.org.au>
In-Reply-To: <20200709123011.GA18734@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:13:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
Message-ID: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 9, 2020 at 5:30 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I'm still getting the same warning even with the patch, for example:

Are you building with W=1?

There's a patch to move that broken -Wtype-limits thing to W=2.

    https://lore.kernel.org/lkml/20200708190756.16810-1-rikard.falkeborn@gmail.com/

does that work for you?

              Linus
