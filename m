Return-Path: <linux-arch+bounces-8412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8E9A9437
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 01:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337861F22E9B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED91E32CE;
	Mon, 21 Oct 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHz0D/R9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FC1E47B7
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553536; cv=none; b=GaF+gqXQjNVN8lcVsLXoP5lj2qI4hr46ffaXqfufIR0gOv5eW8afzrrYDl/RoZezHI427VRxvvUEW2sNlqmCH0oARCRDhCbysGNP6tFmp77HaYPdeiFzq41ckGNBTMWqlJXDXQ27F5J8YonxqO18cu8uDrNM4e2sudzbJKmULVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553536; c=relaxed/simple;
	bh=X916ky8vzME0jkYISKDdzwdl7efRQ8hg38UiB7TfrUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bouhA1okBk5xFQ85K2O7yQ4JOVtJckp+UEZG0aP0y7pmOcu/g3d7PBmXAYJbTWhkKSLdXK186e+hmpw743DFXbKdfnpsgCOn7qLtX9W9gk27ZW7t2QFdp1GL/BbuhN61yCjcXaVajbuJPIIa9zP5swjWD5s1FmmvcwhGYOye5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHz0D/R9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so80721cf.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729553532; x=1730158332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBSWnMd6XTE6VfUT0N7YniZsrpOBHvMOUqQ82iETS4o=;
        b=hHz0D/R9d/i5iIa0/fTOPVY4teWIgusx8+Zt8WFvaURuj0b6jBYb6S5xg+mEfKcvBw
         ezyDmHKyQuI7sp82PEKqlMQJGmVJb4+iIjMD/7xnrhlEgDnyoB/3VxeuTAC2MzqfmIvv
         XEsBNGB6KuAT3860MlzXyhDCRCoqWG23DvYLueON8OKtaXpZiBxOsYMCtjBg3W5m26hw
         DhEVEknXrClMURnBTAc7eIgCB/SNDGDlwekYC7FINV/yo40ttnaIcaheOdofbAL8trr1
         Xl5XKxzkZVO8Hb+8cqCvDVROUW/zRuwQ59WbN6SkgK7lsLugWADRB9/gY19XXJ7RC9Dw
         V3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553532; x=1730158332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBSWnMd6XTE6VfUT0N7YniZsrpOBHvMOUqQ82iETS4o=;
        b=kyfJo4xvDhQYkFoFCInSTWqy0DU4Gpmb4d0vF0iGMLzJ0TF29ukfJ6n+We8aAXB8sU
         1778gDlRmm86PbltAs+1B8d38oBPOwoi4N7i9tMGoOGKoI9t4S2OKqtozuBRHBnhxXKH
         czqgbAOZAwWwNsbhg8Z/RAE4Zd8cniGaQStHpsOGDKZce9ncIzlDeggZvupcnLmBzItr
         hCE8Ve72sTKRhJsc0HMqIzRe9byJWYHrgXBqYAq4JcH6lKTx++y+82E6D3uXXlP/XU2F
         7zNcIwJJS0aDZOAEciHA1EpayC2o+xXlX2cKZ8EFqKB3483VFyuK86S3KdfalReViCH7
         2LPA==
X-Forwarded-Encrypted: i=1; AJvYcCXjeYlaOdmpgCRsohjb81Vn90m9fv4qgABbQUGv7oa+/S7PMD7ibiyyhgU7KIMUjbEpUCe9pawEoIXl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu2sW93zsatdz1j06Zkqn2ArJFKLS9hjnqNjnYncHydAEMRJs
	ZhKh63Fnm60iS/j/j5mBMPPL+54zyxkgjvM78aXyjcY9rwD8FhLyrqxmTNA1S/ugM7/7Mx7FBsD
	b9ZjiFkJ8cJOdOXFtHEnRLA+ztJzt0x7YFrc6
X-Google-Smtp-Source: AGHT+IE5R7f/XKkSpNfZF7Clv3CBDSwXz9GBn9EUoEfkMZ71oeRPVNz7IXIERudPlcaZsIWm17D9Wt+QRWMaJ8nPkfg=
X-Received: by 2002:ac8:5e07:0:b0:45e:fda3:e995 with SMTP id
 d75a77b69052e-46100abdb08mr1708541cf.16.1729553532461; Mon, 21 Oct 2024
 16:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-5-xur@google.com>
 <CAK7LNAQpFdHxAGk1SSRrJwyKA1XjfJLbyAeka7-YemJ1zEevnQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQpFdHxAGk1SSRrJwyKA1XjfJLbyAeka7-YemJ1zEevnQ@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Mon, 21 Oct 2024 16:32:00 -0700
Message-ID: <CAF1bQ=Tp8Dc=jpNNq+B+qj90bowod8dQ1JYRsM4q5ARdf=Jd_Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] AutoFDO: Enable -ffunction-sections for the
 AutoFDO build
To: Masahiro Yamada <masahiroy@kernel.org>
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

The answers are the same as the reply in [PATCH v4 5/6]

