Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC91FA0D5
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgFOT4S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgFOT4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 15:56:17 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA416C061A0E;
        Mon, 15 Jun 2020 12:56:17 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r1so6098478uam.6;
        Mon, 15 Jun 2020 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE0LNtUfHwCZfHJtiwpqCqgHEs083VlAicgdPb4arnA=;
        b=CgauWzi/p+lKVkfKxcfMfoa8q00z4GWwihq05Iqk9RQMiMiO43hGJA0F6gLK5uKI8F
         mFLIJUGKNUS5dYNjBSAj4AjvaQzOAVX+CroaoW2QBoRa9N5gGz2QdxdQpDYbM9mbNORo
         cds341qMmbYkfTWYpl5McCiS1TFnzyE9Q2CrcOE2Q9mAN892lxkojYfYI57PqWEU9/ES
         ZN9sEo42OYdMRzy1VDBFW7RsOpUqpH2aPyszyPG5Z+IhgQ02Ya0lV7E5t/2y+kRUi6u1
         HqAMtJCKs42hYjXo0215z7DjJ8t2GZjH8yWOLhRwSs/fRRXEsz2aIQCLdCwDVyL2g/CJ
         ENTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE0LNtUfHwCZfHJtiwpqCqgHEs083VlAicgdPb4arnA=;
        b=WPHr89IqRxQoieZ6RIUV4j0fm5/NhX5KF+mhVl8irW+ALxlI2//MoFGzVV7zrdKoyL
         TF5G939+rVoX52sQIleBqal0T7hUhTFbDLyqw9H4RHyHluOT1z2OytNR7FOedzIM8+Ig
         ElS9VpCNlTT0/RXc4d4b7ON8TmJ7Jbz55UGOfmNTvRN9z5iSkKAZkO0XhiDVIRI+Sjyy
         1ecKzCWXYRCNaMov1POafQ8RRHrCiRbZd3PaG7lervditrO4BRGRRWXT4hqJpq+R4M9X
         Irq/fjXATr4LU9d6gSAfPGCgNqBF4YYsiBCVsteELk2+XkDFx37UGaxT8D/qByTJ4PW6
         WyWg==
X-Gm-Message-State: AOAM531twtysDSsxrQWb7q1XzfUtKAA7D9R77Z37y1SATrRryXYANvLX
        HlZNfG04Nc4aQfZKxTpW7vvHNqvHCfUhkkOt3Fg=
X-Google-Smtp-Source: ABdhPJwTj/Vg5XaivfzLDSl5V6JhFhGHRMpuiP/5bEc/zAG9j98k2eN13ZCFKzPuA5gV/YAwXVD8fcJe12n7P4x5Nps=
X-Received: by 2002:ab0:71ce:: with SMTP id n14mr21513010uao.46.1592250976810;
 Mon, 15 Jun 2020 12:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200608184222.GA899@rikard> <20200608221823.35799-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200608221823.35799-1-rikard.falkeborn@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 20:52:36 +0100
Message-ID: <CACvgo51nGOeCtsCRaUuRGuFvV_EpHqWSph9AeA66Su2-_Fyy-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] linux/bits.h: fix unsigned less than zero warnings
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rikard,

On Mon, 8 Jun 2020 at 23:18, Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> an unsigned unknown high bit, some gcc versions warn due to the
> comparisons of the high and low bit in GENMASK_INPUT_CHECK.
>
> To silence the warnings, only perform the check if both inputs are
> known. This does not trigger any warnings, from the Wtype-limits help:
>
>         Warn if a comparison is always true or always false due to the
>         limited range of the data type, but do not warn for constant
>         expressions.
>
> As an example of the warning, kindly reported by the kbuild test robot:
>
> from drivers/mfd/atmel-smc.c:11:
> drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> |                            ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
> >> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> |                         ^~~~~~~
>
> Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

This version is far better than my approach. Fwiw:

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Thanks
Emil
