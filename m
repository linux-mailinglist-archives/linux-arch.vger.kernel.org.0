Return-Path: <linux-arch+bounces-7438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A1986750
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F352871AE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F8132114;
	Wed, 25 Sep 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTR+c/jJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012241F94C;
	Wed, 25 Sep 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294474; cv=none; b=Chf2E8caTF8xwxyNH7IyGupJwIiDUg/JF4PthJmpT6DSA+3Mw+eBFkvENssrU2KkChTeTr2Zfr+9gzU6+09xxjvmMDxknoMA2xPNPsdnVt5/j5V2BlGd9gxQOmNIQVGv4MVDSZW8CAxILIgb16Omr2PfRWG5+luclbAgXX+RORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294474; c=relaxed/simple;
	bh=hhUZIlacRl/vnMEKcyfWg9tD49NT/MnhWz9itBFRH/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azI0jPN5B4LVvfsIayFhqKJ8nPcobFAWwjvm48OQqUJmmvjP/zGq2uV+0BsHvODf9zwIT/npQY76dMZ/muZRo9gc4w7ElZcEwWHvDnlK18cDPzB6GdXITGeGkHupMnshASKalgCeSlmcgn+H9RNL7cKLeSq7jP08BE7eP/abTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTR+c/jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66A0C4CED2;
	Wed, 25 Sep 2024 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294473;
	bh=hhUZIlacRl/vnMEKcyfWg9tD49NT/MnhWz9itBFRH/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KTR+c/jJpox6lNTwZnur9ylGmJ8SNnMLBqE2bVDeKktdg6DiGi1EfTbK4p/QLfrsg
	 62cQ8Xp4g29Hc7A3FUqmxI+kwfZ2doQI9xGt7TSqSAX7TIfCIOG+mYse38LPl3BQWZ
	 l2iF8SThxm63ZjDF5HLI5C21pBaJ962vsnPsoOdMvYtcSZtRE66YpjivKriiies7Co
	 LaxrXpNgSSEEqxTDyY1RyJvKdmUcWWka/8YN0bSo2GO5HoqpEe+qDcQXm8LBLK0D94
	 8ydW6VYJrwsZMAlDTHl93avEh1VQTy7peDTyg6QRgD3UXHuTo3whNIgc1mG6jaSwpr
	 A7tc3n4LvYVlA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so2789911fa.0;
        Wed, 25 Sep 2024 13:01:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4dTpIA5NOcrnkM/L0fsvwHd1USRpPkb1NuZvL481WBPV99WHq2Je0TrBX/0b7TKL8PdIZweM86iJjnC2PIPBV1A==@vger.kernel.org, AJvYcCU7A4OYWWVuIaCnYE0mRzr2JHUIS+s5KFqMPnd7ipG1UEwr9zsF/8OJL48XAJMrzb3DvSXfj5MmVCvVvqWC@vger.kernel.org, AJvYcCUjGhddAq/npKGbS0eSB2RtZJ1B5cJmurlwGD0lzWtWw40bSGgVFB2D+jwZ5/23v0revu4+WtZas84FSKLq@vger.kernel.org, AJvYcCV1q7a/k0G9TWyUr/F04Z+/uYM28qGe8tYNwIlrj/yx5ZLaYocM2Vn9CpF3D4QfyCcaBVU=@vger.kernel.org, AJvYcCVlLbZz1ZrbY1O/PpMdp7Nng3RT9iTUhhUW8BUFUkVxTWkySxkD0x2sadHHfgLqU5DRjv4jRvkTgewd@vger.kernel.org, AJvYcCW+anu23ORbljXkZJ3TKkB4uCuLDXoN+HWJyrqY7N8rgWt5ziE9cg4ROwF6N9k/4hwyfYQnXemuLUxt@vger.kernel.org, AJvYcCW77FEeuH7XLTCybPp8SyzYeMPOpXviQKGdRfUuksL5QQnLGs/Gaza1X3RnUXRnOV9+JlajpvuLQOQLRbwO@vger.kernel.org, AJvYcCWNOdNxifeI3ecd27y1DAYo+DoKzNN1F8UVwD3NwxUmXzxht78olzCRZX4ultOZK9EKE2WBG6S9Lcw=@vger.kernel.org, AJvYcCWWqek8ooX5XeA/sdEWvJOl9NVQ9q9VV7LZTGpSrJZQ3ApDkNEDgPBc22e1lvmAgfhlxx+eDJuw/iscFA==@vger.kernel.org, AJvYcCXK7rLveMThERg+CtNRdrLLU/G1
 x1KdJkTt12K8/2A3RuSSm8xIjfVR/nAKZ8nFuoZhahq4/F4VSTexbaShMMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2h4Wp/qW3FAvQAVD3lM9hdOfJ6nR1ro0amn52xxgwurnIE7O0
	DfF1pjxIJh1cyZYWcgmuTLtrtQhk90N9lsfXanaqgL8/+W3DG26eWZ9rOYIk2WFYxuLEDn8i4uZ
	oAFOg2673weEGBjnWVnSKv1PkAGo=
