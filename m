Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3BF1A46
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKFPmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 10:42:49 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30906 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfKFPmt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:42:49 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xA6FgS18017184;
        Thu, 7 Nov 2019 00:42:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xA6FgS18017184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573054949;
        bh=Oo7scaKCpuRmjy0rieaBsErle9xeIHQqeWuJeV94uVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z5nGbnKJncnVEI+smSe+r6VUouK3mGviPjIJoz6VkEBTc4RZyeiyoMnXAxUTgemLG
         Bk4x2rBTogiKatm/GJ08J+X2FzzcE43lf8n8Zh952/wvo71k9ED5kZmvHBc3GMtBZK
         ETdfCEWG0xHwvcqos8JqaqD7OhOuwPfzEsBhxy0KCHD7alEfKsJi5xWdJbDaNPtKDr
         NLs51rnqTtkYg8wA7Hol6kNwOTQW5sAkswehKpsTcWmsay9AGdnxZOiwDmfkALJclC
         D2zWE5n18662Vk5JuGW3jHoigoht7aMq6OiURqFqYxQl3r38hBcpdymA7AjKnNBSbz
         bB1oRYa5nVZ3g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id k15so16256350vsp.2;
        Wed, 06 Nov 2019 07:42:29 -0800 (PST)
X-Gm-Message-State: APjAAAXgeJijqr17zy+51SyrUL9tZE/OB6oJQB/0MEbf5EaCilGZ4yud
        Gq7dx2WEvi2rgrC1f+/4r3rz3i0KARr99xBV10w=
X-Google-Smtp-Source: APXvYqwmOlQCDUNvIPO3lrS+m40I1QEkJs0iOwKwT64R031JiVD1L7FuobJCuN4uEkmtT1/ndh5HkYLqfzxCG+gZsbY=
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr1616942vsf.181.1573054947982;
 Wed, 06 Nov 2019 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20191018043148.6285-1-yamada.masahiro@socionext.com> <20191018043148.6285-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191018043148.6285-2-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Nov 2019 00:41:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpjkd8VpMAp+vx+Ud5ipSsfxPY6cAr31tmG=08_qi1kQ@mail.gmail.com>
Message-ID: <CAK7LNARpjkd8VpMAp+vx+Ud5ipSsfxPY6cAr31tmG=08_qi1kQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] asm-generic/export.h: remove unneeded __kcrctab_* symbols
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 1:56 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> EXPORT_SYMBOL from assembly code produces an unused symbol __kcrctab_*.
>
> kcrctab is used as a section name (prefixed with three underscores),
> but never used as a symbol.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.

>
>  include/asm-generic/export.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 80ef2dc0c8be..a3983e2ce0fd 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -43,7 +43,6 @@ __kstrtab_\name:
>  #ifdef CONFIG_MODVERSIONS
>         .section ___kcrctab\sec+\name,"a"
>         .balign KCRC_ALIGN
> -__kcrctab_\name:
>  #if defined(CONFIG_MODULE_REL_CRCS)
>         .long __crc_\name - .
>  #else
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
