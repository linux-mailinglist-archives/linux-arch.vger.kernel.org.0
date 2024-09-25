Return-Path: <linux-arch+bounces-7435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E898668D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3391F2454C
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365313BC18;
	Wed, 25 Sep 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/gYBwTD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF112C80F;
	Wed, 25 Sep 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290483; cv=none; b=MWQoMsSpyzUxXMu5jJ0MUnNfZI34HnN+ywUgRnfNho8V3RZ4zw3VuzAYh0jzCSqbOeei4oPpN/8fXz9c+SO+HTgAY/36HGCTC0bTejOqMNXHHXCV/T6WPi5vIgng9xLeGOQQq5evPtlkGkP0HabZQtP8/NTCXZGdTRHbkr93MoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290483; c=relaxed/simple;
	bh=Rj5vyu9f3WQi2xyog3TTrfbjGBMTkj1blLma/kg2CPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV9hq1M7xfYSF5FWVUf3yuHqYbYvaAwu0X2egaKDrWS1nz0vln5JmEEVwz3MHGp6gbWJ1rze15lUpczs07iLkkwb/V9gX9YzPVQrhjqzYbxfoqMQvrLm/tA6Sous1dy2jhRZOT8fPj7XqC7XenrYrjToxMvY7jPmtQQwUQRIGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/gYBwTD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ddceaaa9f4so1956727b3.2;
        Wed, 25 Sep 2024 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727290481; x=1727895281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9JiPc1e2s96zySsIYz0vtObK76Zc9LQl9NPrLea+EU=;
        b=X/gYBwTD+Fnvsc5wuL5kZjdjj48aU94vSac/O1N5Qf7FCDNBQfaDSDuG0EdPaYPpmW
         DTM9VyYf6Zr9SRqaQ252H/GLrOBOdi4gQ1X+W/GTl0PAr5QH3HfbXSUwJ+uYtfVDpgCo
         BYHMsrRuZX2SAd3Vn2cJgCDF4H3sKplHXgjX+0saTGixXqabxVVTEFu0sCcj4rRrit1y
         Z5fPdcXjggwQRCDVfqDdp5l18wxqA5/RcqVe0+Cbe+ri6nC6FT3etvzz3lpVm1NbzCUT
         XcvTC0oBM5Nx/PkCWD7iBlqJjmLzmlv98AR6Ocokeiuxfuc9jpZMwJG3FtOWWewEEtBX
         Zg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290481; x=1727895281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9JiPc1e2s96zySsIYz0vtObK76Zc9LQl9NPrLea+EU=;
        b=j0y4Ggi3l1VMCqogHFQ9WypYV62GV+XVgZuYSkNm0rYvU/gDr960iTsBydMCv6xE14
         U+uiuH49B38l+I+QtQQfmuuooga4b8A5uxYbFfmAbSfwOKmkyEGUEJ4bewbBFMkBbgM4
         rS5zTB7rpkejI+yWJnWFdJE/ru3ALvRUK9dEzA36JvyCV2vtKx+NUOoXZ45ZCVKRrJlP
         o3ZKXXpWNmVUkibYQz8J/jtKkZIoRiEIyGJFHoHNTiHlvze1NJUwiF39SmKUPd5wHaM2
         7WwJA7zWpcLtMN0zrWvEf+/vIXO35rDW1erobsMq7eb6vLBuy7dyAkl9An6PHkITyvIZ
         pgSg==
X-Forwarded-Encrypted: i=1; AJvYcCUKqiRZP2FajVALy5efeRt/9kYuLIE/hxjmhuKjJHVmYCsIV1ybU1IJqZ1RreqxiYRv5ct2STTu4FGOmw==@vger.kernel.org, AJvYcCUZq9FcVNNW/LuJeg/HSX0yKdGYboSCUbxEsaX7KOhMG6uZd+yE3hkylLiRdTHB6OcGqnup1m6uA+Uiij6O@vger.kernel.org, AJvYcCUmjOFuTTroMHta24CgbX+dBkNU5OeEU1pMyswnXYqYEq1eupKo3MnkWzcmeb8bitzaLZ2Civ2mQuF9z/laZj4ifg==@vger.kernel.org, AJvYcCVIacoIIxjT9On+GJaXbqf361FJGqhOD8FX9aEx/jPFiBQ6GVsMjOtHBikjan3S05RCVx84164PVtNtXiDO@vger.kernel.org, AJvYcCVLzj1PdJLzTKyWHmWCT9TE450NwbUj+4UI25D1o2ed8h8b5RuCAe/GUDRwjQUcC/w3asOIY5wQq9Ek@vger.kernel.org, AJvYcCVbEbXiS29YiF94ZIX15Q/N4zUmoK19PVK20een7F4CGjUQZkbaDxGoWafwci6qnkFNXU0O5hMMWk2xpoga8RM=@vger.kernel.org, AJvYcCVn1U8mQHbK/Jt4S39DjOvxPzHeqs92qIzSoxk0bw+CkVyqpEXBBGUETj2ZODD9aXHHccI=@vger.kernel.org, AJvYcCVq8F/+0ZNXLDc0KNVQI0rKN1cpUK+XjWFEdXh6KQ6h9c5hL5jlwFVoSALSVmk5Xlw8Z64F6oQJOyB9@vger.kernel.org, AJvYcCW1R9PMDm92u9GZmX07pCgEqE6u8J0jK8gECHig3cVInLOb746gCFV3mGB6QEbKUSm9bCYhFtr+gFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwapRbAgdJOgHOsVDhu+wKGZzTfNhB4+XZ9cmDxkXqdfTIsmiIs
	daEhG6eH+T0IvuYw9zsSCc1S0tLv6Sercd3NzuMyKSnj2dLAJBQbHtdgjZGglLuai2uKO6urE9K
	OWKC+lt4ogqxUovgUyqr9sX2P0cs=
