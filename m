Return-Path: <linux-arch+bounces-10610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3FA5968A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9251188C620
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0A22A4D1;
	Mon, 10 Mar 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhfdQ7Az"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1F22154C;
	Mon, 10 Mar 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614157; cv=none; b=AoZSfJ8V7fuK3+PSUkKjTcV/a2RYt89F8b09046VINDlI1l9iw59TrZhOXuPfRNlMp345Eqmi4EVRdpW3Qb5rb/bAkvNM7l7tCpmI4aFqI0J+9dY8wCli/CVr4RbxXDkgQ11gFB8iqVAYW7IB1XAiKaoYhQLdXRHMMytIKCnTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614157; c=relaxed/simple;
	bh=9JX3XY9vPoVhLHV2mTUB+zf5fX4dLzA4Gt+vcTFbIqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csFH83GvxwqUMaWCg+qIwgcvS9r2Hk+K/QIITdEn5WgYT4AFwbyCDsmeXtX4hSgtcbs3DkS8KNFELwERm2EwuzHrMFsajWqBUr3RzNjqaVWpvdp2jdrRVV1Jfrdz2j5VTx5YWVLOEDk7nwCc7YBzFzkYn8dsam1Z5wc86tlPlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhfdQ7Az; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abec8b750ebso727397666b.0;
        Mon, 10 Mar 2025 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741614154; x=1742218954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvsHojGzktqIc1mRDfrH3Tw28TialK1JD2DdtffnVRo=;
        b=JhfdQ7AzbZJ0MtsJbT4up8viu0z+JH1aiWNVBJcweTvNI+ogYiAuCcqt6goKbez7F6
         F7FMyBRQow79TBG+NK15EZ7MKmVb3Ng97/w4O6hBVbjVpKtY0I7SN9Djcfm/l61em9ie
         0LvajXM6YlZA9ENsWb6BnC5HtLojKcgGv63pQOpQqQTrVMoMnFUOKL8+Cvsl8sMm8Bx0
         ovtESV+73oKG9u8iuBHylDKDw9xJBaVufZdCFvpEAsqFy+KVlNlwJxmrEH2WWoLzWsAP
         cnLfGtqw7ZynTj8zIdNh+zbGlYC6C+No7mnJIL/tOgYb9wzkrb0TltXzHWeAJOCKsDND
         RCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614154; x=1742218954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvsHojGzktqIc1mRDfrH3Tw28TialK1JD2DdtffnVRo=;
        b=mev0wNSypXTp84lmHEIp+qQJgRZ5LQ800GpqaURQrS8pKX4igtgc2BGL+1Z15uqU5q
         r9mUTuhQ+tIeOsc8LrYp215Fp49X5QLhsR5khuyR6N8dpZZcx9m/KD9sefVT3sTecy+t
         6LegaRkgstTKNrglBFKhN/QuhATlV2O66vT3hHbLBmsf/S7JdpQZNhjKFNXGZH58DdSI
         UCKGLlrU8tsbx5c1LuEdqYZWcwHT1lnepjuQYmvolZLKFTQ01tmAwjffCYyDMg9RmbD4
         dsOzz7wcRIuZNH8GIrZFZclrrhsqUsxh3z5BWMakdcbD/w/k3uk3czu4Zklm7NvN3qSW
         hyDA==
X-Forwarded-Encrypted: i=1; AJvYcCVoi6shhiGGCsgLupw5tqaOJnpD3hOtLXWY8XidVwtJKus421+iiEFQcjQksVwT6Tax1d9blSGyvKa02w==@vger.kernel.org, AJvYcCVzJlYQe43agoKBQmgVTZDpSEr/XCIm+i8d1hEXKQaCHUet9cZxevuEy6kFiqXY62StDs46wtbjv6s929FK@vger.kernel.org, AJvYcCWvM/n17LWMkU5L2ClL3uoIRA9SW3PqvknG7QFVDeULJByfx+T9ePoAcxvyI6478ytPKEJH5OlJDEnHJJtH@vger.kernel.org, AJvYcCX5jtLVRi1SBi7Az+PCY5Ic46mLP7NKq3dwn+ycsZOj3Z8OCvHRxt/yrZQlFH6en7WjYZqpd1iTpEad@vger.kernel.org, AJvYcCXCRTNcNdDMFAQugM6WlDw5Yxer7yyrlbEdvMQH/VajhtJwugT8xhBOhvHjiCKrW32yvywXrq+8seCsdg==@vger.kernel.org, AJvYcCXwh/XrEinI0+1qOwwBWHhTgYimJDERaEMyHJHr5uCN3OBgaBRGmVtPFgQSOpQIV5uOfBx3BxvvmM6q@vger.kernel.org
X-Gm-Message-State: AOJu0YzstnZFR36YbiizdnDv4ogSwH0UjEOOL1RFR+ijx7kRA7XStzVA
	7ntfpZHyavAp1Ay+Ndwn10OSlZft5DZph1IZljKaDEpIF+4WxQ1oSLQUe7Dsh/bC5VZmxQKwOdb
	E2X0xqUR34iNDHGZl6QbQ7O6KSZg=
