Return-Path: <linux-arch+bounces-8327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BC9A58D4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 04:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE031C21163
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC728F40;
	Mon, 21 Oct 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7xWJgps"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801414263;
	Mon, 21 Oct 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477562; cv=none; b=T7wemuM9UZBYWJi8IakuG6DSKJMkJ6MvBbmeDoHPc5QpR4Vmg81ptfVPFxFvuj/mHO+gtYKdNMWvLkHrH7EfHo4qpscK3G/fQ9a/GEFHFl8ufJ+PZ8BNX6HOZTrciZHLBniytdxoGAhfi58KbnhA/Enh7EGFM7uMdfb+IiABnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477562; c=relaxed/simple;
	bh=MFT4zhrh4dk/9hhl8cF/ZTJqOH7EJNqbVWengUh4ThY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+mGg/6hV9jgWE4fEfC7uSNe1DhNrqq44u9JxYFe4TETFWd6VWKx+2ndZAZgFl6NNgaa9VjvBurFkROWBLrjzoMA11L7ejIkSbaLRHyWgs9OSqMNBaLsg82l23Foqw05kdDgrhvtv0lwzyHY5kZld9kd+XMLzGFObh3VJdvIiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7xWJgps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FDCC4CEE9;
	Mon, 21 Oct 2024 02:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729477562;
	bh=MFT4zhrh4dk/9hhl8cF/ZTJqOH7EJNqbVWengUh4ThY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H7xWJgpsasDUk70C4/IJ1JOodR4BXod5q7vXP/7zQNzi4ZcYrO3wYWvkeZpxk0PPK
	 OYAgbrkJW3fdNK7I52V/++6BR3xoCm2XbmT80AvirGaIjEEkb5lP7DBE8WUo7QMe7L
	 WlOJGXrVlDr1zQCRjxJDlSjvGNb+4J+YAfXRP2tbot14+Af9moZIYH6OY57s9XZg1W
	 c8rW+uC7ywbw1c6tyvtrdW1WUnO9eAnh1JC286Yr4jaKB931t5M3c/TM6zhXPkLItj
	 v/bLslAMJJLY9AMqOsh68JceUWi+NpktC5zuENhSeLck/TWcEZDVY/WXXJYmWqv6Ce
	 46+IUOWKvvFWA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fe02c386so4943727e87.0;
        Sun, 20 Oct 2024 19:26:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUexSen5qSerDp3nkpASDvltcaiRjymbBtOa+aP4TMX0qxFOcgI3XoHFpdQcuEumMFr7L8yE6yi11Fn@vger.kernel.org, AJvYcCVQsxbPVl+ZP9NNmLMlRPDt9+O8tNnUFzaGgeXwJSIKHisJX6a7usX+DubY/+y8mg6ORu9xrRc6XmV5sDUs@vger.kernel.org, AJvYcCVU863Dl9OCcQLQ760BIz95GF3EoxbhDwuOEoYuymsN3ICp4hqKQgRT1YLDndaB5MSJ5oIUAjZC1TyD@vger.kernel.org, AJvYcCWnfSIyjYgEvQAv2rYU4KRSgNtWHtFEzazei5w03lSmcf8yjHf0CTbV4FdVHq3LiLp1cQar7YB1fDks6elB@vger.kernel.org, AJvYcCXD4T5bIcElhk8uhlxAbuvWabbcDpf32Nr7t/V49EwMyFt2A6+cfr68+FQ6LF0/7tP6Jrblg+JHRwKx@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEaIeUEQ9Qi2fjzkp2bfeR0xJrl3kaVChLM8EDxzygzXSsAPR
	sx52fFvazSOSErurMZ6OmNS1nfUwaC9wRYMQhUhmx1FqZBkLf1NEklmvZes10JeSjYl21EffnIO
	twmF6wu4RGhsKpOy/D3ARBXFUpak=
X-Google-Smtp-Source: AGHT+IFBmY1ZoaSbuZ8jhtdZcMeZUakQQoaHbk51Bf1kKrMDFcSPu+LCqqfc976Jq/JE1IgxgWhpyiU1IfJ/3MKOh2U=
X-Received: by 2002:a05:6512:2210:b0:52c:ad70:6feb with SMTP id
 2adb3069b0e04-53a15b808bcmr2536918e87.20.1729477560598; Sun, 20 Oct 2024
 19:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-5-xur@google.com>
In-Reply-To: <20241014213342.1480681-5-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 21 Oct 2024 11:25:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpFdHxAGk1SSRrJwyKA1XjfJLbyAeka7-YemJ1zEevnQ@mail.gmail.com>
Message-ID: <CAK7LNAQpFdHxAGk1SSRrJwyKA1XjfJLbyAeka7-YemJ1zEevnQ@mail.gmail.com>
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

