Return-Path: <linux-arch+bounces-5670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B693EE8F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92E31C219EE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995C12D773;
	Mon, 29 Jul 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa6fveY5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133312D758;
	Mon, 29 Jul 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238587; cv=none; b=PrnVCAh71yXWJBCzz558VYmmJLQpnnGRMutyBYqiGvNZn7i8idXuCow3OEs9Yicwmn7Z39+GXTz+bZP2aAphznWVIm5x/MVjN6EUs4EKElpqecJy6HL4FQ8GlrN/Wb0M5n709f7+Ml2MCAHVvXUnbMRU36M3Ul4R8D/tFZY9VQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238587; c=relaxed/simple;
	bh=I7SM50EkhC2nL2ONJulc7JgZPylZSIxXMjC88jHd45E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmNaPuuT6l8QaQHBW4ixf+pNsAw08Z1mMGCYLr2A39SzdaEvxjlcGnt+Ulbz8JoKb2nGJw9P5fEJbKa13KPi1ejCJfFSzA5UqdOeQlXtUdulFidL4NSpsl3h9mxvG5SCF/swWYpGo0IufybH82eo8cAbcztfwaTbxa+9f0kd1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa6fveY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8ACC4AF1D;
	Mon, 29 Jul 2024 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722238586;
	bh=I7SM50EkhC2nL2ONJulc7JgZPylZSIxXMjC88jHd45E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fa6fveY5Ozp8Qi0n3/hPO5DEd1iGrETkxxvEaxa2i8VIOrt9BWpJ4/r9gOd+QIXwJ
	 JO+HzPBJUvPG6z6MpyCp9NcOh+P4gPsC6BU7o+qv29WgvbVlXkZ3C29uHh6JHWex+K
	 kIpnBY0Rpy9gQOZe3A243Hdm+DPesmd8KhhPrHyutUtjjlwMzctdHFD6/joCgVlJt7
	 tNsLT8oUQDeu1l5kwcMRHTkqlfzD2/n20qDKMWxx+nQNyEnfb4F5izjYZv+PrGW8TA
	 Q0iaUB92LfW7JeSUJV6MVDt+0aLs608/WwPxq41g341/jrptITnIkbkftwjWMTWYlN
	 UzMrR5qb/yXRw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so35690621fa.0;
        Mon, 29 Jul 2024 00:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNMwrdGTqu71H7eZwuZDSGQYmVS6gZIscH0Pf5YpkJNAs0zIH0mFHehzXR48cPRXI52Lr093reR2xgi0B743etvRkTkQ4fiKEZmEqvGuKtryjlnLqFnfa73BHi8tOu8j+9LJZmulW9Wl8b2JtUmSU8E/WYQUDsE1fwl3Qb6MmEObMyiJ/4dI3y5UgJckCT4Ae3SbT/92KEHeYPAmKC6kS8VkDW2l1CazUadh9GzXug+kWfOILb/lGy8DLcWQ==
X-Gm-Message-State: AOJu0YxnM0UdeObyFPn7cwdBODzEkh7cNriOMCZrxsnWyt+CxotIvk0m
	pWaLpdqREJ8Ff8DXT4MiC10bFDahI7HbkQ6uFRTJE+uHMN0KwA9GFn0VEJYpmG3hf6sbzeRSEoB
	+VOHsm7MEP9Jgu8aggZwt+LyIkIk=
X-Google-Smtp-Source: AGHT+IH5q1QJoJgi2M+CBahXKgkZVjCTvPJ0BnyNWvUsOEOWg5UXlc8Ue86En+VxK2Wx5SAGgAROLzJpHmdnKGVd0n4=
X-Received: by 2002:a2e:b4ba:0:b0:2ef:2311:cc66 with SMTP id
 38308e7fff4ca-2f12ee62913mr36565691fa.44.1722238584976; Mon, 29 Jul 2024
 00:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com> <20240728203001.2551083-7-xur@google.com>
 <63eb1654-c614-4f6a-9bc5-8c8085eadf8c@app.fastmail.com>
In-Reply-To: <63eb1654-c614-4f6a-9bc5-8c8085eadf8c@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 29 Jul 2024 16:35:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9EU1ZAUh9SAEQ4Ar5LY-wUstaCjGLt7=Kr=uJMNfJvQ@mail.gmail.com>
Message-ID: <CAK7LNAT9EU1ZAUh9SAEQ4Ar5LY-wUstaCjGLt7=Kr=uJMNfJvQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, John Moon <john@jmoon.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Mike Rapoport <rppt@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Eric DeVolder <eric.devolder@oracle.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Benjamin Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Xiao W Wang <xiao.w.wang@intel.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-efi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	llvm@lists.linux.dev, Krzysztof Pszeniczny <kpszeniczny@google.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sun, Jul 28, 2024, at 22:29, Rong Xu wrote:
> >  Documentation/dev-tools/index.rst     |   1 +
> >  Documentation/dev-tools/propeller.rst | 188 ++++++++++++++++++++++++++
> >  MAINTAINERS                           |   7 +
> >  Makefile                              |   1 +
> >  arch/Kconfig                          |  22 +++
> >  arch/x86/Kconfig                      |   1 +
> >  arch/x86/boot/compressed/Makefile     |   3 +
> >  arch/x86/kernel/vmlinux.lds.S         |   4 +
> >  arch/x86/platform/efi/Makefile        |   1 +
> >  drivers/firmware/efi/libstub/Makefile |   2 +
> >  include/asm-generic/vmlinux.lds.h     |   8 +-
> >  scripts/Makefile.lib                  |  10 ++
> >  scripts/Makefile.propeller            |  25 ++++
> >  tools/objtool/check.c                 |   1 +
>
> I have not looked in much detail, but I see that you need
> a special case for arch/x86/boot/compressed and
> drivers/firmware/efi, which makes it likely that you
> need to also disable properller support for
> arch/x86/purgatory/Makefile, which tends to have similar
> requirements.
>
>      Arnd




I applied the following commits:

 - 9c2d1328f88adb6cbfb218163623254b96f680d3
 - 7f7f6f7ad654b326897c9f54438a06f03454bd0d



This might be another case to apply a similar approach
instead of sprinkling PROPELLER__PROFILE=3Dn.




--=20
Best Regards
Masahiro Yamada

