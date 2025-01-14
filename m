Return-Path: <linux-arch+bounces-9745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC132A10988
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DBC3A134B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C31494DF;
	Tue, 14 Jan 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4T5S0yt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70F7E105;
	Tue, 14 Jan 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865353; cv=none; b=UpDKv1ngYuFicHQfRJpp2xSC+MZ990n91uOAlmmouqGm042c5jdLscqruscHxsDNonsAXeMRQwqXS4wf8KiCUZrpLYXM7MymaOY+xUu9ui4vlhf61OnMqPaLB6+TmmV75PpDJpQjV3XdkyBfI6KRjJcHm+3z6X4Nat5WbBPh8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865353; c=relaxed/simple;
	bh=uzieb3PpttrSGXVw+mO02BuIgTXRAr2xwj6otgCdt6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3owWCunZCCyS02Rp4RsmbSVm7eSonnft0zY9sId82xuBYvMwLkgxoyHTdwTtJWrcPCYtJ5c7o9Mp3dK/r/brBTFLoJdD3BZdmUTRUofgqUptyhyTAkmbLDX1jhgS8/ZDNTtGmWyApd5pPbV1gkuV78m6iSeYTwYEjJa+1WBjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4T5S0yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ED1C4CEEC;
	Tue, 14 Jan 2025 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736865352;
	bh=uzieb3PpttrSGXVw+mO02BuIgTXRAr2xwj6otgCdt6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U4T5S0ytbZ2qJPTb9ndZYRk8WA9ZFaSMMqEKaRCurN0ZrwVtfS+Nfk+B+9xHd9El+
	 rMLxp9WOm1yTzhoe4m29p8nW6aaIAeH3o6Ta9pLNkmZEcIboLVkSo5rLgSFD/VDsHp
	 Tdljt257wXjbjsgdRxEQzEclRXeqE9mwTgeajX+7/SaR8MFetCBRY9DuKn/5NaOboE
	 OZTff8UCtWu/VpTGWgSuI91HFiFCtlZ55y4KRfeaOgV7eRRzt0dEaBtXTIpTNxoNq2
	 w2oNAIJhtjQFpr4dVOPTx2q9VqH2nkEpdgBZxMd9Hgy2dHld/5/ax04mmCnPd+zbW9
	 1U/CbXmRDci6w==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e35be77b5so1459684a34.1;
        Tue, 14 Jan 2025 06:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhhgH4WYVtyWcYJDqIvcyvuDv+10NhhoSR7FN/LKW5L9/AjhyZndI1MRSUyUT3sXHedjAI4UAjadzx@vger.kernel.org, AJvYcCVqUclJKSHwsEz13IKZ/s1GwFcBHIbrwR8TxuTpPjWsr6dl1VSlb+VaAUTAN6zB9m8cR4KSCK8DZWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1zyUIZ4jOh+pKPvVp4L+qZWiov04aeJkB45SgRmSKwyififQ
	K52AjBXTkQQuFzIdVczhpBfS59RKo3I3SXqLmM4NCmMKO4Da8daIkBko9518OG/i5655my5ptNI
	FQOj/6sY4U6ezTqcT2jiMSQV8mE8=
X-Google-Smtp-Source: AGHT+IH1RknkEPNA5SHC3B1OkEK9Zf55bGrD/rzwlyGX6YRlIPqRgm9/BvsyUggkICMw+21bElzxL8TGau13Un9jx+c=
X-Received: by 2002:a05:6870:2f18:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2aa0699904emr14988683fac.36.1736865351648; Tue, 14 Jan 2025
 06:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-4-frederic@kernel.org>
In-Reply-To: <20250102150201.21639-4-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:35:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hL5nhCD-A1Oa31zHxHfOjOMFfeRfc-AGR3vb9p_00tqA@mail.gmail.com>
X-Gm-Features: AbW1kvYHnyXXcOAl3blrKjYldKJPLP7civgrZHPIfPETu_DDu39ZhH2fg7Gie-Q
Message-ID: <CAJZ5v0hL5nhCD-A1Oa31zHxHfOjOMFfeRfc-AGR3vb9p_00tqA@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/cpuidle: Move buggy mwait implementations away
 from CPUIDLE_FLAG_MWAIT
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:02=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Buggy MWAIT implementations can't carry the CPUIDLE_FLAG_MWAIT flag
> because they require IPIs to wake up. Therefore they shouldn't be
> called with TIF_NR_POLLING.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

I would do a patch introducing arch_cpuidle_mwait_needs_ipi() or
equivalent before patch [2/6] and I would use it in patch [2/6] right
away.

