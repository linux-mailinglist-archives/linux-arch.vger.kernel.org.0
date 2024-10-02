Return-Path: <linux-arch+bounces-7624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96598DF19
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3B286A77
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B81D1754;
	Wed,  2 Oct 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFl7hH8b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94A1D1747;
	Wed,  2 Oct 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882769; cv=none; b=pxdDcpYNhQzaFrbfWWTdoAy5T2lzBk36UAcJylwYNZnzgz7oIZa7yGEWrRWsjEwQzjF52DDfE+54Ep3V2sLxCV8QzOStNvcLerPGyXrJQpH4arJcbCIpoevP+hCUt5ZXKrPR91XS8nhrlsR1O3NqvuUjcZs+ky9x/HauWjGL0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882769; c=relaxed/simple;
	bh=h4ubFnE46xeI8wN9+4BYkWAbARBnOtNFKXLTjQ3iYxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/0WAUaW4NJwGkxGX5009XaAeckcRtfkKx7gfzvlM4Gkocb9cmCxHF2L5lWCj2rn8N47J8Ez/zcF4zlL7sQk5DftsnBlzSLAPnXoBKB3bV6fVlicf+0qdaeNWh/SNlS5TqYjVvRDSPp01RUfzGD+aUF3fkVbuDTOpd9YXrdSw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFl7hH8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E446C4CEDA;
	Wed,  2 Oct 2024 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882768;
	bh=h4ubFnE46xeI8wN9+4BYkWAbARBnOtNFKXLTjQ3iYxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KFl7hH8baEyBXLc9YdutCabBIIsebd7h0c09OkpKue3HyYk0dPbzyKEPIAYZw8EA0
	 OSqK38e9b/ZQqENWs+TnswX2GzFQqN2nL0SRR4IVxtTfVUlSFGfffBS7Jg4BMNQIz8
	 HMkEBAAndduR9nNbwqZIze+PTqfQzCMnCy8hpJdW/BS84scv9IwY4mniaBcqBDDZua
	 ZBd9lUJThYLwrBMX2si1+483PfVcboCG4r+GJNcdiKhotGYBsctAy1Sareu7r1J5jh
	 Wd6eNnpiy5IQorN76AsuNn8HDWHvuwIblRMKj84P4HPuwkx+3e6SIsEVpTzuDrCbzg
	 6kBiHvv5uu5wg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso33591821fa.2;
        Wed, 02 Oct 2024 08:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU922GEKNn6LZhgnjGS2QUeFmjo+wnFmMpy6eLQ9G1fz3j8xjPAdP4x+bgpZT5yNeZM2iOTOyrEr9RVWLOG+10PUA==@vger.kernel.org, AJvYcCU9kYaw7wsEzF4tsjQJLxFZNX25xxykStLPwqRBfhbVTHZNmKJWrxmuoRjTCmpm/SYJBL410TQPDCI=@vger.kernel.org, AJvYcCUB2rkMUyu2bNGeO8wBtIsMLvKa7lZydMJbMW4Bxxwrpvbko+jXVLVm2TFB0QhNmbJHDKztlSMs/CZ30cgq@vger.kernel.org, AJvYcCUZR7aY4XoONkPxt8Jcbz94wfoixa6beFi/SKdvhW7JfaTkMo+dA8QeVnzzRB5vcawoSZcsEB7cPdnK@vger.kernel.org, AJvYcCUsoQRScStowdXVQtBdYa3HvUL9e5/dG45q/I83H+AQW+ho8c2SudVrPnoxlEqbjKOzkRKnKqbYV+2wvw==@vger.kernel.org, AJvYcCUu9InXWCk13ff5Oj0NQcOKHn/6NTaWalcta+coZJmsqYAmPcPyeYAGEbtRQ29JyUuzbHLhyV7UKeL3FHlz@vger.kernel.org, AJvYcCVKr38Oz3ZFNutXiDquBZrOwm5m+8wRi5xnsOrR3kLvhzLszjawCfumBbNc4Hkj69L2ZIDl7sJh7y3w@vger.kernel.org, AJvYcCVaaUroALnYz6xKiYm88LhCZuu19l96wAufzFzsmH8wIIBp7TwOoNoO9e8g4ik/Djm/1/3TnAZWfUre3Xnp@vger.kernel.org, AJvYcCWMHAODt0YnDCyNxv3MmFkzwUecMJydYA4sVjLanfncSGmSDC4moqSDxZeT7+1o3gYbqfvm5u4FvRGKla64Vfk=@vger.kernel.org, AJvYcCWtQclJEh22
 PR9XC9EWOF4gjdoQ+uWRmSHmaZk6bVROo408of0WP2MKFvMJme9Xz6p/6zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwyEdmFi8ER46JM4uTfUuPkVftZSGfO7CrZlzB1Ow2LT9BTD/
	fAjRiNVRf70MN79/xoOJN3u9o0V2lTeXhQaRKLB3vAKfNVN5zkxRRzHU94c0OhveBmDUZK8frAK
	GxV187uqGsHmJFwQqHvVvZJw05Xg=
