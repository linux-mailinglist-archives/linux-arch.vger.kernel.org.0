Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C06D18D4
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaHoV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 31 Mar 2023 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCaHoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 03:44:20 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C710D7;
        Fri, 31 Mar 2023 00:44:20 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id p204so26428290ybc.12;
        Fri, 31 Mar 2023 00:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeeuMn+18qxZye2SkBV27ZVnmjOgzoZ1e4uAuUPEtd8=;
        b=NEkNs9nIyiqmMCe4ucyDNo3UPYYhNlVff4aJXGa3ESoR8yek03zaeTDqfv2xTi1Vpv
         B5i67hE8Y2IUZgV7iM0P/CDFAnTiJ/jjNehmTptAyTvDTW++dcWt33APlRJ/ClDJPknK
         VuTBJI/tRGEe7SZNn6J/+pjNeaqXxmx6r+0TUcCIEzFrfD/ypvxAQWaQH1PP7TamXeIk
         mi4Ag6my+86WEGJ54Z0MJlriHlijC4tpq/UTXV1agq+TjTVNkL5kI/dizHZEOtW4sKpK
         No8pUea+d0oihb7ybP4PgzlH+S+XixCjJ8NF1yiIAncyKNq3h9hRDR496FiEyqdrU7MF
         2MAw==
X-Gm-Message-State: AAQBX9dPHiJtlZCkSFYUSzcZGZ0q8/ms8o5PWixkoDjEBi3slStTaNgc
        vOFlgaZahqcTYuKw092Yy3jJxVAeAEaOdXsV
X-Google-Smtp-Source: AKy350YEyQ70by6BsyR0OM1g8DmPwmCsMNXU1owLYTO5sC6CPGI2+B8oKewqEBQfHU30cnjqDpMAdQ==
X-Received: by 2002:a25:dbc3:0:b0:b48:e823:bd0d with SMTP id g186-20020a25dbc3000000b00b48e823bd0dmr24596375ybf.23.1680248659121;
        Fri, 31 Mar 2023 00:44:19 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 85-20020a810658000000b005460412e2fcsm374611ywg.70.2023.03.31.00.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:44:18 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5456249756bso400497577b3.5;
        Fri, 31 Mar 2023 00:44:18 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:544:8bc1:a179 with SMTP id
 h31-20020a81b65f000000b005448bc1a179mr13310763ywk.4.1680248658426; Fri, 31
 Mar 2023 00:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230330195604.269346-1-corbet@lwn.net> <20230330195604.269346-5-corbet@lwn.net>
In-Reply-To: <20230330195604.269346-5-corbet@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Mar 2023 09:44:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=yyEciJD6iU-g90T3Qxg+t27Vz6VuojkhbxdODDJGwA@mail.gmail.com>
Message-ID: <CAMuHMdU=yyEciJD6iU-g90T3Qxg+t27Vz6VuojkhbxdODDJGwA@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: move m68k architecture documentation under Documentation/arch/
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jon,

On Thu, Mar 30, 2023 at 9:56 PM Jonathan Corbet <corbet@lwn.net> wrote:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/m68k into arch/ and fix all in-tree references.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks for your patch!

> diff --git a/Documentation/translations/zh_CN/arch/parisc/debugging.rst b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
> index 9bd197eb0d41..c6b9de6d3175 100644
> --- a/Documentation/translations/zh_CN/arch/parisc/debugging.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
> @@ -1,4 +1,4 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>
>  :Original: Documentation/arch/parisc/debugging.rst
>
> diff --git a/Documentation/translations/zh_CN/arch/parisc/index.rst b/Documentation/translations/zh_CN/arch/parisc/index.rst
> index 848742539550..9f69283bd1c9 100644
> --- a/Documentation/translations/zh_CN/arch/parisc/index.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/index.rst
> @@ -1,5 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>
>  :Original: Documentation/arch/parisc/index.rst
>
> diff --git a/Documentation/translations/zh_CN/arch/parisc/registers.rst b/Documentation/translations/zh_CN/arch/parisc/registers.rst
> index caf5f258248b..a55250afcc27 100644
> --- a/Documentation/translations/zh_CN/arch/parisc/registers.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/registers.rst
> @@ -1,4 +1,4 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>
>  :Original: Documentation/arch/parisc/registers.rst
>

These changes do not belong in this patch.

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
