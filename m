Return-Path: <linux-arch+bounces-7795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94F993CAD
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 04:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7179D1C23320
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 02:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEB225A8;
	Tue,  8 Oct 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJVgAncT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0956224FA;
	Tue,  8 Oct 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353499; cv=none; b=kxjZYHz9Ah78Dx+x+97YILXfbua2qT4ovzcyWEy4KHiwi8v+HCFaWcFIFIxNoqfEXpyn/QNKJD00IrOpG16sKPQka03DVXDeAdXTtjawEFDb7H7pwtmCEoQHLR3NY5FIatPbPICyRcgrqCOPgATRCFvsptnGEk1CYPbu08Z25rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353499; c=relaxed/simple;
	bh=ecuISJm/aWL+tNMQ+twAVlW+4RZvWpoN2srrbXkDB94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUsqmyvkKAqojaQthubbDoX4KV9HTc3oiS1YXoRd1Q3n8NzBxNNjBtDiEuNARs3iU+oh2IhSxaF11wlSvWFGpuwk4fOhAErVSWZWi3mSHpO9PiE/bf/b/f8wcavhmoILDxHbVpEHamCCvksz61j1XYcFwIg8DzVpofvSOs2znX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJVgAncT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA0AC4CECD;
	Tue,  8 Oct 2024 02:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728353498;
	bh=ecuISJm/aWL+tNMQ+twAVlW+4RZvWpoN2srrbXkDB94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sJVgAncTPsJH0dYu/FY7tpoM13FlZrkcGW302R2qV3rAtntuHnx6b6IBtsoGqJfUK
	 OJlF20yd3fT8v8p+RPUvLVZ1RAMX5W6IbxX8tZagSwZOA/94MMpuD4+qFDEILoEjsf
	 P9uAjzPBaX291VACffb+ISH0H3TDsmmxM/gNcXrwWMJ0mwOhLF9F36oQ6KMq+Kl+J3
	 cl4KezTj+ksZUrr54Ao44lrKdmPEUpk3T3kJ7LEHkgZvFjg/8ZeTWGIRfWaPxyNycf
	 uEqf34myc+g6AkPGGZi/bTzkGCJuh9wf939s4XdMc4f/DEpE3N6CmVgYLon7hKR9NJ
	 ZKCT4YfZMpMYg==
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d2ddb61c8so119690f8f.2;
        Mon, 07 Oct 2024 19:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNPA+rtDH5uYjZVbNY0F7smViTncwDq+rDIbEpaAECa2zfXnDqjH44soMVZJNrsA3O8toN8U7GJGeINUTgrA==@vger.kernel.org, AJvYcCUShv6w18H7qxmBv3rauvICCRq2nooWqQBa8zNuAr62o7Lf8GWrKBnIdP8w0M0PPqvhbzmFm/rDy5deYA==@vger.kernel.org, AJvYcCUUto2NDOkbfKA4FDP3Ba9HUSaHUO9/TXSExe10XqGY4myP1j+CEYjYDAomqwbxO3g08RcHt3TyuXfN6+JZ@vger.kernel.org, AJvYcCUYW8NFoBVPE1J6xzauEQW7olec5iC6wpn8sm2HidpVBHsyALUwCAT1TjqHesnL3Tzl5HYt+wY3to4=@vger.kernel.org, AJvYcCUwlrpU0pUYm1ezlH6emNxO1HPBcigiuq0+yaiykXdK89lfeVMXPNc/aeHyxW0Bkx0caK7khD07Mh4lQiv8@vger.kernel.org, AJvYcCUymArPZHfkrpwwPZvR4VMCb1H372TJxoopgqfjEb1WI4bhCNtlTEP3hgzaoSNxQMvoSE4=@vger.kernel.org, AJvYcCVcWgWDIS4ovuOnvvGkH6qUs2VgPkdg68cRt5mE8uY9IoZQQITBIOXFagD2+nxf4NiHZJJnzxYxQL/kXqoBtH0=@vger.kernel.org, AJvYcCWHzw5SUWeSGWiAtxoQtzQDY7KwX8/dWCpiNcUu+Z/GtDvpl4C62DhCRbGC3jUa4Kyq/+giktVgZnJh27w=@vger.kernel.org, AJvYcCWkZHEnXvEfIgRm4SCTbvQFocAg86/jONp0FFoQSL9w7xakQwSul/x9c+ftAhq6oluBsULJzlnRmrJvrzQwXVE+QsZQ@vger.kernel.org, AJvYcCXF65q8QSTr
 C4HJK0PmNVUxDz7XYsP6j5odccrXFO/SXo4F0/09egB0koJqZcQdc4rhZ1Jxoe6WXQ7riGaVlQ==@vger.kernel.org, AJvYcCXJxg71K3KwHX1WmS4LfP9MuxFdxfaozsea2KokzqKyhRzOt5V7F6yOqlKJClZoqY4BDnFAVyX4b6Awfg==@vger.kernel.org, AJvYcCXOrfvlQUOOajdeW+B9I/Lf/8QqKtmJTB5kQIDEL8TW/LhfWwAweeziqs5A9nWdHxq9ARTk5G5IoeevYQ==@vger.kernel.org, AJvYcCXslaWvCJ55ET4+7eEesoiwZg90bWPLAwIHtqajaX1llRZya2FGHb8hA+v66LWxr0snosXLwg+W34pvug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMxHfmbmxegTTQv1+JDm9JH8NzIl7+eAX4tJntxcYVHOfsDzB
	ao7LXoBIGlk0MU/f4lUL3FMKqILGlYkl3hROylGkegkIUzuJAylmsvo6SO1nsrsdCfw1HBYPRxE
	rob4Jwp7n72zgcexJCMLyXGtPGwM=