X-Gm-Gg: ASbGncua38schHhDAOSuPoGmNok+HtXs3Kn2EW1t9PJ/FwATEUJCCTjaxi9IQX6tV0x
	8Wg+FwHZeM96zs7yPIagpM/mVfqqhv8PxRmnDE3nM7d27WrgGj07ciVAx9tL/YNN/qgkdVHhorI
	2PZAtUpSywKuxU3XhtfafReQsOhyJefIzeimEErSJQJK+6
X-Google-Smtp-Source: AGHT+IFUfaQlQuaPqqkcPWFR+Uc30OuqKeGBgv4UhgRVglMXjxzsUDhKEonas+ed+S1TKw+FHpP1oVa0jMVOpi7ix8c=
X-Received: by 2002:a17:907:9691:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-ac252a886dbmr1424178866b.15.1741614154071; Mon, 10 Mar 2025
 06:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307220304.247725-1-romank@linux.microsoft.com> <20250307220304.247725-10-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-10-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 21:41:57 +0800
X-Gm-Features: AQ5f1JrFNYOkTeGrjIoQMzNLPYhLnbwrDYGfCpL3y-Ny919xFrzmZmgmS7VWREs
Message-ID: <CAMvTesCFZ6sxQp7qqSDjD9idRjVHxh96Sp4betomgFH-OFLZ3Q@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v5 09/11] Drivers: hv: vmbus: Introduce hv_get_vmbus_root_device()
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, 
	conor+dt@kernel.org, dave.hansen@linux.intel.com, decui@microsoft.com, 
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, 
	kw@linux.com, kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org, 
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org, 
	mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org, 
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

On Sat, Mar 8, 2025 at 6:05=E2=80=AFAM Roman Kisel <romank@linux.microsoft.=
com> wrote:
>
> The ARM64 PCI code for hyperv needs to know the VMBus root
> device, and it is private.
>
> Provide a function that returns it. Rename it from "hv_dev"
> as "hv_dev" as a symbol is very overloaded. No functional
> changes.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Why change all device's parent to vmbus_root_device?

The ARM64 platform uses the device tree to enumerate vmbus
devices..  Can we find the root device via device tree? vmbus
code on the x86 use ACPI and it seems to work via ACPI.


> ---
>  drivers/hv/vmbus_drv.c | 23 +++++++++++++++--------
>  include/linux/hyperv.h |  2 ++
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c8474b48dcd2..7bfafe702963 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>         struct hv_vmbus_device_id id;
>  };
>
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;
>
>  static int hyperv_cpuhp_online;
>
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>
> +struct device *hv_get_vmbus_root_device(void)
> +{
> +       return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
> +
>  static int vmbus_exists(void)
>  {
> -       if (hv_dev =3D=3D NULL)
> +       if (vmbus_root_device =3D=3D NULL)
>                 return -ENODEV;
>
>         return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_d=
evice)
>          * On x86/x64 coherence is assumed and these calls have no effect=
.
>          */
>         hv_setup_dma_ops(child_device,
> -               device_get_dma_attr(hv_dev) =3D=3D DEV_DMA_COHERENT);
> +               device_get_dma_attr(vmbus_root_device) =3D=3D DEV_DMA_COH=
ERENT);
>         return 0;
>  }
>
> @@ -1930,7 +1937,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>                      &child_device_obj->channel->offermsg.offer.if_instan=
ce);
>
>         child_device_obj->device.bus =3D &hv_bus;
> -       child_device_obj->device.parent =3D hv_dev;
> +       child_device_obj->device.parent =3D vmbus_root_device;
>         child_device_obj->device.release =3D vmbus_device_release;
>
>         child_device_obj->device.dma_parms =3D &child_device_obj->dma_par=
ms;
> @@ -2292,7 +2299,7 @@ static int vmbus_acpi_add(struct platform_device *p=
dev)
>         struct acpi_device *ancestor;
>         struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>
> -       hv_dev =3D &device->dev;
> +       vmbus_root_device =3D &device->dev;
>
>         /*
>          * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2383,7 +2390,7 @@ static int vmbus_device_add(struct platform_device =
*pdev)
>         struct device_node *np =3D pdev->dev.of_node;
>         int ret;
>
> -       hv_dev =3D &pdev->dev;
> +       vmbus_root_device =3D &pdev->dev;
>
>         ret =3D of_range_parser_init(&parser, np);
>         if (ret)
> @@ -2702,7 +2709,7 @@ static int __init hv_acpi_init(void)
>         if (ret)
>                 return ret;
>
> -       if (!hv_dev) {
> +       if (!vmbus_root_device) {
>                 ret =3D -ENODEV;
>                 goto cleanup;
>         }
> @@ -2733,7 +2740,7 @@ static int __init hv_acpi_init(void)
>
>  cleanup:
>         platform_driver_unregister(&vmbus_platform_driver);
> -       hv_dev =3D NULL;
> +       vmbus_root_device =3D NULL;
>         return ret;
>  }
>
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 7f4f8d8bdf43..1f0851fde041 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1333,6 +1333,8 @@ static inline void *hv_get_drvdata(struct hv_device=
 *dev)
>         return dev_get_drvdata(&dev->device);
>  }
>
> +struct device *hv_get_vmbus_root_device(void);
> +
>  struct hv_ring_buffer_debug_info {
>         u32 current_interrupt_mask;
>         u32 current_read_index;
> --
> 2.43.0
>
>


--=20
Thanks
Tianyu Lan

