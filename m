Return-Path: <linux-arch+bounces-8443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8479ABF3B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C13F1C20AAD
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B114A4F7;
	Wed, 23 Oct 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/zhR8AY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C06EB7C;
	Wed, 23 Oct 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666210; cv=none; b=dkzd0HXYdyXVQf/TlFvd6t2PgRBzWCAmOQDmJR+AxzcgkRntaj6eFaTnp1JCkGgowe7edms3kq4wMOiWlDzVGDBkKP/4cd3RREqqxHRgd4eZ0VHNvnjaGEVZ/y9prCFzYrkJbK1pZYWfC4TMzjexazuWHXBQGYyYw7RK1Its7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666210; c=relaxed/simple;
	bh=RQQZvOsEY2ct+0yNfTneZkiX3JYBxO54BNP2zHpNQrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBtIkh+CMpLHK1br2D79xnD5KknjeOSAtTgK/DgvZg4LW2CTJ6TQsP2cCDd150LkHRvrN34Ix6KT1JTOoehp9sJU4UmLsYF7ExWZ4IrsWlwPX/2Il+zBGiZuPk9JMFPi7NCo2LnbsBC4KLZZ30uWWlrLRk5o57KiAaYLEEH36a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/zhR8AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E347C4AF0C;
	Wed, 23 Oct 2024 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729666210;
	bh=RQQZvOsEY2ct+0yNfTneZkiX3JYBxO54BNP2zHpNQrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/zhR8AYfyHWMcOTOZF2yy65jaU4Z18WPz1uoDkhlsTHL/H284hE06w4s80YsUK9G
	 7GwuWywjYJDtaXN42dzhcT/dDwphzprxP0SojSqjRWmlixkcjLy40AFJuQIYOqYJlE
	 aCPJ+jvZUTyJ2LFZt4T0k295i1DDjcw0xhotyiP9SuqUpPMgPuvSm9ELc4RJ8U4M7Z
	 s+20Hd2Tpg79kZf74XH0POGXsaUj6buIdPohHC8oQFMMKxMpwSd6td3VsTANptiI/h
	 3glUdWWtigWwL1T4rULY2PQ4ZJHuPLy45aZS7geRarRBCNNaLJWccNGfQMOtFKtgGC
	 iSO3I69h8X4OQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ee1acb86so4724626e87.0;
        Tue, 22 Oct 2024 23:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0j2tAGswLSLmuBNVRwDbZwbEldv8Ru0HpY+Rl4fxeJwSg2yiqoMpeI9VYk2yOs1g8LvMugeTzsTDescdY@vger.kernel.org, AJvYcCWWfSkX2+TFgxExrouWSKKI5ucJbSYdz/h72S1MAcfKVOEv6D5G+/LukZJRAu7du7KXsCKAym+JGIRe@vger.kernel.org, AJvYcCWuRnCB92ZKKbjNKU5med2rsQzkKoIjMlktH05HFOy2mOmLHdjNLOWMTMfB5nXK4IzPHEt2nlmLVaxNwQsx@vger.kernel.org, AJvYcCXkUPwwBa4ijF9Y0vQi3lspSiOhMLbCDjbHZJt9tclVGgP1dSsMswrMgwTKXQBSbsaUZkcmxEcY6Wps@vger.kernel.org, AJvYcCXsRfVHfiLzWQeejc3gmBXbm1agtRKxDAG3Ckfs0VeGg4qX8gDSKW4mgpu7yq9vzO3KDDQfFFnbA9ig@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnB9H1VkrdtgUf+CpcYrKeJZkeYqt+aeVpYif5RjcoTqAThmi
	DNS23C2SEsQd3ktwCyuo5bUgzfJdCohd30tbwOVnohvQvq4VA/A1N/kSlz9ek74fTDD8BSJLTpB
	vNa7JM6/+yc3iYrX+Mk/hG3zzKoc=
X-Google-Smtp-Source: AGHT+IFUmBnF+TYIOamdr5Y/xsy0PHfBj9wF40cYSA33Skyi5sVptmJXVy5P3dIVlafCSNoY08nucugvVyBlnMM3t7o=
X-Received: by 2002:a05:6512:1586:b0:539:89a8:5fe8 with SMTP id
 2adb3069b0e04-53b1a30f7c5mr677344e87.29.1729666208926; Tue, 22 Oct 2024
 23:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-5-xur@google.com>
 <CAK7LNAQpFdHxAGk1SSRrJwyKA1XjfJLbyAeka7-YemJ1zEevnQ@mail.gmail.com> <CAF1bQ=Tp8Dc=jpNNq+B+qj90bowod8dQ1JYRsM4q5ARdf=Jd_Q@mail.gmail.com>
