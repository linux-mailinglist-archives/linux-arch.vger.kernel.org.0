Return-Path: <linux-arch+bounces-5454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF59339D5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF69B2166F
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7B1CD2A;
	Wed, 17 Jul 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv35rG/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AD9461;
	Wed, 17 Jul 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208625; cv=none; b=i18yFROCHqWGj1/e5peGu6g2ePhH5w3K/HQlY8tQjwCpdwII4QjXry2DAKtccJWwMjXJX/seGMJ1eCHrIDVZn3P3R4ME3kdfnpHSAodZrreHt1GrHT3xgUiUjzuH/e6SL7CpXiQU/ZeQxbfEsc/f40tnLt+yFMzaDaEEAIbOWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208625; c=relaxed/simple;
	bh=UgLgkxAAK1bpntMcGljtPImGpKAi1pNB35Mh3l8zNIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sur5SZsh+65SVH2kMKe2f417CB8tfdAuynP2VepAZ4hraU30EbQZcpNgh8lOEs3a0vJ4iQi2MmHD5/u9e/HwU3+D5WORjFR47k44Hlq7p4ZDpOeyQbCEqqh5jUXNksltjzO9YwXQc512U7wtlwbLydlVunKcQmSvdHm8L5sefqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv35rG/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98178C4AF16;
	Wed, 17 Jul 2024 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721208624;
	bh=UgLgkxAAK1bpntMcGljtPImGpKAi1pNB35Mh3l8zNIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gv35rG/92muT8WZHaqeRJan592jHtD7nTfg8q0zkGGUTeUO2/Q3796k6p4sdK4BgD
	 5tE+m7n198T8mJ49yc7HnzXHsej3f6gZpoTQSF2/qca8P5JodHwZ0cIBcqMG1cmvd8
	 rPT6g8TAa7nS608yJKFbjUXJtfOvl7Do6CCE682sbM3TCBYJ27sWKFNgvmkonvwlTm
	 PkYtJxGXtRaO7w+OWV4OGIsM0YGfVAzstlJXu+picVIH4erNNXDfgSD26Urwi8iSVe
	 mjZTxOUM0ruN/xVqGR4w7BP2w99QLOeTUbsfgbHf9pQfTbfDCjFGvp5OHu24NpF9kW
	 Mxzc0wTmUn1eQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso7745910a12.0;
        Wed, 17 Jul 2024 02:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1WOejGW5QdmmA4YetLwVgKP9wzpccAWfR+UvIMwhrnVhcB1wrtpLxAaMW5hrhXf5I4h1TpawLl13DItagdVXiHv2/oA9p32PaWcxcsdy6kqpBe8lO3GPLEOAAaxzKnZHSRFT+RpLIFUMd6pI+pzK9pALBflElbrq/OJyuUzy8x2apiA==
X-Gm-Message-State: AOJu0YxjbXA3CEBNvhr2zEwKJtN34cX+vFvBK8SfigyKomtPEF09v8hW
	2ttTs4W2yERCnMTLzk/j/H9rs0g/5DKlJaKg6tzPUrFM9411Ua5N7RyHeC+CWcCpT1V33SFDKsy
	Tg3i9X5nwEVvY1OBFbZYUUC0i6sg=
X-Google-Smtp-Source: AGHT+IG6E9uB4jRPKPiECpjXt0tCBe1OPH5XeKp7ACG5/b0Vid2C9Ki0zl7E8oIq9QazJR+h14TXBataMTw2v6bzZGs=
X-Received: by 2002:a17:906:f2c6:b0:a6f:501d:c224 with SMTP id
 a640c23a62f3a-a7a013377c0mr76709066b.57.1721208622961; Wed, 17 Jul 2024
 02:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com> <20240717061957.140712-12-alexghiti@rivosinc.com>
In-Reply-To: <20240717061957.140712-12-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 17 Jul 2024 17:30:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtT5KxpjjOs5QMcrxz6wEKTjHgxrgXZvXy1HbQ3AhhTQ@mail.gmail.com>
Message-ID: <CAJF2gTQtT5KxpjjOs5QMcrxz6wEKTjHgxrgXZvXy1HbQ3AhhTQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:31=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha or Ziccrse are not present.
>
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.
>
> This is largely based on Guo's work and Leonardo reviews at [1].
>
> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren=
@kernel.org/ [1]
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  .../locking/queued-spinlocks/arch-support.txt |  2 +-
>  arch/riscv/Kconfig                            | 29 ++++++++++++++
>  arch/riscv/include/asm/Kbuild                 |  4 +-
>  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>  arch/riscv/kernel/setup.c                     | 33 ++++++++++++++++
>  include/asm-generic/qspinlock.h               |  2 +
>  include/asm-generic/ticket_spinlock.h         |  2 +
>  7 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/spinlock.h
>
> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support=
.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> index 22f2990392ff..cf26042480e2 100644
> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> @@ -20,7 +20,7 @@
>      |    openrisc: |  ok  |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bbaec0444d0..5040c7eac70d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -72,6 +72,7 @@ config RISCV
>         select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +       select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>         select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>         select BUILDTIME_TABLE_SORT if MMU
>         select CLINT_TIMER if RISCV_M_MODE
> @@ -482,6 +483,34 @@ config NODES_SHIFT
>           Specify the maximum number of NUMA Nodes available on the targe=
t
>           system.  Increases memory reserved to accommodate various table=
s.
>
> +choice
> +       prompt "RISC-V spinlock type"
> +       default RISCV_COMBO_SPINLOCKS
> +
> +config RISCV_TICKET_SPINLOCKS
> +       bool "Using ticket spinlock"
> +
> +config RISCV_QUEUED_SPINLOCKS
> +       bool "Using queued spinlock"
> +       depends on SMP && MMU
> +       select ARCH_USE_QUEUED_SPINLOCKS
> +       help
> +         The queued spinlock implementation requires the forward progres=
s
> +         guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha=
 or
