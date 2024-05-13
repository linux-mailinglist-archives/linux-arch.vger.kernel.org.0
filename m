Return-Path: <linux-arch+bounces-4386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22A8C49C0
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A1C282E9C
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2E84D3E;
	Mon, 13 May 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ccm7AzJr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93953E30;
	Mon, 13 May 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640697; cv=none; b=ANePrJdYDYIywGVa38ayOgAa5QiPy8ppxUIxqfonuP06FhcP0AMp+2IA7it4UqUnP0IvRbVgiTT6D+LGSBL9mX6DuAOBjrjzAte0LLHhVtCPtrLyv22Xr3vNxtih+Etev8pq4cdVzbRIShdYA7fv5/ca9VpzErolvV1w6MOrf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640697; c=relaxed/simple;
	bh=BAFv8AC6amhIecrF8hdOUU0Utzaza1MY/IfWMVB1EGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1fBtGAY6/Xx+iaAXXvWMWlxc1bU6JODZ+yfXjnvaxHlqind7CxU4b2vWfgm6E2KLAQqkHuzW7xVpsDUZzoBN9U9A+NUbkD2wQSZD0WRuWrEXc7MuX6nAMsCxF1L3GtpDsPUl4sme4cUlaJKXA3lDxlnJ/WmVDWvfJQevutZ+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ccm7AzJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF35C32786;
	Mon, 13 May 2024 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640697;
	bh=BAFv8AC6amhIecrF8hdOUU0Utzaza1MY/IfWMVB1EGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ccm7AzJrOHl7szBXHj3OwKtrRjQqNKrjrzH4zVjbroaCP9Wh0TEqGu1v4AhtK7e2o
	 5SNH/T+4EhdVCPluQoFIiz4l/5ikh8YR3K/al02r8b/iGop4aUq25HpEnEHnfFg7Ad
	 tk5uPTyArgz8ECCgAWD6pwqbBcxQjCILqSn5oPZ6vUcG5b0rmK6mKn4YOjj+TSYiBP
	 qaBdf8wVGkqZl+GxCb9eIvNoBAFYqomrUa7eaAZCYWvxx+XsdNmLhEXk0GdcMVW6Rd
	 HC0/gbYdTrU60PaczUt2RQpVVOCHxHrlpsj0aOc+QiKk3zEmEEDdJ4x9Uh0xtKl+Jm
	 nPC+/T/jYqTuA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so58124351fa.3;
        Mon, 13 May 2024 15:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/AULmrIMPx9cnrO9JWrX/iwx5HMS3xGMAKwr6QKoioT0aGZ3044oxNbdDtOYcO5q7yNS3667xzy4ejKDyOJGW4Q66CZysYsC0GivTm9BZ+Tvaf8y/SzxJpw5z9TEQi5ABLWCEy/q75eJWclq50otqxFiO2d7qhDe0vWcxXIKOyz9nCfgoD+Ic+abgMZwCFXHWsBrvr6FPYZhJSZnx21+tvot3G1KyDw==
X-Gm-Message-State: AOJu0YyZaor58hUNgxx3M+m4lYeXmdVJSZ2n0Dumu4GPyf7qk8e0cOsH
	RWJLUkTQlspSC7XTzBJ5yr+5HSattIFISFWfjMpvMZDcC8LQEvL2NzXMb1eb9MqA9C20NV+2Ut3
	qjd5+5lYOK1jfc24hLFRMGO4VkRY=
X-Google-Smtp-Source: AGHT+IGBf6cwawpdt+KryFCPwJPDXhW8OKKaHz9OjzKHBBjNlCagzhZ3gwQgkLxLGNRBD6K1oMfwAG+gx60UX9WpIgI=
X-Received: by 2002:a05:6512:3151:b0:513:1a9c:ae77 with SMTP id
 2adb3069b0e04-5220fe799c9mr5293673e87.52.1715640695978; Mon, 13 May 2024
 15:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <202405131136.73E766AA8@keescook> <CANpmjNO=v=CV2Z_PGFu6ChfALiWJo3CJBDnWqUdqobO5X_62cA@mail.gmail.com>
In-Reply-To: <CANpmjNO=v=CV2Z_PGFu6ChfALiWJo3CJBDnWqUdqobO5X_62cA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 14 May 2024 07:50:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvr9-K2Hwv=Qx9stSTyFTC8Bc7EAHemVnCSo-geZUL+A@mail.gmail.com>
Message-ID: <CAK7LNATvr9-K2Hwv=Qx9stSTyFTC8Bc7EAHemVnCSo-geZUL+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Johannes Berg <johannes@sipsolutions.net>, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:55=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Mon, 13 May 2024 at 20:48, Kees Cook <keescook@chromium.org> wrote:
> >
> > In the future can you CC the various maintainers of the affected
> > tooling? :)
> >
> > On Mon, May 06, 2024 at 10:35:41PM +0900, Masahiro Yamada wrote:
> > >
> > > This patch set removes many instances of the following variables:
> > >
> > >   - OBJECT_FILES_NON_STANDARD
> > >   - KASAN_SANITIZE
> > >   - UBSAN_SANITIZE
> > >   - KCSAN_SANITIZE
> > >   - KMSAN_SANITIZE
> > >   - GCOV_PROFILE
> > >   - KCOV_INSTRUMENT
> > >
> > > Such tools are intended only for kernel space objects, most of which
> > > are listed in obj-y, lib-y, or obj-m.
>
> I welcome the simplification, but see below.
>
> > This is a reasonable assertion, and the changes really simplify things
> > now and into the future. Thanks for finding such a clean solution! I
> > note that it also immediately fixes the issue noticed and fixed here:
> > https://lore.kernel.org/all/20240513122754.1282833-1-roberto.sassu@huaw=
eicloud.com/
> >
> > > The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
> > > such tools. Otherwise, not.
> > >
> > > This works in most places.
> >
> > I am worried about the use of "guess" and "most", though. :) Before, we
> > had some clear opt-out situations, and now it's more of a side-effect. =
I
> > think this is okay, but I'd really like to know more about your testing=
.
> >
> > It seems like you did build testing comparing build flags, since you
> > call out some of the explicit changes in patch 2, quoting:
> >
> > >  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
> > >  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
> > >  - include arch/sparc/vdso/vma.o into UBSAN
> > >  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GC=
OV, KCOV
> > >  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSA=
N, GCOV, KCOV
> > >  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSA=
N, GCOV, KCOV
> > >  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
> > >  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV
> >
> > I would agree that these cases are all likely desirable.
> >
> > Did you find any cases where you found that instrumentation was _remove=
d_
> > where not expected?
>
> In addition, did you boot test these kernels?


No. I didn't.




> While I currently don't
> recall if the vdso code caused us problems (besides the linking
> problem for non-kernel objects), anything that is opted out from
> instrumentation in arch/ code needs to be carefully tested if it
> should be opted back into instrumentation. We had many fun hours
> debugging boot hangs or other recursion issues due to instrumented
> arch code.


As I replied to Kees, I checked the diff of .*.cmd files.

I believe checking the compiler flags for every object
is comprehensive testing.

If the same set of compiler flags is passed,
the same build artifact is generated.



--=20
Best Regards
Masahiro Yamada

