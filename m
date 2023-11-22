Return-Path: <linux-arch+bounces-386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F004D7F5160
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C9EB20CA5
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897F5D910;
	Wed, 22 Nov 2023 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4571BD;
	Wed, 22 Nov 2023 12:16:50 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f4b29abdbcso21055fac.0;
        Wed, 22 Nov 2023 12:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684210; x=1701289010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+AKNbPfGcSitF9DQBk43/GENfS9BTVC5pjwY2CWch8=;
        b=Bu5pFWc2ETKxL65yawgTFd7QN/bAEYfIseyHUYG/wZv4J0cEI8nhynLHfTa7QvWgpn
         UY6i6wsyCO4nqk7poMpH3gwZFogrqI2UlMoZKhy385XeLHqUGBy6p4Gj3K26HIjo5vbT
         SFdIwNj1diF59CY/axcaC0cN3zzJUehQvNm7WSmq2Q3+sE0ji2i2enNeYb6w7XS33RN0
         kC1unYUAdEH+y/gchfS7wg79HZqn6UjveITZ7SmkAOqx+ySIfBe05J3oJrMx2v5sTQhu
         ACPcVkA83B2SibqwvK88yc7xy6DPcyQ4RlnlNZDvltTwmpQLhWw2KjJeHh8qpYJawe/7
         CM+A==
X-Gm-Message-State: AOJu0YwBcB68LlYn0Nia3sbFrGu7yDB2adf3QhBmPUfU8N4gDfZlEFcg
	7Zyt40jhWHNXp1YmKF13Aa/UVAfIY6EGdYP8jrKalExF
X-Google-Smtp-Source: AGHT+IEZOuwWL+O8Ns2NywQDonavCXvBHcgdxxi2QZSHFBHwzFPNR8Ac+xre6B7/Fz+/eqIGB2UbpAfb/c6ikknz6l8=
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id
 o32-20020a05687107a000b001e98a7e5893mr4323044oap.5.1700684209905; Wed, 22 Nov
 2023 12:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk> <E1r5R31-00Csyt-Jq@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1r5R31-00Csyt-Jq@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 21:16:39 +0100
Message-ID: <CAJZ5v0iYRXh369M3XTM0V8Q9mWkAT2y+9pJMD7HMaGjgpvFEMw@mail.gmail.com>
Subject: Re: [PATCH 05/21] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64
 and riscv
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, 
	justin.he@arm.com, James Morse <james.morse@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 2:44=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> Neither arm64 nor riscv support physical hotadd of CPUs that were not
> present at boot. For arm64 much of the platform description is in static
> tables which do not have update methods. arm64 does support HOTPLUG_CPU,
> which is backed by a firmware interface to turn CPUs on and off.
>
> acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
> and removing CPUs that were not present at boot. arm64 systems that do th=
is
> are not supported as there is currently insufficient information in the
> platform description. (e.g. did the GICR get removed too?)
>
> arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
> to prevent CPUs that were not described as present at boot from being
> added to the system. Similarly, riscv relies on the same check in
> map_rintc_hartid(). Both architectures also rely on the weak 'always fail=
s'
> definitions of acpi_map_cpu() and arch_register_cpu().
>
> Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
> CPUs present. Neither arm64 nor riscv support this.
>
> Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
> selecting it on the other three ACPI architectures. This allows the weak
> definitions of some symbols to be removed.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I can apply this if it gets ACKs from the maintainers of the affected
architectures.

> ---
> Changes since RFC:
>  * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
>    HOTPLUG_CPU isn't.
> Changes since RFC v3:
>  * Dropped ia64 changes
> ---
>  arch/loongarch/Kconfig        |  1 +
>  arch/x86/Kconfig              |  1 +
>  drivers/acpi/Kconfig          |  1 -
>  drivers/acpi/acpi_processor.c | 18 ------------------
>  4 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ee123820a476..331becb2cb4f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -5,6 +5,7 @@ config LOONGARCH
>         select ACPI
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_MCFG if ACPI
> +       select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>         select ACPI_PPTT if ACPI
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>         select ARCH_BINFMT_ELF_STATE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..dbdcfc708369 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -59,6 +59,7 @@ config X86
>         #
>         select ACPI_LEGACY_TABLES_LOOKUP        if ACPI
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> +       select ACPI_HOTPLUG_CPU                 if ACPI_PROCESSOR && HOTP=
LUG_CPU
>         select ARCH_32BIT_OFF_T                 if X86_32
>         select ARCH_CLOCKSOURCE_INIT
>         select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff19..a3acfc750fce 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -310,7 +310,6 @@ config ACPI_HOTPLUG_CPU
>         bool
>         depends on ACPI_PROCESSOR && HOTPLUG_CPU
>         select ACPI_CONTAINER
> -       default y
>
>  config ACPI_PROCESSOR_AGGREGATOR
>         tristate "Processor Aggregator"
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 0f5218e361df..4fe2ef54088c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>
>  /* Initialization */
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -int __weak acpi_map_cpu(acpi_handle handle,
> -               phys_cpuid_t physid, u32 acpi_id, int *pcpu)
> -{
> -       return -ENODEV;
> -}
> -
> -int __weak acpi_unmap_cpu(int cpu)
> -{
> -       return -ENODEV;
> -}
> -
> -int __weak arch_register_cpu(int cpu)
> -{
> -       return -ENODEV;
> -}
> -
> -void __weak arch_unregister_cpu(int cpu) {}
> -
>  static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  {
>         unsigned long long sta;
> --
> 2.30.2
>

