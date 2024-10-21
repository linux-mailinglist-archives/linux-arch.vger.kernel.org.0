Return-Path: <linux-arch+bounces-8326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDE9A58CE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 04:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB161F21158
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 02:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1814263;
	Mon, 21 Oct 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d08KNrR0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AD10940;
	Mon, 21 Oct 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476946; cv=none; b=hNGs3T4Pxc/hvghaKtXSDwPOloX/IWlhhd6YRY2DRWa7tiUfxuxpC6ipQUucbTVZ+8CRad7vOiW6wkp6lvKZ5MrW/BKunA62x7JHK4DNy4o42DmodJn2btaUBiZ6p7Ogf/iMZO3YhAllUxyye7CijeEHqPJYxcJaJGV9ZVNe9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476946; c=relaxed/simple;
	bh=7yCrAsbcPnUs8QLX4xme6O9ayrQJh78Qk/A7EGSgZtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7YjSVoMCEGaid7EBmjEKk2T1qMPul2XzFjwVsUahns1l3xyxsRXVIcvJWDb5kJHXxeMRzDRC3lRZdoAVsRc3Ns+NZQvCn4ilNkXUT0FfrQbURF0RwwMK7ZlODU4N5Hx3T58l2xzTit3emp2+rwucyhnX7mV5cDxa78ppKnO7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d08KNrR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E0C4CEE7;
	Mon, 21 Oct 2024 02:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729476945;
	bh=7yCrAsbcPnUs8QLX4xme6O9ayrQJh78Qk/A7EGSgZtY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d08KNrR0EDdB5cZL1479IaZ60BD1V2vtCsS7R0jtnBAV4w+rISPncIzkr2lYtP761
	 e/FVBP8Z+3v6ba4VnJsf1PJTUWvJj8Ryh5j08KR1o5WRLn0sjwqC3z6Nc8v67wdKiW
	 9ZHjL0fdEqOOY1cxGZvwJsxl4z457YuI9setNk1QaTLQnXJ3/cYwiSVT3JDYH0eXS1
	 VNLqNODc7A8HrsjvJpGj6GFyM6fynPTjAjymsLSGFxLRK4RoI//h915vj/B/gg0R18
	 ptcqdj2UlOJZb0jv0rSGEiKkDqoe7VlU7B2Hb4lrNT+/1nxHN5ljadfMzfV7aC5sGb
	 +WitOv0l8ullQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f8490856so4101222e87.2;
        Sun, 20 Oct 2024 19:15:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7MQDaD0/hTUZIr+oEGIMY3o0TqN8j6F8NQrJneFjU61h6TB2/9VSREEt7pYr/cZ2XOBZvnOCn9kPwSLR5@vger.kernel.org, AJvYcCU8rdPOB9F9pulikWHKdAaWw1+Zmu8BCoY9P/y012q4MdK4agQ6n/Fvl2j6Bnn/XSN/QbWKm2NQvW2n@vger.kernel.org, AJvYcCUMusVIX44d+bttljTgjpNtm3twZSxXpUrlsnC0M9EYlD3aN40ziwPEQeONmEPGSSHyCJTPwzlSuz68@vger.kernel.org, AJvYcCW2I2FL/Iyw9Z/srMwme5SzLefuOScbPPLgtBHQPPSoKKOypN4noKwDZ9xqJqVMk5qOM8vbMY28oiCaczxi@vger.kernel.org, AJvYcCWRm7IzOlccbfoczrvw31gp0d4DQ9bCm6rLkBcM7O+xuObGBMmSfSSsHaTawKsDwUSZcHZ5NDTc7VmY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+D/OL+sg7rKTD7RvZS3qnlaXtWQKgzIdnwNMiUYdBzIumAMOY
	xpCKVpxRSCH3HnP6dvrQxyxN2mfyrU933q7fyO5fbuyue4KKt3KSMfr2JeDgxDFpV+ugdopirKI
	AKQ27ULJoLvPozGbYqWSRjbWoYhY=
X-Google-Smtp-Source: AGHT+IH3ESdsYc+/+wUsglq6HOvcvexZoZqe+c/NsP73ESbFMnBfgYbBsi4+2Lp8sphgSZWamBJV5g/oTZN9ldIl0yc=
X-Received: by 2002:a05:6512:280d:b0:53a:d8b:95c0 with SMTP id
 2adb3069b0e04-53a154a26ecmr4500158e87.30.1729476943821; Sun, 20 Oct 2024
 19:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-4-xur@google.com>
In-Reply-To: <20241014213342.1480681-4-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 21 Oct 2024 11:15:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqnhZuDf75_juBtdK0GV8jL_aDjnuyU=-8zjdCZetF1g@mail.gmail.com>
Message-ID: <CAK7LNARqnhZuDf75_juBtdK0GV8jL_aDjnuyU=-8zjdCZetF1g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] Change the symbols order when --ffuntion-sections
 is enabled
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
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> When the -ffunction-sections compiler option is enabled, each function
> is placed in a separate section named .text.function_name rather than
> putting all functions in a single .text section.
>
> However, using -function-sections can cause problems with the
> linker script. The comments included in include/asm-generic/vmlinux.lds.h
> note these issues.:
>   =E2=80=9CTEXT_MAIN here will match .text.fixup and .text.unlikely if de=
ad
>    code elimination is enabled, so these sections should be converted
>    to use ".." first.=E2=80=9D
>
> It is unclear whether there is a straightforward method for converting
> a suffix to "..".



Why not for ".text.fixup"?

$ git grep --name-only '\.text\.fixup' | xargs sed -i
's/\.text\.fixup/.text..fixup/g'



I do not know how to rename other sections that are generated by compilers.




> This patch modifies the order of subsections within the
> text output section when the -ffunction-sections flag is enabled.
> Specifically, it repositions sections with certain fixed patterns (for
> example .text.unlikely) before TEXT_MAIN, ensuring that they are grouped
> and matched together.
>
> Note that the limitation arises because the linker script employs glob
> patterns instead of regular expressions for string matching. While there
> is a method to maintain the current order using complex patterns, this
> significantly complicates the pattern and increases the likelihood of
> errors.
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index eeadbaeccf88..5df589c60401 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -554,9 +554,21 @@
>   * during second ld run in second ld pass when generating System.map
>   *
>   * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
> - * code elimination is enabled, so these sections should be converted
> - * to use ".." first.
> + * code elimination or function-section is enabled. Match these symbols
> + * first when in these builds.
>   */
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG)
> +#define TEXT_TEXT                                                      \


Why did you do this conditionally?

You are making this even more unmaintainable.





> +               ALIGN_FUNCTION();                                       \
> +               *(.text.asan.* .text.tsan.*)                            \
> +               *(.text.unknown .text.unknown.*)                        \
> +               *(.text.unlikely .text.unlikely.*)                      \
> +               . =3D ALIGN(PAGE_SIZE);                                  =
 \
> +               *(.text.hot .text.hot.*)                                \
> +               *(TEXT_MAIN .text.fixup)                                \
> +               NOINSTR_TEXT                                            \
> +               *(.ref.text)
> +#else
>  #define TEXT_TEXT                                                      \
>                 ALIGN_FUNCTION();                                       \
>                 *(.text.hot .text.hot.*)                                \
> @@ -566,6 +578,7 @@
>                 NOINSTR_TEXT                                            \
>                 *(.ref.text)                                            \
>                 *(.text.asan.* .text.tsan.*)
> +#endif
>
>
>  /* sched.text is aling to function alignment to secure we have same
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>


--
Best Regards
Masahiro Yamada

