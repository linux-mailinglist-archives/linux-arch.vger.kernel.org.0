Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AF11C52D
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 06:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLLFMx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 00:12:53 -0500
Received: from condef-03.nifty.com ([202.248.20.68]:23871 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLLFMx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 00:12:53 -0500
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-03.nifty.com with ESMTP id xBC54FXY002029
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 14:04:15 +0900
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id xBC5404b010658;
        Thu, 12 Dec 2019 14:04:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xBC5404b010658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576127041;
        bh=f0mX96dUj+4SSO7tlGuJjbJ2RUgELAxn1iGgSDGDbbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZ1JIZHe8zix2l9FjfNAniHgyI9oSvauhAcPoqTxKT2A4OdfQ6LoL/v8zbDHIMxYj
         mhDcjoSh0vEu+LtXS+MtkYAcpX3jOyRNJlre+cXE2vx+SKR622V+/EdoCDiv6L9Czp
         dtHzu1j68lvJTCpkBrcMBvfNBGz2s/SYZeCDlVHU3+Mi3/LVg1RrQyRG37YV2D6gEs
         7MSFfyhR+rJYSoK/A9Tros/69wod/qLfHR/Wy8Lu7G3yKos64Goxe3qgV5XICmBHu5
         BzgUVnck5bQ8tGq7xoCugzdLckDKpcc1wceT248Z9mjHWiNNHBELC/vO2+O8mLC1F/
         GEeLkj0rANPTw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id x4so665004vsx.10;
        Wed, 11 Dec 2019 21:04:01 -0800 (PST)
X-Gm-Message-State: APjAAAXMPwaobBoE4sd8jkEacqCsZ7ZlT2dTD2kKyttmCH2x6FplGIYx
        O3UTPnU1/JCCWya6SMPJgRVKP55G6i6Ym7Q36LE=
X-Google-Smtp-Source: APXvYqwITbfxXfryxfdFs+wuDBH6lMreA653GFfyRlQshqBOwFIPRjFb2inNIzS8YEl1Z3dRS/b2hoN5oMNCFLezUXA=
X-Received: by 2002:a67:7ac4:: with SMTP id v187mr5603811vsc.181.1576127040046;
 Wed, 11 Dec 2019 21:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-3-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-3-catalin.marinas@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Dec 2019 14:03:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARR=DjdnZdu=L+0H8ALr4XJNpVbcRTOz_sVZdZpcM0pdQ@mail.gmail.com>
Message-ID: <CAK7LNARR=DjdnZdu=L+0H8ALr4XJNpVbcRTOz_sVZdZpcM0pdQ@mail.gmail.com>
Subject: Re: [PATCH 02/22] kbuild: Add support for 'as-instr' to be used in
 Kconfig files
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 3:40 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Similar to 'cc-option' or 'ld-option', it is occasionally necessary to
> check whether the assembler supports certain ISA extensions. In the
> arm64 code we currently do this in Makefile with an additional define:
>
> lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
>
> Add the 'as-instr' option so that it can be used in Kconfig directly:
>
>         def_bool $(as-instr,.arch_extension lse)
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-kbuild@vger.kernel.org
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---

Please feel fee to apply this to arm64 tree.
Acked-by: Masahiro Yamada <masahiroy@kernel.org>

>  scripts/Kconfig.include | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index d4adfbe42690..9d07e59cbdf7 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -31,6 +31,10 @@ cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/null -o /de
>  # Return y if the linker supports <flag>, n otherwise
>  ld-option = $(success,$(LD) -v $(1))
>
> +# $(as-instr,<instr>)
> +# Return y if the assembler supports <instr>, n otherwise
> +as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
> +
>  # check if $(CC) and $(LD) exist
>  $(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
>  $(error-if,$(failure,command -v $(LD)),linker '$(LD)' not found)



-- 
Best Regards
Masahiro Yamada
