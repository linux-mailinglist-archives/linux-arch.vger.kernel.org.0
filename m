Return-Path: <linux-arch+bounces-4253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F278BEC3D
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552561F223A2
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263916D9D2;
	Tue,  7 May 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjPMiHJ0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F616D319;
	Tue,  7 May 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108738; cv=none; b=L/yDg/OXdEts6v5q9nKAFYiiv8pEU706h97xbgTGXKrufZSFwK0S9sQoS1F/1xobMlHugZHCyHROyP3W47JgEgD2irQIo0MJw6+Yx8pQdbdo9ntCjdb21GfHUwbPaJffFr8By3st84/LwPQpq+FOdkQAajL2jOPGrIc/fgisQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108738; c=relaxed/simple;
	bh=RXjxiKuVIg66+4e4zRGgHnAS0eHWvtxBBhUDFGqspwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQrUjJ5/eDBhHxbfXmWSg71Ag+gG+W+tzapDmhGso0RqDwxeKakKsrxnoBZz2BYRMGtMO9FfrTYL7dvLHsqX4TfhJ3tXplOXRhBNMCEZfmdkW7RWVWLmB2PHGPEQacX8TZF0JC3LuFqOyk6xtbiawJoGtJ0hxCllLKABWKjpRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjPMiHJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9394C4DDE0;
	Tue,  7 May 2024 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108737;
	bh=RXjxiKuVIg66+4e4zRGgHnAS0eHWvtxBBhUDFGqspwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AjPMiHJ0Hm2xzIl7Alq1yoV8rbkVe5bNuUm7RDM5BclkgOkJtvitJv2e7bVWYycat
	 7GaD0KVba/JY9YXF/tjK6GYceA1f5LthmtyHahTlgFKhmk2YPu7aAwYQ7aeRIBWv/5
	 Mvsk/lcZenuxg5AqQDNx3zr18qhJ316CzqRHbGQbViw+HR4qRqCRaSa24jdsIEtBws
	 XXJNXAJ82uKlxAr1fxk/9Cz+NxsQPXcEWfcIpGDTdVCquspzfMK6bLQpWlqSDl8MIE
	 8AzGaw91fcfsop+XTvUZQhTBV96vwhV19nqDBPyNysPdqgGisaHl4Vj//GZP5OR7Sp
	 eXrTZVflejSog==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5af609de0d2so318102eaf.2;
        Tue, 07 May 2024 12:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7D8TBJ4LbzR2KfPuJt0EVoRcL0sjBPr+C1uULQQU1v2PneOhovbHFcgj10nQ3pPRQ8A8h9xmbAPX43BUNuDqtq8We4swnz/UgxTsJWiW4W78Df0WQ+KfFMS0kBXGMayUwCmNoyXp4dnafyYzS/poEwsB9bN+Y2kPIgoxErisN9SvWYUKvprIdvch5SPjFEF7oQ2Y+IqAaW5VI/Ljy+A==
X-Gm-Message-State: AOJu0Yz/GsDIbVqWf46YFl5jFrNKdpeb9JAsoEeZlNbvcUIvHCKyndlN
	t4WMZULPQTtBCH3x3NnyEamhWS8sin9VD1LdrQe+rwXcFTgX86LfG3OFyVUC2/vSAXwhQ18ih3X
	PQv1g2/RDpGUGp9M7J9O+9dNPXt8=
X-Google-Smtp-Source: AGHT+IF3DM1jvXt28nOSFpZ7axthsouZnF1Q5Tkxbf3eoVMe0Qp8gd2UpGhIK/KgeLsuVQ1JcjFRVflsYxqumunVBys=
X-Received: by 2002:a05:6820:1f92:b0:5ac:6fc1:c2cb with SMTP id
 006d021491bc7-5b24caad211mr423157eaf.0.1715108737184; Tue, 07 May 2024
 12:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com> <20240430142434.10471-8-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240430142434.10471-8-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 21:05:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBF56XspBYaxZ2CoF0P0idVovJ_=s1Kks3xe4O9LJf9A@mail.gmail.com>
Message-ID: <CAJZ5v0gBF56XspBYaxZ2CoF0P0idVovJ_=s1Kks3xe4O9LJf9A@mail.gmail.com>
Subject: Re: [PATCH v9 07/19] ACPI: processor: Add acpi_get_processor_handle() helper
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Gavin Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, 
	justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:28=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> ---
> v9: Tags
> ---
>  drivers/acpi/acpi_processor.c | 11 +++++++++++
>  include/linux/acpi.h          |  7 +++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4a79b42d649e..e8cbe0e40dd0 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,17 @@ EXPORT_PER_CPU_SYMBOL(processors);
>  struct acpi_processor_errata errata __read_mostly;
>  EXPORT_SYMBOL_GPL(errata);
>
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +       struct acpi_processor *pr;
> +
> +       pr =3D per_cpu(processors, cpu);
> +       if (pr)
> +               return pr->handle;
> +
> +       return NULL;
> +}
> +
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
> 2.39.2
>

