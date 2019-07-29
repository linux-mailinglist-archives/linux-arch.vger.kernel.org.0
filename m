Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5A789A2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfG2Kct (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 06:32:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44908 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2Kct (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 06:32:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so43671761qke.11;
        Mon, 29 Jul 2019 03:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ddrv52LpMoY4aKg5qHamGgD3HmNhIC4nCuOZOIPUmeo=;
        b=BZNe9OgsD8qH9dHgCA7GA4XqDYsbMRDOcBwRKUowjp7ERwEBv1ebAXYhJ1b2220e+0
         XfqKs91AEBubj5hh5BTPNUpQ64YW1HOumYhc2L14mSunn54H8fTHKxDEAtyLuYy/FHDY
         ovdAe9YRHGfFKFPcWPV6cvu34gHNAZLx0OW1B26HW7vk16D4xR//HzXUWk594YsA1q/Y
         B0ErnqDJGQMqGN5g6djclFjkDtXNf7f6wmGrfbY6ZxNmNhzCFSRbbpsZBfC08SwUVN+x
         WoGWupz5fZwuG5eqkjx2kHvt5iMB4HAyrAbZZ/Z0ZmzWVEUNBxa6YrGkcCLKcTa+0fd4
         6+lA==
X-Gm-Message-State: APjAAAVfCJUKl6kLUJBsYoSInwBto6tMJp+uDZVys54wTY1OMBe0B+jw
        QF6S86ZdKHa9eMwkPcnHxH0lJz9fOHmq1hi1NSaPRvoXlHI=
X-Google-Smtp-Source: APXvYqzZYi8UksT2DgWjRWxV30TkQZ9QFLsasXrfRZoyxINJyI2UP1v9H3QBW82bSn3z1aed2Je5FmyLZvrWTOWzxvY=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr27588559qkm.3.1564396368144;
 Mon, 29 Jul 2019 03:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190729095521.1916-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190729095521.1916-1-ard.biesheuvel@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jul 2019 12:32:31 +0200
Message-ID: <CAK8P3a1=6nW0d+LOp__tMepYwGCc5f+e6qb1D3wUtp6_79Yd-A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: make simd.h a mandatory include/asm header
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 11:55 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> The generic aegis128 software crypto driver recently gained support
> for using SIMD intrinsics to increase performance, for which it
> uncondionally #include's the <asm/simd.h> header. Unfortunately,
> this header does not exist on many architectures, resulting in
> build failures.
>
> Since asm-generic already has a version of simd.h, let's make it
> a mandatory header so that it gets instantiated on all architectures
> that don't provide their own version.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Looks good to me, if you want this to go through the crypto tree,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I noticed that this is the first such entry here, and went looking for
other candidates:

$ git grep -h generic-y arch/*/include/asm/Kbuild  | sort | uniq -c  |
sort -nr | head -n 30
     24 generic-y += mm-arch-hooks.h
     23 generic-y += trace_clock.h
     22 generic-y += preempt.h
     21 generic-y += mcs_spinlock.h
     21 generic-y += irq_work.h
     21 generic-y += irq_regs.h
     21 generic-y += emergency-restart.h
     20 generic-y += mmiowb.h
     19 generic-y += local.h
     18 generic-y += word-at-a-time.h
     18 generic-y += kvm_para.h
     18 generic-y += exec.h
     18 generic-y += div64.h
     18 generic-y += compat.h
     17 generic-y += xor.h
     17 generic-y += percpu.h
     17 generic-y += local64.h
     17 generic-y += device.h
     16 generic-y += kdebug.h
     15 generic-y += dma-mapping.h
     14 generic-y += vga.h
     14 generic-y += topology.h
     14 generic-y += kmap_types.h
     14 generic-y += hw_irq.h
     13 generic-y += serial.h
     13 generic-y += kprobes.h
     13 generic-y += fb.h
     13 generic-y += extable.h
     13 generic-y += current.h
     12 generic-y += sections.h

It looks like there are a number of these that could be handled the
same way. Should we do that for the asm-generic tree afterwards?

      Arnd
