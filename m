Return-Path: <linux-arch+bounces-7436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A585F9866AC
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B93B1F24C01
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB713D537;
	Wed, 25 Sep 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGBPGmYg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1D3A8F0;
	Wed, 25 Sep 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291682; cv=none; b=ZljYXOoaiTIHQeLRak/2Xi/DPE4fmpdBwMhsR9ZOaOq4BiHiFHbUo91bUS7ebgCB1+0967874/Dxn12L/BCpi+Q+tmeG1eAV3wEWmxFGNCYw9/7WZdJeC8ChcDBGpWNPBeR/m9rMQBhXVQHx7Jt1FuDxjFn370tG1w36PXU1Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291682; c=relaxed/simple;
	bh=v6vimdadH9tmhJ3NLSECJJW2W8zTrYSh4bxODwkPlVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ3MKgNRanmxBRzCKICgOnjdUxLPZsCMCiFvXWVuJTeFGMi+KM1lJB1SVxUpGgg7WmDZJ2+yQufQr7dtMBz02Bh5VzVJubPoFh4JepRHCJMpR1khuY+XX/ErlYkqZNWBUiL85j2vf8Sq/MpBL5UV7IBnbvRgKMvSqzltqfplPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGBPGmYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3478C4CEDC;
	Wed, 25 Sep 2024 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727291681;
	bh=v6vimdadH9tmhJ3NLSECJJW2W8zTrYSh4bxODwkPlVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YGBPGmYgAPdAFKNTwwajPecfktex9cSL6WggNqGsmkyZ+kpGzsxngdf8S8+81jNKy
	 eRHOxSC4Er/nJLoAMfLrBkTHIcD1IdZYm1TNFrPbeS5EE4HG+uTT9AVyVqhIl/8HJL
	 psBuU8DB8inowiaBUE9F9LJuDlTjOY0eHfoSjx7oH91PPbsHYt2Ihsnvpoy1LM1AK1
	 tYHEHOvaPLcu5CS66hGTlA73hlGTptk2NtlRfVRmbHTdaNwk1haPSHF9lDYgrCR7dL
	 s9OTTLilWDbSivuiX3XMZtzsg/Rv746l/RHhNETo2Bt5HCeuV+cwNeebX7eUhXXI68
	 feesglxmQ0ChQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75d044201so2549571fa.0;
        Wed, 25 Sep 2024 12:14:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5ZeKdfIgrlWJVoF3dZw/MryjDq1OBAtW7/wWvZ39Q8BYCf3Ta5zIib4Sb9UNbOpdChRG8oILJpZ7Yew==@vger.kernel.org, AJvYcCVEepfcUoJK0hFRyMtMo4ttgzHs3Yc0sqKD1gwEgeEk5nbGJzB6/Li7pSDLXz4jCXt+mmM=@vger.kernel.org, AJvYcCVINns85+lJO3p8tYXZKpz8JLPjaqekX/L03ecB5f0kANpmr/loxQFZGer3a7q+dOlbBT1Or/mlLkPehN4W@vger.kernel.org, AJvYcCWZoiKqGorhzylWXT0hVTGex8LYmBYZMmgz9J1spOqF5zn/7Otpc9HeeEtDHIPlvwUST9+PgstxLnMCgI5O@vger.kernel.org, AJvYcCWatXrn6ZA/WaewE9IJM1shPVHyL+xJ2T7Jg4i1TtHVT6bCzceTHE5csOy4qD9ZgT+3FKeC+KGSY8Z9@vger.kernel.org, AJvYcCWbr4fkQOZCfejjRkSXIRpNNMhsLtY8IMIQ6lPCA/ae921YSBeHLUe8aFrehlMR4iqW/BmZ3xPICTE=@vger.kernel.org, AJvYcCX0mraYPupOVPOePgaZNlNxeJ7IwkpjEVKl3eut3msYDKcNU11DbTeoSWciRXQYcJJcrAqS36zQpuxSZUKV@vger.kernel.org, AJvYcCXANerKtuePxb1v8UUkb3xwCqAtqCA2ZgqsrzCfh7vBGALrjE8U0g3s5pdbzvPnOctnmtOdDupstXOE@vger.kernel.org, AJvYcCXX+LCkerne2OmJmbORYpIVxPT412JYbgbrJX6sel/ZW4+4wHv4DeIuA883QW/1YOsqYpOjLebxOjVA87S8eY5yaA==@vger.kernel.org, AJvYcCXb3VRxTG7pjiHDSOc5+lVfN598
 MSvY8qUrR8LbbgZmoCNT5WvhVv51KW192Ml+t4+YNCCWgEcAtm4e8SBS7sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNRGNmMd8VCp3rtX41FszfYFhV6086KoQZoTAtL6FLl0PFzQP
	xgrGBVBHKjaNJy/kRUVQUhYM0C5YsTZhZYt5/I1IjI0MrJpQtZoH5FINdwISlFhnu+S1s0tAYBR
	EACk9hTthTy4YKoONcnwjQpT8LXE=
X-Google-Smtp-Source: AGHT+IHhx37wVyIVLg+xrue+pSSLZp5Q9LgYurWqXbgYba/vJ5Rw09i+I8llv3k1oq/x6sYNFgZcR26HfbSEX6O6VBA=
X-Received: by 2002:a05:651c:2126:b0:2f7:631a:6df8 with SMTP id
 38308e7fff4ca-2f9c6cecd0fmr2173111fa.23.1727291679841; Wed, 25 Sep 2024
 12:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com> <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
In-Reply-To: <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 21:14:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com>
Message-ID: <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com>
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

On Wed, 25 Sept 2024 at 20:54, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Build the kernel as a Position Independent Executable (PIE). This
> > results in more efficient relocation processing for the virtual
> > displacement of the kernel (for KASLR). More importantly, it instructs
> > the linker to generate what is actually needed (a program that can be
> > moved around in memory before execution), which is better than having t=
o
> > rely on the linker to create a position dependent binary that happens t=
o
> > tolerate being moved around after poking it in exactly the right manner=
.
> >
> > Note that this means that all codegen should be compatible with PIE,
> > including Rust objects, so this needs to switch to the small code model
> > with the PIE relocation model as well.
>
> I think that related to this work is the patch series [1] that
> introduces the changes necessary to build the kernel as Position
> Independent Executable (PIE) on x86_64 [1]. There are some more places
> that need to be adapted for PIE. The patch series also introduces
> objtool functionality to add validation for x86 PIE.
>
> [1] "[PATCH RFC 00/43] x86/pie: Make kernel image's virtual address flexi=
ble"
> https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgroup=
.com/
>

Hi Uros,

I am aware of that discussion, as I took part in it as well.

I don't think any of those changes are actually needed now - did you
notice anything in particular that is missing?

