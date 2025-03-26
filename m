Return-Path: <linux-arch+bounces-11135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00725A719A1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 16:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E5817B885
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761601F3BB9;
	Wed, 26 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX6aTZbf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1471EEA36;
	Wed, 26 Mar 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000928; cv=none; b=ZBnDrQqNqtPVR5d3WT+NObr7pfoX9FG4ABKkemqRLWNGDXlfJ13aFo43zCQWP0TQbiTd1PbL5RWRKp8TBZ/j0U++RZuFBVcm5tnNMwmvtGQAudwMPYjLoKx+t8LgefYBXPBI6dSXkHkKs8ZA+/zI8EW6ttQo/76o8g4lpbOYGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000928; c=relaxed/simple;
	bh=2FjJkXZ1Sr7UVOgZLzCfOaayYT0ey4QBq9TK9OK+P/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iny8sHywRy1KDbeDQ8bEOeoLWeS1yRNjap40ktcb3yMCdjkyEfceIfsqdJeUTQgKG49caAwF1cPGvHqOINZLTHf0aqZyZKw7Au8JqWQ4MeTWJiYHGfE10lUYCv63ivspVyEhYd3nhB7vgqgW3XT8D5Mmd9MFksXJBH9qBvaA6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX6aTZbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA9C4CEE2;
	Wed, 26 Mar 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743000927;
	bh=2FjJkXZ1Sr7UVOgZLzCfOaayYT0ey4QBq9TK9OK+P/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HX6aTZbfmKW3A2e/vn8L0G+6m4LL7IV/4qxaFFkyjSE9WQc2yJgVcmxtQn0yvGNkB
	 j6/G1HeyjUGGQ+beZvHvcO588uANwt91E4OKcxRzxTXZI5mCXQTIZ2GG9s8mhOZjSp
	 TS0R+5Y4qCBs+JMfbnbCvadMlrkMaksBOO3waBiF05sW9mCoLUbEcMF8Yx3tUsMpXq
	 fHw/Kn1InTPrQzu2NX8fmA9qXnwoc+6z/41+WHWS62uemtTQ1oQHUCZj9FZzfLavBp
	 5C39yp2vgvXV6jaJWKLHkNQxTEJwn3NhnThF88ek5cHtzIAmEj4Zxl7WPMuPhOcEm9
	 Z//hTubBOrTcw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c2c754af3cso3523539fac.3;
        Wed, 26 Mar 2025 07:55:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/nLXbfqNxVE6AKjH4vRNioLbDxaMz94xZdKU7DF6o8QZZx7QJ5OT5LNAnsj5HJfj0DT1mcfO2OZD/7Asw@vger.kernel.org, AJvYcCVBwVumVtKSzzDL3fRQgHJsNyZitgY5rtR7MooIXKcotd/J2MM2zwlANPKYDWd7tDG2pJkuSWqEkkdB@vger.kernel.org, AJvYcCVLM2AEqUVI6S5NEaf4QGYR/jksq1lONKFoboKm6tM38msGE4e/glC1DIjKdEIdOChN8wJvRpT7mAT//Q==@vger.kernel.org, AJvYcCWZE/EOvRFCRUzrabNmjb5ZEUm3KJpMXQzK5uZvlOD4tSgHY0k57YM3XWVseGIHDahL04QAKAcnKdz1@vger.kernel.org, AJvYcCXO77w8RQlvdpbARz9KV2CX/7pEmkYSZyoImlBt6ppwx3eEiFFXyjkYX8rcLxD6uGsMsIuyMtduYoZXNOal@vger.kernel.org, AJvYcCXjeHZ97FWu/c0b7Nyew0lu4N3lIEt7maak/pm5VLy+r/BYjrnTgrn1DvLZoYfygOFokG3uqQaTTFOL4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW6hqHItVobhEdS17eTiFOAWMBtIy0LkA/0afBker09U/MIYI
	NMA45GSvzl7+/vKcjiFF5w0uZho8JHLUCfjKgxby8qW7W73zLfWWZQ88gg7aTTN2f7r3SxcC8er
	Vsol+BoEQRLRMxkKn4NVTVi3D4pU=
X-Google-Smtp-Source: AGHT+IEYYA/6LylePhPYpVsBFlVh+o1a/2X6ugf3+5Zk77UyBnBXpaSo0UzJzWGtji5Mqp0Q8hwWmxY8a4Ns27KKFng=
X-Received: by 2002:a05:6871:5223:b0:2bd:455e:c22e with SMTP id
 586e51a60fabf-2c7803002damr12663712fac.19.1743000926945; Wed, 26 Mar 2025
 07:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315001931.631210-1-romank@linux.microsoft.com> <20250315001931.631210-11-romank@linux.microsoft.com>
In-Reply-To: <20250315001931.631210-11-romank@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 15:55:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1bX_3zRUUf-=euuvhm1dPB6bjEXPH9O-kMGcZjRspcw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr4yQ264W4Fr4uvYbe-kFtKKfam4-v0_OqzzA1JU-y-jScH9oT2tKvFv-0
Message-ID: <CAJZ5v0g1bX_3zRUUf-=euuvhm1dPB6bjEXPH9O-kMGcZjRspcw@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v6 10/11] ACPI: irq: Introduce acpi_get_gsi_dispatcher()
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
> Using acpi_irq_create_hierarchy() in the cases where the code
> also handles OF leads to code duplication as the ACPI subsystem
> doesn't provide means to compute the IRQ domain parent whereas
> the OF does.
>
> Introduce acpi_get_gsi_dispatcher() so that the drivers relying
> on both ACPI and OF may use irq_domain_create_hierarchy() in the
> common code paths.
>
> No functional changes.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

This basically looks OK to me except for a couple of coding style
related nits below.

> ---
>  drivers/acpi/irq.c   | 15 +++++++++++++--
>  include/linux/acpi.h |  5 ++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 1687483ff319..8eb09e45e5c5 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -12,7 +12,7 @@
>
>  enum acpi_irq_model_id acpi_irq_model;
>
> -static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
> +static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
>  static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
>
>  /**
> @@ -307,12 +307,23 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
>   *     for a given GSI
>   */
>  void __init acpi_set_irq_model(enum acpi_irq_model_id model,
> -                              struct fwnode_handle *(*fn)(u32))

Please retain the indentation here and analogously below.

> +       acpi_gsi_domain_disp_fn fn)
>  {
>         acpi_irq_model =3D model;
>         acpi_get_gsi_domain_id =3D fn;
>  }
>
> +/**
> + * acpi_get_gsi_dispatcher - Returns dispatcher function that
> + *                           computes the domain fwnode for a
> + *                           given GSI.
> + */

I would format this kerneldoc comment a bit differently:

/*
 * acpi_get_gsi_dispatcher() - Get the GSI dispatcher function
 *
 * Return the dispatcher function that computes the domain fwnode for
a given GSI.
 */

> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
> +{
> +       return acpi_get_gsi_domain_id;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_gsi_dispatcher);
> +
>  /**
>   * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
>   * callback to fallback to arch specified implementation.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4e495b29c640..abc51288e867 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, =
int triggering, int polarity
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>
> +typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
> +
>  void acpi_set_irq_model(enum acpi_irq_model_id model,
> -                       struct fwnode_handle *(*)(u32));
> +       acpi_gsi_domain_disp_fn fn);
> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
>  void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
>
>  struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> --

With the above addressed, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch and route it along with the rest of the series.

Thanks!