In-Reply-To: <CAF1bQ=Tp8Dc=jpNNq+B+qj90bowod8dQ1JYRsM4q5ARdf=Jd_Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 15:49:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY+QR_waBU4nNCGE6QLde4dbuYuR_5OUzdYig+Vaoptg@mail.gmail.com>
Message-ID: <CAK7LNATY+QR_waBU4nNCGE6QLde4dbuYuR_5OUzdYig+Vaoptg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] AutoFDO: Enable -ffunction-sections for the
 AutoFDO build
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:32=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> The answers are the same as the reply in [PATCH v4 5/6]

> >
> >
> > Again, why is this conditional?
>
> The condition is to ensure that we don't change the default kernel
> build by any means. The new code will introduce a few new symbols.
>


Same answer.

I guess you prefer unmaintainable code
because you are not a maintainer.


> >
> > The only difference is *_start and *_end symbols are defined
> > when CONFIG_AUTOFDO_CLANG=3Dy.
> >
> > And, where are these symbols used?
>
> These new symbols are currently unreferenced within the kernel source tre=
e.
> However, they provide a valuable means of identifying hot and cold
> sections of text, and how large they are. I think they are useful informa=
tion.

OK, then you are doing unrelated changes to
 include/asm-generic/vmlinux.lds.h.

This patch should touch only scripts/Makefile.autofdo

If you want to insert *_start and *_end markers,
you can add a separate patch, explaining your motivation.






>
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > > +
> > >  /*
> > >   * .text section. Map to function alignment to avoid address changes
> > >   * during second ld run in second ld pass when generating System.map
> > > @@ -557,30 +578,30 @@
> > >   * code elimination or function-section is enabled. Match these symb=
ols
> > >   * first when in these builds.
> > >   */
> > > -#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_=
LTO_CLANG)
> > > +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_=
LTO_CLANG) || \
> > > +defined(CONFIG_AUTOFDO_CLANG)
> > >  #define TEXT_TEXT                                                   =
   \
> > >                 ALIGN_FUNCTION();                                    =
   \
> > >                 *(.text.asan.* .text.tsan.*)                         =
   \
> > >                 *(.text.unknown .text.unknown.*)                     =
   \
> > > -               *(.text.unlikely .text.unlikely.*)                   =
   \
> > > +               TEXT_UNLIKELY                                        =
   \
> > >                 . =3D ALIGN(PAGE_SIZE);                              =
     \
> > > -               *(.text.hot .text.hot.*)                             =
   \
> > > +               TEXT_HOT                                             =
   \
> > >                 *(TEXT_MAIN .text.fixup)                             =
   \
> > >                 NOINSTR_TEXT                                         =
   \
> > >                 *(.ref.text)
> > >  #else
> > >  #define TEXT_TEXT                                                   =
   \
> > >                 ALIGN_FUNCTION();                                    =
   \
> > > -               *(.text.hot .text.hot.*)                             =
   \
> > > +               TEXT_HOT                                             =
   \
> > >                 *(TEXT_MAIN .text.fixup)                             =
   \
> > > -               *(.text.unlikely .text.unlikely.*)                   =
   \
> > > +               TEXT_UNLIKELY                                        =
   \
> > >                 *(.text.unknown .text.unknown.*)                     =
   \
> > >                 NOINSTR_TEXT                                         =
   \
> > >                 *(.ref.text)                                         =
   \
> > >                 *(.text.asan.* .text.tsan.*)
> > >  #endif
> > >
> > > -
> > >  /* sched.text is aling to function alignment to secure we have same
> > >   * address even at second ld pass when generating System.map */
> > >  #define SCHED_TEXT                                                  =
   \
> > > diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> > > index 1c9f224bc221..9c9a530ef090 100644
> > > --- a/scripts/Makefile.autofdo
> > > +++ b/scripts/Makefile.autofdo
> > > @@ -10,7 +10,7 @@ ifndef CONFIG_DEBUG_INFO
> > >  endif
> > >
> > >  ifdef CLANG_AUTOFDO_PROFILE
> > > -  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_P=
ROFILE)
> > > +  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_P=
ROFILE) -ffunction-sections
> > >  endif
> > >
> > >  ifdef CONFIG_LTO_CLANG_THIN
> > > --
> > > 2.47.0.rc1.288.g06298d1525-goog
> > >
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>


--
Best Regards
Masahiro Yamada

