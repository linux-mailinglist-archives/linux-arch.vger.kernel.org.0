Return-Path: <linux-arch+bounces-8328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6789A592F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 05:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378BD2823F4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 03:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D136126;
	Mon, 21 Oct 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TABi75Fd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AEA41;
	Mon, 21 Oct 2024 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480735; cv=none; b=K9zr15xNQ6hGzORntIT6sbqIiUlW/4x+nfM3IHOuZiHApuhhuPEtqCZpWWJAIhnKf2r125e+1JLowGlvYq6mbkVlhRM1Df9znvFjhnEeh2OF2C5lNAqRitVn2OE3kP+/9yK1NDg2ndNoNRZCS5AS+etVLvt6UkQ3/AdPy6FSi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480735; c=relaxed/simple;
	bh=Nie2AFcFSUfc/tFdc/pmxlhQ189rqt/EUrhnGQ9Geo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqqxkGsmnIyq0FbIEyUKscozZKby6CXX+SrAGX1I1LFM+V+KTKReoT7xtrJVISI2qaegIM76BLd61zrPPB7ezHbopRMc2hKB1Ak8rgeCnQqxYtUce5oP28wRCSeGIduPqWY0gbkfowRGj5yZdyws7FtU1Snu/29/xwgg9l4ooUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TABi75Fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C09CC4CEEA;
	Mon, 21 Oct 2024 03:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729480734;
	bh=Nie2AFcFSUfc/tFdc/pmxlhQ189rqt/EUrhnGQ9Geo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TABi75FdBaoOqSod8UvE6rF34pp3dGkoSsLNDQ9gZvM1YQes8MFBtgQXofPpazonz
	 gIyCXFFOWHPiXx3K6o4Yqau09U66BLNpx/GT+GBOcoscXIT6POPLLJkh976s65uw9v
	 2gu0XIR75/D+2T8YESyGs4nfSb6KvlO0z5CTQjZR8ag8NjtoayTqt8TX6hM+vKUSdo
	 9uAZ71bXTKUBUe5GjPj0F8dZd86uwtdL6lEk3UzAe7Rp4f9mT1Xpi+e/c8h/AmBEpP
	 SKM4IXx+qMVJ+JU1cNWj1p2Br1+KexfXrKPhBUCAx1Y9U5s/+78eDdtLSZKEjiIMn4
	 1fgbGMSbcAOdQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f84907caso4360457e87.3;
        Sun, 20 Oct 2024 20:18:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUXlW4pBsm4qVEWNirsc/Asn7f1OTO0zNJ04x3tfARk9J/omquO3IifyWt8Gozy3y44e8vOuiaWjpd@vger.kernel.org, AJvYcCUrcK22cXtaTBd08faZ24c5UDpo+9IshW72XosIhmnlynRtgom2yHYWTCJzpZYdPTpIykJCXkQKyKhIsysc@vger.kernel.org, AJvYcCVo00BqlFx6I+bGRaRkF7qxt+QAVmUc4qmh7w8o0rhIVJSXD2V3pNJ2GPdMhv3h+IhZAeFQJ6up7OiQ@vger.kernel.org, AJvYcCW3BMTou1m7NMciC+pNo7clDM/xbARkn7l+DVNnl+jq85+0srxj3p7/21xTjs9gJHaKuSwbFOCoE6gc@vger.kernel.org, AJvYcCW6oKZj/t6OsqI4gG3qrbNqnshuM1JfVMg5U3CaOil0d8Y52uyh0A8/HUljm2g0i+lOJ444d8BLU57xwd78@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwFLHYGCS32y0q6f3RpzX+qo5Y7IN+L6kIfxAkl6o+S0kaYeV
	zzBdtdmbCV16ioyHwBmgvFB5IaocIPW6cpT7vPT8jT/ADV+EWmHYonOoX5+hR1+dqAVa+Gn2n/O
	m7ICn7p5rcNaLOKg5xdRmi8ZT2qw=
X-Google-Smtp-Source: AGHT+IFF+6OY++aC6VgSvFOGFIPuUwbQy2uTC0O38gyEQAjFUkHkDmaIEUyBHfWpTEdN9+71dto4vZQ2X+vvT37eHI4=
X-Received: by 2002:a05:6512:b19:b0:539:df2f:e115 with SMTP id
 2adb3069b0e04-53a1521993cmr4056473e87.23.1729480732824; Sun, 20 Oct 2024
 20:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-6-xur@google.com>
In-Reply-To: <20241014213342.1480681-6-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 21 Oct 2024 12:18:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0RwJYkCXHj8QMH3sqXgY2LBTiYV8HnKD8oANB8Bb+Yg@mail.gmail.com>
Message-ID: <CAK7LNAQ0RwJYkCXHj8QMH3sqXgY2LBTiYV8HnKD8oANB8Bb+Yg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] AutoFDO: Enable machine function split
 optimization for AutoFDO
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
> Enable the machine function split optimization for AutoFDO in Clang.
>
> Machine function split (MFS) is a pass in the Clang compiler that
> splits a function into hot and cold parts. The linker groups all
> cold blocks across functions together. This decreases hot code
> fragmentation and improves iCache and iTLB utilization.
>
> MFS requires a profile so this is enabled only for the AutoFDO builds.
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 6 ++++++
>  scripts/Makefile.autofdo          | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index ace617d1af9b..20e46c0917db 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -565,9 +565,14 @@ defined(CONFIG_AUTOFDO_CLANG)
>                 __unlikely_text_start =3D .;                             =
 \
>                 *(.text.unlikely .text.unlikely.*)                      \
>                 __unlikely_text_end =3D .;
> +#define TEXT_SPLIT                                                     \
> +               __split_text_start =3D .;                                =
 \
> +               *(.text.split .text.split.[0-9a-zA-Z_]*)                \
> +               __split_text_end =3D .;
>  #else
>  #define TEXT_HOT *(.text.hot .text.hot.*)
>  #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
> +#define TEXT_SPLIT
>  #endif


Why conditional?


Where are __unlikely_text_start and __unlikely_text_end used?







--=20
Best Regards
Masahiro Yamada

