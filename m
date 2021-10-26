Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8EE43B266
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhJZMcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhJZMcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 08:32:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B15C061745;
        Tue, 26 Oct 2021 05:29:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so7130307edd.11;
        Tue, 26 Oct 2021 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95w+JIBxdk96vFyS997ptIswrw8erLoiU2nFptHB2Z4=;
        b=U3BhOWCO7EE9x/zhlbhUZ9GuWsusB7VPV8wreSMY23LIw9s0HFjFo3fgjKH24xoDc6
         0lcAo+sm/9Hb1iRd3LKl8yzR6lX9csqO1YwpSbGE7c0nOpK1zbJsGc0c0qtAjxgxXCz9
         sNWpfikrThv7UUE/wCnjeW2ZxUPKJKPoZQtESIGCgQqoR8XZN6sciTCXc/z3Ssx5zq12
         Guj8ui8XE/CjempXrda83s/7O31q9fFTrmAmbd1/jaoGHkl8L8SMyqNXOHQoVJtJU9t5
         QzXzsAXl4GeOjHjFgVG4KBG5+5VqOoLJPAEFLfL42lcFdk36E89Vy+q0ighoCrd8+ma9
         RpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95w+JIBxdk96vFyS997ptIswrw8erLoiU2nFptHB2Z4=;
        b=cyBcmRzgU3iW5o7AEKbHY1AfaIDAzQ774XWq2iAsKw9UdXOZeTXs1ZfcikXWiMUm07
         RkkwqctOFLqbyLBK6h7EskRxGjYsGFCCUQjWbF7bwmCq2BLd8LUnNtndDVzzlikFPspl
         AJ295sj7yBDHPOahXikg8lP+Br2Y5ZPanNwwkGYY0xnqrKyrdbeTj0MMQR1N2aaEwi2X
         7RGtrkb8YGv4KYd4nvjXXPoVOLb3TmDYI7r4g4M7N/sGFabIDMKhfjiEYO8RqmSYsQ1K
         R/XihmauOSYGtF5q3pBDbWhFWjpZGUVusuhYfFZPeR1s/+pyhR/r7vtjGMlduiyFHwlq
         IDYg==
X-Gm-Message-State: AOAM531EQzfWl+OgZt1A86xoTvPSE1003HVF9cVOC1j/gcWz0tPkShro
        KqKMyEyQRtwDwUuOed0eMnDqTuELtWs5MyGXCpI=
X-Google-Smtp-Source: ABdhPJzgzCatEBIyHH641b2+HxtvgsbEOOEdWaqIXEqWyDN3PlxYeazI2rGOOdImDvGopH6ZwTknOL9YLRd534JaPOk=
X-Received: by 2002:a17:906:1601:: with SMTP id m1mr30164722ejd.117.1635251387825;
 Tue, 26 Oct 2021 05:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211026100432.1730393-1-arnd@kernel.org>
In-Reply-To: <20211026100432.1730393-1-arnd@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 26 Oct 2021 05:29:36 -0700
Message-ID: <CAMo8BfLskHzSW5FJUajAEvr6NRfvYhRRxKG4CQOFAQwtZtrRLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: ensure futex_atomic_cmpxchg_inatomic() is present
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 26, 2021 at 3:04 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The boot-time detection of futex_atomic_cmpxchg_inatomic()
> has a bug on some 32-bit arm builds, and Thomas Gleixner
> suggested that setting CONFIG_HAVE_FUTEX_CMPXCHG would
> avoid the problem, as it is always present anyway.
>
> Looking into which other architectures could do the same
> showed that almost all architectures have it, the exceptions
> being:
>
>  - some old 32-bit MIPS uniprocessor cores without ll/sc
>  - one xtensa variant with no SMP
>  - 32-bit SPARC when built for SMP
>
> Fix MIPS And Xtensa by rearranging the generic code to let it be used
> as a fallback.
>
> For SPARC, the SMP definition just ends up turning off futex anyway,
> so this can be done at Kconfig time instead. Note that sparc32
> glibc requires the CASA instruction for its mutexes anyway,
> which is only available when running on SPARCv9 or LEON CPUs,
> but needs to be implemented in the sparc32 kernel for those.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/futex.h   | 29 ++++++++++++++++++-----------
>  arch/xtensa/include/asm/futex.h |  8 ++++++--
>  include/asm-generic/futex.h     | 31 +++++++++++--------------------
>  init/Kconfig                    |  1 +
>  4 files changed, 36 insertions(+), 33 deletions(-)

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
