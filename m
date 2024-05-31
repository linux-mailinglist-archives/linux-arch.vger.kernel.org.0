Return-Path: <linux-arch+bounces-4634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D38D5F63
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A912289AAF
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A219150980;
	Fri, 31 May 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwNNV4NV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24C1420A8;
	Fri, 31 May 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150628; cv=none; b=EwbfrKa+/LiR12BrqJhCh97oWtb0sW0Ki2ZzzJvOkBFvLVnGqvHWazXPylEpCSpFYMnVZMZMSPJ+AEK22B/IzwbJmQbFAmfqFOIfbB7vV78o8w1Rk+e6m3s755CipL1nQMcKATIe1MliGWmT7mJ9QGhSokk2j4/6f4IYAfs4Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150628; c=relaxed/simple;
	bh=t03VszJlYXWjlgLgRz4DrrJUItlK5fWgyIBqemTmRtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYzhyV64ty114tTmPgftyXyF70infcKu1S9o/s2O3A9N5XSF5t8FGIOD06txXflkhro2zleheyrBuOkzBGDKHVnYR0qGuyjyBHzrUaywqNHchSGSIjbhdKzOtq7JvX/d0n+nvDcceCQ70LaG5p+4rlul2+ZT99l3nuva4nAwVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwNNV4NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2575C32789;
	Fri, 31 May 2024 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150627;
	bh=t03VszJlYXWjlgLgRz4DrrJUItlK5fWgyIBqemTmRtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OwNNV4NVWYhb8XQhusRpYk4z3BAAEsR63IshMyAo1R+SN7+LyGc+EgTcWAAhHfAkx
	 Dy/IeAZDixFPoYCj+EVj17U69ic/eKAPJKTqLdfwRmvgz/ojvB91rmimCbaO2Fd+f0
	 A3+s71Ds6Tli1quSxCQ5Hn0uEw/UKq5L2PoO4vjFn9Deq9frUn1vJ159fbAvyqfaX6
	 gHQ7G3r2Nn5+9znCMpd0zeYg1U2+MS8KfuuyxUXaM9D8v0sAAqH+oo34ubIuPANrjv
	 d4IgxAj05wERlT3HMFmQDF7tbOzu9PDnE+MYIUWEAod8CvuIKXc6F7YyAGsXQnB8X5
	 cELxPcLQOthAg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so10440911fa.0;
        Fri, 31 May 2024 03:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxo6KOmGnFZsUVw1gkHdWTUGFk6EUUB4Mr9J2kdB26AB2aA07yp38pommhLDuMP+Y4vWs1bT+O1WWHB+ehRq27AVSIqtsMJ7E81FO9O0ZEHHXktEcmYsx1xOPV1CtoTJm9UG8ttofWwg==
X-Gm-Message-State: AOJu0YztF1i3Ph/s01k4cS10RCg8PX3WXBY/06Pr111dW5qT1KLGjlyM
	6n89CQkJLrL6LXXGpOBmQLJKTAXSw6PBHhbWUxQKUpG3GsRzYRju+QD9pztqkf+1W70YDfQE6df
	FXRHu5xj1/hVQ8XfjgD7kKqot6ng=
X-Google-Smtp-Source: AGHT+IGph5h2oW3Dk7SWlCjgispuNa465sTR/iGdfB03Qip20ZxOhdUXcN+IBJrlNNPf+O5gHNrReQc8qPokrfWTY4Q=
X-Received: by 2002:a2e:818c:0:b0:2da:736d:3cf5 with SMTP id
 38308e7fff4ca-2ea951ac985mr11126011fa.41.1717150626510; Fri, 31 May 2024
 03:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <20240506133544.2861555-2-masahiroy@kernel.org> <0e8dee26-41cc-41ae-9493-10cd1a8e3268@app.fastmail.com>
 <CAK7LNAQOdQMi-4ODy69urh7mcfoGrwKt17LBDQLTujxWrj3xjw@mail.gmail.com> <e2054e49-c465-46c6-a14d-b48949a738c5@app.fastmail.com>
In-Reply-To: <e2054e49-c465-46c6-a14d-b48949a738c5@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 31 May 2024 19:16:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4kzwJdf1HtnwK86VuMqpL2CBtpSsVcFH-EGizqLqAFA@mail.gmail.com>
Message-ID: <CAK7LNAR4kzwJdf1HtnwK86VuMqpL2CBtpSsVcFH-EGizqLqAFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kbuild@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 6:06=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, May 31, 2024, at 10:52, Masahiro Yamada wrote:
> > On Tue, May 28, 2024 at 8:36=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>
> >> I don't understand the nature of this warning, but I see
> >> that your patch ended up dropping -fsanitize=3Dkernel-address
> >> from the compiler flags because the lib/test_fortify/*.c files
> >> don't match the $(is-kernel-object) rule. Adding back
> >> -fsanitize=3Dkernel-address shuts up these warnings.
> >
> >
> > In my understanding, fortify-string is independent of KASAN.
> >
> > I do not understand why -fsanitize=3Dkernel-address matters.
>
> Right, this is something I've failed to understand as well
> so far.
>
> >> I've applied a local workaround in my randconfig tree
> >>
> >> diff --git a/lib/Makefile b/lib/Makefile
> >> index ddcb76b294b5..d7b8fab64068 100644
> >> --- a/lib/Makefile
> >> +++ b/lib/Makefile
> >> @@ -425,5 +425,7 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $=
(TEST_FORTIFY_LOGS)) FORCE
> >>
> >>  # Fake dependency to trigger the fortify tests.
> >>  ifeq ($(CONFIG_FORTIFY_SOURCE),y)
> >> +ifndef CONFIG_KASAN
> >>  $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
> >> +endif
> >>  endif
> >>
> >>
> >> which I don't think we want upstream. Can you and Kees come
> >> up with a proper fix instead?
> >
> > I set CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_KASAN=3Dy,
> > but I did not observe such warnings.
> > Is this arch or compiler-specific?
> >
> >
> > Could you provide me with the steps to reproduce it?
>
> This is a randconfig .config file that shows it, but
> I've seen it in a lot of others:
> https://pastebin.com/raw/ESVzUeth
>
> If this doesn't reproduce it for you, I can try to narrow
> it down further.
>
>      Arnd


Thanks, I was able to reproduce it.

The issue happens with CONFIG_KASAN_SW_TAGS.

I do not see the issue with CONFIG_KASAN_GENERIC.



--=20
Best Regards
Masahiro Yamada

