Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A1781C17
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjHTChi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHTChi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB0847C0;
        Sat, 19 Aug 2023 18:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F1561959;
        Sun, 20 Aug 2023 01:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34C3C433CB;
        Sun, 20 Aug 2023 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692495943;
        bh=6fcQLBduqpJE52egBZQkcMs9RprzwAUDcASkLZuT6Zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1z1ywUGeI0d7gh0O6Remzq5PxzL6iYeVC524AR+yPTJTSajxGOPIJgtFzqwT/Ugl
         llVLRrML0HM2+mDEMJyZMuHUc9B610+jN7Ekkic0muYSR9gldoro5OuH1YyLkyLFHz
         BB4aLogbPv4Px74pW6kR37A8cWLtkre4lG4NHNKDzysvNhZbxEzS/6TH3k4BZB1XZO
         YSiTICSRMnz+0DJr6mSkTU0sVCUg/wC6XUnoWTGUJ8qqfRpN/g+LC9ORYn7GS4SDLe
         5Yk/4YyoRKYFbYCJxXSAjdHUJdIGJQ+Hok/u3mo33JGcP/9mTR9USLS3adwnbSwv+Y
         NanEoV3C4c7Dw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1bfca0ec8b9so1372812fac.2;
        Sat, 19 Aug 2023 18:45:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxldTex8kRrkJ2RMai0uzZ0eTd37rGuCSWSRDIrnAbhcYGCGlyJ
        Z3wE8fXuRv/7N7vOn1ZpqgHRESz27P+vrB36P0Y=
X-Google-Smtp-Source: AGHT+IGsZifTiodwRSU4On/Zy2oCp44tbAWfjza+kklugHVAOlgDj+S+yAHIkLlrHrRTHc/lOwJSkYaPEuEhxKIO+xE=
X-Received: by 2002:a05:6870:73c6:b0:1bf:61e3:df1 with SMTP id
 a6-20020a05687073c600b001bf61e30df1mr4559515oan.50.1692495942212; Sat, 19 Aug
 2023 18:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-7-arnd@kernel.org>
In-Reply-To: <20230811140327.3754597-7-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 10:45:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToUuWO2-Z=2A+Ubc8iwxRg8VVWFoEpDtHrtDXcSVzg1Q@mail.gmail.com>
Message-ID: <CAK7LNAToUuWO2-Z=2A+Ubc8iwxRg8VVWFoEpDtHrtDXcSVzg1Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] extrawarn: move -Wrestrict into W=1 warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023 at 4:40=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are few of these, so enable them whenever W=3D1 is enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index ec528972371fa..8abe90270b335 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -54,9 +54,6 @@ KBUILD_CFLAGS +=3D -Wno-pointer-sign
>  # globally built with -Wcast-function-type.
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wcast-function-type)
>
> -# Another good warning that we'll want to enable eventually
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, restrict)
> -
>  # The allocators already balk at large sizes, so silence the compiler
>  # warnings for bounds checks involving those possible values. While
>  # -Wno-alloc-size-larger-than would normally be used here, earlier versi=
ons
> @@ -99,6 +96,7 @@ ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
>
>  KBUILD_CFLAGS +=3D -Wextra -Wunused -Wno-unused-parameter
>  KBUILD_CFLAGS +=3D -Wmissing-declarations
> +KBUILD_CFLAGS +=3D $(call cc-option, -Wrestrict)
>  KBUILD_CFLAGS +=3D -Wmissing-format-attribute
>  KBUILD_CFLAGS +=3D -Wmissing-prototypes
>  KBUILD_CFLAGS +=3D -Wold-style-definition
> @@ -120,6 +118,7 @@ else
>  # Suppress them by using -Wno... except for W=3D1.
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, restrict)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-truncation)
> --
> 2.39.2
>

Applied  to linux-kbuild. Thanks.
--=20
Best Regards
Masahiro Yamada
