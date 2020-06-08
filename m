Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C428F1F1F31
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgFHSoc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFHSoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 14:44:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500AC08C5C2;
        Mon,  8 Jun 2020 11:44:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so10856668lfg.9;
        Mon, 08 Jun 2020 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyL9AG+EFCBzwXFwLDd8EbAbgZhHaqJwjdz7TgHOiYw=;
        b=mL+GNA2FG4HsXvVnkoxTb434Y31Detzb31ZKCm4kR2pgFjmdv+nPZF0Gn1cITJs8OZ
         n3a9HF4U80TzRPfJ24C/HyWubtl5UxuJ7xWijJMABqaf09jQNu392TXmiYaWIb1AZCDT
         dban/QRWM4802ANFK4wPRycuZ3ga7WPUTsEdX+tIZXAB9pFefmspQ4xuMCoD7uudQu7E
         bJ+0VtwTxmWVvJK/KMhhw4w7Qk8D7ZUwGd71EyhG/9o4A5CFlH5zruanv1xgjmWqK5GQ
         btON9cG8TyuB5pUpeMvBgW7IWZlrsN6LWRytgy8j7+f2vU1Myi54ytGnb40KKBA4YqhY
         rMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyL9AG+EFCBzwXFwLDd8EbAbgZhHaqJwjdz7TgHOiYw=;
        b=KyXdjUwXvHCZHMn+ksI3KVAyOieYe07yGLiBSsxzmhPn9noSY3qMa5DqKMPg8Va6wM
         iYIU+2ge1puNqlDpEQxlhzPI4DsKRvN3FZGzRWBW5qyrmjmrZZ1s2rdpVdObk1H+PKg+
         o4/fDWIWV9ZIHu2Rq59tflOBhnuRnQa7NcWqZBnF2zlaVJSRH2IyV3c48eyu7nC4xfKF
         Xy2DedMLdyIrD+fqk2kwMg673du8ZH4LEULJ4rkSsn38nB75/Wa7jGACru/uQlmLuvAI
         seoTlUYJtSB5p5HLLrRI2TXPEZ+cVfseH6QRSY09eRCPCKoa5JSnvQzkZ/py3sIbTAAa
         0uNQ==
X-Gm-Message-State: AOAM533Xho8XV/kM8PIMJdVRGYG5J33evUzpLctv3OaTqReuZY/+PkXK
        A12MUZbFDsum7fKP9P88MzrnJqZ7C2Y=
X-Google-Smtp-Source: ABdhPJxPZTBUgw8IjTEOAqpsENgOgvgi5A4vpLqMkcNAoipP9+5qKn2/LrcZDOZ3LFXtxbdR1Eoc1A==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr13474983lfa.20.1591641870507;
        Mon, 08 Jun 2020 11:44:30 -0700 (PDT)
Received: from rikard (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id o4sm4532793lfb.75.2020.06.08.11.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:44:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 8 Jun 2020 20:44:26 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Message-ID: <20200608184426.GB899@rikard>
References: <20200604233003.GA102768@rikard>
 <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
 <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 08, 2020 at 11:08:04AM +0300, Andy Shevchenko wrote:
> On Sun, Jun 7, 2020 at 11:34 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > Add tests of GENMASK and GENMASK_ULL.
> >
> > A few test cases that should fail compilation are provided under ifdef.
> >
> 
> Thank you very much!
> 
> > * New patch. First time I wrote a KUnittest so may be room for
> >   improvements...
> 
> Have you considered to unify them with existing test_bitops.h?

test_bitops.c seems to be tests for macros/functions in bitops.h, so I
figured it would make more sense to add tests of bits.h in test_bits.c.
But I don't have a strong opinion about it. If you prefer, I'll move
them to test_bitops.c.

Rikard
> 
> -- 
> With Best Regards,
> Andy Shevchenko
