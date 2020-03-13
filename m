Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12CA184C3C
	for <lists+linux-arch@lfdr.de>; Fri, 13 Mar 2020 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCMQTc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Mar 2020 12:19:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMQTc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Mar 2020 12:19:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so10964713wme.1;
        Fri, 13 Mar 2020 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DzWpdx6328OZ0aH4x17MPaDC7GHF6Gljp2V0qUX/DXo=;
        b=UaJGqhaStKvtpmCHIX3kKDpHnWc+X5jToC5SA/qFSF367bfEjsz2TVGFQPWSP8HeUx
         GRLu8BKAOod/fH4D9Sowc0g+v0PGZvefYUcatrjW7Hns/gHMn0/5MvDT//4Z9EWPhYvQ
         KJah4mfhH2zRxGewD8tH3WSFEYvcHtW/vfQO6ucpmC8zuWcsqvQ5w246yKiWspujo/Ly
         vdN9l8dgYdikc6SF9YTp5CKa4Mi8ppQT3A9PbDL/lzQqsfGXhMpz8T50Q2WliEJDvN7x
         nJt9rp5Tyx77XMF6/Rv1OlehOLOIkgQL2QYO5J0J0WTA4aa++VluIhkdS0C3yTOp8PjN
         Y+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzWpdx6328OZ0aH4x17MPaDC7GHF6Gljp2V0qUX/DXo=;
        b=NYITuNGP1USg2O+J0QUggvMzwJGEABlr/kQ8vA6LpF7qh8OypZIH5jS67eFUxDPVvR
         vHxHw3p5hnWaCXAuLpaft2KSxZOtrTWNIv1fbNvoyBKgcLhY/f8n5XTIUUj/TSVouRcC
         VP6xtTFV52lZGKaTxqqh9XK15ZUtxQsrKQNqn7aKD41l6n9qMPTh+zX8lD0S7sz2siwC
         bdUApVEE1Zwbj8yUuS1w3W9+eBGyHMsiZHzebskGOi3rGZQkg944tYxjcuUubsGjBVqE
         GN7Cpx9rJu5lLlBAaYE7z9U0iXlRrnhOwUBy7tDEhmOzLRQ+dZmiYK7pGclTiOvZivb7
         Y+6A==
X-Gm-Message-State: ANhLgQ0nkLk+z7jmzJ5oE8HbNJpPdIJJmng49E2+NFABaxEv4GqIBD/Z
        GJDguFYk8wQI5ptm9hj9eik=
X-Google-Smtp-Source: ADFU+vsq06fil7othF27XQT8Yzw4TwrwXBYm7m6KjdoRKe730VpT0nmboNEJS30sUYpx7sh4hoWlkQ==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr11500620wme.103.1584116370132;
        Fri, 13 Mar 2020 09:19:30 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w1sm16365071wmc.11.2020.03.13.09.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:19:29 -0700 (PDT)
Subject: Re: [PATCH v3 00/26] Introduce common headers for vDSO
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <693b6a61-b5f6-2744-1579-b356e6510547@gmail.com>
Date:   Fri, 13 Mar 2020 16:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313154345.56760-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo, all

I like the idea, but I'm wondering if we could have less-grained
headers? Like, AFAICS the patches create headers < 10 lines and even
mostly < 5 lines.. I like that header's names perfectly describe what's
inside, but I'm not sure how effective to have a lot of extra-small
includes.

Or maybe there's a plan to grow the code in them?

On 3/13/20 3:43 PM, Vincenzo Frascino wrote:
[..]
>  create mode 100644 arch/arm/include/asm/vdso/clocksource.h
>  create mode 100644 arch/arm/include/asm/vdso/cp15.h
>  create mode 100644 arch/arm/include/asm/vdso/processor.h
>  create mode 100644 arch/arm64/include/asm/vdso/arch_timer.h
>  create mode 100644 arch/arm64/include/asm/vdso/clocksource.h
>  create mode 100644 arch/arm64/include/asm/vdso/processor.h
>  create mode 100644 arch/mips/include/asm/vdso/clocksource.h
>  create mode 100644 arch/mips/include/asm/vdso/processor.h
>  create mode 100644 arch/x86/include/asm/vdso/clocksource.h
>  create mode 100644 arch/x86/include/asm/vdso/processor.h
>  create mode 100644 include/vdso/bits.h
>  create mode 100644 include/vdso/clocksource.h
>  create mode 100644 include/vdso/const.h
>  create mode 100644 include/vdso/jiffies.h
>  create mode 100644 include/vdso/ktime.h
>  create mode 100644 include/vdso/limits.h
>  create mode 100644 include/vdso/math64.h
>  create mode 100644 include/vdso/processor.h
>  create mode 100644 include/vdso/time.h
>  create mode 100644 include/vdso/time32.h
>  create mode 100644 include/vdso/time64.h

Maybe we could made them less-grained?

I.e, time32 + time64 + time.h => time.h?

Thanks for Cc,
          Dmitry
