Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27171F1740
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgFHLJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 07:09:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0378C08C5C2;
        Mon,  8 Jun 2020 04:09:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so8590322pga.6;
        Mon, 08 Jun 2020 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IadYXFhkE9TxetqZC3/Mn8ce5vAmGMwA3+vZQoNchRc=;
        b=Ucj+OEpk8pKpWezw+2PhPDIuqj0cQXwJt4VGig+J+TqeCvIe5l6jFi5TGu3PvJeAUe
         xZKoHvXL3GuFEceB6AcxWRg8y8EUFSZAyOXanxcuebOXosLO6s+yHv63o54sTnj2ILak
         zs7gO57Fkh7WWfyrAWfBr+nyQvIvV8er5LZJ1J2POMtvBWpfAWS1EDwFG270nhaH7fmc
         YE+xau657m6clbHxg0uOD7mXWb4SM9detXVNlb+/jPMGAXcvfVdqpe2owqvU3JmpCBFZ
         uAX7e+ub+fQ2CDaKVLXSgGBuheLIJnlu7v/ima9sZdo5SzEsiyIa/bWwI6k/Cavy/52k
         BecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IadYXFhkE9TxetqZC3/Mn8ce5vAmGMwA3+vZQoNchRc=;
        b=kGvRtTkz9vHu99sfRss7Nf1k6OIwsYqbvUtIlfej7LBgxVCW2fOZ4s+nrOrQMsVdl0
         OEjb1jn1alVoU1CzLGq7jA6DAgmCKYjhAN8o4XfsDN8SIMOljW4Hn7nUOo4IrA3gECWJ
         d24Z+goE4ux2JX3fdZn92Qlu30kcMv8tvSPh+QQ0evTg6iyk1Q0yym7TQdeZrDau5h90
         TGw11+2tgc47OsvtP2nCUH74gr5MQa8bH1gM4x7/GbRDNGgi0948gK9PMaTxCh8mX51N
         FkvruKqa3kZmH/QTjfc9cJzS3BHqxEsRQn25VLHj4wyf62Fd4vlMpYFB77yC6cxw7LsE
         PhXg==
X-Gm-Message-State: AOAM530Ql0Qxql/YfZZtb5m50x9K75KsQNeZnJUFjTguLISU/gLWLAPA
        XO0Al2S1TEORVkagk9CEKiRyTvVGuvaeMAqy/BA=
X-Google-Smtp-Source: ABdhPJxxVzgo1CEcFBRfmXMb/osSGYUoEshriG7oOTMOKIU+44b7UsUa8SaVcV/sSPCEuMRcaS0xZJ2BmlKDyAzH/Cc=
X-Received: by 2002:a63:305:: with SMTP id 5mr19164999pgd.74.1591614592065;
 Mon, 08 Jun 2020 04:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607203411.70913-1-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 14:09:40 +0300
Message-ID: <CAHp75VfY7fynQC9+ER2iPE9wEU2AwJvUesVi9mmwf-A-3NPoog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] linux/bits.h: fix unsigned less than zero warnings
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 7, 2020 at 11:34 PM Rikard Falkeborn
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

It's much better, than previous variant, thanks!
FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> v1->v2
> * Change to require both high and low bit to be constant expressions
>   instead of introducing somewhat arbitrary casts
>
>  include/linux/bits.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 4671fbf28842..35ca3f5d11a0 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -23,7 +23,8 @@
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __builtin_constant_p(l) && __builtin_constant_p(h), \
> +               (l) > (h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
