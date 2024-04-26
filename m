Return-Path: <linux-arch+bounces-4026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C398F8B3FBD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 20:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF8728372B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91728B67F;
	Fri, 26 Apr 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtIGLkVI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C4BE47;
	Fri, 26 Apr 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157659; cv=none; b=iIsS1ltRFP+46ejY/wX+KloXu086hcV88c+P2ejt/NeisOsUlfsblotq/T7it4PWhc98ymhfYpWkbSOueoLQZLGkTd/pkpMk8a/udmxr6nIy7OprHuvf8uFDUsNBggJ6zFJKQThopnIzNmh4WnnQGJFbUNGz8Qgfa1HHqztv+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157659; c=relaxed/simple;
	bh=Erw8uuVUeGio0PshYx2zkVsumWpV4GynBPxpYdsctHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjaTFsMKPJsd6ECpK5eJQMtHHBBrcQy2bNWholG/aQpWcw5tyLpA0MlqtYWKsy2PKxCaduDlhtwlvHtsEkm2ua6onJ0QLT9zCsP8Xny/LkJyJ+eW98yy2bXfdwQHF10gtW9C1MzTifLqPQozN/DFe85Nx99iJLFUlga+IFlYGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtIGLkVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD5C2BD10;
	Fri, 26 Apr 2024 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714157658;
	bh=Erw8uuVUeGio0PshYx2zkVsumWpV4GynBPxpYdsctHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PtIGLkVIeqBKR9XEnfi6oa2ABiJCHDWkMcxnQH6NsAziRnrm6MjyOXSpNcpzr5Bpj
	 E/+DTDMfi551f7rzH24rHY27M/wW2GL5thq60UidmW3gekcOw/Lw7WAfRzWyd8GkUc
	 AMCRC/bEKdhEkcE8BUKVSsq3i6jRXE/rRiDch/q2swRdO1P0u026aiMTpNhht44wJL
	 UIPWzKzyFzPlmxNLqcd/AT/DShSQyLxRDyOuWXTPLByxMvQzpvRUI5+5WtOVbnGLoN
	 udeSsSYdjr9fYuzLauYRgGtv2ybIbSepMhbtSmBkkZI6dcFW/TNhf3zMRdYQbw+V8+
	 QrxzekJFRuwhA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d3a470d5so3047934e87.3;
        Fri, 26 Apr 2024 11:54:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM8ZypdlDMPCN05MdpxMV/6rLXZtcthQG9/QpcKsMGYUW2eevOcSli1y6SfRPpMwlSeJ5Ttu7Q9+dNZhAyBiR4QkZUkqmOumo7kUtTyFxqylnBV8403zaKDMwrz9d+0rzOJ7EeoPir879K7bAePY0UV1X3Kxlt53BrN7nKffn6fBhw5G9GaTPXHR89gjaJnSViXXQK/Z9e9pQHQ8Jt8rSgZR1X6robljV/3F4iOHMlCgBxtP8PhAJFmxUu8Ut/sE1zZ6ZSxabtH2pDjyUvZUbF6bGI5xWFEnY4kJGn4UgnJjaXxnuQz2GIyHVYtA1Dj6npO2OIQvhrvq8Ld93BZeeC6GqDt9Kk3KPka02dfbHrV3kmRYmKQLTzAh8GWguMVXabpy9ArdcBgbOt4RU=
X-Gm-Message-State: AOJu0YyvMBvKSJznNwb3zf29G4NMrsHTe0pHsgQ0tK6coE0MNUuAnslp
	82BY0/S5+qI3Zb/qoPqVT2tbiMpbK5Me0kJTbRkyDFC6Z2n9yugCCqm0i+zlRbcVvmtb7ETHP3d
	5qgcUSYU+VsKePNbi2/nxlYntOHQ=
X-Google-Smtp-Source: AGHT+IHR8dCzuYaMcfUu9DJ1W7DJuyt98T5r37UenPfdlzP0RlXEYGrXPEenPo3iSsrLDDgw6B5I00dbfOalDiVdMh8=
X-Received: by 2002:ac2:5202:0:b0:51c:1fb4:2327 with SMTP id
 a2-20020ac25202000000b0051c1fb42327mr2189866lfl.24.1714157657105; Fri, 26 Apr
 2024 11:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426082854.7355-1-rppt@kernel.org> <20240426082854.7355-8-rppt@kernel.org>
In-Reply-To: <20240426082854.7355-8-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Apr 2024 11:54:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7+wmDA_aaZKhNLfEZ-F1aLpUKssXqu5tUs6s=P9yvB-Q@mail.gmail.com>
Message-ID: <CAPhsuW7+wmDA_aaZKhNLfEZ-F1aLpUKssXqu5tUs6s=P9yvB-Q@mail.gmail.com>
Subject: Re: [PATCH v6 07/16] mm/execmem, arch: convert simple overrides of
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
> Several architectures override module_alloc() only to define address
> range for code allocations different than VMALLOC address space.
>
> Provide a generic implementation in execmem that uses the parameters for
> address space ranges, required alignment and page protections provided
> by architectures.
>
> The architectures must fill execmem_info structure and implement
> execmem_arch_setup() that returns a pointer to that structure. This way t=
he
> execmem initialization won't be called from every architecture, but rathe=
r
> from a central place, namely a core_initcall() in execmem.
>
> The execmem provides execmem_alloc() API that wraps __vmalloc_node_range(=
)
> with the parameters defined by the architectures.  If an architecture doe=
s
> not implement execmem_arch_setup(), execmem_alloc() will fall back to
> module_alloc().
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Song Liu <song@kernel.org>