X-Google-Smtp-Source: AGHT+IEY1YYkhERqv1Guf/9KJxOHKzNT9jpbgg+x9EdmvWSPTNvmnHPEwdJSiqJFazSq6NN7k+EJ+tpT15NwNECytIk=
X-Received: by 2002:a2e:be24:0:b0:2f7:baac:fad7 with SMTP id
 38308e7fff4ca-2f91ca5b318mr26781181fa.39.1727294471846; Wed, 25 Sep 2024
 13:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com> <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
 <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com> <CAFULd4bLuHQvHNaoLJ4DoEQQZZF0yz=uD27m49M+AbYnh=+NzQ@mail.gmail.com>
In-Reply-To: <CAFULd4bLuHQvHNaoLJ4DoEQQZZF0yz=uD27m49M+AbYnh=+NzQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 22:01:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJHGuxvEgZik_YnrUjoQZCDFaMsTd6BZU=dFe1UcUUNQ@mail.gmail.com>
Message-ID: <CAMj1kXFJHGuxvEgZik_YnrUjoQZCDFaMsTd6BZU=dFe1UcUUNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev, Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Sept 2024 at 21:39, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Wed, Sep 25, 2024 at 9:14=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Wed, 25 Sept 2024 at 20:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@goog=
le.com> wrote:
> > > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Build the kernel as a Position Independent Executable (PIE). This
> > > > results in more efficient relocation processing for the virtual
> > > > displacement of the kernel (for KASLR). More importantly, it instru=
cts
> > > > the linker to generate what is actually needed (a program that can =
be
> > > > moved around in memory before execution), which is better than havi=
ng to
> > > > rely on the linker to create a position dependent binary that happe=
ns to
> > > > tolerate being moved around after poking it in exactly the right ma=
nner.
> > > >
> > > > Note that this means that all codegen should be compatible with PIE=
,
> > > > including Rust objects, so this needs to switch to the small code m=
odel
> > > > with the PIE relocation model as well.
> > >
> > > I think that related to this work is the patch series [1] that
> > > introduces the changes necessary to build the kernel as Position
> > > Independent Executable (PIE) on x86_64 [1]. There are some more place=
s
> > > that need to be adapted for PIE. The patch series also introduces
> > > objtool functionality to add validation for x86 PIE.
> > >
> > > [1] "[PATCH RFC 00/43] x86/pie: Make kernel image's virtual address f=
lexible"
> > > https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antg=
roup.com/
> > >
> >
> > Hi Uros,
> >
> > I am aware of that discussion, as I took part in it as well.
> >
> > I don't think any of those changes are actually needed now - did you
> > notice anything in particular that is missing?
>
> Some time ago I went through the kernel sources and proposed several
> patches that changed all trivial occurrences of non-RIP addresses to
> RIP ones. The work was partially based on the mentioned patch series,
> and I remember, I left some of them out [e.g. 1], because they
> required a temporary variable.

I have a similar patch in my series, but the DEBUG_ENTRY code just uses

pushf 1f@GOTPCREL(%rip)

so no temporaries are needed.

> Also, there was discussion about ftrace
> [2], where no solution was found.
>

When linking with -z call-nop=3Dsuffix-nop, the __fentry__ call via the
GOT will be relaxed by the linker into a 5 byte call followed by a 1
byte NOP, so I don't think we need to do anything special here. It
might mean we currently lose -mnop-mcount until we find a solution for
that in the compiler. In case you remember, I contributed and you
merged a GCC patch that makes the __fentry__ emission logic honour
-fdirect-access-external-data which should help here. This landed in
GCC 14.

> Looking through your series, I didn't find some of the non-RIP -> RIP
> changes proposed by the original series (especially the ftrace part),
> and noticed that there is no objtool validator proposed to ensure that
> all generated code is indeed PIE compatible.
>

What would be the point of that? The linker will complain and throw an
error if the code cannot be converted into a PIE executable, so I
don't think we need objtool's help for that.

> Speaking of non-RIP -> RIP changes that require a temporary - would it
> be beneficial to make a macro that would use the RIP form only when
> #ifdef CONFIG_X86_PIE? That would avoid code size increase when PIE is
> not needed.
>

This series does not make the PIE support configurable. Do you think
the code size increase is a concern if all GOT based symbol references
are elided, e.g, via -fdirect-access-external-data?

