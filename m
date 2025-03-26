Return-Path: <linux-arch+bounces-11136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4FA719A7
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7FD16A780
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F61F4CAD;
	Wed, 26 Mar 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmjyCflb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5941F418C;
	Wed, 26 Mar 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001020; cv=none; b=f248sew1VfVKGI8b52OZ4WgAWcqAFQjSNVoboS+tsZ+HLmVrLEzgMeh3stj5BEVJTzRgM4zxUDeaRW5Sm/ia5TjH3wud04ZB2izOWSYS4bu0JUMxVNPDDPRVgrzRsgsOhbxvh90ZgHyMN14Qje+BiWXz1VOa2Js4Rcxc2XQ1o+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001020; c=relaxed/simple;
	bh=nF2RjFGpG3A65aMAwOnP1USwdp3nJlYReQNJqbqS1So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzk5amsCppmKa+TWqwjqDn20XuOxYf4B6moxRGF1A3CcBTVx/8hn2ZwxIOdBdU7P+XlX6v4TR0r00dpN5UCm6NoPik8N6BTvRJoER7b2OzCfdqpe3TiITpxuagzCWQrlRnFE9V15so1CROzGUHES3pYENjpWyuetUIIDQsz91ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmjyCflb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE3CC4AF0D;
	Wed, 26 Mar 2025 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001020;
	bh=nF2RjFGpG3A65aMAwOnP1USwdp3nJlYReQNJqbqS1So=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MmjyCflb+tTlR5MBkQj7dY08iImGGcSdOex2tnRAjv2CwuMydzr+6g+T89hlPyD4T
	 5lbqYAQY1q4vepYMT/XhJU+lTrqvOgrZmGzGiXtajU4A5oznmqySeZjpuJNR3Q7W/c
	 2U2gPiGrsFJGXTzlXGKjjC+KX+QA+4YZli8XjIS5v2cXZbLXcPzwTzo/J8qoXDy1wh
	 6b6w6zSoOQkpRQzMmVs/tly8J3rqdTwfv4skjGW1/KON/IPTMCNxxYNslK00Qlfofy
	 yGqZAwmI5DoSHSLJz/HeXZfPLBCZzh63fOnqGNF6MKW+cs1HkhqnyVq4TVMetHf2m7
	 ON5jKJk2k7NaA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fea67e64caso4127299b6e.2;
        Wed, 26 Mar 2025 07:56:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFQ3IKFkWX9FZbuRA+HWh64MYUMhe6TayEp3Q2WWpyCCCLXd6EJj60WtnFa25d6WxcCrk42h0iz6n7hw==@vger.kernel.org, AJvYcCUsxRevZ+ejpNRUMy8NhazkUQQXgTbXLpePYVqN7gBQZcLdYSKpv01VAmfNnkOQJrcSy5w5Af5CCEhnXw==@vger.kernel.org, AJvYcCVChEJmJTZdTJ5OqfnG2PSewBsm9pmt29xQwaHLQ5G/uTjisE7MM/sLi6wO5qZfra97q3sB4rkUYaWKPoz8@vger.kernel.org, AJvYcCVwp3RZp3ZC+bDwG/eZ94WvUEoDzWYWPYXMblauArX6n+OBt5zT2D66pxyeCHwAiU31Ul2z3SADhQCD@vger.kernel.org, AJvYcCX0cwsyE9ey5CeM7lrkerbPazwYOvn+jmjQpwlbx/6jCg1KnqAG46mr0qIHv/enPRbqucV/ertV7AdXcYde@vger.kernel.org, AJvYcCX7AfwD7WMflOS5l5KkmtgMbEOvlbP6hz1Rgj2v11KbDUuq23ACWVXRAWmbE4B9OUJWU4eDJmu/PyRx@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqkWVbRKpeXJOZCXonAVpF5J+j+a2yN6Pl+ibY/uMpqRAT4Vu
	SuTCwdau/GXFOhzZZ9+ZGTpKFPDHPerpPFWWr2USjpqDsVyY9ymmRfE0axbSObFfVcRm++aQKPP
	xUOCSBnEapwrrYSbJz7xdi6D2jOU=
