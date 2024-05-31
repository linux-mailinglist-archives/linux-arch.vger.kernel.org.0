Return-Path: <linux-arch+bounces-4632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087288D5D29
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC11C218E7
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CB15382E;
	Fri, 31 May 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmz11taJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B84E1C8;
	Fri, 31 May 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145565; cv=none; b=FBLgO1PZv50j2hznltCU4ktFX9U/eLDcb8ET61Qz8ORPFd7y0OrdCY7c8ecF6N9BCwmT5ySIcyz85msvMAfVHolPmP0UN7bNd09MT1GiGTA7AXplAuJPcVvfze8CTK4XB0YhUfKENZz1ODrCWV/dvarmP60+z6pLq3lEayTGgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145565; c=relaxed/simple;
	bh=8rhSEmWMci+lrN0K4ohr4Uw7Q3j2uy4yq8C2n//ukdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLD6Zp7zjlTN9agR4yvEU5Oz7FuwRSB8bwV7q8SGIWApGb6a+6/qYYg2kRVrQrPWnVpJ/GMl9IDEGnWU8WFS27Dyioy2h3L1N4eVjqIicGiOzOmGQ8k9qSDh2ptV8JIoWr18aRTtyEgL3z62Tw2yNaTNX30gwWGZN9DrHxxPtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmz11taJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F157DC116B1;
	Fri, 31 May 2024 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717145565;
	bh=8rhSEmWMci+lrN0K4ohr4Uw7Q3j2uy4yq8C2n//ukdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pmz11taJfxdx0uFXHcqai3LXX017MUS0ITOE8we/yXXTihr+nNY/s9SmdAG9DCF8R
	 9UXsU0q/a0LNT/bujh4SBzG5Ptrp0QIfL4AhLexIRU9722Akam1TmsXCI/rFkpczzo
	 wlL7DIasx1IGkZybukcLbxMj3pvte+coAcwgvzNRAm9qQg1A6MzohNhicE2CgQxkdG
	 Hbuy8k2J+akmFLrz9o+H8BLhuqpYhnb6psipZ9rkeAmG4T38qWY7UIZJ98klg4j6fn
	 OtjVrd687odMlc5GGjHjm3yhQ9gBeTeY1rGkujZcI4JGjK5hdV6jYED/zus+SQgSBt
	 pWvmfg7A0eXWQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso2603642e87.3;
        Fri, 31 May 2024 01:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+pR8Gu5PCArc2nY8Z+ebJLUc4ZDLWaYTbFP8GcGfUdB89tBUARKlIS/v8EYwJtmhQYNBiFa4e+sbZLN3smmoHHZb7Dgfvv7NlRYnumUOnsTxubanqIIOwkqk9EkN60tn1yWPuHzwx+A==
X-Gm-Message-State: AOJu0Yys5sBoloDyY+1SXuKZ5xaPbchwP9sWNvtetD6XclDoDQvXtmCR
	gwaDRZbix89dihGfP3bhRh8dp292Ms17xBTCgxy4XRiIGty7GR/hn7jUO29xTvQW/tFwqLFKEIa
	mZNqHkADMg8f0xn/CRMtbqgaGTK4=
X-Google-Smtp-Source: AGHT+IEvq57ZRxJcJOYZh6B++SqfSCGoCYQjo4N74EP+P9s0e3YyIW1uOYLA8KgPxsYGEhB8v0aMT1OnsRas65UHGD4=
X-Received: by 2002:a19:a40a:0:b0:51d:9f10:71b7 with SMTP id
 2adb3069b0e04-52b8955ac59mr1052287e87.28.1717145563673; Fri, 31 May 2024
 01:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <20240506133544.2861555-2-masahiroy@kernel.org> <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