X-Google-Smtp-Source: AGHT+IG9/HXDQPVy3roiGpnpx5nYoWEmk19PPS8Q+OmkGvZ1j1NxJVVRW61nrohcbFPxLB5t6MVKLRvfuhF1lJEIdu8=
X-Received: by 2002:a5d:6e0a:0:b0:374:ce15:9995 with SMTP id
 ffacd0b85a97d-37d0e78253cmr10508015f8f.34.1728353497103; Mon, 07 Oct 2024
 19:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007062858.44248-1-rppt@kernel.org> <20241007062858.44248-6-rppt@kernel.org>
In-Reply-To: <20241007062858.44248-6-rppt@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 8 Oct 2024 10:11:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
Message-ID: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] arch: introduce set_direct_map_valid_noflush()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Mike,

On Mon, Oct 7, 2024 at 2:30=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Add an API that will allow updates of the direct/linear map for a set of
> physically contiguous pages.
>
> It will be used in the following patches.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm64/include/asm/set_memory.h     |  1 +
>  arch/arm64/mm/pageattr.c                | 10 ++++++++++
>  arch/loongarch/include/asm/set_memory.h |  1 +
>  arch/loongarch/mm/pageattr.c            | 21 +++++++++++++++++++++
>  arch/riscv/include/asm/set_memory.h     |  1 +
>  arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
>  arch/s390/include/asm/set_memory.h      |  1 +
>  arch/s390/mm/pageattr.c                 | 11 +++++++++++
>  arch/x86/include/asm/set_memory.h       |  1 +
>  arch/x86/mm/pat/set_memory.c            |  8 ++++++++
>  include/linux/set_memory.h              |  6 ++++++
>  11 files changed, 76 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm=
/set_memory.h
> index 917761feeffd..98088c043606 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -13,6 +13,7 @@ int set_memory_valid(unsigned long addr, int numpages, =
int enable);
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  #endif /* _ASM_ARM64_SET_MEMORY_H */
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 0e270a1c51e6..01225900293a 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -192,6 +192,16 @@ int set_direct_map_default_noflush(struct page *page=
)
>                                    PAGE_SIZE, change_page_range, &data);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +
> +       if (!can_set_direct_map())
> +               return 0;
> +
> +       return set_memory_valid(addr, nr, valid);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/inc=
lude/asm/set_memory.h
> index d70505b6676c..55dfaefd02c8 100644
> --- a/arch/loongarch/include/asm/set_memory.h
> +++ b/arch/loongarch/include/asm/set_memory.h
> @@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
>  bool kernel_page_present(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_invalid_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>
>  #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index ffd8d76021d4..f14b40c968b4 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -216,3 +216,24 @@ int set_direct_map_invalid_noflush(struct page *page=
)
>
>         return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT =
| _PAGE_VALID));
>  }
> +
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +       pgprot_t set, clear;
> +
> +       return __set_memory((unsigned long)page_address(page), nr, set, c=
lear);
This line should be removed.

