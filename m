Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C73E8322
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 09:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfJ2IWa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 04:22:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33293 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfJ2IWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 04:22:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so12597747wro.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dc5k5cS+lEX1SYr8UJULwUVDCp6mopnMnZfWYmGBCQo=;
        b=A4gHFXApxerLrfS/58BvoK//1y1mARGLUGD1wXl13PVjUkYphztL0q3I9iFgWYQGSP
         zrEjaLHDqHIsSXVnDwW8dI4GZmEfCJOKudCdIPzQM1Nh4qb0xIbNAD/naX5+pVK+5ZEn
         ZXPjBDwmR6IOqN/inZwk3UH0Oxo/+KGG01hKggDCr/5OJeRlACGTwthTragNkLJVR9qW
         P6U4Y7tpOEeAd0WTdtbAh7gk2izzk+2OniLv0UhtkKnHilz5Dr/h4WMeOHHcWLu8okVB
         t8YoEOrcTUon7n2Yeb8VbwLXLy64SbWNSYyOYE8zsamK8Fh85H/tugKYuE7BDTW3e8A9
         H3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dc5k5cS+lEX1SYr8UJULwUVDCp6mopnMnZfWYmGBCQo=;
        b=qu4iEx+AJt3T/3tWEqqt8BHcJxgtMI15BEiwmx3dKK2PHldYTbABRBCQWeJ7I+pBL5
         6DDd3trVuF7nQTVUSWvPiCQRTS2/K6jcFWZBVe+zf35dd1uHIH9TgEA/Kr1QAoBSPw40
         cZ1ppkFElpugCAIZ6TD4uzc1N/jEhFIYHi6ehvUHJzvDlLfkOJF1+GcUUVYv38wdANbp
         HomaBlul206pOkOTiOjN6Y5noSjJnmmGQrOX84Bm2qhN0vbU1/FxhqP35MAQPlpx4x4m
         /+DO/Yx8+GX0UkUAgjDfroqGl6YK6dXViiMeKIASiq9H0A/hIXqdLwr3kKHS0Yb0TS0Y
         WS7A==
X-Gm-Message-State: APjAAAVle9o5/CTus4jp7rqvh+5b35yrhYGZboqIaBrVO099Rz0LI0Ts
        ObuLNcNblDsOjbeELeI0fclGtOBwTZv8XWnDlQmJq/xfT3HNZA==
X-Google-Smtp-Source: APXvYqwN10D6LbfAXatOlZBrdKFI55fFKfkyB9LhxhsiVOFM0KEsohYgu7zOVPU91eDRAYF9dPJl1fNLY1QpmxWEcrI=
X-Received: by 2002:adf:f685:: with SMTP id v5mr19497461wrp.246.1572337348180;
 Tue, 29 Oct 2019 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191028210559.8289-1-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 29 Oct 2019 09:22:16 +0100
Message-ID: <CAKv+Gu-mnyKK_0s7fF_8C0aq1ur+RoHscVwTfd31quEVqZhefw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Improvements for random.h/archrandom.h
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Oct 2019 at 22:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> During patch review for an addition of archrandom.h for arm64,
> it was suggeted that the arch_random_get_* functions should be
> marked __must_check.  Which does sound like a good idea, since
> the by-reference integer output may be uninitialized when the
> boolean result is false.
>
> In addition, I noticed a few other minor inconsistencies between
> the different architectures: x86 defines some functional macros
> outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.
>
>
> r~
>
>
> Richard Henderson (6):
>   random: Mark CONFIG_ARCH_RANDOM functions __must_check
>   x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
>   x86: Mark archrandom.h functions __must_check
>   powerpc: Use bool in archrandom.h
>   powerpc: Mark archrandom.h functions __must_check
>   s390x: Mark archrandom.h functions __must_check
>

Modulo the nit in reply to 1/6:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
>  arch/s390/include/asm/archrandom.h    |  8 ++++----
>  arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
>  include/linux/random.h                |  8 ++++----
>  4 files changed, 33 insertions(+), 31 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
