Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2294A37810B
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEJKRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 06:17:36 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:35626 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEJKR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 06:17:29 -0400
Received: by mail-vs1-f52.google.com with SMTP id j13so8124988vsf.2;
        Mon, 10 May 2021 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVvVN78+/ymEH+RZL6HvoVCZVksTZw7UVoQH006DAA8=;
        b=uiiBmkHlh6s5t0Q6ekUiP2RK7fY7IrsyQ4X30oiYA8nOMTOpVbsOvsK7rvWIFRp5nB
         Iyz9R163vNvnPCJjmJnKmSm9EVCKvRl3B8XAu/IQq0hbrCjB938R2BQfS2eqOpwdotGZ
         9pFwtE0SkDsLD9aCYyjTNEeofBctawz9Do4erZDD9m6RaGkVyXC24qrPpqEUloTKapnG
         6uYgPdJG0ouqCMdUKazKPGQj0VRN81LNyPxfW1MDE2XhFnh97MuO/gmBH6LojXMha+eq
         K00aTjCBMcVu5XyNmqHszmx9GMMcQg4BSKMLVtzRWmxVcIZGbF9YWM1CgN4dKUh3KZ7S
         ao/A==
X-Gm-Message-State: AOAM531JjyLLwBGwA+OJvXqPpY+9fUftJOP2AN9bNMe6nZntmYtHtYJa
        9mls5DQUw1KnpELouF1hp176F5u0ZHy/VKgocUs=
X-Google-Smtp-Source: ABdhPJwCjZFq7knTQzQamMPg7B/M6YwpWZB1FCmai2ATFOyJJM+uqtP/4aHsoLXiIPOmyugP+gy2CWFKz8LbQiDSA/c=
X-Received: by 2002:a67:8745:: with SMTP id j66mr19115560vsd.18.1620641784321;
 Mon, 10 May 2021 03:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-2-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-2-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 May 2021 12:16:13 +0200
Message-ID: <CAMuHMdV1=mJzbr1cLwo-zUnThh9J8BmdW870dJCvp_Kft8kM2w@mail.gmail.com>
Subject: Re: [RFC 01/12] asm-generic: use asm-generic/unaligned.h for most architectures
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Sat, May 8, 2021 at 12:09 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are several architectures that just duplicate the contents
> of asm-generic/unaligned.h, so change those over to use the
> file directly, to make future modifications easier.
>
> The exceptions are:
>
> - arm32 sets HAVE_EFFICIENT_UNALIGNED_ACCESS, but wants the
>   unaligned-struct version
>
> - ppc64le disables HAVE_EFFICIENT_UNALIGNED_ACCESS but includes
>   the access-ok version
>
> - m68k (non-dragonball) also uses the access-ok version without
>   setting HAVE_EFFICIENT_UNALIGNED_ACCESS.

This not only applies to dragonball, which has the CPU32 core, but also
to plain 68000, and any SoCs including the 68EC000 core.

It also applies to early Coldfire, but AFAIK Linux doesn't support these
(see dfe1d26d4a90287e ("m68knommu: Allow ColdFire CPUs to use unaligned
 accesses")).

 > - sh4a has a custom inline asm version
>
> - openrisc is the only one using the memmove version that
>   generally leads to worse code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/include/asm/unaligned.h       |  9 +-------

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
