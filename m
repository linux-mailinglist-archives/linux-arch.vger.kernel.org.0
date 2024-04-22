Return-Path: <linux-arch+bounces-3896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2538AD47A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDB4284598
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B916154C19;
	Mon, 22 Apr 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL3U4rJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB96219E0;
	Mon, 22 Apr 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812390; cv=none; b=KNM05wrHGWEmkWy5KtDCxQ3U5wqnb8xbUSp1GrWplvxhfd7BMz/pOXk4YpayGZ7OPLw02GmWxS9/ZXvrCwuMhtkl4MmN9S+LRAFUvlFGJHf4tNk7uBenLyd5XkrwbZLKPaaJZyvjUxxKwwx6GjKs1+eJrf0lzJUdoKsxD/oIo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812390; c=relaxed/simple;
	bh=6gVRWvCD43SHzW9MJNgmb/G+pTy5o5QLdvzHoFGOY8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmcbeFIHfOpRx8Z3TkE4lwAjsgiAYQpsbuoA8LAPWJrCBqmVoKLXxCvqz+iuzEWx1T+pz4YhkgkVqQCScThn8oJQ/GQL8yRu4PHj0drRhgJ/8bLX7DFZ+GHP6RZC8cTRr55hy069XJ76veny9TQTHNxvItyy4FVz/ALWyRvWBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL3U4rJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B06C4AF0F;
	Mon, 22 Apr 2024 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812390;
	bh=6gVRWvCD43SHzW9MJNgmb/G+pTy5o5QLdvzHoFGOY8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JL3U4rJkt3X03aXzLZ0B3r/2PJUJaVAe8JCNvGQRMkjLN4zUnkzeEoHusUO3hKwaq
	 fdxSH/N4CwP5cVsB0ZhewV9hp33WkZrrXqLRPKQ7n9inywbMAyU4ViWoIOphUMvxIl
	 AsOIuaUe1lPqFPxDFBxGtb1vgzPVRbCGIqpIFPh56Sd8MGMYz0iKv7iwOG2c1S0XDi
	 V83T72tHq91uOZABAe/0Z7iv9OTub+X4MYNa9Y3A6rGaz4k3Mbyb1EL0c7jh4Q2aoz
	 hS9+OtswjShh/3YthrYzZz2JRZO9BuCzxI/PhZjHTayHBrUZemPS28ElqIObNhRoms
	 Rzwj1eCKUr/hg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c75145c6c4so81779b6e.0;
        Mon, 22 Apr 2024 11:59:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkL2F9/BCIqOndNEcu1KODzUXql2w3ueFz6kZy2wOT3peMYEthlNpcZwH6oB5kPCASXN4EmxXNQP0MeB03X8Sl8WidtSWUmrz5nA3sFimjqhXUYBOaqhTjuRU6/0KlUiWc6l0ELCYoAOF13dZbpR66kT2AFcIzOvktFWBypaTeI9DVobAya4wqNNDGU3Pt6jzuXABMEUNe2E8SAROshg==
X-Gm-Message-State: AOJu0Yx7WoMqfkqtzM6IVKhq9Y38sHoCVkaDPGHqnjigWhrTFcqAEMzx
	ATaIjbyf5EPsh+MXpQYYgJ76I/LJGBrg6h/4L+Ox5l4yDDLovp3FjXYo8bBxYQN9TECPdOJsnnh
	q4EQbmU2OidviBv0VKerMRKS8tvo=
X-Google-Smtp-Source: AGHT+IExK3DcdJriPUSWTCy1cAHuU7dWFQag2+82kAyKCZ3mbzTJd67vrF3319LOdQqaXIme06M3/BHhocdPIWLS1YI=
X-Received: by 2002:a05:6820:26c3:b0:5aa:6a31:4f53 with SMTP id
 da3-20020a05682026c300b005aa6a314f53mr11947440oob.0.1713812389406; Mon, 22
 Apr 2024 11:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 20:59:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hox_E7UK7BQFKFiN_6vsJmE-xOPTShbcPytMifN42OJQ@mail.gmail.com>
Message-ID: <CAJZ5v0hox_E7UK7BQFKFiN_6vsJmE-xOPTShbcPytMifN42OJQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/16] ACPI: processor: Add acpi_get_processor_handle() helper
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:56=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> v6: New patch
> ---
>  drivers/acpi/acpi_processor.c | 10 ++++++++++
>  include/linux/acpi.h          |  7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index ac7ddb30f10e..127ae8dcb787 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,16 @@ EXPORT_PER_CPU_SYMBOL(processors);
>  struct acpi_processor_errata errata __read_mostly;
>  EXPORT_SYMBOL_GPL(errata);
>
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +       acpi_handle handle =3D NULL;

The local var looks redundant.

> +       struct acpi_processor *pr =3D per_cpu(processors, cpu);;
> +
> +       if (pr)
> +               handle =3D pr->handle;
> +
> +       return handle;

struct acpi_processor *pr;

pr =3D per_cpu(processors, cpu);
if (pr)
        return pr->handle;

return NULL;


> +}
>  static int acpi_processor_errata_piix4(struct pci_dev *dev)
>  {
>         u8 value1 =3D 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t phy=
sid, u32 acpi_id,
>  int acpi_unmap_cpu(int cpu);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr)=
;
>  #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 s=
leep_state)
>         return false;
>  }
>
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +       return NULL;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  extern void arch_post_acpi_subsys_init(void);
> --