On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Enable -ffunction-sections by default for the AutoFDO build.
>
> With -ffunction-sections, the compiler places each function in its own
> section named .text.function_name instead of placing all functions in
> the .text section. In the AutoFDO build, this allows the linker to
> utilize profile information to reorganize functions for improved
> utilization of iCache and iTLB.
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 37 ++++++++++++++++++++++++-------
>  scripts/Makefile.autofdo          |  2 +-
>  2 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 5df589c60401..ace617d1af9b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -95,18 +95,25 @@
>   * With LTO_CLANG, the linker also splits sections by default, so we nee=
d
>   * these macros to combine the sections during the final link.
>   *
> + * With LTO_CLANG, the linker also splits sections by default, so we nee=
d
> + * these macros to combine the sections during the final link.
> + *
>   * RODATA_MAIN is not used because existing code already defines .rodata=
.x
>   * sections to be brought in with rodata.
>   */
> -#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG)
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG) || \
> +defined(CONFIG_AUTOFDO_CLANG)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> +#else
> +#define TEXT_MAIN .text
> +#endif
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG)
>  #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundlit=
eral* .data.$__unnamed_* .data.$L*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
>  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
>  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
>  #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
>  #else
> -#define TEXT_MAIN .text
>  #define DATA_MAIN .data
>  #define SDATA_MAIN .sdata
>  #define RODATA_MAIN .rodata
> @@ -549,6 +556,20 @@
>                 __cpuidle_text_end =3D .;                                =
 \
>                 __noinstr_text_end =3D .;
>
> +#ifdef CONFIG_AUTOFDO_CLANG
> +#define TEXT_HOT                                                       \
> +               __hot_text_start =3D .;                                  =
 \
> +               *(.text.hot .text.hot.*)                                \
> +               __hot_text_end =3D .;
> +#define TEXT_UNLIKELY                                                  \
> +               __unlikely_text_start =3D .;                             =
 \
> +               *(.text.unlikely .text.unlikely.*)                      \
> +               __unlikely_text_end =3D .;
> +#else
> +#define TEXT_HOT *(.text.hot .text.hot.*)
> +#define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
> +#endif



Again, why is this conditional?


The only difference is *_start and *_end symbols are defined
when CONFIG_AUTOFDO_CLANG=3Dy.

And, where are these symbols used?











> +
>  /*
>   * .text section. Map to function alignment to avoid address changes
>   * during second ld run in second ld pass when generating System.map
> @@ -557,30 +578,30 @@
>   * code elimination or function-section is enabled. Match these symbols
>   * first when in these builds.
>   */
> -#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG)
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG) || \
> +defined(CONFIG_AUTOFDO_CLANG)
>  #define TEXT_TEXT                                                      \
>                 ALIGN_FUNCTION();                                       \
>                 *(.text.asan.* .text.tsan.*)                            \
>                 *(.text.unknown .text.unknown.*)                        \
> -               *(.text.unlikely .text.unlikely.*)                      \
> +               TEXT_UNLIKELY                                           \
>                 . =3D ALIGN(PAGE_SIZE);                                  =
 \
> -               *(.text.hot .text.hot.*)                                \
> +               TEXT_HOT                                                \
>                 *(TEXT_MAIN .text.fixup)                                \
>                 NOINSTR_TEXT                                            \
>                 *(.ref.text)
>  #else
>  #define TEXT_TEXT                                                      \
>                 ALIGN_FUNCTION();                                       \
> -               *(.text.hot .text.hot.*)                                \
> +               TEXT_HOT                                                \
>                 *(TEXT_MAIN .text.fixup)                                \
> -               *(.text.unlikely .text.unlikely.*)                      \
> +               TEXT_UNLIKELY                                           \
>                 *(.text.unknown .text.unknown.*)                        \
>                 NOINSTR_TEXT                                            \
>                 *(.ref.text)                                            \
>                 *(.text.asan.* .text.tsan.*)
>  #endif
>
> -
>  /* sched.text is aling to function alignment to secure we have same
>   * address even at second ld pass when generating System.map */
>  #define SCHED_TEXT                                                     \
> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> index 1c9f224bc221..9c9a530ef090 100644
> --- a/scripts/Makefile.autofdo
> +++ b/scripts/Makefile.autofdo
> @@ -10,7 +10,7 @@ ifndef CONFIG_DEBUG_INFO
>  endif
>
>  ifdef CLANG_AUTOFDO_PROFILE
> -  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFI=
LE)
> +  CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFI=
LE) -ffunction-sections
>  endif
>
>  ifdef CONFIG_LTO_CLANG_THIN
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>


--=20
Best Regards
Masahiro Yamada