Huacai

> +
> +       if (addr < vm_map_base)
> +               return 0;
> +
> +       if (valid) {
> +               set =3D PAGE_KERNEL;
> +               clear =3D __pgprot(0);
> +       } else {
> +               set =3D __pgprot(0);
> +               clear =3D __pgprot(_PAGE_PRESENT | _PAGE_VALID);
> +       }
> +
> +       return __set_memory(addr, 1, set, clear);
> +}
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm=
/set_memory.h
> index ab92fc84e1fc..ea263d3683ef 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -42,6 +42,7 @@ static inline int set_kernel_memory(char *startp, char =
*endp,
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 271d01a5ba4d..d815448758a1 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -386,6 +386,21 @@ int set_direct_map_default_noflush(struct page *page=
)
>                             PAGE_KERNEL, __pgprot(_PAGE_EXEC));
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       pgprot_t set, clear;
> +
> +       if (valid) {
> +               set =3D PAGE_KERNEL;
> +               clear =3D __pgprot(_PAGE_EXEC);
> +       } else {
> +               set =3D __pgprot(0);
> +               clear =3D __pgprot(_PAGE_PRESENT);
> +       }
> +
> +       return __set_memory((unsigned long)page_address(page), nr, set, c=
lear);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void=
 *data)
>  {
> diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/s=
et_memory.h
> index 06fbabe2f66c..240bcfbdcdce 100644
> --- a/arch/s390/include/asm/set_memory.h
> +++ b/arch/s390/include/asm/set_memory.h
> @@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>
>  #endif
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 5f805ad42d4c..4c7ee74aa130 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -406,6 +406,17 @@ int set_direct_map_default_noflush(struct page *page=
)
>         return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEM=
ORY_DEF);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       unsigned long flags;
> +
> +       if (valid)
> +               flags =3D SET_MEMORY_DEF;
> +       else
> +               flags =3D SET_MEMORY_INV;
> +
> +       return __set_memory((unsigned long)page_to_virt(page), nr, flags)=
;
> +}
>  #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
>
>  static void ipte_range(pte_t *pte, unsigned long address, int nr)
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set=
_memory.h
> index 4b2abce2e3e7..cc62ef70ccc0 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -89,6 +89,7 @@ int set_pages_rw(struct page *page, int numpages);
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
>
>  extern int kernel_set_to_readonly;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 44f7b2ea6a07..069e421c2247 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2444,6 +2444,14 @@ int set_direct_map_default_noflush(struct page *pa=
ge)
>         return __set_pages_p(page, 1);
>  }
>
> +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid)
> +{
> +       if (valid)
> +               return __set_pages_p(page, nr);
> +
> +       return __set_pages_np(page, nr);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e7aec20fb44f..3030d9245f5a 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struc=
t page *page)
>         return 0;
>  }
>
> +static inline int set_direct_map_valid_noflush(struct page *page,
> +                                              unsigned nr, bool valid)
> +{
> +       return 0;
> +}
> +
>  static inline bool kernel_page_present(struct page *page)
>  {
>         return true;
> --
> 2.43.0
>

