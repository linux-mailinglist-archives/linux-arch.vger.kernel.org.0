Return-Path: <linux-arch+bounces-10749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67514A5FFDA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 19:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB02117AEE5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F31F03E0;
	Thu, 13 Mar 2025 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnhXIoTk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1551EFFA9;
	Thu, 13 Mar 2025 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891494; cv=none; b=J0uZZRczyQW1BznbWrH3q1nWyz3wZ/xzrD//xZMiT9bDWiJakUKrkP62tG84w8y9T9X1fC1+a5j++85sUHGNlwinNxfgplwXo9YXLnhQYbXBGAJ5pGOO7H+3TkdJ9ILj5sF5ODRLGuIfmIt2bV8RHVO2a0/F1dsZsUYxQ8/hAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891494; c=relaxed/simple;
	bh=QlrkRP5I6RTz1lPCtN5zk3M5pm0O9z7QzlqRgomvjQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCx9XfNv2T5K2aO9a3D222Vcd6VDTIAcUE5rq4+RdmUbX9MXNTFQqO7Mml1FdZp+r6JE2vkNBWre2J9VqZOLsZwCXnifg//g13wygK/3J3jrnrlo5t6O5n4pEfGb98PBl3kZ3CetRqd3A0Oq2dIlNelyWHGH/yykDl+DbFbx1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnhXIoTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BF5C4CEFF;
	Thu, 13 Mar 2025 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741891494;
	bh=QlrkRP5I6RTz1lPCtN5zk3M5pm0O9z7QzlqRgomvjQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LnhXIoTkCwWwLQy654e32ktSRBBCvIiG9b2hKyu6onBsTkAjERAmziuGX0st7Auqg
	 SYpt7I+8sO50eeWmFz4B+ezIQL3iphfcwaLQCecNPFG238AST/I6mJjR9Cm7Qhtnsp
	 uqShKstvAdW4lKiXALVRC54yMBumFkP74kiRY5MvfBxq67fW2SVAaJuVvhRfMffnds
	 tCwJOnfiTqJ8ELFf0ZhW/7PFSl/BeJpC2wgo7+yoqk6AfscXq/e4I4u82rnPIoWM9t
	 hph5YEyoLUulJuNAdCm6KiWPYR7vKjMA3MNxqmcbQWjEQ0bEc8Bjy9bsWw3JEjXvpy
	 LdfYkYUvJQx2A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso237515266b.3;
        Thu, 13 Mar 2025 11:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjOkqTDsnUMJgKdJWstKbw1msK0smur4UWXJ4qjaVMF4NqqlO3QGrmlIqi+0U4fDg5MysHPacIXTX38g==@vger.kernel.org, AJvYcCV93wDWAOK1LbScokqImL1KqAc1v2nemvom+kF2o+jv8QoG7JVwoUQAkAvyk2AZhh35QjW68UX0+xci@vger.kernel.org, AJvYcCVTjcI4B6vZNbh8NROSoHjmhrnU+HaCubUVatCiuPZvzAzXZosmQOE3p/XPu+PecNrLg6i3X5CbPOT9lJyB@vger.kernel.org, AJvYcCXOcDDi40yOfDEjot8SU+5rIqpA6B+1PR7vfFzqkXVXphd3hUMUmaTiOYNi9hIG7HU41ok+owVQQBifhQ==@vger.kernel.org, AJvYcCXiu1XLk7H6fjObE5SWVJ97tW6yzUuLiyfo9F6BzabzeJZXDu/P9udWa5ZIRwTn+3zh7UGvVWd9Q1OS@vger.kernel.org, AJvYcCXojQGLoiQ8sgeUAcXU7ziiNz6e/pIffPik24AlkH3rz53e/JehjH9GxglH+wRr3VjeA03y9qCqcDYExACT@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxOdNPWU4ByCg2JYJKbufPKRJ+ajAeqNB2KHEtBK76VGH3vso
	g8DFLAf6e/6Owti2Ylb7/34pHS9g9/Fv9RQ06zP64blttkqdsY0AheQ6cHfjhXsFHxSZQJH1xOR
	9r4GgainUWYGdXFWkGp/eCy+JKA==
X-Google-Smtp-Source: AGHT+IE84CwfiOJs5wEvz9/gyK0Vhm2tPQAYrNHeBZsspi51p+XlCkmCog0DPrxtkstcI25d+u0kzAVhA8ECGZ8aCbU=
X-Received: by 2002:a17:907:9382:b0:ac2:7a3b:31e2 with SMTP id
 a640c23a62f3a-ac2b9ea186bmr1272361466b.45.1741891492123; Thu, 13 Mar 2025
 11:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307220304.247725-1-romank@linux.microsoft.com> <20250307220304.247725-9-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-9-romank@linux.microsoft.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Mar 2025 13:44:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmS4EEoPkOmaH6F_0XtQu5wkM-WEfxFvjLA=bJroEUVw@mail.gmail.com>
X-Gm-Features: AQ5f1JoBoOFXWy0RvRDKcw8n2aFR2QulZQgf-P4S7wWE9_vZ-wABCiQ7BInknts
Message-ID: <CAL_JsqLmS4EEoPkOmaH6F_0XtQu5wkM-WEfxFvjLA=bJroEUVw@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v5 08/11] Drivers: hv: vmbus: Get the IRQ
 number from DeviceTree
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, 
	conor+dt@kernel.org, dave.hansen@linux.intel.com, decui@microsoft.com, 
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, 
	kw@linux.com, kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org, 
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org, 
	mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org, 
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

On Fri, Mar 7, 2025 at 4:03=E2=80=AFPM Roman Kisel <romank@linux.microsoft.=
com> wrote:
>
> The VMBus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
>
> Update the VMBus driver to discover interrupt configuration
> from DT.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/vmbus_drv.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 75eb1390b45c..c8474b48dcd2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2345,6 +2345,36 @@ static int vmbus_acpi_add(struct platform_device *=
pdev)
>  }
>  #endif
>
> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
> +{
> +       struct irq_data *data;
> +       int irq;
> +       irq_hw_number_t hwirq;
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq =3D=3D 0) {
> +               pr_err("VMBus interrupt mapping failure\n");
> +               return -EINVAL;
> +       }
> +       if (irq < 0) {
> +               pr_err("VMBus interrupt data can't be read from DeviceTre=
e, error %d\n", irq);
> +               return irq;
> +       }

I don't think why you couldn't get the interrupt is important. Just
check for (irq <=3D 0) and be done with it. I'm not even sure if
returning 0 is possible now. There's a long history to that and
NO_IRQ.

Rob