X-Google-Smtp-Source: AGHT+IFjphesp/WsGS3U0PINOY0QAoUmw2aq4caedP0chVHCCyNa6a0rrCXQNZVU8wv2cCgEaQKnFwQhCH9Io7gBKbI=
X-Received: by 2002:a05:651c:1502:b0:2fa:d84a:bd83 with SMTP id
 38308e7fff4ca-2fae106e266mr23266981fa.24.1727882766692; Wed, 02 Oct 2024
 08:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
In-Reply-To: <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Oct 2024 17:25:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
Message-ID: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
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
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thanks for taking a look.

On Tue, 1 Oct 2024 at 23:13, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 9/25/24 08:01, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > As an intermediate step towards enabling PIE linking for the 64-bit x86
> > kernel, enable PIE codegen for all objects that are linked into the
> > kernel proper.
> >
> > This substantially reduces the number of relocations that need to be
> > processed when booting a relocatable KASLR kernel.
> >
>
> This really seems like going completely backwards to me.
>
> You are imposing a more restrictive code model on the kernel, optimizing
> for boot time in a way that will exert a permanent cost on the running
> kernel.
>

Fair point about the boot time. This is not the only concern, though,
and arguably the least important one.

As I responded to Andi before, it is also about using a code model and
relocation model that matches the reality of how the code is executed:
- the early C code runs from the 1:1 mapping, and needs special hacks
to accommodate this
- KASLR runs the kernel from a different virtual address than the one
we told the linker about

> There is a *huge* difference between the kernel and user space here:
>
> KERNEL MEMORY IS PERMANENTLY ALLOCATED, AND IS NEVER SHARED.
>

No need to shout.

> Dirtying user pages requires them to be unshared and dirty, which is
> undesirable. Kernel pages are *always* unshared and dirty.
>

I guess you are referring to the use of a GOT? That is a valid
concern, but it does not apply here. With hidden visibility and
compiler command line options like -mdirect-access-extern, all emitted
symbol references are direct. Disallowing text relocations could be
trivially enabled with this series if desired, and actually helps
avoid the tricky bugs we keep fixing in the early startup code that
executes from the 1:1 mapping (the C code in .head.text)

So it mostly comes down to minor differences in addressing modes, e.g.,

  movq $sym, %reg

actually uses more bytes than

  leaq sym(%rip), %reg

whereas

  movq sym, %reg

and

  movq sym(%rip), %reg

are the same length.

OTOH, indexing a statically allocated global array like

  movl array(,%reg1,4), %reg2

will be converted into

  leaq array(%rip), %reg2
  movl (%reg2,%reg1,4), %reg2

and is therefore less efficient in terms of code footprint. But in
general, the x86_64 ISA and psABI are quite flexible in this regard,
and extrapolating from past experiences with PIC code on i386 is not
really justified here.

As Andi also pointed out, what ultimately matters is the performance,
as well as code size where it impacts performance, through the I-cache
footprint. I'll do some testing before reposting, and maybe not bother
if the impact is negative.

> > It also brings us much closer to the ordinary PIE relocation model used
> > for most of user space, which is therefore much better supported and
> > less likely to create problems as we increase the range of compilers and
> > linkers that need to be supported.
>
> We have been resisting *for ages* making the kernel worse to accomodate
> broken compilers. We don't "need" to support more compilers -- we need
> the compilers to support us. We have working compilers; any new compiler
> that wants to play should be expected to work correctly.
>

We are in a much better place now than we were before in that regard,
which is actually how this effort came about: instead of lying to the
compiler, and maintaining our own pile of scripts and relocation
tools, we can just do what other arches are doing in Linux, and let
the toolchain do it for us.

