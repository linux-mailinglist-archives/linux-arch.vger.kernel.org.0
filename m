Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4377A01C
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjHLNUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 09:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F212D;
        Sat, 12 Aug 2023 06:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E146224B;
        Sat, 12 Aug 2023 13:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B962C433CD;
        Sat, 12 Aug 2023 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691846449;
        bh=KiVWzwXffBabZj7CaC7L9spu8MLm1nLoW46GmfuHr5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uDsgi91R7OO5cmIqME2rfwo/u+9X6sdMXifhh2eW56E/9QHFZ8buOri1KRG/jt+G6
         8+QbJCClsDsl3SoV9tFc3Cv07ACdjrY43V6J82KYjrWN+j6Nf+o+1DHSXdav+UwH1b
         E+t2eL3o1+i4HI/sIEy9aEkaFfJgpFUSov1mjkfsF83aZ9Xb4xsf+zKCUrl9rUczuk
         Ub5O998ndmWR0lS73BW0Vomw1cq5n4wuCpFET9oJiIGfU+8QHRsYlttxiuA2VZ4WTG
         eFMh4mR28MXXv0+6rLeMYOU4RhwNWOVHLA4EdU/EZAbMHFhuutweNHmeeOqOq+ERdx
         yfGLLBpOGB3PA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c4c5375329so357371fac.2;
        Sat, 12 Aug 2023 06:20:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYEmw7cioUmP6HTh82tOjmN81rFcJ6L6QauRrDywCGQFsltOcc
        pty4a71jH17E46qGwTPBxE7ievGzy2FYtF2g+Go=
X-Google-Smtp-Source: AGHT+IHoxEQlqrIU4O3r11MseHpu1yyRFBIkG9En7CKCXXTtmG0Q429l28yOXSom5BW0J5S5cdaQyIGpzfnCB8QYgXk=
X-Received: by 2002:a05:6870:b4ac:b0:1bf:8c9a:9a2c with SMTP id
 y44-20020a056870b4ac00b001bf8c9a9a2cmr4873526oap.15.1691846448497; Sat, 12
 Aug 2023 06:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-7-arnd@kernel.org>
In-Reply-To: <20230811140327.3754597-7-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 22:20:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmwOE0YD0BGKTgbqwiMWjX-b=f8WwyFCnv-b9hi9SmXA@mail.gmail.com>
Message-ID: <CAK7LNARmwOE0YD0BGKTgbqwiMWjX-b=f8WwyFCnv-b9hi9SmXA@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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


Like the previous patch, -Wall implies -Wrestrict.

I'd like to remove it as we can save cc-option call.




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


--=20
Best Regards
Masahiro Yamada
