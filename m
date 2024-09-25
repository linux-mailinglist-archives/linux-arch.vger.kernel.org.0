Return-Path: <linux-arch+bounces-7439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E02986791
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A21284727
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88C148304;
	Wed, 25 Sep 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4rIz9xq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F1145324;
	Wed, 25 Sep 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295755; cv=none; b=TVA7yHvlGLjQNorsdLQyuZyB5g8ioWKyS/aNKvTBqBxV9FGnZ6NvIguebT8BNtS8QMF9TZ3ykXkm2j+Dr36KIPSbVoSYN0iy/B5XWKrjAcdC0/HoMUzmtq2wEczrfaoNmFERdXNH3bZEccIIJmtBJaUqCAYAbmBzfOMXKFDf3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295755; c=relaxed/simple;
	bh=YIIgXkMaMQVypTqr3Dlc/4cjp96pZ1OIgVbT5mp5nAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1S6bO/N8w2/lRnlYSVqL0NBZB9J+hVraXE5CLk4SHoQP6sf+RI2o8db6Ej+1J38uoQmGiBfHYbrJWLsdw956yGON9OX6Jt+jcbB4mw1K17lFf+Yqutls/X1OQdCxAhwwfw55VyzSEbP1nInOuI6LL3sJB+Cn9nuK64GOhn3gvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4rIz9xq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f761461150so3638271fa.0;
        Wed, 25 Sep 2024 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727295752; x=1727900552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIIgXkMaMQVypTqr3Dlc/4cjp96pZ1OIgVbT5mp5nAM=;
        b=R4rIz9xqQVB/bLtEgdETqXL+TmwWK/Nu4EfIbtRSyyMDpvgBS6lAh+8aIwTCE32kZW
         nXcn2d526VqsF4Jcv4OjBZSSSO2YTqa09a+f4JUc5jpaK31Rdlx9j3kqmiFmYGH8AZNJ
         vT6lPzyiol+GD79kseASvqKEnWYt/9sjL3Xx168quRJ/07K1sA29aZRQN6LLRXitxIm4
         qPUy0MuyhwXXFK49Kr6BgLzyH5m/Bf469eh7TWIMiQgkFXx4+/dROrGbWlL4dtjKmzGq
         39BVnqIxJBBlokvyNCpIMnuiDjg3tJxA3zejxxIJgEN92onzzfvICm40T59FLbGCgYzX
         D+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295752; x=1727900552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIIgXkMaMQVypTqr3Dlc/4cjp96pZ1OIgVbT5mp5nAM=;
        b=pqA2E0W34xlpe24MXwRj93Xq7x7i4KDlhITRqwFv7tRXnE37bF1aDK6t3L7IJ3gm0b
         MUoaohwvRGPNBBCl9fTbp26VDqpLhfr6bVIV/1fM7NIRty6WlcOdvYsj88slY0P0pT1s
         msmC8Sywgq0TdfSn0LoxFicQ+10Sj6ZkUUvpIYsN/LOKlTGb2a/DzBXEkWQgQX3A5RDl
         dz2jZS5DXevduQLODSut9udI5lT2ZI30LvPy2OUXoZX+e/C8dYh6H7ORLwTdKchXGMFh
         LeD0eHcRfkhuFul3VfNNOMzyMxkU08j46qoDwgkRRrooUIt31v/CVr+feBwPKDKnCKkn
         cBxg==
X-Forwarded-Encrypted: i=1; AJvYcCUy+GvaMYXaXgjJPdo+OqKj3ssuF//g5a1j7BrItdtn7Q+mqqcY67h/nLpCwjvIdfnIVa376rBkCgUH1Fmby10=@vger.kernel.org, AJvYcCV+4vK+Tqm+LUVLd+bxG4CYVirJT5r+GkDljJ3Z6o5B6fgC4kp/JcYKl2QfXIhFwcUI0IdG+McRSF7p2Na9f0jteQ==@vger.kernel.org, AJvYcCVxv7jReUmxkwu9iRaoWizaTXfJ1RwznuXp7qM0Y3OkhUjMbvho4Lnvjug7Sb7j2BD1OL6xxr1sHAI7@vger.kernel.org, AJvYcCWY63SAYnfVsUGsm3aeXOmyp7d4h3Rk6suLfOUzsInULb3sVeatsf1LYtqSEXx8JJ9LWWx9+86O3I7SgjNa@vger.kernel.org, AJvYcCWmukuKJ98yZbPnzb4e5b8PIVfpvjZFe4AH+iqVpwJi6H2mJ6GHWqQGakoCyr8+kJWxTpnQd/HQGdLy@vger.kernel.org, AJvYcCXC54xV7OgJndVrniRFqVGl1k2sKyc/MySJbulYdLjSzh8q/NWhD1/7/87EC/bXnvE8/AGaxXtlCCvV4j5i@vger.kernel.org, AJvYcCXFcpr4pevDBYqaIFz6J12PliEPXPI1h0Q2CB67uZoz0rAsvqp2E2IcXVsIG2BVLn3OLJE=@vger.kernel.org, AJvYcCXFlJwaXjZAmjspNvQB7R0CORPvCv2diMYlR3qnJN4nFB6GiGAJXQ6M/CWq3cUAGi+0hN6ofRO6/4s=@vger.kernel.org, AJvYcCXG36AvffcwopsGfJ8KStE/vdjmyjwgVlAno394L1e1lUKG2Tb7CgJ5Ev7UV/2wkxkeo9APaMC/25MD3g==@vger.kernel.org, AJvYcCXG4v+l/XwA4pJQt19yM3C8
 SPLB/WsqwcMeztny/3AOeGkYcIpy2WQGA1s4p98QxXeOytGebiS8eLmXnXZE@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4/8l31ABOXGRACBB6ioR1k6IpfzZnxxnsrtJQrq5Xvltka4Q
	Ik7O2m92DUhMyQ5WtLjLPorOlzYef23rXMDZFO2eHN1EbvAnfvpmdtGOoQybxwEyfnRdQfTbAP2
	NhDL1wFIJms+mDh7QPaem63xX/k4=
