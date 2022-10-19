Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF2605001
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJSS4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJSS4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 14:56:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE613ECC7
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:56:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f4-20020a9d0384000000b0066208c73094so974110otf.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8CxBkZb6IhM+m9VFiO2jPrdWrbVMTNRewPIBF3tqkA=;
        b=AHNIIr/yPXz4tPtwy3N0+CS8dtLnS1uko6A/0obc0vzi2BOtldQhySPxD40rDPQWo2
         oOiLoggmXtuKbETCejbTtKYbkzVXhkmPLTlKT8Xz5ci/Qnrm/IQu6DMWn6PBLtmzO06C
         qTvqu1BL4SkqzYZ+SkeI+iq7XwZv3sAUe2RD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8CxBkZb6IhM+m9VFiO2jPrdWrbVMTNRewPIBF3tqkA=;
        b=jzjknUJVLx1cQTqaeyD8N6kI9ilHtSaFwrXm3vcNXXiIr3k/JB5Gy9RxhvNf372vcg
         CL6sdmWzJeeV83Ao3FxVKGSFNT1x6wcNGXzaQs1sr6E6NsR3fIhfUvea0Gnf8BBdwVqV
         JC96Keas2Ft1ymct9W94CpjnKLgGAE62vJ0zMgFLWXbzR+pNESnKf7e/TNbC9tFtW1t+
         gad8uqTyewsrY33ZQ9jCYyeg8eSqnw8vcCfwjwkZgUAKGZdqk2IrxJyrp+fyQqUialO5
         RYS/yI4AHn97XJA9yFdsOG4KNVVOtziWlf8s0UcrcrygeElBghcGdg4tInmZChw18D3b
         UKlw==
X-Gm-Message-State: ACrzQf1HzAKDqdQ8ezmi74mW02JQw4GUymRNUr90QBh4kdFsCLFft7/U
        CT/+FAMC35yQEtvCx6iuwom84JViNgPD2A==
X-Google-Smtp-Source: AMsMyM6Rsbi9kBWKJttmIguGB1lfWlBp6qZntQQ/JYfjVjgSsZOoL0tGfCNFhnvtP8i568xeIQ3QYg==
X-Received: by 2002:a9d:641a:0:b0:660:da68:fe52 with SMTP id h26-20020a9d641a000000b00660da68fe52mr4778260otl.16.1666205779357;
        Wed, 19 Oct 2022 11:56:19 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id d14-20020a05680813ce00b0035493cbd9absm7140270oiw.21.2022.10.19.11.56.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:56:17 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id i25-20020a4a8d99000000b0047fa712fc6dso3667923ook.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:56:17 -0700 (PDT)
X-Received: by 2002:a4a:aeca:0:b0:480:2413:1edc with SMTP id
 v10-20020a4aaeca000000b0048024131edcmr4334366oon.96.1666205776676; Wed, 19
 Oct 2022 11:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
In-Reply-To: <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 11:56:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
Message-ID: <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:21 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> A few times in the past, we've split a warning flag into a group so
> that we could be more specific about distinct cases. Perhaps if
> -Wpointer-sign was a group that implied -Wpointer-char-sign, then the
> kernel could use -Wpointer-sign -Wno-pointer-char-sign.

That might be interesting, just to see how much of the kernel is about
'char *' and how much is other noise.

Just for fun (for some definition of "fun") I tried to remove the
-Wno-pointer-sign thing, and started building a kernel.

After fixing fortify-string.h to not complain (which was indeed about
strlen() signedness), it turns out a lot were still about 'char', but
not necessarily the <string,h> functions.

We use 'unsigned char *' for our dentry data, for example, and then you get

     warning: pointer targets in initialization of =E2=80=98const unsigned
char *=E2=80=99 from =E2=80=98char *=E2=80=99 differ in signedness

when you do something like

    QSTR_INIT(NULL_FILE_NAME,

which is simply doing a regular initializer assignment, and wants to
assign a constant string (in this case the constant string "null") to
that "const unsigned char *name".

That's certainly another example of "why the heck did the compiler
warn about that thing".

You can literally try to compile this one-liner with gcc:

     const unsigned char *c =3D "p";

and it will complain. What a hugely pointless warning.

BUT.

It turns out we have a lot of non-char warnings too.

The kernel does all these "generic functions" that are based on size, like

        atomic_try_cmpxchg_acquire()

which are basically defined to be about "int sized object", but with
unspecified sign.

And the sign is basically pointless. Some people want "unsigned int",
others might want a signed int.

So from a quick grep, we do have a lot of strlen/strcpy cases, but we
also do have a lot of other cases.

Hundreds and hundreds of that atomic_try_cmpxchg_acquire(), for
example. And they might be trivial to fix (it might be similar to the
fortify-string.h one where it's just a header file that generates most
of them in one single place), but with all the ones that are just
clearly the compiler being silly, they aren't really even worth
looking at.

                    Linus
