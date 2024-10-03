Return-Path: <linux-arch+bounces-7651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214C98EDA5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA91C215AD
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11F1537D4;
	Thu,  3 Oct 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo5b2EyM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964414431B;
	Thu,  3 Oct 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954034; cv=none; b=RnTvpHk6QXcQiB6o8HEEdYp8nOUGzI3YA7ilzFIfB6XHeHjGlH52mUXXYc0xr8HH5ohBBM32wXftJYcoLJTqkYSOwB29SnKVn7+mJYhWBsY2ufYWKwDtfu0f3b3R081vXJt7iviSeHGBGmYRzzXSmWqwRzhAhvqSDH6qZyOxJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954034; c=relaxed/simple;
	bh=ncshirJSuuxVYT6Rg4hMRMg6qTFNBzUzykD4N2BkVY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPHSvaGKTWN8C0Nx37QsvMHDiJT6HLS64DtcWGxae2zf39VWSoA27me9CYpyUqVRwF4+8WeJMGg4N5tNvpBE+56XS0M66lBlX14WFwtEEYSRYswezlEZzDTamgqwcsSlUDI9I83gZnikxGS0BA6+RFEgARFxKs9gz5EtnPICyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo5b2EyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02029C4CED4;
	Thu,  3 Oct 2024 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727954034;
	bh=ncshirJSuuxVYT6Rg4hMRMg6qTFNBzUzykD4N2BkVY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jo5b2EyMOS3uk9JDlHSQeU5R1aJyjAs0+fTPWkZCep6Wfe3FtEcKX92qY2mtaY2EK
	 Ci8TPn6Ee42qRsmfrcj1l+x8zMsi6bvfBaExW2NU/fSlbTuDXDF1+X8cFBydkm8Y27
	 lb+XzyBozg7zRqcDdBoznF0nnozWrNcR9tzS6b9UomNb4g91qxhdupQuTqUK4zEuA4
	 z7g+nzwCR3g6dyxU7168Y4P6qlP/X9DMrNre/R3uCNKxAg+BkBWF+gHp9jrQW3cTIh
	 xrWMcRuCjU0dRKRqqjEvI0IIIfAguu/05IPATBt+DaAJfq3OXiy9Jf7zCzIbXi+uOl
	 853BOc6UvNv1A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53995380bb3so1051099e87.1;
        Thu, 03 Oct 2024 04:13:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMZ83aPs6Y9Mc8/76A84iJla1AJCX9Et2K13+KujubLe2sgHbvnKgZl4NuiD05HVtyE8WoJyooTELHDKJc@vger.kernel.org, AJvYcCUol65TBElcH6VRPdOKTevF5/Lg0Bgvr04QoHuzeJ3vv0tXAom1N8dA6JhOhqxEsnpwFieSoEgOiaao@vger.kernel.org, AJvYcCV2cpTVxzMwed+BQGXixWf2l6Z1qOjOhdS+ZPRILONG3juJVUAa0l4Zf0jyUO+AN/tX3AubuqvbL+Ht2w==@vger.kernel.org, AJvYcCV7SHMXRybZNmiZtR6oeW3XlhWJ1sPvIu0OCAp6W/yr/M2Cr8GVxev0QSXYb8S9gB2bsNWEFlveQx67vqKTdRY1vw==@vger.kernel.org, AJvYcCVJycArIR3VPg10j8rte3NuVKrN4Dmbp658AY1jhRwXGJa6NxFlF4vgRLHCCLJxjzLUtOflFlJdVswb13Kq@vger.kernel.org, AJvYcCVKCH+27bj3KprvYndBy1OLWcz2gzFauQzBYu9karbRPFXS4JY+qZ4NI2zETiEcLm3JbJYurHJFJ5km@vger.kernel.org, AJvYcCVcx5OIiA5GHF2O32Qr+FTzWaMyGUhNjGDurLGNpEP0zFwdIVFyFcGZXSv+fycttd4RGuQJgTfOEOqmVPTc@vger.kernel.org, AJvYcCVvZrcqj31MD4y8rXNg+pz6HKBUIvYSj4JzJcBz5q6QkdO4qgoD/0iJh9oAg1i2BZougKDDXCgcp0ZWV9zi33E=@vger.kernel.org, AJvYcCWmGLvSpl1papB8MvSTPgS3BfainKQddGsUq0U3iaLkR/wjmAjqJFIMpmXpdpYTYMxfqmwnOXYCzns=@vger.kernel.org, AJvYcCXEL4X4VlMI
 XN6mutoyZsnTaiRR8MYaOjH0ixRxr5SsiEgXOfAD6OYUkpqwMxpR9paJcRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYusTtmvHCpx+fbQj35DhxxIcDdBxZMUegSYe4vdI008LT62L9
	POZO1ex2ELV2iUqAp2JCPWCr6iQo88kkk52Cdhf6Ls8/9HA/oIsCmBfOcw6nZCIp93wnszGav6m
	/VNPGY8sBWRRCLFdtEFGdi7TAss8=