On Sun, Oct 20, 2024 at 7:26=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Enable -ffunction-sections by default for the AutoFDO build.
> >
> > With -ffunction-sections, the compiler places each function in its own
> > section named .text.function_name instead of placing all functions in
> > the .text section. In the AutoFDO build, this allows the linker to
> > utilize profile information to reorganize functions for improved
> > utilization of iCache and iTLB.
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 37 ++++++++++++++++++++++++-------
> >  scripts/Makefile.autofdo          |  2 +-
> >  2 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 5df589c60401..ace617d1af9b 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -95,18 +95,25 @@
> >   * With LTO_CLANG, the linker also splits sections by default, so we n=
eed
> >   * these macros to combine the sections during the final link.
> >   *
> > + * With LTO_CLANG, the linker also splits sections by default, so we n=
eed
> > + * these macros to combine the sections during the final link.
> > + *
> >   * RODATA_MAIN is not used because existing code already defines .roda=
ta.x
> >   * sections to be brought in with rodata.
> >   */
> > -#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG)
> > +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG) || \
> > +defined(CONFIG_AUTOFDO_CLANG)
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> > +#else
> > +#define TEXT_MAIN .text
> > +#endif
> > +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG)
> >  #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundl=
iteral* .data.$__unnamed_* .data.$L*
> >  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> >  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> >  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundlitera=
l*
> >  #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
> >  #else
> > -#define TEXT_MAIN .text
> >  #define DATA_MAIN .data
> >  #define SDATA_MAIN .sdata
> >  #define RODATA_MAIN .rodata
> > @@ -549,6 +556,20 @@
> >                 __cpuidle_text_end =3D .;                              =
   \
> >                 __noinstr_text_end =3D .;
> >
> > +#ifdef CONFIG_AUTOFDO_CLANG
> > +#define TEXT_HOT                                                      =
 \
> > +               __hot_text_start =3D .;                                =
   \
> > +               *(.text.hot .text.hot.*)                               =
 \
> > +               __hot_text_end =3D .;
> > +#define TEXT_UNLIKELY                                                 =
 \
> > +               __unlikely_text_start =3D .;                           =
   \
> > +               *(.text.unlikely .text.unlikely.*)                     =
 \
> > +               __unlikely_text_end =3D .;
> > +#else
> > +#define TEXT_HOT *(.text.hot .text.hot.*)
> > +#define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
> > +#endif
>
>
>
> Again, why is this conditional?

The condition is to ensure that we don't change the default kernel
build by any means. The new code will introduce a few new symbols.

>
>
> The only difference is *_start and *_end symbols are defined
> when CONFIG_AUTOFDO_CLANG=3Dy.
>
> And, where are these symbols used?

These new symbols are currently unreferenced within the kernel source tree.
However, they provide a valuable means of identifying hot and cold
sections of text, and how large they are. I think they are useful informati=
on.

>
>
>
>
>
>
>
>
>
>
>
> > +
> >  /*
> >   * .text section. Map to function alignment to avoid address changes
> >   * during second ld run in second ld pass when generating System.map
> > @@ -557,30 +578,30 @@
> >   * code elimination or function-section is enabled. Match these symbol=
s
> >   * first when in these builds.
> >   */
> > -#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG)
> > +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG) || \
> > +defined(CONFIG_AUTOFDO_CLANG)
> >  #define TEXT_TEXT                                                     =
 \
> >                 ALIGN_FUNCTION();                                      =
 \
> >                 *(.text.asan.* .text.tsan.*)                           =
 \
> >                 *(.text.unknown .text.unknown.*)                       =
 \
> > -               *(.text.unlikely .text.unlikely.*)                     =
 \
> > +               TEXT_UNLIKELY                                          =
 \
> >                 . =3D ALIGN(PAGE_SIZE);                                =
   \
> > -               *(.text.hot .text.hot.*)                               =
 \
> > +               TEXT_HOT                                               =
 \
> >                 *(TEXT_MAIN .text.fixup)                               =
 \
> >                 NOINSTR_TEXT                                           =
 \
> >                 *(.ref.text)
> >  #else
> >  #define TEXT_TEXT                                                     =
 \
> >                 ALIGN_FUNCTION();                                      =
 \
> > -               *(.text.hot .text.hot.*)                               =
 \
> > +               TEXT_HOT                                               =
 \
> >                 *(TEXT_MAIN .text.fixup)                               =
 \
> > -               *(.text.unlikely .text.unlikely.*)                     =
 \
> > +               TEXT_UNLIKELY                                          =
 \
> >                 *(.text.unknown .text.unknown.*)                       =
 \
> >                 NOINSTR_TEXT                                           =
 \
> >                 *(.ref.text)                                           =
 \
> >                 *(.text.asan.* .text.tsan.*)
> >  #endif
> >
> > -
> >  /* sched.text is aling to function alignment to secure we have same
> >   * address even at second ld pass when generating System.map */
> >  #define SCHED_TEXT                                                    =
 \
> > diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> > index 1c9f224bc221..9c9a530ef090 100644
> > --- a/scripts/Makefile.autofdo
> > +++ b/scripts/Makefile.autofdo
> > @@ -10,7 +10,7 @@ ifndef CONFIG_DEBUG_INFO
> >  endif
> >
> >  ifdef CLANG_AUTOFDO_PROFILE
> > -  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PRO=
FILE)
> > +  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PRO=
FILE) -ffunction-sections
> >  endif
> >
> >  ifdef CONFIG_LTO_CLANG_THIN
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
> >
>
>
> --
> Best Regards
> Masahiro Yamada

