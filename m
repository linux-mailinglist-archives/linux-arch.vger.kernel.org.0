Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87532FE498
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 09:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbhAUIFH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 03:05:07 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38078 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbhAUIEn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 03:04:43 -0500
Received: by mail-ot1-f44.google.com with SMTP id 34so820110otd.5;
        Thu, 21 Jan 2021 00:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2IYvzXGwV6xHNM+MUo0hPQb7UzsectWR0FG/X10PkI=;
        b=UgisBm4bsiYzChzcOGyaUXwFq2wf7WhRfmxP7hu2p32VPlPMXG72OQYUYWMtpj2Ztf
         jfTm/TgUtWXwI3zTt40BxXdRbv516nFwM2buugq2f8dZN6h9hP7jq+byI1f3SIXqUwpY
         pq+KBLOcVUADZaUra2ntFuGfQYoDRrKeVwRiCggCuQZVjWycqX9J7Tm5B9VO2euGtXxU
         105b6llUrtzoCrkYKBA3McHFPDz2bYcuCNkmyjBNkkeeZjdUP2szZeww5+vd7BId3OjX
         eT2W1hUi31cSdIteBsFdOQz2LpBIClNoHN0dRmB+n4PwdtbsIP9GHFz6zJ2149+tQpuv
         B4Mw==
X-Gm-Message-State: AOAM530Jr4xl+tF5dS9fLVlYJgJRBZD9G1Dp0Bg1Tv/eH/9sBF+oFkVA
        dcfe56KV2n+qcEs8WMgI6wSPx0mEbbYbsQj+JcU=
X-Google-Smtp-Source: ABdhPJzSbca3ijAzNOm3Ms2SefSVDK4WWVoOOJl2SDNzMRneWPfF/x1Lgdp8kPfgBqgJdeUvPiwJBD9V4y25u0g6aww=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr9472201otr.107.1611216229592;
 Thu, 21 Jan 2021 00:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20210121000630.371883-1-yury.norov@gmail.com> <20210121000630.371883-2-yury.norov@gmail.com>
In-Reply-To: <20210121000630.371883-2-yury.norov@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jan 2021 09:03:38 +0100
Message-ID: <CAMuHMdWe3Mx2q7WJvZa+Wt+TbG7ER086ph8UCSR6yR+Wj73HWg@mail.gmail.com>
Subject: Re: [PATCH 1/6] arch: rearrahge headers inclusion order in asm/bitops
 for m68k and sh
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 1:06 AM Yury Norov <yury.norov@gmail.com> wrote:
> m68k and sh include bitmap/find.h prior to ffs/fls headers. New
> fast-path implementation in find.h requires ffs/fls. Reordering
> the order of headers inclusion helps to prevent compile-time
> implicit-function-declaration error.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/m68k/include/asm/bitops.h | 4 ++--

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
