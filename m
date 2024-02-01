Return-Path: <linux-arch+bounces-1975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A1845D41
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32771F298EB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CD5A4E1;
	Thu,  1 Feb 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV3Coqwd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD35A4DD;
	Thu,  1 Feb 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804917; cv=none; b=jvHp2umBnhsqFyC94U6SO4Za9Zfkwkz9LkDGe13VnYSXgetjc4fCBrtTrvhQ1HRl+KzfcaYPZ+YlCtD9VlRxKx9DNba+4ZEm2klL3p7U/bzMmYwl9pi1hQGBcHVxwuixSmGsf1EIz6SDjdJU5R+7Tu+y3SAYYMqZvhIJxVyQ92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804917; c=relaxed/simple;
	bh=AYoNkt7FBERipsA6+gWOzsLUUlJSiRlytP9Ua8kgOO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhGXn9ih1dgx0ELG1iZvxEwu/zlE3XOwbSNtb1W8bicjJWNozF6m/3Ba+UPno/xfITsu6M9LpeEKx/SmehBpecE9glhqA3zPb/HsF8hsF8L2D1RbDwxYGOAhrUMdCepXHlXAUS05SOY+Z8/pZ4WS4q3b8S3+hdqrLMP8BNVPjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV3Coqwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1CCC433C7;
	Thu,  1 Feb 2024 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804917;
	bh=AYoNkt7FBERipsA6+gWOzsLUUlJSiRlytP9Ua8kgOO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CV3CoqwdSSmMD8zmP5QrTCOkRJLjaGMSF95A7VIPYV/EV/MMM2FJvyXgwlcafjaaN
	 iLHNQ+FqZ2otMTGTqfGpgMw+M1aeoyprZmM1x+9u4Y4iN3tD0MelYB9aPlwPY39i/Y
	 F/1wxlcobf6un6EIHMNNol4Fw7XvihnSkfpNipuuLF8b4uCsK86xil3OIpTuilWQd5
	 i/+B6BE/GV1VkRi2ua9Ffc7cPyMUq9fJb+Sn77q0o/JudVwFZKKWpA3uIXndgKsBGv
	 Da9hHc0npRpi8zXPY7U3rdff78VEehn/Wh+PKlWTFu93U9l9aDDh1n9Bpq2bAH7NW4
	 0keUfCRnAKREQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5113000a426so1375197e87.2;
        Thu, 01 Feb 2024 08:28:36 -0800 (PST)
X-Gm-Message-State: AOJu0YyFHBjJkiz7/CzOgO15faXOjwuyShHRq8W2n81yIoT90HtUUzP3
	s3Nxw5P36BXoZIKRHKGhoZ1oACbKjUCppb8arEq9+UBu4tYcY99wNcgb136UrtCJ2o0/tQM01xV
	08b99gRRvbBEH7JA46q51NNBcaoY=
X-Google-Smtp-Source: AGHT+IGyHtwSRcTL6/4uhQhAfoq9TneyyfKnj3SLIV6x5awNwiaKP9QM4hpCSbY07j7uj5hnjq0UJldlmz8GcShfIOU=
X-Received: by 2002:a05:6512:70:b0:511:b86:35b5 with SMTP id
 i16-20020a056512007000b005110b8635b5mr2032216lfo.9.1706804915280; Thu, 01 Feb
 2024 08:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-22-ardb+git@google.com> <20240131073156.GHZbn3bILaWLEluzp-@fat_crate.local>
 <CAGdbjmJi_b0jt4-noJEdVFvQ80BOBULmHic8D-uGsNn4m9rTyg@mail.gmail.com>
In-Reply-To: <CAGdbjmJi_b0jt4-noJEdVFvQ80BOBULmHic8D-uGsNn4m9rTyg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Feb 2024 17:28:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFZKM5wU8djcVBxDmnCJwV4Xpest6u1EbE=7wyLUUeUUQ@mail.gmail.com>
Message-ID: <CAMj1kXFZKM5wU8djcVBxDmnCJwV4Xpest6u1EbE=7wyLUUeUUQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] efi/libstub: Add generic support for parsing mem_encrypt=
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Conrad Grobler <grobler@google.com>, 
	Andri Saar <andrisaar@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 17:23, Kevin Loughlin <kevinloughlin@google.com> wrot=
e:
>
> On Tue, Jan 30, 2024 at 11:32=E2=80=AFPM Borislav Petkov <bp@alien8.de> w=
rote:
> >
> > On Mon, Jan 29, 2024 at 07:05:04PM +0100, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Parse the mem_encrypt=3D command line parameter from the EFI stub if
> > > CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy, so that it can be passed to the earl=
y
> > > boot code by the arch code in the stub.
> >
> > I guess all systems which do memory encryption are EFI systems anyway s=
o
> > we should not worry about the old ones...
>
> There is at least one non-EFI firmware supporting memory encryption:
> Oak stage0 firmware [0]. However, I think Ard's patch seems simple
> enough to adopt in non-EFI firmware(s) if needed. I merely wanted to
> point out the existence of non-EFI memory encryption systems for
> potential future cases (ex: reviewing more complex patches at the
> firmware interface).
>
> [0] https://github.com/project-oak/oak/tree/main/stage0_bin
>

The second patch in this series actually implements the mem_encrypt=3D
parsing for both EFI and non-EFI boot. I just broke this out in a
separate patch because it affects architectures other than x86.

