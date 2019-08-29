Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34CAA1EFF
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2PZQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfH2PZP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:25:15 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE0E23428
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567092315;
        bh=izoNkph/QjwkRYkXPZQmm9ytluYnjBoc9TYsmIgqnSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iUFipIVZ1HFIrEALnAF/EnoEcF209ZLWvRC4PEWbszkw/lCP9Yvj37ci8J+w7/hxQ
         zi/3IdAUX14zyQDtjJ0thyL4mPt5cSWzBq103mHEZpUO2EBt91zBEDCvu4xzO9SOzg
         6Vbq+bL+ekh6s4QH3C1lVJ97BVS4YmMDzILHOYCc=
Received: by mail-wm1-f47.google.com with SMTP id p13so4319537wmh.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 08:25:14 -0700 (PDT)
X-Gm-Message-State: APjAAAU8DYsa3dsoabVFXMZmocbQ14Ts0ldnV1ZcCoEmerg6qpWxMSdc
        QEFz3jstHhmC98MGyApPpwi2XtioAPyNBbJoOCbNGQ==
X-Google-Smtp-Source: APXvYqw9u1fu+EHt/4WAojvjLjQ7rKpFezaEHESzZAnb7jZ2raRq1MIbYw3eQuXsuFrZUlLqFJAlw9hQa1Rszg/FXvs=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr12807622wmg.0.1567092313279;
 Thu, 29 Aug 2019 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-5-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-5-vincenzo.frascino@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Aug 2019 08:25:02 -0700
X-Gmail-Original-Message-ID: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
Message-ID: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
Subject: Re: [PATCH 4/7] lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> VDSO_HAS_32BIT_FALLBACK was introduced to address a regression which
> caused seccomp to deny access to the applications to clock_gettime64()
> and clock_getres64() because they are not enabled in the existing
> filters.
>
> The purpose of VDSO_HAS_32BIT_FALLBACK was to simplify the conditional
> implementation of __cvdso_clock_get*time32() variants.
>
> Now that all the architectures that support the generic vDSO library
> have been converted to support the 32 bit fallbacks the conditional
> can be removed.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Andy Lutomirski <luto@kernel.org>
> References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/vdso/gettimeofday.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index a86e89e6dedc..2c4b311c226d 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -126,13 +126,8 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>
>         ret = __cvdso_clock_gettime_common(clock, &ts);
>
> -#ifdef VDSO_HAS_32BIT_FALLBACK
>         if (unlikely(ret))
>                 return clock_gettime32_fallback(clock, res);
> -#else
> -       if (unlikely(ret))
> -               ret = clock_gettime_fallback(clock, &ts);
> -#endif
>
>         if (likely(!ret)) {
>                 res->tv_sec = ts.tv_sec;

I think you could have a little follow-up patch to remove the if
statement -- by the time you get here, it's guaranteed that ret == 0.

--Andy