In-Reply-To: <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 31 May 2024 17:52:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com>
Message-ID: <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kbuild@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:36=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, May 6, 2024, at 15:35, Masahiro Yamada wrote:
> > The objtool, sanitizers (KASAN, UBSAN, etc.), and profilers (GCOV, etc.=
)
> > are intended for kernel space objects. To exclude objects from their
> > coverage, you need to set variables such as OBJECT_FILES_NON_STNDARD=3D=
y,
> > KASAN_SANITIZE=3Dn, etc.
> >
> > For instance, the following are not kernel objects, and therefore shoul=
d
> > opt out of coverage:
> >
> >   - vDSO
> >   - purgatory
> >   - bootloader (arch/*/boot/)
> >
> > Kbuild can detect these cases without relying on such variables because
> > objects not directly linked to vmlinux or modules are considered
> > "non-standard objects".
> >
> > Detecting objects linked to vmlinux or modules is straightforward:
> >
> >   - objects added to obj-y are linked to vmlinux
> >   - objects added to lib-y are linked to vmlinux
> >   - objects added to obj-m are linked to modules
> >
>
> I noticed new randconfig build warnings and bisected them
> down to this patch:
>
> warning: unsafe memchr_inv() usage lacked '__read_overflow' symbol in lib=
/test_fortify/read_overflow-memchr_inv.c
> warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/te=
st_fortify/read_overflow-memchr.c
> warning: unsafe memscan() usage lacked '__read_overflow' symbol in lib/te=
st_fortify/read_overflow-memscan.c
> warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/te=
st_fortify/read_overflow-memcmp.c
> warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in lib/te=
st_fortify/read_overflow2-memcpy.c
> warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/t=
est_fortify/read_overflow2-memcmp.c
> warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/t=
est_fortify/read_overflow2-memmove.c
> warning: unsafe memcpy() usage lacked '__read_overflow2_field' symbol in =
lib/test_fortify/read_overflow2_field-memcpy.c
> warning: unsafe memmove() usage lacked '__read_overflow2_field' symbol in=
 lib/test_fortify/read_overflow2_field-memmove.c
> warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/te=
st_fortify/write_overflow-memcpy.c
> warning: unsafe memmove() usage lacked '__write_overflow' symbol in lib/t=
est_fortify/write_overflow-memmove.c
> warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/te=
st_fortify/write_overflow-memset.c
> warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/te=
st_fortify/write_overflow-strcpy-lit.c
> warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/te=
st_fortify/write_overflow-strcpy.c
> warning: unsafe strncpy() usage lacked '__write_overflow' symbol in lib/t=
est_fortify/write_overflow-strncpy-src.c
> warning: unsafe strncpy() usage lacked '__write_overflow' symbol in lib/t=
est_fortify/write_overflow-strncpy.c
> warning: unsafe strscpy() usage lacked '__write_overflow' symbol in lib/t=
est_fortify/write_overflow-strscpy.c
> warning: unsafe memcpy() usage lacked '__write_overflow_field' symbol in =
lib/test_fortify/write_overflow_field-memcpy.c
> warning: unsafe memmove() usage lacked '__write_overflow_field' symbol in=
 lib/test_fortify/write_overflow_field-memmove.c
> warning: unsafe memset() usage lacked '__write_overflow_field' symbol in =
lib/test_fortify/write_overflow_field-memset.c
>
> I don't understand the nature of this warning, but I see
> that your patch ended up dropping -fsanitize=3Dkernel-address
> from the compiler flags because the lib/test_fortify/*.c files
> don't match the $(is-kernel-object) rule. Adding back
> -fsanitize=3Dkernel-address shuts up these warnings.


In my understanding, fortify-string is independent of KASAN.

I do not understand why -fsanitize=3Dkernel-address matters.



> I've applied a local workaround in my randconfig tree
>
> diff --git a/lib/Makefile b/lib/Makefile
> index ddcb76b294b5..d7b8fab64068 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -425,5 +425,7 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TE=
ST_FORTIFY_LOGS)) FORCE
>
>  # Fake dependency to trigger the fortify tests.
>  ifeq ($(CONFIG_FORTIFY_SOURCE),y)
> +ifndef CONFIG_KASAN
>  $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
> +endif
>  endif
>
>
> which I don't think we want upstream. Can you and Kees come
> up with a proper fix instead?
>


I set CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_KASAN=3Dy,
but I did not observe such warnings.
Is this arch or compiler-specific?


Could you provide me with the steps to reproduce it?





--
Best Regards
Masahiro Yamada