> +         LR/SC with Ziccrse provide such guarantee.
> +
> +         Select this if and only if Zabha or Ziccrse is available on you=
r
> +         platform.
> +
> +config RISCV_COMBO_SPINLOCKS
> +       bool "Using combo spinlock"
> +       depends on SMP && MMU
> +       select ARCH_USE_QUEUED_SPINLOCKS
> +       help
> +         Embed both queued spinlock and ticket lock so that the spinlock
> +         implementation can be chosen at runtime.
> +endchoice
> +
>  config RISCV_ALTERNATIVE
>         bool
>         depends on !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuil=
d
> index 504f8b7e72d4..ad72f2bd4cc9 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -2,10 +2,12 @@
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D flat.h
>  generic-y +=3D kvm_para.h
> +generic-y +=3D mcs_spinlock.h
>  generic-y +=3D parport.h
> -generic-y +=3D spinlock.h
>  generic-y +=3D spinlock_types.h
> +generic-y +=3D ticket_spinlock.h
>  generic-y +=3D qrwlock.h
>  generic-y +=3D qrwlock_types.h
> +generic-y +=3D qspinlock.h
>  generic-y +=3D user.h
>  generic-y +=3D vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/s=
pinlock.h
> new file mode 100644
> index 000000000000..4856d50006f2
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#define _Q_PENDING_LOOPS       (1 << 9)
> +
> +#define __no_arch_spinlock_redefine
> +#include <asm/ticket_spinlock.h>
> +#include <asm/qspinlock.h>
> +#include <asm/alternative.h>
> +
> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> +
> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
> +static __always_inline type arch_spin_##op(type_lock lock)             \
> +{                                                                      \
> +       if (static_branch_unlikely(&qspinlock_key))                     \
> +               return queued_spin_##op(lock);                          \
> +       return ticket_spin_##op(lock);                                  \
> +}
> +
> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> +
> +#else
> +
> +#include <asm/ticket_spinlock.h>
> +
> +#endif
> +
> +#include <asm/qrwlock.h>
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..d7c31c9b8ead 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,38 @@ static void __init parse_dtb(void)
>  #endif
>  }
>
> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +       char *using_ext;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> +           IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
> +               using_ext =3D "using Zabha";
> +
> +               asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA=
_EXT_ZACAS, 1)
> +                        : : : : no_zacas);
> +               asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_IS=
A_EXT_ZABHA, 1)
> +                        : : : : qspinlock);
> +       }
I'm okay with this patch.
I suggest putting an arg such as "enable_qspinlock," which people
could use on the non-ZABHA machines. I hope it could happen in this
series. That's all I need, thank you very much.

> +
> +no_zacas:
> +       using_ext =3D "using Ziccrse";
> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
> +                            RISCV_ISA_EXT_ZICCRSE, 1)
> +                : : : : qspinlock);
> +
> +       static_branch_disable(&qspinlock_key);
> +       pr_info("Ticket spinlock: enabled\n");
> +
> +       return;
> +
> +qspinlock:
> +       pr_info("Queued spinlock %s: enabled\n", using_ext);
> +}
> +
>  extern void __init init_rt_signal_env(void);
>
>  void __init setup_arch(char **cmdline_p)
> @@ -295,6 +327,7 @@ void __init setup_arch(char **cmdline_p)
>         riscv_set_dma_cache_alignment();
>
>         riscv_user_isa_enable();
> +       riscv_spinlock_init();
>  }
>
>  bool arch_cpu_is_hotpluggable(int cpu)
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinl=
ock.h
> index 0655aa5b57b2..bf47cca2c375 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qsp=
inlock *lock)
>  }
>  #endif
>
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the correspondi=
ng
>   * queued spinlock functions.
> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qsp=
inlock *lock)
>  #define arch_spin_lock(l)              queued_spin_lock(l)
>  #define arch_spin_trylock(l)           queued_spin_trylock(l)
>  #define arch_spin_unlock(l)            queued_spin_unlock(l)
> +#endif
>
>  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/=
ticket_spinlock.h
> index cfcff22b37b3..325779970d8a 100644
> --- a/include/asm-generic/ticket_spinlock.h
> +++ b/include/asm-generic/ticket_spinlock.h
> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arc=
h_spinlock_t *lock)
>         return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the correspondi=
ng
>   * ticket spinlock functions.
> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(ar=
ch_spinlock_t *lock)
>  #define arch_spin_lock(l)              ticket_spin_lock(l)
>  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
>  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> +#endif
>
>  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

