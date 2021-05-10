Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E81378117
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhEJKUS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 06:20:18 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:34514 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEJKUL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 06:20:11 -0400
Received: by mail-vk1-f181.google.com with SMTP id q135so3256777vke.1;
        Mon, 10 May 2021 03:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdRd6/gKBJmSyWKHkTLo2vWOf1KaAzTkqqnkH637tvE=;
        b=LmPF7zFkb7uf5dzLJfo26JKe+3M/Ykym5U5jIeFh66lJnb4sda9jjDjYqfiRuMWK1+
         QiRD49fmnkOn4DDqv0sRp6/Oex5eMV5mjhoUVRqY0Hc4BaFdgvmReBuxtyroAzNxz+fs
         o2XxadUR5bKBqtrkzjHS/mxiMNi1eTf+7vZev5KTlHePRCWCk3I089HMJlCJWOlwkMeI
         Z7D/Gw8M/ATXr6ExWM0jh64q/666Medw+cNMElEDMKGcWNlGZch3VpU2b6cC6sQ1mv95
         z2UFYv8p5t7+002tvo4VYBnhpO+3QToyuEUGHx3dOsIASblUw878bezNQp4cScX4D813
         mPiQ==
X-Gm-Message-State: AOAM5325biKBcSKDjPSUPaoKpomxyP2E0jz+aw6Si/KS8HmPXIlq/8je
        7lS9dG260bbOBfGDIuO5Rg8vjhDdIpn7BAUNC0s=
X-Google-Smtp-Source: ABdhPJyaOXi+XArkeKM210IRY8QcEM26/c7KnI/L43ooxhYTjbJbpZlbZUWioVOj4c1tWLX5jGBLlpRzufl3a7TwMsc=
X-Received: by 2002:a1f:1f81:: with SMTP id f123mr16115181vkf.6.1620641946301;
 Mon, 10 May 2021 03:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-5-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-5-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 May 2021 12:18:55 +0200
Message-ID: <CAMuHMdWYoGfDafgcObE4Cb4spZ4vAAEDfWPt-4+1pmEebjM6Ow@mail.gmail.com>
Subject: Re: [RFC 04/12] m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Sat, May 8, 2021 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All supported CPUs other than the old dragonball use the

Same comment about dragonball as for patch 01/12.

> include/linux/unaligned/access_ok.h implementation for accessing unaligned
> variables, so presumably this works everywhere.
>
> However, m68k never selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> so none of the other conditionals in the kernel get the optimized
> implementation.
>
> Select this based on CPU_HAS_NO_UNALIGNED to make the two settings
> always match, and then use the generic version of the header.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -22,6 +22,7 @@ config M68K
>         select HAVE_AOUT if MMU
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_DEBUG_BUGVERBOSE
> +       select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED

This was clearly forgotten in commit 58340a07c194e0ae ("introduce
HAVE_EFFICIENT_UNALIGNED_ACCESS Kconfig symbol"), which predates the
existence of CPU_HAS_NO_UNALIGNED.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
