Return-Path: <linux-arch+bounces-7434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F7598665F
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D14286563
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924B13BAC3;
	Wed, 25 Sep 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXl9LiMB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE541849;
	Wed, 25 Sep 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289186; cv=none; b=tgYBhJ9Gk2AMqoflPAQme3kVF40DCPd1jic+dT4qbM3UAbjz+FDukJ8sK/+J7pK0LhZuDrUuSH9xcgqpj4n4Dpbpsr/F3LAK3lsanpgmB8vlWKggNZJDcw8PuyBcoXmM9lvU0Rxwp9ddFhD5HchtnAp5uX9DmajdJGX4WznUNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289186; c=relaxed/simple;
	bh=a4TscZhPkFUpuRsMP0BamYUYJ4NTFPOf/N+pr3km5jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqJ92P2j3kcDogPsZ/HLzVIvEuPCbBxI1YJfd9XcTxKHTe8daW5Xq2hodOYIvXaSqdSMJho8gIFi6yQfz/SMkSgGpd1nQ9WGAOmKqmQNJCuX+iNKYt/Krq1NpUCQuQlIgSq9CDQWQmWwJVmTIshP1HN/cwlwJdYzIyWAgchlxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXl9LiMB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so1845681fa.3;
        Wed, 25 Sep 2024 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727289183; x=1727893983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TaypDUy15NjLViQ9n5rNlOiyd4lGW04UgUrk3q1RZw=;
        b=bXl9LiMBmzEzDgRr3sc7CDMCPyF4vnp2L9UB+CbKIzbtJtQ5WlMSTjAPPTqnXzeeI3
         quDwGKG/MBmtMHmjq3csRWcD1yBmlCFAoBftNBBfOKVT56qlSAiceIbC/9Cfo+G75dWI
         gLYFfbUtJ65ZlNVS4zv5JMoGHod+bQZAkPYQVvB0L4sqq8nYJJCejMq3cMrzk3PSrchX
         FBKPnj0lg9//QDRcuigQt7MUxlnDYZv7ufMnQFyJQP9zZI3/5gRzy2KzgkSMHONxctLk
         GKUSc5SnKqvX2F0NKNG/wAXtaNScuPZn4MONR5OjNgFmqfnlAbQlg9I9+sqyfH7bjVda
         COaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289183; x=1727893983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TaypDUy15NjLViQ9n5rNlOiyd4lGW04UgUrk3q1RZw=;
        b=rHtDLDzlgnuB5Va3dYXeAoZhH2pKJbUR+Mie165yL8GCtK3QNBLZOm7bSV4kODVAma
         WLP/YDv/RT89+cY+/doqIgaGQe6W7PSxQ35q8EIFnKWAxLM3OxceHPJ2QLHpzk/H7S51
         eFve69gtqPfgU3jDOELt8CcKqhGpLEDeiIvHU8M7d9W5zPq8SG9DQE7bKGTGMnwjBCpN
         JU4cWjyMTKWt9bgTri1/N2liopJXb090g5E+6NWXqfq1RYQ5U2y48vrYuGiR8Nkkfyqc
         LQkvva/+BCo15AOi71SD8N0AVzsZkXwfhJAjUz4pvcn4oGs/JxBcEY/6gmM5Z+cmsClP
         VaNg==
X-Forwarded-Encrypted: i=1; AJvYcCVCOESDAfMj1rrgtPrkfP3KWh4OykJLCb0Ff7Y+2rVCX+EgPw2Bhnp4UbVibYfQQZJ/fA4=@vger.kernel.org, AJvYcCVMPKGirMekiNL6aHSz1vcEhBXvHuKrE3fkNYPKSHv00zkInV8KpnxiyCetaawi5ePPgp8EQwlNyI08LRU6jOyQig==@vger.kernel.org, AJvYcCVc9QbURf7tj07gBdiaN9oukDHryNzp0EKItL/IugM815iC9MwZLKWttem1VyatBtLAjiF5Yiqv1sg=@vger.kernel.org, AJvYcCVjqJk//MeUYrkq0fptGMbWFT5yT7RLILEyCQRMkEOl97ABAcRpg94OeLLHcdY5cAYYXjwKOyb72IOz@vger.kernel.org, AJvYcCW+paV9En8u5/mcJXR3mQhZjts2oNVBL0QBKDo4xdfWct0da0y1CcZ0FepA5i+AZuetIkDWei/LNvznB0V6qF8=@vger.kernel.org, AJvYcCWpjNssfGrDBKCpAmOKEUZ18AaYuu7RpnA5CTkbywlwpNlO0FtW5UgFBmFc38+X3+zeGpzJKKilpDIv@vger.kernel.org, AJvYcCX42LE/z/XO36MN52i23UYNVqzUoiF0O+h6D43VYMULWq6mJf6MRRLG4pHNBnbGUaEcq9GP6WGIW9XJ4w==@vger.kernel.org, AJvYcCXQMH1GPR6DozAP4ICmQmfkh3n0WykoXDY/qpg+0LrADNS9KtH3td4iLIaoctersLwKm7TcRGe1LsbvuEpV@vger.kernel.org, AJvYcCXlxsQkHdbilJAS9/+qanZzyyh//O621l/pBkb2w+nRZc96ddyMLVLOx7+5/S357OtsOFE0jojZvw3+I8Dn@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfTYzMsdVsxJ9W8yeSN9SwSQupO3aR4NAYJpmmEHR/4QWEKhF
	VXUn+jVRvQmNg24hdLfHMjDdBUEAohqVpeK5Wg3kM3rt0+5hwVqHzCrJkOSeINKN//n8a2/O9Qd
	OFlZD9s9iua0p4gC3D6t9B7Q+BJk=