X-Google-Smtp-Source: AGHT+IFvfamGkkaVTjihL57HO7Ma4jzbZpdj4uNVGUYPPPoT8ZkXDScK2UWxGNJ3KCLrPCqwFqRqAGWpvpi86QGVs6w=
X-Received: by 2002:a2e:be1c:0:b0:2f7:562d:cb5b with SMTP id
 38308e7fff4ca-2f915fc0ad0mr39215031fa.7.1727295751491; Wed, 25 Sep 2024
 13:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com> <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
 <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com>
 <CAFULd4bLuHQvHNaoLJ4DoEQQZZF0yz=uD27m49M+AbYnh=+NzQ@mail.gmail.com> <CAMj1kXFJHGuxvEgZik_YnrUjoQZCDFaMsTd6BZU=dFe1UcUUNQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFJHGuxvEgZik_YnrUjoQZCDFaMsTd6BZU=dFe1UcUUNQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 25 Sep 2024 22:22:19 +0200
Message-ID: <CAFULd4a3RFZVRs12iX7+K=i1Xj0rZAyD6djrmUpmAuU4VULCrg@mail.gmail.com>
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
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

On Wed, Sep 25, 2024 at 10:01=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 25 Sept 2024 at 21:39, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 9:14=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Wed, 25 Sept 2024 at 20:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@go=
ogle.com> wrote:
> > > > >
> > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > Build the kernel as a Position Independent Executable (PIE). This
> > > > > results in more efficient relocation processing for the virtual
> > > > > displacement of the kernel (for KASLR). More importantly, it inst=
ructs
> > > > > the linker to generate what is actually needed (a program that ca=
n be
> > > > > moved around in memory before execution), which is better than ha=
ving to
> > > > > rely on the linker to create a position dependent binary that hap=
pens to
> > > > > tolerate being moved around after poking it in exactly the right =
manner.
> > > > >
> > > > > Note that this means that all codegen should be compatible with P=
IE,
> > > > > including Rust objects, so this needs to switch to the small code=
 model
> > > > > with the PIE relocation model as well.
> > > >
> > > > I think that related to this work is the patch series [1] that
> > > > introduces the changes necessary to build the kernel as Position
> > > > Independent Executable (PIE) on x86_64 [1]. There are some more pla=
ces
> > > > that need to be adapted for PIE. The patch series also introduces
> > > > objtool functionality to add validation for x86 PIE.
> > > >
> > > > [1] "[PATCH RFC 00/43] x86/pie: Make kernel image's virtual address=
 flexible"
> > > > https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@an=
tgroup.com/
> > > >
> > >
> > > Hi Uros,
> > >
> > > I am aware of that discussion, as I took part in it as well.
> > >
> > > I don't think any of those changes are actually needed now - did you
> > > notice anything in particular that is missing?
> >
> > Some time ago I went through the kernel sources and proposed several
> > patches that changed all trivial occurrences of non-RIP addresses to
> > RIP ones. The work was partially based on the mentioned patch series,
> > and I remember, I left some of them out [e.g. 1], because they
> > required a temporary variable.
>
> I have a similar patch in my series, but the DEBUG_ENTRY code just uses
>
> pushf 1f@GOTPCREL(%rip)
>
> so no temporaries are needed.
>
> > Also, there was discussion about ftrace
> > [2], where no solution was found.
> >
>
> When linking with -z call-nop=3Dsuffix-nop, the __fentry__ call via the
> GOT will be relaxed by the linker into a 5 byte call followed by a 1
> byte NOP, so I don't think we need to do anything special here. It
> might mean we currently lose -mnop-mcount until we find a solution for
> that in the compiler. In case you remember, I contributed and you
> merged a GCC patch that makes the __fentry__ emission logic honour
> -fdirect-access-external-data which should help here. This landed in
> GCC 14.
>
> > Looking through your series, I didn't find some of the non-RIP -> RIP
> > changes proposed by the original series (especially the ftrace part),
> > and noticed that there is no objtool validator proposed to ensure that
> > all generated code is indeed PIE compatible.
> >
>
> What would be the point of that? The linker will complain and throw an
> error if the code cannot be converted into a PIE executable, so I
> don't think we need objtool's help for that.

Indeed.

> > Speaking of non-RIP -> RIP changes that require a temporary - would it
> > be beneficial to make a macro that would use the RIP form only when
> > #ifdef CONFIG_X86_PIE? That would avoid code size increase when PIE is
> > not needed.
> >
>
> This series does not make the PIE support configurable. Do you think
> the code size increase is a concern if all GOT based symbol references
> are elided, e.g, via -fdirect-access-external-data?

I was looking at the code size measurement of the original patch
series (perhaps these are not relevant with your series) and I think
2.2% - 2.4% code size increase can be problematic. Can you perhaps
provide new code size increase measurements with your patches applied?

Thanks and BR,
Uros.

