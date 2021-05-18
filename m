Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC2387BBD
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhERO5y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbhERO5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 10:57:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4FEC06175F
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 07:56:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v5so11917479ljg.12
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GIgWhqGcodNJt+bhmadIRku1GYGWA9BQY8QV+rt7Hg=;
        b=SN/bhWDUJ2SkBrO/ViOth1isjAPZnYWzCwPZ44mO97QnaN+zuhO5YuiWSqpMCEBe32
         eEnYvdyPJ4sVC4dfBW20qujRJ8QsR0Q+Ir7WBgaSE9L/1h6IgNSaa8lgmghnrhMEDf46
         1m6lR628LVmKdGAvvXtGWXQWZawohBG0sHO9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GIgWhqGcodNJt+bhmadIRku1GYGWA9BQY8QV+rt7Hg=;
        b=YW6O6ogyKyi+XPQ+57pLBSz8OGN+AVA7xRl1YzyLre5mq3zA4X29HG44qA3jO3Tuon
         OKzZPhWkyf2T7fllDfzGeOdcgYA51CY8YSyymSEWliuYpWZj730+JYX3uAOFNkZsRFYA
         YqIjl3zCmfwBDjTTdgkVNFfnRJhG1MMbKDl74/Q61ifIn/2mHMeLOEhb9FJunSYTIOFw
         rHSvu5OLZqAIrXSP8+jY3okve6fR0q9RHwmn1G9+zRgaIvcEqlnoBCqF8ZnHXhnL2i9I
         pmpmHrbyHTje4tnvzWxC1J1GCBi2eLXgWVx1psaHNgw9XPuaZtU2wH9CKBeP9nHOJf62
         E4Lg==
X-Gm-Message-State: AOAM533hczaF7Zl3l9OJQ8UxouRtgyzsAp8LMKmHL0rIORBuShMZ7Y1o
        NXUYfRryF7ZeKI1K8Xhd/ztUF+JOpoqLyE2X
X-Google-Smtp-Source: ABdhPJw/99kMxCwR0yFRx73jzv4gJj69z8EspYcbsKgYPbWtG8E04JDo+vAvZV310kqPy8vVDCVxLg==
X-Received: by 2002:a2e:8646:: with SMTP id i6mr4309604ljj.391.1621349794120;
        Tue, 18 May 2021 07:56:34 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k18sm2350657lfg.200.2021.05.18.07.56.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:56:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i22so14501635lfl.10
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 07:56:32 -0700 (PDT)
X-Received: by 2002:a19:c3d1:: with SMTP id t200mr4305910lff.421.1621349792609;
 Tue, 18 May 2021 07:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com> <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
In-Reply-To: <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 07:56:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
Message-ID: <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 12:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > I wonder if the kernel should do the same, or whether there are still cases
> > where memcpy() isn't compiled optimally.  armv6/7 used to be one such case, but
> > it was fixed in gcc 6.
>
> It would have to be memmove(), not memcpy() in this case, right?

No, it would simply be something like

  #define __get_unaligned_t(type, ptr) \
        ({ type __val; memcpy(&__val, ptr, sizeof(type)); __val; })

  #define get_unaligned(ptr) \
        __get_unaligned_t(typeof(*(ptr)), ptr)

but honestly, the likelihood that the compiler generates something
horrible (possibly because of KASAN etc) is uncomfortably high.

I'd prefer the __packed thing. We don't actually use -O3, and it's
considered a bad idea, and the gcc bug is as such less likely than
just  the above generating unacceptable code (we have several cases
where "bad code generation" ends up being an actual bug, since we
depend on inlining and depend on some code sequences not generating
calls etc).

But I hate how gcc is buggy in so many places here, and the
straightforward thing is made to explicitly not work.

I absolutely despise compiler people who think it's ok to generate
known bad code based on pointless "undefined behavior" arguments - and
then those same clever optimizations break even when you do things
properly.  It's basically intellectual dishonesty - doing known
fragile things, blaming the user when it breaks, but then not
acknowledging that the fragile shit they did was broken even when the
user bent over backwards.

                Linus
