Return-Path: <linux-arch+bounces-8442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161C9ABF38
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C71F24E12
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C714AD3D;
	Wed, 23 Oct 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD5AhOPT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D014A62A;
	Wed, 23 Oct 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666128; cv=none; b=me5I1nXSkzGwyvRThipiNgNpL46Nrbw3DuOjFthM+qHhWBvTAGsNr5RLjpJV6SU5hbXPLu5YkdCVVtcjK8V8k4Z71vZx33pNyfZLrLiMFJzfJvuErRw0cM5VNEyH3oibYiuXLR2OSa8h9DjZCkhQcVPzT2cSxmPxvPLu5G/rS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666128; c=relaxed/simple;
	bh=kYoU1eS7DH5zpPgw6YnpnIh/xXKRa9ty0/rXTdqSfR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CagcJAdxEwSmF+xJPBj9QyCvdo1ysO+nk/q9Ec4flhlod9hstWIHJmsV749IuSkoyaxDzNh6O/lPTlpXiRSb9OPAVL/mN+A5L5bV1cOUTvzvyea/eHt9KQ4Tc5YV2rRmwkLOinrYC9nREqaLpJ8feQ9w1DriAEh0Ck+KyfDuDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD5AhOPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5178C4CEF0;
	Wed, 23 Oct 2024 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729666127;
	bh=kYoU1eS7DH5zpPgw6YnpnIh/xXKRa9ty0/rXTdqSfR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sD5AhOPTNRwGoWZCK7a3K6NZlg7XmKTizThfvUnZkotQpjpP15ICyzwQjkK55+ejD
	 P23o6ZX7S3AQFbndAu5P3lDmxBgNx2y7MoZ9BtN42f+1+KwOJc4oV7HBc+2VfYFfPX
	 UxWNHWNF/6CinCOGke7UzAEkG1eaFHv78o1MgOIlKJZdBVwy6GYK+FleyPageTITM0
	 Zw/yNAdjXvbdcAA+WtED6nQz/QLG7/l2p3WRnvNgUEl/4IiArqprJRbdg+NcCNYlqs
	 LaZY7Ie5PqnqoOYzZgu+/J00/WMVY6Yya9uiJc8EFK5p6zsuCXUaqjgqdHBtCxR+sW
	 ns8cp48MuUKLw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so6951864e87.0;
        Tue, 22 Oct 2024 23:48:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ5ZLwGU+ieUhUda9/mbtVD4UlYOWy/KR+rm8Nao6N8waFudQrdfvfVnvo7ELg21r+naxa6XavRlmooZE1@vger.kernel.org, AJvYcCWrQw0jrryizk2kwtIGfbNpRORgsZsTb+uhDcSIrnpgzuMjmtXCFj+zEiBZbh79Vi1zpJ7cOMC0Co2p@vger.kernel.org, AJvYcCX8uLUSfIrvYd9NrL+hpYwAdQPm2Ke0boVcLTlBWQCuVSOFzqhb4bJFdk2t856km+fU79D0V9/iOfL3@vger.kernel.org, AJvYcCXWYdnll3li8q76K/IFKk5m7Z3niFf7iQjz59cl9a3BBpWjSFSgdsXTGI2MH1CPBp8NnLCTALywk+cwd8MY@vger.kernel.org, AJvYcCXuQ0gczLmEl85qbTRumKegPYNsaT/IioIJC9F4EX14ANcFoE+SWd1GSYQYA0BXVffB0/29SaivLTa1@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTPrX71K7abpdXR9+yh3reS3G9Tolp51yMQ0GgCoKRHLLKXTx
	EW1A2ECCbmQKkBa8Zu+Z0wTskVbFT1cxXjTA3HfPJnQHR5wChLdpEo2+2lW6WpPMpg9DfiR0CX3
	gVvu0yGxLnLkgkJBN5YqPK8dIhfc=
X-Google-Smtp-Source: AGHT+IHdLm9VEq1+63pkrH8mvjYT/uIVSs925aHw/8k3D4K+tqs7TqGU6Kx3vXCa/TmQKTFwzjFzUPMcGvaKqm9PY2w=
X-Received: by 2002:a05:6512:239d:b0:539:e873:6d7 with SMTP id
 2adb3069b0e04-53b1a30c2ecmr674708e87.1.1729666126389; Tue, 22 Oct 2024
 23:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-4-xur@google.com>
 <CAK7LNARqnhZuDf75_juBtdK0GV8jL_aDjnuyU=-8zjdCZetF1g@mail.gmail.com> <CAF1bQ=S1Hv=fJxk38dYkRTAXWQO_4W8QLTfbNRbihg8UvUKvGQ@mail.gmail.com>
In-Reply-To: <CAF1bQ=S1Hv=fJxk38dYkRTAXWQO_4W8QLTfbNRbihg8UvUKvGQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 15:48:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9HtgL=sDn25BeCxSTz6Hg1x+cYbCe54oxy74S4y2Ogw@mail.gmail.com>
Message-ID: <CAK7LNAS9HtgL=sDn25BeCxSTz6Hg1x+cYbCe54oxy74S4y2Ogw@mail.gmail.com>
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

On Tue, Oct 22, 2024 at 8:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> On Sun, Oct 20, 2024 at 7:15=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> > >
> > > When the -ffunction-sections compiler option is enabled, each functio=
n
> > > is placed in a separate section named .text.function_name rather than
> > > putting all functions in a single .text section.
> > >
> > > However, using -function-sections can cause problems with the
> > > linker script. The comments included in include/asm-generic/vmlinux.l=
ds.h
> > > note these issues.:
> > >   =E2=80=9CTEXT_MAIN here will match .text.fixup and .text.unlikely i=
f dead
> > >    code elimination is enabled, so these sections should be converted
> > >    to use ".." first.=E2=80=9D
> > >
> > > It is unclear whether there is a straightforward method for convertin=
g
> > > a suffix to "..".
> >
> >
> >
> > Why not for ".text.fixup"?
> >
> > $ git grep --name-only '\.text\.fixup' | xargs sed -i
> > 's/\.text\.fixup/.text..fixup/g'
> >
>
> I did not move .text.fixup because it currently groups together with TEXT=
_MAIN.

OK. Then, .text.fixup is not a problem.



> >
> > Why did you do this conditionally?
> >
> > You are making this even more unmaintainable.
>
> Again, we don't want to change the default build.
>
> If you think the change can apply to the default build, we would be
> happy to remove the condition.


I believe this should be done unconditionally.

If you are concerned about changing the default,
I am concerned about changing it under any condition.

We should avoid maintaining two section layouts.




--
Best Regards
Masahiro Yamada

