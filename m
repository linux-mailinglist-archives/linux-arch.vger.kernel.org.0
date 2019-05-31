Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E377B30A5F
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaIfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:35:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36259 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaIfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:35:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so10398196qth.3;
        Fri, 31 May 2019 01:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IAGTJ1uN3QgaPB0JEyQM4jANte20b3cD0wECnCP0+4=;
        b=n4dNxHkho9p36ijPunDYFCbKnuTSzDXRzM6VfR3VtuYRkQ5sqpjHkr3imVWxIv4Oxw
         gdmOC1B5RnOiK9UQSvHnPkZCdtShNip/BCTEH0/MuQmlF/TobDTCeJlJOH6nSE1oEc5Y
         g8NdCCk6xrIZdqPTn+5SK47VyOCovnvEX1t5+1QzP3bCJBIrqEiGUUi3YTZklCvSgjxD
         7+eGF/YAdanOuAvtt9+x0m32NpNcPsrozsoCuhQiCejq7tbOGJO2XA6yoB0l9pEhEkG6
         oKuDAFKwLbrkx8F/qGPFONHCScCOJit7RcLRzmW5eY17T3b2bVF3XFmLP9788so9Gaf7
         D6hg==
X-Gm-Message-State: APjAAAVp8cmCMkT7z2OqCBJ14Tyz2h69ZkisJVVX0Ocq5uS9TBcOLOC7
        5la64MfGXgnNMgqAE55z0rsen5xpZ6CKEG1dV+Y=
X-Google-Smtp-Source: APXvYqwJnDx5Tq81xAUY+isfpEB8HE2a5+TeAN3eO+1/XlqybT+dn9X3SVzRZ6Qq/cvLrjWF8XAcIqH+slSq4FlW4JU=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr7134581qtd.7.1559291715239;
 Fri, 31 May 2019 01:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-18-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-18-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:34:59 +0200
Message-ID: <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
Subject: Re: [PATCH v6 17/19] mips: Add support for generic vDSO
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> --- a/arch/mips/vdso/vdso.lds.S
> +++ b/arch/mips/vdso/vdso.lds.S
> @@ -99,6 +99,10 @@ VERSION
>         global:
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
> +               __vdso_clock_getres;
> +#if _MIPS_SIM != _MIPS_SIM_ABI64
> +               __vdso_clock_gettime64;
> +#endif
>  #endif
>         local: *;
>         };

Same comment as for the corresponding arm change: I'd leave the ABI
changes to a separate patch, and probably not add __vdso_clock_getres
at all.

Also, you seem to have a typo here:

> +notrace int __vdso_clock_gettime_time64(clockid_t clock,
> +                                struct __kernel_timespec *ts)
> +{
> +       return __cvdso_clock_gettime(clock, ts);
> +}

This should be __vdso_clock_gettime64, not __vdso_clock_gettime_time64 I think.

       Arnd
