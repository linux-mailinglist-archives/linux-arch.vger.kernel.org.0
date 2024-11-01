Return-Path: <linux-arch+bounces-8770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114049B9A95
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 23:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96A282057
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993E1E32A4;
	Fri,  1 Nov 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcuv7wXS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6B1CEE91;
	Fri,  1 Nov 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498672; cv=none; b=KUOJV8QBOn1JjxzPO3ScWIcepHceBks5NIyAep639mGwf/3gTEsiJGO6hFRjjMvmF3ge9QAV62zlaiXUWSQHv/0pFBOi1tUkcv3QqQvMqjfrNI9OhBzvipDP+Sw2sSf7DMOoZohkjTPgdZArhi4oIuT++nBhyZcDtYAURO1rMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498672; c=relaxed/simple;
	bh=rcoTiHAzGNigzhjuUOf3w29Wr+BpteeHJQCW1ztY21k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQkIH/Rg4erlEP/V8/8Uwzx/jveCaTNyI8KIsxa89Z7ltaBvYv7x2Xs6eWR/psQysDnn645XxWyIbMcyhrXPmpirpIW5d67mc3fA7ij04FziBvKJ4vzL0RAy0ae2AmQ/zrYoTltvXXwE5CYaefqtIVmCPQ1Y2c0wUs8uj3JWo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcuv7wXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3C6C4CED5;
	Fri,  1 Nov 2024 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730498672;
	bh=rcoTiHAzGNigzhjuUOf3w29Wr+BpteeHJQCW1ztY21k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zcuv7wXSl6E/pJLqvocrlSymBS4scHtLKXTcP+fMrvmrGXVIea9jn0+QGHOGLUeAb
	 wlAl5cSK7kQC9XO8ADw2A6KRBq4llF28tgj0eOWKf0AbKSqTsAi4pGwWTWGQQ9yRCX
	 O0i1Zhd3DSnnFl7TqKgTIu5Nz14o2T20gXExsyDXPxZkN2V+iTczHy9eJ3q9Knn2bz
	 WkzDhS5SjZvKetf7D8DVj7pjXqP96hzR+TZVEnuQVe2etQrYXdwc8PxPFCvFHylNPK
	 atzuVdx0OpfYKNyGWoorkpwN1u3F27QjDoKhTeiXkNHapW3YeVKj0ysavnK+ZEDD1Y
	 Csd9H4hjVaQ8g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb49510250so25464591fa.0;
        Fri, 01 Nov 2024 15:04:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt7r25aXE0RlR6kuDg2q/jpjvNEs9wYthkWo7tv8bGaEF36nIqF9BYsqnWzVQ4EjdhSCgtaBX+xfOihA==@vger.kernel.org, AJvYcCWmIrlQ64vhwgCuIZjqExy2uG4AjpLyVGsmprek2wxy3H2NdC2gsm8Zv7tptJRgzkCu8VJBs9smB+ba@vger.kernel.org, AJvYcCX9j1dWeHWEQIQjvFRs96i/WnjhVpinb4Bj30VRdmeznAeA6F13tG2SG6+4Kzh06Myi12lG57EBVI3h@vger.kernel.org, AJvYcCXj5St3YfGTbCEeurz/eC8fBcrtrGRw/TemRp/HX0V1RaNH7lGtqXjsNOb2nj08BVnd8PluGeFbA2zT+Je/@vger.kernel.org, AJvYcCXwSv2bokXYuWwA4V6JcCIDJoAY97KhWsn7Wz+A6khRGnXnTFs4ynMSORbgOeR60STXTpYMnMxSi1Ij@vger.kernel.org, AJvYcCXzCCeLaMl6xLFtlzOuLF65Bm/b3+o3YYEB9px9xzflSuKoFrLy+1lP5GukAOcF3k449xqsfL70/PkFJ2/E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gFSX+EDLJd9wraZhrKwtRzSkrT5T06CH5/HQpKfbEQiCZSSH
	1YPHXxp25cm9IcwsCJZpzAwUSFWg4rf6qB93EvD7NwX5lLgkX4WY71QL5nP8KbidFf/jF2QaFkV
	lDXrPjNYDwswuPPnXx3E5nTiexYM=
X-Google-Smtp-Source: AGHT+IGVMAgeS0V2k3gbBjmJnFp43Rbmnq4wT0SbRNO4NZeNLFW4f4vONEJ7HO2aD/gqiSPW9yN22T197mAQWhrZFyU=
X-Received: by 2002:a2e:819:0:b0:2f7:a5fe:adbe with SMTP id
 38308e7fff4ca-2fdec72f2bemr34602561fa.18.1730498670823; Fri, 01 Nov 2024
 15:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com> <20241026051410.2819338-4-xur@google.com>
 <CAK7LNAR6Ni5FZJBK_FZXWZpMZG2ppvZFCtwjx9Z=o8L1e-CyjA@mail.gmail.com> <CAF1bQ=TjpUrEgiqepyaGAiDoFM8jzozzxW=0YvTXpFY64YoTzw@mail.gmail.com>
In-Reply-To: <CAF1bQ=TjpUrEgiqepyaGAiDoFM8jzozzxW=0YvTXpFY64YoTzw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 2 Nov 2024 07:03:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZ3Hw-OuMe39eOHR=H1BSpyaGQf4xUFW9tuOWFnEzXqw@mail.gmail.com>
Message-ID: <CAK7LNARZ3Hw-OuMe39eOHR=H1BSpyaGQf4xUFW9tuOWFnEzXqw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] Adjust symbol ordering in text output section
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 3:37=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Current order is:
> .text.hot, .text, .text_unlikely, .text.unknown, .text.asan
>
> The patch reorders them to:
> .text.asan, .text.unknown, .text_unlikely, .text.hot, .text
>
> The majority of the code resides in three sections: .text.hot, .text, and
>  .text.unlikely, with .text.unknown containing a negligible amount.
> .text.asan is only generated in ASAN builds.
>
> Our primary goal is to group code segments based on their execution
> frequency (hotness).
>
> First, we want to place .text.hot adjacent to .text. Since we cannot put
> .text.hot after .text (Due to constraints with -ffunction-sections,
> placing .text.hot after .text is problematic), we need to put
> .text.hot before .text.
>
> Then it comes to .text.unlikely, we cannot put it after .text
> (same -ffunction-sections issue) . Therefore, we'll position .text.unlike=
ly
> before .text.hot.
>
> .text.unknown and .tex.asan follow the same logic.
>
> This revised ordering effectively reverses the original arrangement (for
> .text.unlikely, .text.unknown, and .tex.asan), maintaining a similar leve=
l of
> affinity between sections.
>
> I hope this explains the reason for the new ordering.


Make sense.

Please describe the above in the commit description.

Then, it will be clearer why you not only moved up fixed patterns
but also reversed the order.







--=20
Best Regards
Masahiro Yamada

