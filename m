Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4533613
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfFCRHw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 13:07:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFCRHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 13:07:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so10264720qta.6;
        Mon, 03 Jun 2019 10:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aj0cpcxQ2O6hFlX37bf2kO1xsusmBejE3Ar/NHpEoV4=;
        b=PrKCX00Qc7nd2X6YD1cxY0AuHzxAzf61VRgq4ZgBcdhJv0NSHaoIqArXe8WVsnbp5P
         7fvj0wFK0gQMQ0ninVbQ2FvtYtezTEcQzLLMNfl+Y42qT76Q6Xfj00fDWhCglcgw+RHZ
         TABntafcN6GaDbYpnxFFfsEo7ONdm0kGGs2SQ9ATry8RW4HVLS+pV2ARCTX6r4maLoyz
         hlbUIS1sbFHqHTKrYBzadTW8FAAWmZXRQVDYd3kYUStScEn+zQz6vJ6atne21+2/nKiJ
         fUslK9Xnk7MUs6m/KD6xgK/drc+MJZynZkc13kZ3vjIQUxMd53P/3Kk5xL4HUi/8b7zb
         FSjg==
X-Gm-Message-State: APjAAAUoyVvCHfmot5SutjaKdLjC55Tad7vnK7y9ekF7Ngz0FrxNv6FA
        kU4WJ4fkVwSrn8pIvmW1knp+uqpnp3+VXcO56tU=
X-Google-Smtp-Source: APXvYqwbJWvGlfk068cQnPCsOnTMnS+38b2uW4yx7NPKeQr+nVfqv4x5tnNHu/1skd7GPUOm+SPgjUJEz0LsR7r4j08=
X-Received: by 2002:ac8:2433:: with SMTP id c48mr23290784qtc.18.1559581671050;
 Mon, 03 Jun 2019 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-18-vincenzo.frascino@arm.com> <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
 <200c39f5-3bff-cacb-57c9-e11c57df70f5@android.com>
In-Reply-To: <200c39f5-3bff-cacb-57c9-e11c57df70f5@android.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Jun 2019 19:07:34 +0200
Message-ID: <CAK8P3a24SFh1eeYpkU1xWL4_2j5_7ieejwuBZW1m3G6biKSK4g@mail.gmail.com>
Subject: Re: [PATCH v6 17/19] mips: Add support for generic vDSO
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
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

On Mon, Jun 3, 2019 at 4:54 PM Mark Salyzyn <salyzyn@android.com> wrote:
> On 05/31/2019 01:34 AM, Arnd Bergmann wrote:
> > On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >
> >> --- a/arch/mips/vdso/vdso.lds.S
> >> +++ b/arch/mips/vdso/vdso.lds.S
> >> @@ -99,6 +99,10 @@ VERSION
> >>          global:
> >>                  __vdso_clock_gettime;
> >>                  __vdso_gettimeofday;
> >> +               __vdso_clock_getres;
> >> +#if _MIPS_SIM != _MIPS_SIM_ABI64
> >> +               __vdso_clock_gettime64;
> >> +#endif
> >>   #endif
> >>          local: *;
> >>          };
> > Same comment as for the corresponding arm change: I'd leave the ABI
> > changes to a separate patch, and probably not add __vdso_clock_getres
> > at all.
>
> Removing this would break ABI (would it really, it just replaces the
> syscall ... so it is more of a user space expectation)? already present
> in arm64 before this series.

What I meant is that we should only keep clock_getres() in the vdso
for architectures that already have it, to keep the ABI unchanged,
but not add it to new ones.

At the moment, arm64, nds32, ppc, riscv and s390 have clock_getres,
while arm, mips, sparc, and x86 don't.

Also: on 32-bit architectures with 64-bit time_t, the series only adds
clock_gettime()., not clock_getres(), so user space should stop
assuming it's there.

        Arnd
