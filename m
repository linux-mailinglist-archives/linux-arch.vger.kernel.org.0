Return-Path: <linux-arch+bounces-5291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CC9294F5
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E921B2127C
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404813B58F;
	Sat,  6 Jul 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO5gXbrf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6013A87E;
	Sat,  6 Jul 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720289296; cv=none; b=VAIqt+lk/l7csVnepNryysdfYbprxW1gq4IAjYxKQSvyrHDYLXB05W7AruHbWV+JuMnXenu6X+5ENQbl4SqU9DKtVRHZXUCDylai5EvpGslKgvA/2jzllsvo/Hr7acgR6yxpKvwKeM9lkjoxXKrTqae9qzSVwLeHJb0/yNXsgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720289296; c=relaxed/simple;
	bh=uDlkl+sgIHM1QHirLoUu2V9j90VrrBXLSt/Bf+ihwrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI7W2FekSaaYHVbETBjguZ2QDc10wmr3I/P/tDD33MqH8lGlG37y44urodpTu370XtpBmrll9ewG+/G+LEAYY9j0vTmkPaNr0K8azN0nKO278IvJyncV1AEvwQ+hl0H0Hy/eSqP7c31Yb2FZRTtZ1vgZf5bWl8sL4hu9dWClbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO5gXbrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B4C4AF0D;
	Sat,  6 Jul 2024 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720289296;
	bh=uDlkl+sgIHM1QHirLoUu2V9j90VrrBXLSt/Bf+ihwrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UO5gXbrf7AH9sCVWD6lVDLh/Pe+OubB0hImuHwl5ehyPnNq6f01Qq4dvPk24QNd6L
	 Iof9JHYXwDv3246nHJGjzCJ+XRxJtTNEkRjM+lzRrhV7TBfQfWEEahd8wg704uaTR0
	 rqjWdKRDyVTrPkKfFl8yLGp71R9yH2bXkuel2zx+/EfFMiJaBy/FCh17liRWt7uuIj
	 tQarwCrUCtZseeh3JN6wDhZC+8Jb/OVzuvRgQ6mwvUi/h8Kf3CoxxF3nCkR3P+WJju
	 WHxJp/bn665xEWz2hY1BeliHsQ4C2HxXiXHX6kCvnj6UgVh8+aE3AaLCRrYKwbeVoK
	 uPKaEbfJedXKw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea8320d48so957026e87.1;
        Sat, 06 Jul 2024 11:08:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU00w9gEg/V+btMYBvd57yYStNikeHfADb9bolP24nBqaiLPIqYLmnFw1EQOLW1ktcE8LZ1766k55lAPSpLqC0QTsUiPnajmrK61g==
X-Gm-Message-State: AOJu0YxjvWkeh4tA37GGFiYct+/va73C7+SyioUrscqJnZAPzb6uxKkK
	q2JUasE2WarP/6DXFJix2FoFOhMp6v+VmI1EZLhbg7Jyk+DulSD1GXQfidQ3fsPwGlY22S4+fBE
	24WkRJaB/0k0U5ZInQXPLphIJL44=
X-Google-Smtp-Source: AGHT+IFiLkmA6j4UqVx5NmU+ArqOPS8G32yVfl+L3r4yqEiQeMdZrxtGBHeqAKOSWgEe7Cj3gv2i14yc8Rs6PPW4kF8=
X-Received: by 2002:ac2:5107:0:b0:52c:8b11:80cf with SMTP id
 2adb3069b0e04-52ea0de1675mr2121490e87.8.1720289294972; Sat, 06 Jul 2024
 11:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706160511.2331061-1-masahiroy@kernel.org> <20240706160511.2331061-2-masahiroy@kernel.org>
In-Reply-To: <20240706160511.2331061-2-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 7 Jul 2024 03:07:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBMJvJM9OjXP=QWZwRFpif8tg9AHTA4vu=7nO6D3ahYQ@mail.gmail.com>
Message-ID: <CAK7LNAQBMJvJM9OjXP=QWZwRFpif8tg9AHTA4vu=7nO6D3ahYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] init/modpost: conditionally check section mismatch to __meminit*
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 1:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> This reverts commit eb8f689046b8 ("Use separate sections for __dev/
> _cpu/__mem code/data").
>
> Check section mismatch to __meminit* only when CONFIG_MEMORY_HOTPLUG=3Dy.

This is the opposite. The correct statement is:


    ... only when CONFIG_MEMORY_HOTPLUG=3Dn





>
> With this change, the linker script and modpost become simpler, and we
> can get rid of the __ref annotations from the memory hotplug code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  include/asm-generic/vmlinux.lds.h | 18 ++----------------
>  include/linux/init.h              | 14 +++++++++-----
>  scripts/mod/modpost.c             | 19 ++++---------------
>  3 files changed, 15 insertions(+), 36 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 62b4cb0462e6..c23f7d0645ad 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -141,14 +141,6 @@
>   * often happens at runtime)
>   */
>
> -#if defined(CONFIG_MEMORY_HOTPLUG)
> -#define MEM_KEEP(sec)    *(.mem##sec)
> -#define MEM_DISCARD(sec)
> -#else
> -#define MEM_KEEP(sec)
> -#define MEM_DISCARD(sec) *(.mem##sec)
> -#endif
> -
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  #define KEEP_PATCHABLE         KEEP(*(__patchable_function_entries))
>  #define PATCHABLE_DISCARDS
> @@ -357,7 +349,6 @@
>         *(.data..decrypted)                                             \
>         *(.ref.data)                                                    \
>         *(.data..shared_aligned) /* percpu related */                   \
> -       MEM_KEEP(init.data*)                                            \
>         *(.data.unlikely)                                               \
>         __start_once =3D .;                                              =
 \
