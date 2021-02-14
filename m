Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951431B160
	for <lists+linux-arch@lfdr.de>; Sun, 14 Feb 2021 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNRCQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Feb 2021 12:02:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:58612 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBNRCP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Feb 2021 12:02:15 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11EH1DmW022819;
        Mon, 15 Feb 2021 02:01:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11EH1DmW022819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613322074;
        bh=SP1sGJk9Sz6Zv6lJ9Wi/Vff8sScxvUIuNUkChOHpFR8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eW5SCVd/ORO2ykDHxnNRrd0j5pNeofX24lJWfc1sAWEZK87VwCvlyBONkk1p+q0pw
         n9urDcCM7JXO/83SDgjvjWIuq0kCzJpxghQ0kdEY/9lSUqF57fsB4kVM44LTekaoBL
         2K5usgTVkdb+i9kzobmJV+tecZNrbgkAygUEWwX3cvMZxzFNtx08+4IWsN9L58B4V9
         msLNld5lBI4A8trmLyO3EgTzKOINsLN5xgyvh+eWnDvPTyAVb6rNcHXCo6xnYQ8S9l
         7hdmlhpR1RGeMV1AEHEn5ADueffOKPk44du6buIJ89LAEEs34fToTGEhTLY+vWrQY3
         BiMMNZH6MaRbw==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id d26so2778301pfn.5;
        Sun, 14 Feb 2021 09:01:13 -0800 (PST)
X-Gm-Message-State: AOAM533clch37dk64kSPjlB2+UzCYJ2WwCkw3YGVARLYTXnzf3SZiAY5
        Tzj3X9RmE4N8rzRkjvZlSrTCVbRotG+c+HSmbvQ=
X-Google-Smtp-Source: ABdhPJynyvRuko2AvW0s/Rsmpz6hR6NWNFNxrImHm+1o7F+Y7g0dNzPk8oFZuEX0oJ2YCILzMn7MQK6BnXeqMrnP+x0=
X-Received: by 2002:a63:1f1d:: with SMTP id f29mr11945438pgf.47.1613322073045;
 Sun, 14 Feb 2021 09:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org> <20210128005110.2613902-22-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-22-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 15 Feb 2021 02:00:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDcfqSCsCeG9+ytrJNfD5mS8OLS2uZS8WRBuTHRL1qRg@mail.gmail.com>
Message-ID: <CAK7LNAQDcfqSCsCeG9+ytrJNfD5mS8OLS2uZS8WRBuTHRL1qRg@mail.gmail.com>
Subject: Re: [PATCH 21/27] sparc: remove wrong comment from arch/sparc/include/asm/Kbuild
To:     linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-um@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 28, 2021 at 9:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> These are NOT exported to userspace.
>
> The headers listed in arch/sparc/include/uapi/asm/Kbuild are exported.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to linux-kbuild/fixes.


> ---
>
>  arch/sparc/include/asm/Kbuild | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index 3688fdae50e4..aec20406145e 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -# User exported sparc header files
> -
>  generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
>  generated-y += syscall_table_c32.h
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
