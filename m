Return-Path: <linux-arch+bounces-1126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE9817BA7
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3859B23BF5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2FE7205D;
	Mon, 18 Dec 2023 20:17:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C67146E;
	Mon, 18 Dec 2023 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20394042a45so279477fac.0;
        Mon, 18 Dec 2023 12:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702930666; x=1703535466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVggm/k7h51uGokCDrYG9yM8ij6+ByTlCjSSiz9AMHU=;
        b=j+cpQAhZ5EEyQhYmHr0vMjlkHiWBOE0Q/mGiu/JrTWX3qqoOAf6hORYIKIinCVwTs5
         yGKbLcrk1gb1WNZXe2/vxOagVXtwV/rS5PCw7qIxss954TuXeTvQTCjQedRKZo6ax/iF
         ixU/rvy+geguv/CA8mXBpdmLFWJVZX/cyuWXHVxTtvHBtc33H4PCnzO1BQBlVXYs/RyI
         pWuro8Q0MgyN8tTfY+/BvgDPYnC8Nz2ryFqJa4oluvzZD4bU+OOk3IIF5vWD/rYPJFxE
         DDx5EvLJEPMuzC7wtX77BRNscywfc+PvfMViCfUK2XIBGgrcvu/tar1LDm9MJboLITK7
         Qk9Q==
X-Gm-Message-State: AOJu0YxMLBTv2B7NYmm5chKSElGEU03qGjummiquhPRJIYWOWFm7GmnM
	WqtLANJtUi/8XlT8a9wv5575rJGDGHpuEsNZY1U=
X-Google-Smtp-Source: AGHT+IFMjefUSNquEpPstcFy8KIyactI5mxHoAdfHlD4qq0J99AZZDv3tX1Y2M6bLJ1U3Iv5VjAbiMgTsk/u/KcBObU=
X-Received: by 2002:a05:6870:9591:b0:203:e5bc:154a with SMTP id
 k17-20020a056870959100b00203e5bc154amr834085oao.2.1702930665760; Mon, 18 Dec
 2023 12:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 21:17:34 +0100
Message-ID: <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
> 5.2.12:
>
> "Starting with ACPI Specification 6.3, the use of the Processor() object
> was deprecated. Only legacy systems should continue with this usage. On
> the Itanium architecture only, a _UID is provided for the Processor()
> that is a string object. This usage of _UID is also deprecated since it
> can preclude an OSPM from being able to match a processor to a
> non-enumerable device, such as those defined in the MADT. From ACPI
> Specification 6.3 onward, all processor objects for all architectures
> except Itanium must now use Device() objects with an _HID of ACPI0007,
> and use only integer _UID values."
>
> Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_C=
ontrol.html#declaring-processors
>
> Duplicate descriptions are not allowed, the ACPI processor driver already
> parses the UID from both devices and containers. acpi_processor_get_info(=
)
> returns an error if the UID exists twice in the DSDT.

I'm not really sure how the above is related to the actual patch.

> The missing probe for CPUs described as packages

It is unclear what exactly is meant by "CPUs described as packages".

From the patch, it looks like those would be Processor() objects
defined under a processor container device.

> creates a problem for
> moving the cpu_register() calls into the acpi_processor driver, as CPUs
> described like this don't get registered, leading to errors from other
> subsystems when they try to add new sysfs entries to the CPU node.
> (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
>
> To fix this, parse the processor container and call acpi_processor_add()
> for each processor that is discovered like this.

Discovered like what?

> The processor container
> handler is added with acpi_scan_add_handler(), so no detach call will
> arrive.

The above requires clarification too.

> Qemu TCG describes CPUs using processor devices in a processor container.
> For more information, see build_cpus_aml() in Qemu hw/acpi/cpu.c and
> https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.ht=
ml#processor-container-device
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
> Outstanding comments:
>  https://lore.kernel.org/r/20230914145353.000072e2@Huawei.com
>  https://lore.kernel.org/r/50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.co=
m
> ---
>  drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4fe2ef54088c..6a542e0ce396 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,9 +626,31 @@ static struct acpi_scan_handler processor_handler =
=3D {
>         },
>  };
>
> +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> +                                                u32 lvl,
> +                                                void *context,
> +                                                void **rv)
> +{
> +       struct acpi_device *adev;
> +       acpi_status status;
> +
> +       adev =3D acpi_get_acpi_dev(handle);
> +       if (!adev)
> +               return AE_ERROR;

Why is the reference counting needed here?

Wouldn't acpi_fetch_acpi_dev() suffice?

Also, should the walk really be terminated on the first error?

> +
> +       status =3D acpi_processor_add(adev, &processor_device_ids[0]);
> +       acpi_put_acpi_dev(adev);
> +
> +       return status;
> +}
> +
>  static int acpi_processor_container_attach(struct acpi_device *dev,
>                                            const struct acpi_device_id *i=
d)
>  {
> +       acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> +                           ACPI_UINT32_MAX, acpi_processor_container_wal=
k,
> +                           NULL, NULL, NULL);

This covers processor objects only, so why is this not needed for
processor devices defined under a processor container object?

It is not obvious, so it would be nice to add a comment explaining the
difference.

> +
>         return 1;
>  }
>
> --

