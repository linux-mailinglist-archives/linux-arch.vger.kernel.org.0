Return-Path: <linux-arch+bounces-8763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA39B9716
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87BDB213F0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C71CC8AE;
	Fri,  1 Nov 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGFyzzrY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B31CDA27;
	Fri,  1 Nov 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484385; cv=none; b=SaENCSdwvsHTbr19+CnDuPi9wceaXBWfW0PyVW9HPIU5dpAmoCBLvyQwdDhkKfZYylIGAPZhvl2JdVbQrRC+cIEi246KWZBkh3i2cWTBoHT1jO+ete62NRQYLtMcw6wCxIQvgJPgz+6klTniwZuc9xeAKwOcfwB4qhruDy/Z/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484385; c=relaxed/simple;
	bh=JJjwqh39fcCVx0ubjs5+WcMycs+cNM3heEyzFIYdiEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPgV1Rt/ymYCdQK5j9hFiOYEXhcpcUbAmewzuyVt1omEIggwSWhKGkgi4d1VLuvN2rRLXzpABIAMRju/TvHepLWE1ZOQ/phq122+Cdss0HQm+Ax4rtYMdzANi/0VR+vAStec/9rxlZE7/L6Xm8PkYx20I2qzZ0PT/iGxMfjdcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGFyzzrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6537CC4CED4;
	Fri,  1 Nov 2024 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730484384;
	bh=JJjwqh39fcCVx0ubjs5+WcMycs+cNM3heEyzFIYdiEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oGFyzzrYctRAw0+vSdKszYhCr6MZakc+bum0xBkNuoIQjBDZeALsgpY3fpU/YiVy/
	 MTo8d1l8hu7PYeFzes6xmZUeJlbgCq1oLePpHv7X8KJZrPe/rIJW++V7LCiA7rgJcP
	 uj9LI2Ws1OEVr3ma5YoOorGlgj6guMZNslSYXTDI/NOdAMqv48y7Mt2wttESaTHS0u
	 c/vIqc0rPjpRCPr2f5R3l61Nn72sFushIGqPjLdP04vQioG+OOaOw00Wy01otQRN5V
	 M/kSKhMjN7Ag2IktDM6GgLS/YZhl8ESusMWDp+OCz0BSSZrn4EuS4GL/gxC3NHIhR0
	 xY0abIZFZxuTw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb599aac99so20217991fa.1;
        Fri, 01 Nov 2024 11:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6QYIwF9S7TltX5Anb20RpjNuKPpQ2VAGUEX16B7mB3jx+xlTuEvb+vi4CNP2nVzwpRIqKmDoSe16I@vger.kernel.org, AJvYcCUMPyr0QisaZiEZPxmWe8Fs9Hz8WxILKajW0IsUJqo3ccEOkHvEQ/dorbtRhAyuQLBOzJ/RMmPnMt5K@vger.kernel.org, AJvYcCV4kAcYaJCfmFRLJdCsQ1PGD67s7KY+A9yd0JdAvohhByeIOEaukY12LRwBdzTqc55+vhVGXHdSq8WkzQ==@vger.kernel.org, AJvYcCWJW+wt5Mfm6zfMpAofnf6ORKbcpYjuVAfjz0Taiy8AOYiaGV8Ng6r7hHfpKioY+UOwo0BlH2JfA/wPezgF@vger.kernel.org, AJvYcCX6FbLujOVTVKakOxhqYBtUkkBe6Aq3UNZkQr6JbN+BhA8ArF8SCl3q2xvcmjfq6gnXwhGuxNQ2LFxv@vger.kernel.org, AJvYcCXJzVdTyqKqngWg5uDO9KbU8PYNPZGY5Yec6svZ30t19dy063NrlLjMb6jpUJRGEQ0fmLOtMlm3gBY4w69g@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFHqTF3dXW5NWnusKaSLsmtJitKLhAhb4axX+tzA/vd00pJFU
	7QebvtBcNrTQ20jAFevfN1HFXQYoltvJbO+ZHrP8VYodAv1D4il53TT5Jjh+d2q2bDQZwAnh4Op
	uWc87t9NxSxpnSV+eZyHxpR3ZrZY=
X-Google-Smtp-Source: AGHT+IENQ8plh56/KCN7UexCPK7YNwOgQocP3X0UjZV+vdI494pX+xUTRKzwl4gLjC+Afni5PbyZK3sjbjZQziO76Fo=
X-Received: by 2002:a2e:b88a:0:b0:2fb:5bf1:ca5e with SMTP id
 38308e7fff4ca-2fedb831b8emr26176271fa.42.1730484383031; Fri, 01 Nov 2024
 11:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com> <20241026051410.2819338-4-xur@google.com>
In-Reply-To: <20241026051410.2819338-4-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 2 Nov 2024 03:05:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6Ni5FZJBK_FZXWZpMZG2ppvZFCtwjx9Z=o8L1e-CyjA@mail.gmail.com>
Message-ID: <CAK7LNAR6Ni5FZJBK_FZXWZpMZG2ppvZFCtwjx9Z=o8L1e-CyjA@mail.gmail.com>
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

On Sat, Oct 26, 2024 at 7:14=E2=80=AFAM Rong Xu <xur@google.com> wrote:
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
>
> This patch modifies the order of subsections within the text output
> section. Specifically, it repositions sections with certain fixed pattern=
s
> (for example .text.unlikely) before TEXT_MAIN, ensuring that they are
> grouped and matched together. It also places .text.hot section at the
> beginning of a page to help the TLB performance.


The fixed patterns are currently listed in this order:

  .text.hot, .text_unlikely, .text.unknown, .text.asan.

You reorder them to:

  .text.asan, .text.unknown, .text.unlikely, .text.hot


I believe it is better to describe your thoughts
about the reshuffling among the fixed pattern sections.

Otherwise, It is unclear to me.




--
Best Regards
Masahiro Yamada