X-Google-Smtp-Source: AGHT+IE/AomPxV+6jhO1GTARWYosyPljDGpP1e9/F5qpa8tECBRSERkhi1mCuqRBaFK/92IcWIO0AVaTr2ic/OREhJo=
X-Received: by 2002:a05:690c:f08:b0:65f:d27d:3f6a with SMTP id
 00721157ae682-6e21d84c92emr41522977b3.7.1727290480582; Wed, 25 Sep 2024
 11:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-57-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-57-ardb+git@google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 25 Sep 2024 20:54:27 +0200
Message-ID: <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
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

On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Build the kernel as a Position Independent Executable (PIE). This
> results in more efficient relocation processing for the virtual
> displacement of the kernel (for KASLR). More importantly, it instructs
> the linker to generate what is actually needed (a program that can be
> moved around in memory before execution), which is better than having to
> rely on the linker to create a position dependent binary that happens to
> tolerate being moved around after poking it in exactly the right manner.
>
> Note that this means that all codegen should be compatible with PIE,
> including Rust objects, so this needs to switch to the small code model
> with the PIE relocation model as well.

I think that related to this work is the patch series [1] that
introduces the changes necessary to build the kernel as Position
Independent Executable (PIE) on x86_64 [1]. There are some more places
that need to be adapted for PIE. The patch series also introduces
objtool functionality to add validation for x86 PIE.

[1] "[PATCH RFC 00/43] x86/pie: Make kernel image's virtual address flexibl=
e"
https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgroup.c=
om/

Uros.

>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Kconfig                        |  2 +-
>  arch/x86/Makefile                       | 11 +++++++----
>  arch/x86/boot/compressed/misc.c         |  2 ++
>  arch/x86/kernel/vmlinux.lds.S           |  5 +++++
>  drivers/firmware/efi/libstub/x86-stub.c |  2 ++
>  5 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 54cb1f14218b..dbb4d284b0e1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2187,7 +2187,7 @@ config RANDOMIZE_BASE
>  # Relocation on x86 needs some additional build support
>  config X86_NEED_RELOCS
>         def_bool y
> -       depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
> +       depends on X86_32 && RELOCATABLE
>
>  config PHYSICAL_ALIGN
>         hex "Alignment value to which kernel should be aligned"
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 83d20f402535..c1dcff444bc8 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -206,9 +206,8 @@ else
>                  PIE_CFLAGS-$(CONFIG_SMP) +=3D -mstack-protector-guard-re=
g=3Dgs
>          endif
>
> -        # Don't emit relaxable GOTPCREL relocations
> -        KBUILD_AFLAGS_KERNEL +=3D -Wa,-mrelax-relocations=3Dno
> -        KBUILD_CFLAGS_KERNEL +=3D -Wa,-mrelax-relocations=3Dno $(PIE_CFL=
AGS-y)
> +        KBUILD_CFLAGS_KERNEL   +=3D $(PIE_CFLAGS-y)
> +        KBUILD_RUSTFLAGS_KERNEL        +=3D -Ccode-model=3Dsmall -Creloc=
ation-model=3Dpie
>  endif
>
>  #
> @@ -264,12 +263,16 @@ else
>  LDFLAGS_vmlinux :=3D
>  endif
>
> +ifdef CONFIG_X86_64
> +ldflags-pie-$(CONFIG_LD_IS_LLD)        :=3D --apply-dynamic-relocs
> +ldflags-pie-$(CONFIG_LD_IS_BFD)        :=3D -z call-nop=3Dsuffix-nop
> +LDFLAGS_vmlinux                        +=3D --pie -z text $(ldflags-pie-=
y)
> +
>  #
>  # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=3D0x2=
00000 to
>  # the linker to force 2MB page size regardless of the default page size =
used
>  # by the linker.
>  #
> -ifdef CONFIG_X86_64
>  LDFLAGS_vmlinux +=3D -z max-page-size=3D0x200000
>  endif
>
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/m=
isc.c
> index 89f01375cdb7..79e3ffe16f61 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -495,6 +495,8 @@ asmlinkage __visible void *extract_kernel(void *rmode=
, unsigned char *output)
>                 error("Destination virtual address changed when not reloc=
atable");
>  #endif
>
> +       boot_params_ptr->kaslr_va_shift =3D virt_addr - LOAD_PHYSICAL_ADD=
R;
> +
>         debug_putstr("\nDecompressing Linux... ");
>
>         if (init_unaccepted_memory()) {
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index f7e832c2ac61..d172e6e8eaaf 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -459,6 +459,11 @@ xen_elfnote_phys32_entry_offset =3D
>
>         DISCARDS
>
> +       /DISCARD/ : {
> +               *(.dynsym .gnu.hash .hash .dynamic .dynstr)
> +               *(.interp .dynbss .eh_frame .sframe)
> +       }
> +
>         /*
>          * Make sure that the .got.plt is either completely empty or it
>          * contains only the lazy dispatch entries.
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/e=
fi/libstub/x86-stub.c
> index f8e465da344d..5c03954924fe 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -912,6 +912,8 @@ static efi_status_t efi_decompress_kernel(unsigned lo=
ng *kernel_entry)
>         if (status !=3D EFI_SUCCESS)
>                 return status;
>
> +       boot_params_ptr->kaslr_va_shift =3D virt_addr - LOAD_PHYSICAL_ADD=
R;
> +
>         entry =3D decompress_kernel((void *)addr, virt_addr, error);
>         if (entry =3D=3D ULONG_MAX) {
>                 efi_free(alloc_size, addr);
> --
> 2.46.0.792.g87dc391469-goog
>

