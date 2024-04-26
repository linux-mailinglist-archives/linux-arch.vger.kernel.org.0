Return-Path: <linux-arch+bounces-4027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49698B3FD1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515A71F224CE
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2DBE48;
	Fri, 26 Apr 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1J8gS6e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F231C06;
	Fri, 26 Apr 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158108; cv=none; b=W6HD41fQz19sweJgwEJ7EYqIaTLo9/32ZjmbPalPqYI4rRBRpWWipZDtA3AmAtb0KjhboJrcLpzp1i2kA7bcOcLKdIerYONNNzOz/m3i9R8OCsTc8NeO9hoOUGY2To7hf/8Hb/0NPp46hywRGydNPK+KNu4u2b1qSNFlnVZwRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158108; c=relaxed/simple;
	bh=spHwlcTCpaNA543nwyK0H2eAD2T0c3htMv4UjyBqffA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhdvC1F4R4e3uvxGNnkx3a5KQr3e8bp8ki0aLHO7xtNRl4F3FBkh3MRRYzDgD+oUgMeSL2sVjQ93FK3x9FvSdCu2JIzqn9xv3aZ4l74MXhCVFwgCNRn3ed4mfMPi4n5wx0Vs/wd6c/rncLGmsB99ky4cqNSkQ0uz8pc4DRD1BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1J8gS6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D934C4AF0B;
	Fri, 26 Apr 2024 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158107;
	bh=spHwlcTCpaNA543nwyK0H2eAD2T0c3htMv4UjyBqffA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1J8gS6el0nAxFSbvhUmiteeeXNoJZJN5MPZ60QK8xy+IuJlkTXsHsNrzkbPy5TqD
	 de39M5yXbq+ntNG1c/6nbsdwkYXeDFX1MSl+Fi0o2O9vI1Qd0a43krhnD8x6h+FV0m
	 wlO6PXD2h3aPbk1x/4BZ7QoDsjaeDob+jGsSj+rmBEO15awWX82WHpVByDcK/7srXO
	 ZSQDUE3BCOcr85i/+vlQyfSOR0XhzCaCfEOgUJDjSgUS6O0kiXb7ZAZne92g7psDMZ
	 DVcXQzkfK3TKHln6vD5/6f1ZlTR1cK6SRZi9YHQAfiSfJAxBcBY+UqW5ezGHDQjaaF
	 pbTgvfRBhCTeA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so2266102e87.0;
        Fri, 26 Apr 2024 12:01:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXv8pxNSWqRXzdQ9G76oELuSMmA5ZFIlKT4vxK5ksqnk6ZYTE2tcW0E/2KmtMBHb0bg5+DgxJCjjVAc0AYY0KuJOIMjrn1f/POQ2t3w1u8h0+v2bJS6LJgRf13SVvbnvJb0RqzVHlQUoOf+2R231l1BJpSJXOSEM/iGAcYOZWYlv710cZYY2EmUAAUZKBJQYESduiBpOqICtdkQx80HUwyGl9nncqu6SlK/LwugCoab+5CEkwAON6Crp5j/Qpu4sx5HqLfh71Iqhvsqn/wBf91CZMhVsUN38HzsPS3M23OBN9pJw21DKsQP1tg9EO+12j0gtaZsUO0Bty0pVxtlp2XSu5gIWAw2Drkx2eLS0ALFz7EMSv976hGLtmS0yLo5y1AVZ0RQywRwpexkIo4=
X-Gm-Message-State: AOJu0YzeamOqJfgHaiNFAFTc75ZvDN7CvcR1I9Tcr0KrQOg6ZMWUUo8t
	4cLLMKqy9j8L3V/5vBpRNP4O+BHS0Q8nNtyhwthsncMEeR95E+mQeWS6j01P48Hinoh+APKwzot
	ZwcMX9BesBaQDLTzIu/xvWnE0R6E=
X-Google-Smtp-Source: AGHT+IF/3UI9Cwbb8z8OI8jFmskqzepU4aeg2+YglDD7FKhfHPiRdUcmMxLF73Ba/yVMMyprkxylEY00eIaasdUhAvE=
X-Received: by 2002:a05:6512:151:b0:513:c1a2:d380 with SMTP id
 m17-20020a056512015100b00513c1a2d380mr1420572lfo.31.1714158105499; Fri, 26
 Apr 2024 12:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426082854.7355-1-rppt@kernel.org> <20240426082854.7355-9-rppt@kernel.org>
In-Reply-To: <20240426082854.7355-9-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Apr 2024 12:01:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW52MYy4Md5O=7XVGvkw395-LB+BiSadxoDdw8CrLw5t7A@mail.gmail.com>
Message-ID: <CAPhsuW52MYy4Md5O=7XVGvkw395-LB+BiSadxoDdw8CrLw5t7A@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] mm/execmem, arch: convert remaining overrides of
 module_alloc to execmem
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Sam Ravnborg <sam@ravnborg.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 1:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Extend execmem parameters to accommodate more complex overrides of
> module_alloc() by architectures.
>
> This includes specification of a fallback range required by arm, arm64
> and powerpc, EXECMEM_MODULE_DATA type required by powerpc, support for
> allocation of KASAN shadow required by s390 and x86 and support for
> late initialization of execmem required by arm64.
>
> The core implementation of execmem_alloc() takes care of suppressing
> warnings when the initial allocation fails but there is a fallback range
> defined.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>

nit: We should probably move the logic for ARCH_WANTS_EXECMEM_LATE
to a separate patch.

Otherwise,

Acked-by: Song Liu <song@kernel.org>

