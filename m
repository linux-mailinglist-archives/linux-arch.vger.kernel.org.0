Return-Path: <linux-arch+bounces-8444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7CD9ABF40
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCC0B25951
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2114A4F7;
	Wed, 23 Oct 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW0YakhI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BF14659D;
	Wed, 23 Oct 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666221; cv=none; b=ftC4KxJLUCayACThCPynFSDBLrpUm2wuxi6hrffmXUhHJ5bDBLZPSNq3pYkHdGiVCwaCbejdltKu5uZ8Mtt8TTVTqHqHPpF1mYJEoken5ya430/Etqprnp7kA2KN+qx+TotlcdrD6OiXSQo+RwqvMjQMD+qiNAK3L0ieTU2J18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666221; c=relaxed/simple;
	bh=HH7WcbLIrvr+Vr1jGnk3XAi1eUso/woDxRvL2rs3tjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9+skY62cuZg+Kyt0CPN6kwX5uTeNbU4fxNSOJetQeNYOMEMU89hQbMcXLpnI5nwBbLrMEcZEYPGs3hyvnZiKCogfo4XBYvW0fscZB+wrAxzyiKsad8BiCdqMczHxzoQ6196Al05ZEMb2CQNJZs+yKkgJC/tktRbGntufxWrB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW0YakhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B288C4AF0C;
	Wed, 23 Oct 2024 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729666221;
	bh=HH7WcbLIrvr+Vr1jGnk3XAi1eUso/woDxRvL2rs3tjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jW0YakhI6Qd4i1J0ygnv/xJf/auliPnU3yvHXVXsNCJT9dNAYAhN3xD5qHIHj9A/2
	 0yyB/yVDTtf/jsLwmQK8/NlbVtD8csiAHE8HnyhDCS+aZGkG/zGWZqR4EMV4gYUBeL
	 iQFgrCDBnSDtzaJJZ7Wj5Dj+DoaGhF+9nZqV2ZbrMn5oxnp0BKWXXqkfHkPEg52lI4
	 jtgOfamusl2KY+Qt2a7hyXrkUe8itFLrb0VKaNSEzzk/znSEtAOZqjcbTP0clbp89+
	 rj04Rmnx9m3nA2HLUPcQZ59KJG607ml1yg0nlbYryQF341qaLzKLIc/9DrdhNJF5Na
	 eyxrVvJs5LEYw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so63395161fa.2;
        Tue, 22 Oct 2024 23:50:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDiVxaizLz8zDcpUlQWu+68n9mbNdH5Kx43ZL5txHDrnwmiR0Ak8rl18iJ0p2SILq244j1iU87Mjcg@vger.kernel.org, AJvYcCWaW/uCyI39b+mjkFAAtbCLeKbHlZfCml68LX9x0YY6iyab3knk65YCbunAHfw0YhWwM50+WCHVU+FP@vger.kernel.org, AJvYcCXZDGBAFGhNg1qvH86o/qkzqlfDD4itVc5Fd+zmm7ATm6CvnFKciYIsrqEpcZhPW0dEmVor5PbAGkybTr7M@vger.kernel.org, AJvYcCXkYfMvcMmpZBnOFKSgwnuJ8PkO2Ya1LAKVNG5R7mWshiOVa8IasCapNFpeC+ZSLYsG6QiFaYchLQ/5BDW4@vger.kernel.org, AJvYcCXp1eb0PE7pe2+isK455jTe2fPyvE0XbdDNL1IUYcZcNtcp0x7mMnSlXf8QufjMv5l/wKu8SWuyPb6M@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHftVk8A3Fr4m2RL6LjMxmZBmxWCTgcVrMzAkYni5LN9ymXwH
	dKewCJ83GdnEVjbnaz64XP/XO7RcLfpGEnGXlmew+w9tjogpXYy5cALLA6q+fH6cizlUgYufhyd
	jUnXZf6jLycyI5K1LAJshTzJc1Ao=
X-Google-Smtp-Source: AGHT+IEhDTHOZcIy12Yxl/gZ0ozyocySmT4Gjk6UW3/+LEWXlTX6KY7iZ8xKJLxyZMnImR+iPFMLPSdhm4B4eaeSdzk=
X-Received: by 2002:a05:6512:3989:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-53b1a37554emr625833e87.54.1729666220304; Tue, 22 Oct 2024
 23:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-6-xur@google.com>
 <CAK7LNAQ0RwJYkCXHj8QMH3sqXgY2LBTiYV8HnKD8oANB8Bb+Yg@mail.gmail.com> <CAF1bQ=RuLmO9S1W6ofmgVQZR7pBqR3iN7gCuUO2TkwGQwM76Kw@mail.gmail.com>
In-Reply-To: <CAF1bQ=RuLmO9S1W6ofmgVQZR7pBqR3iN7gCuUO2TkwGQwM76Kw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 15:49:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB8WZACuQyQQWvjfODTHTrPrbWBNrP0nsMQkQhDr+Pug@mail.gmail.com>
Message-ID: <CAK7LNASB8WZACuQyQQWvjfODTHTrPrbWBNrP0nsMQkQhDr+Pug@mail.gmail.com>
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

On Tue, Oct 22, 2024 at 8:28=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> On Sun, Oct 20, 2024 at 8:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> > >
> > > Enable the machine function split optimization for AutoFDO in Clang.
> > >
> > > Machine function split (MFS) is a pass in the Clang compiler that
> > > splits a function into hot and cold parts. The linker groups all
> > > cold blocks across functions together. This decreases hot code
> > > fragmentation and improves iCache and iTLB utilization.
> > >
> > > MFS requires a profile so this is enabled only for the AutoFDO builds=
.
> > >
> > > Co-developed-by: Han Shen <shenhan@google.com>
> > > Signed-off-by: Han Shen <shenhan@google.com>
> > > Signed-off-by: Rong Xu <xur@google.com>
> > > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 6 ++++++
> > >  scripts/Makefile.autofdo          | 2 ++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/=
vmlinux.lds.h
> > > index ace617d1af9b..20e46c0917db 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -565,9 +565,14 @@ defined(CONFIG_AUTOFDO_CLANG)
> > >                 __unlikely_text_start =3D .;                         =
     \
> > >                 *(.text.unlikely .text.unlikely.*)                   =
   \
> > >                 __unlikely_text_end =3D .;
> > > +#define TEXT_SPLIT                                                  =
   \
> > > +               __split_text_start =3D .;                            =
     \
> > > +               *(.text.split .text.split.[0-9a-zA-Z_]*)             =
   \
> > > +               __split_text_end =3D .;
> > >  #else
> > >  #define TEXT_HOT *(.text.hot .text.hot.*)
> > >  #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
> > > +#define TEXT_SPLIT
> > >  #endif
> >
> >
> > Why conditional?
>
> The condition is to ensure that we don't change the default kernel
> build by any means.
> The new code will introduce a few new symbols.


Same.

Adding two __split_text_start and __split_text_end markers
do not affect anything. It just increases the kallsyms table slightly.

You can do it unconditionally.



>
> >
> >
> > Where are __unlikely_text_start and __unlikely_text_end used?
>
> These new symbols are currently unreferenced within the kernel source tre=
e.
> However, they provide a valuable means of identifying hot and cold
> sections of text,
> and how large they are. I think they are useful information.


Should be explained in the commit description.



--
Best Regards
Masahiro Yamada