>         *(.data.once)                                                   \
> @@ -523,7 +514,6 @@
>         /* __*init sections */                                          \
>         __init_rodata : AT(ADDR(__init_rodata) - LOAD_OFFSET) {         \
>                 *(.ref.rodata)                                          \
> -               MEM_KEEP(init.rodata)                                   \
>         }                                                               \
>                                                                         \
>         /* Built-in module parameters. */                               \
> @@ -574,8 +564,7 @@
>                 *(.text.unknown .text.unknown.*)                        \
>                 NOINSTR_TEXT                                            \
>                 *(.ref.text)                                            \
> -               *(.text.asan.* .text.tsan.*)                            \
> -       MEM_KEEP(init.text*)                                            \
> +               *(.text.asan.* .text.tsan.*)
>
>
>  /* sched.text is aling to function alignment to secure we have same
> @@ -682,7 +671,6 @@
>  #define INIT_DATA                                                      \
>         KEEP(*(SORT(___kentry+*)))                                      \
>         *(.init.data .init.data.*)                                      \
> -       MEM_DISCARD(init.data*)                                         \
>         KERNEL_CTORS()                                                  \
>         MCOUNT_REC()                                                    \
>         *(.init.rodata .init.rodata.*)                                  \
> @@ -690,7 +678,6 @@
>         TRACE_SYSCALLS()                                                \
>         KPROBE_BLACKLIST()                                              \
>         ERROR_INJECT_WHITELIST()                                        \
> -       MEM_DISCARD(init.rodata)                                        \
>         CLK_OF_TABLES()                                                 \
>         RESERVEDMEM_OF_TABLES()                                         \
>         TIMER_OF_TABLES()                                               \
> @@ -708,8 +695,7 @@
>
>  #define INIT_TEXT                                                      \
>         *(.init.text .init.text.*)                                      \
> -       *(.text.startup)                                                \
> -       MEM_DISCARD(init.text*)
> +       *(.text.startup)
>
>  #define EXIT_DATA                                                      \
>         *(.exit.data .exit.data.*)                                      \
> diff --git a/include/linux/init.h b/include/linux/init.h
> index b2e9dfff8691..ee1309473bc6 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -84,11 +84,15 @@
>
>  #define __exit          __section(".exit.text") __exitused __cold notrac=
e
>
> -/* Used for MEMORY_HOTPLUG */
> -#define __meminit        __section(".meminit.text") __cold notrace \
> -                                                 __latent_entropy
> -#define __meminitdata    __section(".meminit.data")
> -#define __meminitconst   __section(".meminit.rodata")
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#define __meminit
> +#define __meminitdata
> +#define __meminitconst
> +#else
> +#define __meminit      __init
> +#define __meminitdata  __initdata
> +#define __meminitconst __initconst
> +#endif
>
>  /* For assembly routines */
>  #define __HEAD         .section        ".head.text","ax"
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 3e5313ed6065..8c8ad7485f73 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -776,17 +776,14 @@ static void check_section(const char *modname, stru=
ct elf_info *elf,
>
>
>  #define ALL_INIT_DATA_SECTIONS \
> -       ".init.setup", ".init.rodata", ".meminit.rodata", \
> -       ".init.data", ".meminit.data"
> +       ".init.setup", ".init.rodata", ".init.data"
>
>  #define ALL_PCI_INIT_SECTIONS  \
>         ".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
>         ".pci_fixup_enable", ".pci_fixup_resume", \
>         ".pci_fixup_resume_early", ".pci_fixup_suspend"
>
> -#define ALL_XXXINIT_SECTIONS ".meminit.*"
> -
> -#define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
> +#define ALL_INIT_SECTIONS ".init.*"
>  #define ALL_EXIT_SECTIONS ".exit.*"
>
>  #define DATA_SECTIONS ".data", ".data.rel"
> @@ -797,9 +794,7 @@ static void check_section(const char *modname, struct=
 elf_info *elf,
>                 ".fixup", ".entry.text", ".exception.text", \
>                 ".coldtext", ".softirqentry.text"
>
> -#define INIT_SECTIONS      ".init.*"
> -
> -#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", =
\
> +#define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
>                 TEXT_SECTIONS, OTHER_TEXT_SECTIONS
>
>  enum mismatch {
> @@ -839,12 +834,6 @@ static const struct sectioncheck sectioncheck[] =3D =
{
>         .bad_tosec =3D { ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL },
>         .mismatch =3D TEXTDATA_TO_ANY_INIT_EXIT,
>  },
> -/* Do not reference init code/data from meminit code/data */
> -{
> -       .fromsec =3D { ALL_XXXINIT_SECTIONS, NULL },
> -       .bad_tosec =3D { INIT_SECTIONS, NULL },
> -       .mismatch =3D XXXINIT_TO_SOME_INIT,
> -},
>  /* Do not use exit code/data from init code */
>  {
>         .fromsec =3D { ALL_INIT_SECTIONS, NULL },
> @@ -859,7 +848,7 @@ static const struct sectioncheck sectioncheck[] =3D {
>  },
>  {
>         .fromsec =3D { ALL_PCI_INIT_SECTIONS, NULL },
> -       .bad_tosec =3D { INIT_SECTIONS, NULL },
> +       .bad_tosec =3D { ALL_INIT_SECTIONS, NULL },
>         .mismatch =3D ANY_INIT_TO_ANY_EXIT,
>  },
>  {
> --
> 2.43.0
>
>


--=20
Best Regards
Masahiro Yamada

