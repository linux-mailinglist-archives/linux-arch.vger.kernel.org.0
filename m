Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B831376B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhBHPYu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 10:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhBHPUU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2021 10:20:20 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C9C061786;
        Mon,  8 Feb 2021 07:19:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c5so1726850qth.2;
        Mon, 08 Feb 2021 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=lfyLu2giIvQHAiyFdLqX9LY0OGrzlVaPuwSjSMWgNvo=;
        b=bFgYcI0tXB2OYiUNwN3bYyLvWdrAC+HPXIh7Obmk7fDusJtRMl5HfHE+hxWj3u5AZc
         ZlOhJ/RulM3wFzbX/YC7Sbs/WJYN/TOW/9F9IpFvGlzyFNmRstTTJJtXandLLEL9U4w9
         GA5c9k8XTm5sXpQJ5Za3boxejN/5hL8t5cnY7Gj5EbGZ7+SNuTd1lJgkgRyqwPMXYzHv
         PnoSKEDkCR6RbeFxUE78AzyrU4V3Uh3ta7Fmkr4qXlM5JowvjrGRtLaUyS7DU6sUUTzR
         EqTU8kADUFogcrp+e0mBMmUKDv7Up++yAsHitwt53rE3lEYP1wn1SW/d5Mu8qE+nT4Z9
         4H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=lfyLu2giIvQHAiyFdLqX9LY0OGrzlVaPuwSjSMWgNvo=;
        b=ErtNKzjuYVkBCJL24bQvAYiUbowf8FuDRx6/gXz273PP7c+8G0knkUV1fJDNDfjwM4
         JAiafR4ZbOSng3jWIjuxeq6efbAxGfxTT70zVh/pToEOZNrF0m3y6qnM3N2m69tlZWro
         wODDUhQLa/Fk42GJFnVpwuuKhKE4V/QJJRJ0ali9/9DaXISIzs6cYiO/bcVVSEbdd/qD
         HUiYaU6i6AHoeMJECcqA8fxtENu3iSy7SpUT7dNZH7IT19xmU5JQA7zATGotKuP4P343
         766TUASE7B2vmG5SWvSZ82/IMutuBpAmwsyM0jq51iKKeFXP2toSUmXqACOI9Scm+DxX
         ImRw==
X-Gm-Message-State: AOAM531ZKtk3Kqs8KbboBIomREPwPT1ds+bObSa8QF0TLMJYQmOMXaVN
        6WpQOxhGc0iepFJ+mDVlZMw=
X-Google-Smtp-Source: ABdhPJyaGerJEvGjV9Mmzqw2vY71Mqu9z/fv3KZnlW+YoYJqXn0ZMX+wqGgUC7cywbF90lsQ090j7w==
X-Received: by 2002:ac8:5909:: with SMTP id 9mr15873605qty.39.1612797576127;
        Mon, 08 Feb 2021 07:19:36 -0800 (PST)
Received: from [192.168.1.171] (pool-68-133-6-116.bflony.fios.verizon.net. [68.133.6.116])
        by smtp.gmail.com with ESMTPSA id m64sm16848259qkb.90.2021.02.08.07.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 07:19:35 -0800 (PST)
Date:   Mon, 08 Feb 2021 10:19:33 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20210208121227.GD17908@zn.tnic>
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain> <YCCFGc97d2U5yUS7@arch-chirva.localdomain> <YCCIgMHkzh/xT4ex@arch-chirva.localdomain> <20210208121227.GD17908@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: =?UTF-8?Q?Re=3A_PROBLEM=3A_5=2E11=2E0-rc7_fail?= =?UTF-8?Q?s_to_compile_with_error=3A_=E2=80=98-m?= =?UTF-8?Q?indirect-branch=E2=80=99_and_=E2=80=98-fcf-p?= =?UTF-8?Q?rotection=E2=80=99_are_not_compatible?=
To:     Borislav Petkov <bp@suse.de>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, jpoimboe@redhat.com, nborisov@suse.com,
        seth.forshee@canonical.com, yamada.masahiro@socionext.com
From:   AC <achirvasub@gmail.com>
Message-ID: <82FA27E6-A46F-41E2-B7D3-2FEBEA8A4D70@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

That did fix it, thank you!

On February 8, 2021 7:12:27 AM EST, Borislav Petkov <bp@suse=2Ede> wrote:
>On Sun, Feb 07, 2021 at 07:40:32PM -0500, Stuart Little wrote:
>> > On Sun, Feb 07, 2021 at 06:31:22PM -0500, Stuart Little wrote:
>> > > I am trying to compile on an x86_64 host for a 32-bit system; my
>config is at
>> > >=20
>> > > https://termbin=2Ecom/v8jl
>> > >=20
>> > > I am getting numerous errors of the form
>> > >=20
>> > > =2E/include/linux/kasan-checks=2Eh:17:1: error: =E2=80=98-mindirect=
-branch=E2=80=99
>and =E2=80=98-fcf-protection=E2=80=99 are not compatible
>
>Does this fix it?
>
>---
>
>diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>index 5857917f83ee=2E=2E30920d70b48b 100644
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -50,6 +50,9 @@ export BITS
> KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
> KBUILD_CFLAGS +=3D $(call cc-option,-mno-avx,)
>=20
>+# Intel CET isn't enabled in the kernel
>+KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dnone)
>+
> ifeq ($(CONFIG_X86_32),y)
>         BITS :=3D 32
>         UTS_MACHINE :=3D i386
>@@ -120,9 +123,6 @@ else
>=20
>         KBUILD_CFLAGS +=3D -mno-red-zone
>         KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
>-
>-	# Intel CET isn't enabled in the kernel
>-	KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dnone)
> endif
>=20
> ifdef CONFIG_X86_X32