X-Google-Smtp-Source: AGHT+IH0sWh3HiA/Y/FG77TM2NrCKaNhbA4eJ/qwHE/WqxSdpNeBFdDDl6WpEY+OacY7yD9godh5OoCJmImz57qPZ+Q=
X-Received: by 2002:a05:6512:1241:b0:536:9ef0:d829 with SMTP id
 2adb3069b0e04-539a07a1db9mr3832198e87.44.1727954032228; Thu, 03 Oct 2024
 04:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com> <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
In-Reply-To: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Oct 2024 13:13:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
Message-ID: <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
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
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 22:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > I guess you are referring to the use of a GOT? That is a valid
> > concern, but it does not apply here. With hidden visibility and
> > compiler command line options like -mdirect-access-extern, all emitted
> > symbol references are direct.
>
> I absolutely hate GOT entries. We definitely shouldn't ever do
> anything that causes them on x86-64.
>
> I'd much rather just do boot-time relocation, and I don't think the
> "we run code at a different location than we told the linker" is an
> arghument against it.
>
> Please, let's make sure we never have any of the global offset table horror.
>
> Yes, yes, you can't avoid them on other architectures.
>

GCC/binutils never needs them. GCC 13 and older will emit some
horrible indirect fentry hook calls via the GOT, but those are NOPed
out by objtool anyway, so that is easily fixable.

Clang/LLD is slightly trickier, because Clang emits relaxable GOTPCREL
relocations, but LLD doesn't update the relocations emitted via
--emit-relocs, so the relocs tool gets confused. This is one of the
reasons I had for proposing to simply switch to PIE linking, and let
the linker deal with all of that. Note that Clang may emit these even
when not generating PIC/PIE code at all.

So this is the reason I wanted to add support for GOTPCREL relocations
in the relocs tool - it is really quite trivial to do, and makes our
jobs slightly easier when dealing with these compiler quirks. The
alternative would be to teach objtool how to relax 'movq
foo@GOTPCREL(%rip)' into 'leaq foo(%rip)' - these are GOTPCREL
relaxations described in the x86_64 psABI for ELF, which is why
compilers are assuming more and more that emitting these is fine even
without -fpic, given that the linker is supposed to elide them if
possible.

Note that there are 1 or 2 cases in the asm code where it is actually
quite useful to refer to the address of foo as 'foo@GOTPCREL(%rip)' in
instructions that take memory operands, but those individual cases are
easily converted to something else if even having a GOT with just 2
entries is a dealbreaker for you.

> That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
> feel are a complete no-brainer and should be done regardless of any
> other code generation issues.
>

Yes, this is the primary reason I ended up looking into this in the
first place. Earlier this year, we ended up having to introduce
RIP_REL_REF() to emit those RIP-relative references explicitly, in
order to prevent the C code that is called via the early 1:1 mapping
from exploding. The amount of C code called in that manner has been
growing steadily over time with the introduction of 5-level paging and
SEV-SNP and TDX support, which need to play all kinds of tricks before
the normal kernel mappings are created.

Compiling with -fpie and linking with --pie -z text produces an
executable that is guaranteed to have only RIP-relative references in
the .text segment, removing the need for RIP_REL_REF entirely (it
already does nothing when __pic__ is #define'd).