X-Google-Smtp-Source: AGHT+IGmSAoh/NM65izkDPKUI1Bx1s1CpYOoqqHj8rwk1HayiQb7/ZTrzCWxEZIlAbPgY/gZ5IPT5mW0vY7TUSaamgg=
X-Received: by 2002:a05:6808:2116:b0:3f9:a187:1f5d with SMTP id
 5614622812f47-3febf79cf75mr13184095b6e.35.1743001019176; Wed, 26 Mar 2025
 07:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315001931.631210-1-romank@linux.microsoft.com> <20250315001931.631210-12-romank@linux.microsoft.com>
In-Reply-To: <20250315001931.631210-12-romank@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 15:56:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jNEO2VcwmMXLZaS+Kqg3iBgHcWb65f90HKUADtPuvgqA@mail.gmail.com>
X-Gm-Features: AQ5f1JraBPSxwGSJAA4KKJZ156j5w2j0joAJRL4jrFqS_Vv7qLwxEV_YVE1Rcsc
Message-ID: <CAJZ5v0jNEO2VcwmMXLZaS+Kqg3iBgHcWb65f90HKUADtPuvgqA@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v6 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, 
	conor+dt@kernel.org, dan.carpenter@linaro.org, dave.hansen@linux.intel.com, 
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com, 
	joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, 
	lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com, 
	oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org, 
	ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com, 
	devicetree@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, 
	apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com, 
	sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 1:19=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
>
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 73 ++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6084b38bdda1..cbff19e8a07c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>
>  /*
> @@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct ir=
q_domain *domain,
>         int ret;
>
>         fwspec.fwnode =3D domain->parent->fwnode;
> -       fwspec.param_count =3D 2;
> -       fwspec.param[0] =3D hwirq;
> -       fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +       if (is_of_node(fwspec.fwnode)) {
> +               /* SPI lines for OF translations start at offset 32 */
> +               fwspec.param_count =3D 3;
> +               fwspec.param[0] =3D 0;
> +               fwspec.param[1] =3D hwirq - 32;
> +               fwspec.param[2] =3D IRQ_TYPE_EDGE_RISING;
> +       } else {
> +               fwspec.param_count =3D 2;
> +               fwspec.param[0] =3D hwirq;
> +               fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +       }
>
>         ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>         if (ret)
> @@ -887,10 +896,47 @@ static const struct irq_domain_ops hv_pci_domain_op=
s =3D {
>         .activate =3D hv_pci_vec_irq_domain_activate,
>  };
>
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +       struct device_node *parent;
> +       struct irq_domain *domain;
> +
> +       parent =3D of_irq_find_parent(hv_get_vmbus_root_device()->of_node=
);
> +       if (!parent)
> +               return NULL;
> +       domain =3D irq_find_host(parent);
> +       of_node_put(parent);
> +
> +       return domain;
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
> +{
> +       struct irq_domain *domain;
> +       acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
> +
> +       if (acpi_irq_model !=3D ACPI_IRQ_MODEL_GIC)
> +               return NULL;
> +       gsi_domain_disp_fn =3D acpi_get_gsi_dispatcher();
> +       if (!gsi_domain_disp_fn)
> +               return NULL;
> +       return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +                                    DOMAIN_BUS_ANY);
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>         static struct hv_pci_chip_data *chip_data;
>         struct fwnode_handle *fn =3D NULL;
> +       struct irq_domain *irq_domain_parent =3D NULL;
>         int ret =3D -ENOMEM;
>
>         chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> @@ -907,9 +953,24 @@ static int hv_pci_irqchip_init(void)
>          * way to ensure that all the corresponding devices are also gone=
 and
>          * no interrupts will be generated.
>          */
> -       hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI=
_SPI_NR,
> -                                                         fn, &hv_pci_dom=
ain_ops,
> -                                                         chip_data);
> +#ifdef CONFIG_ACPI
> +       if (!acpi_disabled)
> +               irq_domain_parent =3D hv_pci_acpi_irq_domain_parent();
> +#endif
> +#if defined(CONFIG_OF)

Why don't you do

#ifdef CONFIG_OF

here for consistency?

> +       if (!irq_domain_parent)
> +               irq_domain_parent =3D hv_pci_of_irq_domain_parent();
> +#endif
> +       if (!irq_domain_parent) {
> +               WARN_ONCE(1, "Invalid firmware configuration for VMBus in=
terrupts\n");
> +               ret =3D -EINVAL;
> +               goto free_chip;
> +       }
> +
> +       hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(
> +               irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
> +               fn, &hv_pci_domain_ops,
> +               chip_data);
>
>         if (!hv_msi_gic_irq_domain) {
>                 pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domai=
n\n");
> --

