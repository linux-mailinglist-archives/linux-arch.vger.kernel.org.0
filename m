Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3963FC8
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfGJEDJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 00:03:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40716 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGJEDJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 00:03:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so925308wrl.7
        for <linux-arch@vger.kernel.org>; Tue, 09 Jul 2019 21:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/+8WA5YVt9o68tf7IxaP2AKZIs3izvlH0APT6Mt07Q=;
        b=K1qh7HcwzDZLVDAhRFo1UMOBKQLz3oQjDqRwz2jFT38WMwz/Hl+vBRVpz6PZ8eyy3Y
         dTAmu29NVGAwAZMWL0pe9v9Be598VLNvCEXNI4Hmi9hk8iVCmDpiCn3DzAX+ya48+l5E
         agWdvXAgbkGVdffOYWAEPWEA5Tt1dpEYgqARMkGUm9CBA9Z7CDJCzkt8K2r4smVHL7vu
         IxMt0gyE+LkrWBBgHX7+Dm2eM7WrA3nvP7LdaYR5P8bZpqvhbzthPdfj/epTNYwzA56p
         AOfetMta9CkyUC4Q9MJQDe4yMoicmVktguXRf/xx872evRk4ahBKSIB/SR+PNbG029Rw
         4ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/+8WA5YVt9o68tf7IxaP2AKZIs3izvlH0APT6Mt07Q=;
        b=nyZSXKw2AvcX0I3kIcfavjzfPLi37gFHd6VlHQrcc9vsAxD26LMgnNMoa+gWIrd2ql
         4i9oPopv97VQeFzLZdV0vO+m+KUdaQAk/nS/Wi1o30KvSqfQl7GCSlq2YR5E47CdB9MP
         9Rdm/+aTMSs5E/G9AEhur642UqycCwswWn9+kkaikbu+q8WIrF9rxIej5gsXmaz+KkLZ
         8qPG8WWSL5lylg5BBVPePItYX/qUhUw2R533m1xtykjPSfL4WR6Xgc2WBF9sREAYnlGF
         goeZ3IMcXyFc5+arI4WlE++le3kisUradqdFDeqRk8lfU0s6kBCGH6e0ntWnLYTD+SaR
         EIxA==
X-Gm-Message-State: APjAAAVGa+uJG8xkSFhGnbrryunPBM1Izss6tQwMeFXcFqlhiM5s1KYz
        2KNZhBkNRRx0BO1z4rKSV9OAeYDVdK9u8+IuLXS/VA==
X-Google-Smtp-Source: APXvYqzPOdmo7LUjjtBVy+Eam/jLKZXcN/T+ttk0oWQFmX0MgxeRc22swD1KsBEGZUN6nDxG/pwDPT36kLteJxt49zQ=
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr9063316wrx.208.1562731387533;
 Tue, 09 Jul 2019 21:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <20190621095252.32307-11-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-11-vincenzo.frascino@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 9 Jul 2019 21:02:54 -0700
Message-ID: <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 3:18 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Provide the arm64 compat (AArch32) vDSO in kernel/vdso32 in a similar
> way to what happens in kernel/vdso.
>
> The compat vDSO leverages on an adaptation of the arm architecture code
> with few changes:
>  - Use of lib/vdso for gettimeofday
>  - Implementation of syscall based fallback
>  - Introduction of clock_getres for the compat library
>  - Implementation of trampolines
>  - Implementation of elf note
>
> To build the compat vDSO a 32 bit compiler is required and needs to be
> specified via CONFIG_CROSS_COMPILE_COMPAT_VDSO.
>

Hey Vincenzo!
  Congrats on getting this work merged, I know its been a long effort
over a number of years!

Though unfortunately, it seems the arm64 vdso code that just landed is
breaking AOSP for me.

I see a lot of the following errors:
01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
pid 755 (cameraserver)
01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
(android.hardwar), pid 759 (android.hardwar)
01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
pid 756 (drmserver)

Which go away if I revert the vdso merge that went in via tip/timers.

I tried to bisect things down a bit, but as some later fixes are
required (at one point, date was returning the start epoch and never
increasing), this hasn't worked too well. But I'm guessing since I
see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
not be built", and the system is half working, I'm guessing this is an
issue with just the 32bit code failing.  While I can try to sort out
the proper CROSS_COMPILE_COMPAT in my build environment, I assume
userland shouldn't be crashing if that value isn't set.

Any chance this issue has already been raised?

thanks
-john
