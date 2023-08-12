Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D992E77A015
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjHLNLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 09:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE7172E;
        Sat, 12 Aug 2023 06:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D0861934;
        Sat, 12 Aug 2023 13:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60C5C433CC;
        Sat, 12 Aug 2023 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691845893;
        bh=XsDo0pkeZK+z6y3fi0H6lYEULXb9ybhcxEMY5esRyyc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZR9rST1E1jYtIjBQ1C7okGzxzK7USgPTh87NQHBK53WxjTRhwDrtsIM/LUfjomQtg
         cz3/zUbgJCQsHaOk35Z8WU9EFgFM80BaP2em+Gx5Po7O2UVK+s/tSYQz5H0AQWBUnH
         kV3dADBNYAmwFdVjceLvjzdZzkV/T44o8KhZWHuTJp+JeJJn/SMDF8Z/bvEeWaBIcH
         5TBNy3VfLI0A81RQya7yHoa5t/8ePzWfE9s6potJAUjlBPoTMlEKhk3EFI/1+/uO51
         ae29U2Qm/1NWk+Ldtj1BXSeLR9wbeR7oGTx13iQOmJKNz3aiVDel5iE6tP01IBtHSw
         NNpWDv5hEjQLQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bca857accbso2667859a34.0;
        Sat, 12 Aug 2023 06:11:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwfD8S/ZuD+Opc4rtCvuGWnQqQ0zcgyJ7I2SKRdepQfFR/cTxrq
        p2CRrGJMZbgwLVE1J9oSD2LoGtb+CLjHU37uMng=
X-Google-Smtp-Source: AGHT+IGeGJeMjyb6mjg59iZwFZuQbxhausX7lvWYmaSPCqoOVpE8I3+3hmpGGSRfq+p9sGpuYpZW4ebntvZBPzFDRTs=
X-Received: by 2002:a05:6871:6a5:b0:19f:4dc2:428e with SMTP id
 l37-20020a05687106a500b0019f4dc2428emr5747947oao.14.1691845893103; Sat, 12
 Aug 2023 06:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-6-arnd@kernel.org>
In-Reply-To: <20230811140327.3754597-6-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 22:10:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuTOwHA0zz8MqxPdt5snMstpSY7==0o6kmU-RML3nioQ@mail.gmail.com>
Message-ID: <CAK7LNASuTOwHA0zz8MqxPdt5snMstpSY7==0o6kmU-RML3nioQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] extrawarn: enable format and stringop overflow
 warnings in W=1
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

On Sat, Aug 12, 2023 at 10:50=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The stringop and format warnings got disabled globally when they were
> newly introduced in commit bd664f6b3e376 ("disable new gcc-7.1.1 warnings
> for now"), 217c3e0196758 ("disable stringop truncation warnings for now")
> and 5a76021c2eff7 ("gcc-10: disable 'stringop-overflow' warning for now")=
.
>
> In all cases, the sentiment at the time was that the warnings are
> useful, and we actually addressed a number of real bugs based on
> them, but we never managed to eliminate them all because even the
> build bots using W=3D1 builds only see the -Wstringop-truncation
> warnings that are enabled at that level.
>
> Move these into the W=3D1 section to give them a larger build coverage
> and actually eliminate them over time.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 87bfe153198f1..ec528972371fa 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -16,8 +16,6 @@ KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes
>  KBUILD_CFLAGS +=3D -Wno-format-security
>  KBUILD_CFLAGS +=3D -Wno-trigraphs
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning,frame-address,)
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-truncation)
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
>
>  ifneq ($(CONFIG_FRAME_WARN),0)
> @@ -56,9 +54,6 @@ KBUILD_CFLAGS +=3D -Wno-pointer-sign
>  # globally built with -Wcast-function-type.
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wcast-function-type)
>
> -# We'll want to enable this eventually, but it's not going away for 5.7 =
at least
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-overflow)
> -
>  # Another good warning that we'll want to enable eventually
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, restrict)
>
> @@ -111,6 +106,9 @@ KBUILD_CFLAGS +=3D -Wmissing-include-dirs
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-but-set-variable)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-const-variable)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wpacked-not-aligned)
> +KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-overflow)
> +KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-truncation)


These are redundant because -Wall implies
-Wformat-overflow and -Wformat-truncation
according to the GCC manual.




--=20
Best Regards
Masahiro Yamada
