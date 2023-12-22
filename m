Return-Path: <linux-arch+bounces-1156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011B81C255
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 01:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFC1C23A18
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D617C2;
	Fri, 22 Dec 2023 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwT61Jw1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1D17C3;
	Fri, 22 Dec 2023 00:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9CBC433CC;
	Fri, 22 Dec 2023 00:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703205212;
	bh=DCqhY8G5czXPSCGceoCrCYsQxI4lJLYKd7y7x4FihOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VwT61Jw1XQYHEa2vgWAYs1YoHWRO0S7hE7Htv1Ic0gxCEFWc0JYnVBTnXfvqX6avS
	 jUJ6S9/rLOx0USXJDoa7SDnefPcILSXcFE6wDKsN4NNO9OoMi7KwoGlxnovMqMPgj2
	 oDypB3jIbd+6LeJvPKF3jO1e7YE9fz07sAExO7UXzLDJ+TILLAqsKhafsszWX2XvyZ
	 os4QPe1VQCru8CxOejXi7ZSHZ3owJ8Y7CBT5EQeSXQroPYTMOu5t0LFcvYgqN2FI+H
	 u9o2HpMzk8wQac4LTIziwTZAyl7uYmpZccVo56FfHumBTqhfMmFQNZy0DkrOqDOEjB
	 SRmizus1ojIhQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5545139bed4so167681a12.2;
        Thu, 21 Dec 2023 16:33:32 -0800 (PST)
X-Gm-Message-State: AOJu0YzMOkDmV2p8Wlu95LJJ/e+M9wFK1T9EhlDSgq8mrZf0jmPI2pbc
	4IbLsHn+v/11yLaf/E6s7miSSW4ISQFT4fnMR+U=
X-Google-Smtp-Source: AGHT+IHE7xapUYCkVvGCFmi9RV46Y/s9vLaqov6zcKDyS05KELd7antkz5QZYd8VP1HoG9uNwf0gfIGOkRvmZc5qbtU=
X-Received: by 2002:a50:cd16:0:b0:554:1171:4495 with SMTP id
 z22-20020a50cd16000000b0055411714495mr61774edi.23.1703205210523; Thu, 21 Dec
 2023 16:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com> <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 08:33:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR9ZxLZwEs=TMeih+vEEuuxNHRkgLsG2ShjXPEZ-G44_w@mail.gmail.com>
Message-ID: <CAJF2gTR9ZxLZwEs=TMeih+vEEuuxNHRkgLsG2ShjXPEZ-G44_w@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:38=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All cpus must be
> considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index a418c3112cd6..7b129e5e2f07 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_u=
nlikely(int cpu, const unsi
>         return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
>
> +DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index b3785ffc1570..095eb6ebdcaa 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/ctype.h>
> +#include <linux/jump_label.h>
>  #include <linux/log2.h>
>  #include <linux/memory.h>
>  #include <linux/module.h>
> @@ -728,6 +729,35 @@ void riscv_user_isa_enable(void)
>                 csr_set(CSR_SENVCFG, ENVCFG_CBZE);
>  }
>
> +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +
> +static int set_unaligned_access_static_branches(void)
> +{
> +       /*
> +        * This will be called after check_unaligned_access_all_cpus so t=
he
> +        * result of unaligned access speed for all cpus will be availabl=
e.
> +        */
> +
> +       int cpu;
> +       bool fast_misaligned_access_speed =3D true;
> +
> +       for_each_online_cpu(cpu) {
Each online_cpu? Is there any offline_cpu that is no
fast_misaligned_access_speed?

Move into your riscv_online_cpu for each CPU, and use stop_machine for
synchronization.

> +               int this_perf =3D per_cpu(misaligned_access_speed, cpu);
> +
> +               if (this_perf !=3D RISCV_HWPROBE_MISALIGNED_FAST) {
> +                       fast_misaligned_access_speed =3D false;
> +                       break;
> +               }
> +       }
> +
> +       if (fast_misaligned_access_speed)
> +               static_branch_enable(&fast_misaligned_access_speed_key);
> +
> +       return 0;
> +}
> +
> +arch_initcall_sync(set_unaligned_access_static_branches);
> +
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  /*
>   * Alternative patch sites consider 48 bits when determining when to pat=
ch
>
> --
> 2.43.0
>
>


--=20
Best Regards
 Guo Ren