X-Google-Smtp-Source: AGHT+IFnZSeaSdTnLQgfoNEdeVLMhBqMGfqv8DaMO7rq1jJMGCnw0pqCqh/uqtAkx22xjLrl+mG72CuzpXzogM33B5U=
X-Received: by 2002:a2e:be1c:0:b0:2f7:562d:cb5b with SMTP id
 38308e7fff4ca-2f915fc0ad0mr37129861fa.7.1727289182671; Wed, 25 Sep 2024
 11:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-35-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-35-ardb+git@google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 25 Sep 2024 20:32:50 +0200
Message-ID: <CAFULd4ZNwfPZO-yDjrtT2ANV509HeeYgR80b9AFachaVW5zqrg@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
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
	llvm@lists.linux.dev, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Specify the guard symbol for the stack cookie explicitly, rather than
> positioning it exactly 40 bytes into the per-CPU area. Doing so removes
> the need for the per-CPU region to be absolute rather than relative to
> the placement of the per-CPU template region in the kernel image, and
> this allows the special handling for absolute per-CPU symbols to be
> removed entirely.
>
> This is a worthwhile cleanup in itself, but it is also a prerequisite
> for PIE codegen and PIE linking, which can replace our bespoke and
> rather clunky runtime relocation handling.

I would like to point out a series that converted the stack protector
guard symbol to a normal percpu variable [1], so there was no need to
assume anything about the location of the guard symbol.

[1] "[PATCH v4 00/16] x86-64: Stack protector and percpu improvements"
https://lore.kernel.org/lkml/20240322165233.71698-1-brgerst@gmail.com/

Uros.

>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Makefile                     |  4 ++++
>  arch/x86/include/asm/init.h           |  2 +-
>  arch/x86/include/asm/processor.h      | 11 +++--------
>  arch/x86/include/asm/stackprotector.h |  4 ----
>  tools/perf/util/annotate.c            |  4 ++--
>  5 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 6b3fe6e2aadd..b78b7623a4a9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -193,6 +193,10 @@ else
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
>
> +        ifeq ($(CONFIG_STACKPROTECTOR),y)
> +                KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3Dfixe=
d_percpu_data
> +        endif
> +
>          # Don't emit relaxable GOTPCREL relocations
>          KBUILD_AFLAGS_KERNEL +=3D -Wa,-mrelax-relocations=3Dno
>          KBUILD_CFLAGS_KERNEL +=3D -Wa,-mrelax-relocations=3Dno
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 14d72727d7ee..3ed0e8ec973f 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_X86_INIT_H
>  #define _ASM_X86_INIT_H
>
> -#define __head __section(".head.text")
> +#define __head __section(".head.text") __no_stack_protector
>
>  struct x86_mapping_info {
>         void *(*alloc_pgt_page)(void *); /* allocate buf for page table *=
/
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 4a686f0e5dbf..56bc36116814 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -402,14 +402,9 @@ struct irq_stack {
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
>         /*
> -        * GCC hardcodes the stack canary as %gs:40.  Since the
> -        * irq_stack is the object at %gs:0, we reserve the bottom
> -        * 48 bytes of the irq stack for the canary.
> -        *
> -        * Once we are willing to require -mstack-protector-guard-symbol=
=3D
> -        * support for x86_64 stackprotector, we can get rid of this.
> +        * Since the irq_stack is the object at %gs:0, the bottom 8 bytes=
 of
> +        * the irq stack are reserved for the canary.
>          */
> -       char            gs_base[40];
>         unsigned long   stack_canary;
>  };
>
> @@ -418,7 +413,7 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
>
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
> -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> +       return (unsigned long)&per_cpu(fixed_percpu_data, cpu);
>  }
>
>  extern asmlinkage void entry_SYSCALL32_ignore(void);
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm=
/stackprotector.h
> index 00473a650f51..d1dcd22a0a4c 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -51,10 +51,6 @@ static __always_inline void boot_init_stack_canary(voi=
d)
>  {
>         unsigned long canary =3D get_random_canary();
>
> -#ifdef CONFIG_X86_64
> -       BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) !=
=3D 40);
> -#endif
> -
>         current->stack_canary =3D canary;
>  #ifdef CONFIG_X86_64
>         this_cpu_write(fixed_percpu_data.stack_canary, canary);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 37ce43c4eb8f..7ecfedf5edb9 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2485,10 +2485,10 @@ static bool is_stack_operation(struct arch *arch,=
 struct disasm_line *dl)
>
>  static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *=
loc)
>  {
> -       /* On x86_64, %gs:40 is used for stack canary */
> +       /* On x86_64, %gs:0 is used for stack canary */
>         if (arch__is(arch, "x86")) {
>                 if (loc->segment =3D=3D INSN_SEG_X86_GS && loc->imm &&
> -                   loc->offset =3D=3D 40)
> +                   loc->offset =3D=3D 0)
>                         return true;
>         }
>
> --
> 2.46.0.792.g87dc391469-goog
>

