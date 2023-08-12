Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919A779E85
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjHLJWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjHLJWP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 05:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CB19A4;
        Sat, 12 Aug 2023 02:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E9A616D5;
        Sat, 12 Aug 2023 09:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0997C433CD;
        Sat, 12 Aug 2023 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691832137;
        bh=oHIFOopjVGe8FRO9TZMz66M6aCivcLPiQR1CNa+qj+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pHDsbngl1SnZP9SXkyteQ8PW3kfgj7S0Thj0P0Q5tUj14AyvxMSce1tSts5dug1wS
         TEqeQDdGe8xa7/pfC2yIh6RPi4+OFSnNoUWUqfiPTAggM9eXpZIJfkR+MfW5/U3KGA
         2Uw3EwFwIvWvlah/VndW9US8VJeaCvlO51jl3y1T9lfTvPtQkJf5oy/FH0TXkdDBec
         PQn2cl3GNwfLAlXsUTIRX5CDyFwHnA4fbwxDxp2l21hDceju7DalBp8+cQ1Lh/W9F9
         OAKlICSVLp9VoZrj6CteFewa8KPfB1TQOmXZGGFmxu0ASqqvntBKDbHXxeNuh3gO+V
         A0a1zXFgIovLA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56c711a889dso2152768eaf.0;
        Sat, 12 Aug 2023 02:22:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfV2mSby+JJ3DWclQNn6/TxkwwKeK9q6HN6EiK3coY/03aj2C0
        uW/jMNDxEufOqPs2ckzfH+WWmRBIaUGql/IfHAQ=
X-Google-Smtp-Source: AGHT+IGcjFblVs5iueZt0jloI0eEW2UYSMxFW+5k21ToY/ZPYjVLpxSMmhmrM8/SoBHwLqjx+lcyHgjFnIZDNlcGPz8=
X-Received: by 2002:a4a:8382:0:b0:566:f8ee:fa67 with SMTP id
 h2-20020a4a8382000000b00566f8eefa67mr3867888oog.0.1691832136859; Sat, 12 Aug
 2023 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-4-arnd@kernel.org>
In-Reply-To: <20230811140327.3754597-4-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 18:21:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0BZ107ngRNQvVO4DjOKj8AOrD2860rOgQ84WP9QfaFw@mail.gmail.com>
Message-ID: <CAK7LNAT0BZ107ngRNQvVO4DjOKj8AOrD2860rOgQ84WP9QfaFw@mail.gmail.com>
Subject: Re: [PATCH 3/9] Kbuild: avoid duplicate warning options
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

On Sat, Aug 12, 2023 at 5:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some warning options are disabled at one place and then conditionally
> re-enabled later in scripts/Makefile.extrawarn.
>
> For consistency, rework this file so each of those warnings only
> gets etiher enabled or disabled based on the W=3D flags but not both.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 43 +++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 9cc0e52ebd7eb..8afbe4706ff11 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -56,20 +56,12 @@ KBUILD_CFLAGS +=3D -Wno-pointer-sign
>  # globally built with -Wcast-function-type.
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wcast-function-type)
>
> -# disable stringop warnings in gcc 8+
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
> -
>  # We'll want to enable this eventually, but it's not going away for 5.7 =
at least
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-overflow)
>
>  # Another good warning that we'll want to enable eventually
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, restrict)
>
> -# Enabled with W=3D2, disabled by default as noisy
> -ifdef CONFIG_CC_IS_GCC
> -KBUILD_CFLAGS +=3D -Wno-maybe-uninitialized
> -endif
> -
>  # The allocators already balk at large sizes, so silence the compiler
>  # warnings for bounds checks involving those possible values. While
>  # -Wno-alloc-size-larger-than would normally be used here, earlier versi=
ons
> @@ -96,8 +88,6 @@ KBUILD_CFLAGS +=3D $(call cc-option,-Werror=3Ddesignate=
d-init)
>  # Warn if there is an enum types mismatch
>  KBUILD_CFLAGS +=3D $(call cc-option,-Wenum-conversion)
>
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
> -
>  # backward compatibility
>  KBUILD_EXTRA_WARN ?=3D $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
>
> @@ -122,11 +112,6 @@ KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-but-se=
t-variable)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-const-variable)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wpacked-not-aligned)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-truncation)
> -# The following turn off the warnings enabled by -Wextra
> -KBUILD_CFLAGS +=3D -Wno-missing-field-initializers
> -KBUILD_CFLAGS +=3D -Wno-sign-compare
> -KBUILD_CFLAGS +=3D -Wno-type-limits
> -KBUILD_CFLAGS +=3D -Wno-shift-negative-value
>
>  KBUILD_CPPFLAGS +=3D -Wundef
>  KBUILD_CPPFLAGS +=3D -DKBUILD_EXTRA_WARN1
> @@ -135,9 +120,12 @@ else
>
>  # Some diagnostics enabled by default are noisy.
>  # Suppress them by using -Wno... except for W=3D1.
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
>
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CFLAGS +=3D -Wno-initializer-overrides
>  # Clang before clang-16 would warn on default argument promotions.
>  ifneq ($(call clang-min-version, 160000),y)
>  # Disable -Wformat
> @@ -151,7 +139,6 @@ ifeq ($(call clang-min-version, 120000),y)
>  KBUILD_CFLAGS +=3D -Wformat-insufficient-args
>  endif
>  endif
> -KBUILD_CFLAGS +=3D -Wno-sign-compare
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, pointer-to-enum-cast)
>  KBUILD_CFLAGS +=3D -Wno-tautological-constant-out-of-range-compare
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unaligned-access)
> @@ -173,8 +160,25 @@ KBUILD_CFLAGS +=3D -Wtype-limits
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wmaybe-uninitialized)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-macros)
>
> +ifdef CONFIG_CC_IS_CLANG
> +KBUILD_CFLAGS +=3D -Winitializer-overrides
> +endif
> +
>  KBUILD_CPPFLAGS +=3D -DKBUILD_EXTRA_WARN2
>
> +else
> +
> +# The following turn off the warnings enabled by -Wextra
> +KBUILD_CFLAGS +=3D -Wno-missing-field-initializers
> +KBUILD_CFLAGS +=3D -Wno-type-limits
> +KBUILD_CFLAGS +=3D -Wno-shift-negative-value
> +
> +ifdef CONFIG_CC_IS_CLANG
> +KBUILD_CFLAGS +=3D -Wno-initializer-overrides
> +else
> +KBUILD_CFLAGS +=3D -Wno-maybe-uninitialized




GCC manual says -Wall implies -Wmaybe-uninitialized.

If you move -Wno-maybe-uninitialize to the "W !=3D 2" part,
-Wmaybe-uninitialized is unneeded in the 'W =3D=3D 2" part.

Maybe, the same applies to -Wunused-but-set-parameter.

Shall we drop warnings implied by another, or
is it clearer to explicitly add either -Wfoo or -Wno-foo?

If desired, we can do such a clean-up later, though.







--
Best Regards
Masahiro Yamada