> ---
>  arch/arm/include/asm/cpuidle.h     |  2 ++
>  arch/arm64/include/asm/cpuidle.h   |  3 +++
>  arch/powerpc/include/asm/cpuidle.h |  4 ++++
>  arch/riscv/include/asm/cpuidle.h   |  2 ++
>  arch/x86/include/asm/cpuidle.h     | 12 ++++++++++++
>  drivers/acpi/processor_idle.c      |  4 +++-
>  drivers/idle/intel_idle.c          |  9 +++++++--
>  include/asm-generic/Kbuild         |  1 +
>  include/asm-generic/cpuidle.h      | 10 ++++++++++
>  9 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/include/asm/cpuidle.h
>  create mode 100644 include/asm-generic/cpuidle.h
>
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidl=
e.h
> index 397be5ed30e7..0ea1d2ec837d 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -55,4 +55,6 @@ struct arm_cpuidle_irq_context { };
>  #define arm_cpuidle_save_irq_context(c)                (void)c
>  #define arm_cpuidle_restore_irq_context(c)     (void)c
>
> +#include <asm-generic/cpuidle.h>
> +
>  #endif
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cp=
uidle.h
> index 2047713e097d..ef49124135a7 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -38,4 +38,7 @@ struct arm_cpuidle_irq_context { };
>  #define arm_cpuidle_save_irq_context(c)                (void)c
>  #define arm_cpuidle_restore_irq_context(c)     (void)c
>  #endif
> +
> +#include <asm-generic/cpuidle.h>
> +
>  #endif
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/as=
m/cpuidle.h
> index 0cce5dc7fb1c..788706bc04ec 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -102,4 +102,8 @@ static inline void report_invalid_psscr_val(u64 psscr=
_val, int err)
>
>  #endif
>
> +#ifndef __ASSEMBLY__
> +#include <asm-generic/cpuidle.h>
> +#endif
> +
>  #endif
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cp=
uidle.h
> index 71fdc607d4bc..1f1b24901d86 100644
> --- a/arch/riscv/include/asm/cpuidle.h
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -21,4 +21,6 @@ static inline void cpu_do_idle(void)
>         wait_for_interrupt();
>  }
>
> +#include <asm-generic/cpuidle.h>
> +
>  #endif
> diff --git a/arch/x86/include/asm/cpuidle.h b/arch/x86/include/asm/cpuidl=
e.h
> new file mode 100644
> index 000000000000..a59db1a3314a
> --- /dev/null
> +++ b/arch/x86/include/asm/cpuidle.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CPUIDLE_H
> +#define _ASM_X86_CPUIDLE_H
> +
> +#include <asm/cpufeature.h>
> +
> +static inline bool arch_cpuidle_mwait_needs_ipi(void)
> +{
> +       return boot_cpu_has_bug(X86_BUG_MONITOR);
> +}
> +
> +#endif /* _ASM_X86_CPUIDLE_H */
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 66cb5536d91e..0f29dd92b346 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -23,6 +23,7 @@
>  #include <linux/perf_event.h>
>  #include <acpi/processor.h>
>  #include <linux/context_tracking.h>
> +#include <asm/cpuidle.h>
>
>  /*
>   * Include the apic definitions for x86 to have the APIC timer related d=
efines
> @@ -806,7 +807,8 @@ static int acpi_processor_setup_cstates(struct acpi_p=
rocessor *pr)
>                 if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2)
>                         drv->safe_state_index =3D count;
>
> -               if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
> +               if (cx->entry_method =3D=3D ACPI_CSTATE_FFH &&
> +                   !arch_cpuidle_mwait_needs_ipi())
>                         state->flags |=3D CPUIDLE_FLAG_MWAIT;
>
>                 /*
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index d52723fbeb04..b2f494effd4a 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -56,6 +56,7 @@
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/fpu/api.h>
> +#include <asm/cpuidle.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -1787,7 +1788,10 @@ static void __init intel_idle_init_cstates_acpi(st=
ruct cpuidle_driver *drv)
>                 if (cx->type > ACPI_STATE_C1)
>                         state->target_residency *=3D 3;
>
> -               state->flags =3D MWAIT2flg(cx->address) | CPUIDLE_FLAG_MW=
AIT;
> +               state->flags =3D MWAIT2flg(cx->address);
> +
> +               if (!arch_cpuidle_mwait_needs_ipi())
> +                       state->flags |=3D CPUIDLE_FLAG_MWAIT;
>
>                 if (cx->type > ACPI_STATE_C2)
>                         state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
> @@ -2073,7 +2077,8 @@ static bool __init intel_idle_verify_cstate(unsigne=
d int mwait_hint)
>
>  static void state_update_enter_method(struct cpuidle_state *state, int c=
state)
>  {
> -       state->flags |=3D CPUIDLE_FLAG_MWAIT;
> +       if (!arch_cpuidle_mwait_needs_ipi())
> +               state->flags |=3D CPUIDLE_FLAG_MWAIT;

Also, some code duplication could be avoided by having something like
arch_x86_mwait_state() returning the flag if the condition is met:

    state->flags |=3D arch_x86_mwait_state();

>
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>                 /*
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 1b43c3a77012..7754da499d16 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -13,6 +13,7 @@ mandatory-y +=3D cacheflush.h
>  mandatory-y +=3D cfi.h
>  mandatory-y +=3D checksum.h
>  mandatory-y +=3D compat.h
> +mandatory-y +=3D cpuidle.h
>  mandatory-y +=3D current.h
>  mandatory-y +=3D delay.h
>  mandatory-y +=3D device.h
> diff --git a/include/asm-generic/cpuidle.h b/include/asm-generic/cpuidle.=
h
> new file mode 100644
> index 000000000000..748a2022ed2a
> --- /dev/null
> +++ b/include/asm-generic/cpuidle.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_CPUIDLE_H
> +#define __ASM_CPUIDLE_H
> +
> +static inline bool arch_cpuidle_mwait_needs_ipi(void)
> +{
> +       return true;
> +}
> +
> +#endif /* __ASM_CPUIDLE_H */
> --
> 2.46.0
>
>

