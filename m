Return-Path: <linux-arch+bounces-9235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0139DFACD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA54F160FE6
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B121F8F01;
	Mon,  2 Dec 2024 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv80Uf0J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9E1F8EE2;
	Mon,  2 Dec 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121629; cv=none; b=ibfLIk7l6LL3BVTTEKu+FxqVodWd3LcIFHPTuCuMiNTMzjWZPdIit1ZYBGI6AkSYlVdd61H5hHady5+5uUaiY9Ql/w1D2q7SUmi/z1Mc4WuD4toL4CnjlNVqTP+OrIUwM4qczhjIMsGQ7t1+TTV12TyEDKHFgVIqPeYVJpUxdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121629; c=relaxed/simple;
	bh=P/Up/t2C443Woe5UzAIXl45/9+G7f8WfojtFfXf7EX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuTqRi4K7fmFdztRoBiLXKt7AGKgmpYystUrIS1C/xdamhtue96rc3noYaJpHmAF03LRUG+c/6qJt42UI/4x1V5draHgUi1vUn54PN/5D2B4smXKIgTyu8rZtnTKKowyQ2z3zEHPSrRopVQZ9+OQZPPBEnAIdFD5cdvX9r59XS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv80Uf0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3076AC4CEE1;
	Mon,  2 Dec 2024 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733121629;
	bh=P/Up/t2C443Woe5UzAIXl45/9+G7f8WfojtFfXf7EX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lv80Uf0JMRBKfyiSMht9pQhrhf+40aBwEKMVGp0MqU2hmhleHN6deZwnVzJMz2Z+h
	 5l3bRQq+ZJwdZuu0aUMDpikzMFNohxBUJn1b9th+sXhNUVxssFmNw/HY57Bg7QovAT
	 eQIcrFJEOhd0q3Jqa+zjRsG0DnFUKyEkJW2uMzMRG1eMf1zmKYZUng4wLLaQIFNZ5U
	 lnVY5pm7wQqicJvFhcvufgoVgSeQIlrpwRo1ObJyV8xCawKdE0I7aOdgY3uBwL49Zw
	 4CiWI7zgzSv4HB2CGKR+f5QlLEUuC9hY8XNdHqJSSaZ7BWyUMsOdrOikXbwd+I7UQV
	 6Nx/1MWfo9pig==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de79c2be4so4334304e87.2;
        Sun, 01 Dec 2024 22:40:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2A2HokAk8EmHfscD3Tlrw23G5uUh1j7fyYgLDGOx3CjdNv7VCk8mJ+ca6XHAwaw/qMea0JZXTck9aQVtX5uY=@vger.kernel.org, AJvYcCUuZzfvmqRX/FJdtLdPkdYNB1ADvXF14w1EblG67+N5yqVyUMQ1wmbYH1WrMIOOo8RfDhf5YQStquHT@vger.kernel.org, AJvYcCVRQqOIak3aiXHhu89daWxGwZah5/VCcxF6xzk+qVvFlOMxBiycUY1Z5s34s+v+8uwzyQV/UORdrVNA@vger.kernel.org, AJvYcCVf5B5wxZ9KU8pyN//ax74qV8RNlRp+edEm7IqCl242Cnh9oDeZ+jMNEff4mk6r1/Ii4QjxLOwyrxziLAQM@vger.kernel.org, AJvYcCWLd3yobxbeOl59x4R5TRfmeuL46tDw6RnfYQP/5Vn07GrAAVA/DDPTCyFFcis84orOGgKKDRO1EW6Q@vger.kernel.org, AJvYcCWUGUuAquHKa1Sf/AreUgzPsFm4uToDTwD+v2em9pn+oHSIqnBQKjaCI41Qw634GPkeFlbKVTzLcVtkFA==@vger.kernel.org, AJvYcCXAC5mrL4pv4JXndjysrJZ5jqudutJ8u2i0TR8Fa/MyZ9nrX+Ywkc3GJkQYlMgjyUwCyixL8JdrJ0i8+aAn@vger.kernel.org
X-Gm-Message-State: AOJu0YyctRCIFk3Ci+/VbjYZrQGj119Ddsz4dql2RmVhgSm+Ax3WQOgC
	HL8lZ9gP/qXzzRGPmJ1De2tNkjhqkMBw6eSDjEohlRzvXRHtfd+znFA5REAkwoZmvOGGovRBcq3
	6fiwreYnSlNkuy4SU0jGJwVYlM34=
X-Google-Smtp-Source: AGHT+IGq3TbC9zB6OHMWE5wRxb61lLhTxQ8/+n08QszowPRBZCUBlwcaxkbfgi3E63QW7qLB7OJxtrxmTZtYvl/OnbY=
X-Received: by 2002:a05:6512:3c99:b0:53d:e8f5:f98a with SMTP id
 2adb3069b0e04-53df0106bb9mr10206071e87.46.1733121627698; Sun, 01 Dec 2024
 22:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <20241102175115.1769468-4-xur@google.com>
 <5e032233-5b65-4ad5-ac50-d2eb6c00171c@roeck-us.net>
In-Reply-To: <5e032233-5b65-4ad5-ac50-d2eb6c00171c@roeck-us.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 2 Dec 2024 15:39:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-yG=jCPSfhmZM1N6Opfm70++hAby35ywpbaADMNHH2g@mail.gmail.com>
Message-ID: <CAK7LNAT-yG=jCPSfhmZM1N6Opfm70++hAby35ywpbaADMNHH2g@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] Adjust symbol ordering in text output section
 [openrisc boot failure]
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
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
	llvm@lists.linux.dev, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 11:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Sat, Nov 02, 2024 at 10:51:10AM -0700, Rong Xu wrote:
> > When the -ffunction-sections compiler option is enabled, each function
> > is placed in a separate section named .text.function_name rather than
> > putting all functions in a single .text section.
> >
> ...
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > Tested-by: Yonghong Song <yonghong.song@linux.dev>
> > Tested-by: Yabin Cui <yabinc@google.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Kees Cook <kees@kernel.org>
>
> With this patch in the tree, the openrisck qemu emulation using
> or1ksim_defconfig fails to boot. There is no log output, even with
> earlycon enabled.

Thanks for the report.
I posted a fix.
https://lore.kernel.org/all/20241202062909.2194341-1-masahiroy@kernel.org/T=
/#u


--=20
Best Regards
Masahiro Yamada

