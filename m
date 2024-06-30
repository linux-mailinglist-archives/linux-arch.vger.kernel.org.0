Return-Path: <linux-arch+bounces-5209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3C91D1AB
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B8EB216C1
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6813D525;
	Sun, 30 Jun 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFql/Uwh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1413C685;
	Sun, 30 Jun 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752046; cv=none; b=hNdLybCWFRg2rc9CZ1cXG/tUWsrpTkFgN0E3IP7K/T1qWUG8ymYsHEy0pYnk1yKoAQ5wm1G131IuvhlY2craoBIQyKatowhQmERX2hrKkqht1H17r12H2GEnWwn0n+8Iw8rbu95RqFk31R9H1pX+ijIRicZDKduzC5pTh8k9NNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752046; c=relaxed/simple;
	bh=MTLcAa4+Z4K8Qu34a7IYdMmh1nWwrZWGHcm39mzOztw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfD0ChH99L3ixy9oeI2yZFwo/sBQ740hv1XNztSQVzFGjWskObpUN+TRrRzTWlSoFvW7uJpOnwU3hJbbEQ60w7wljQwaQGYNelvTTcVooxQmO/UmgwFvL0Aqde9PxRdXKrByPXNpF81o96naH+c+q13qaZzt2URj30GE4lEpg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFql/Uwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7D3C4AF12;
	Sun, 30 Jun 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719752045;
	bh=MTLcAa4+Z4K8Qu34a7IYdMmh1nWwrZWGHcm39mzOztw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WFql/UwhlU5AToM7jPrbjpsP0ocEKkBfI273nUf/54QtBqLOCni0+4ewvUdpAM4rs
	 c7j055sGIRAxASoXbTafztQ5p2b9cnYwWJYLgjHRPFhDmFGpX9yPOdJmfwbhQITKkf
	 b00fdV+8rpQBjZY0UbmDdapfnHyzV3+w0hQaiJ4ylnWe9ETTcUu0bP2U7kjescUL8p
	 NgkhNvNoH3RkEeriqmG+Hv8PFtKivz88Ao8iVnMcnCFC0bL1h3GRw25ybR7vB5otXx
	 I6/li3xaaBJGcfea+zX/Rno4N3pcsYgoytH8PsL0986MuEm15TTkWjjhMjnmf82nM1
	 In7CwbzaFF/jw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so29512911fa.2;
        Sun, 30 Jun 2024 05:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/92KMCkxtAgp215YDgpm9n8N9yiEtnrNs0vSnQUf1ANBcV81HSVuWVBLKCvw0Std1Uto6CHh2FUtQfB7cMpEGs9VZBfgr92dMOOy+gQ7qZ4RX49vm/kJCBiGFZ0wMvPbb7loObzDerZnePUnY68lVPr+tLHtphaxmg6WNKw/cjSnNTdD/1RTbzAYNVAAq06WevUZZBpe2OeHiAXtRsQ==
X-Gm-Message-State: AOJu0Yw0qQ4c8d9XcEAdMNKmUh8wFlB58XbHJ8X8O1+TBkUaJo1Y36H2
	vZ9n89SGGyWXLWN6obfv5qAKAMY/6MTLu7G/AWX/+jJ/BjQojCCJeuje01KwaaAROa/6PH1SoCW
	JxBF4Hhgh2B+me8sbFB+TBF8SeJs=
X-Google-Smtp-Source: AGHT+IFs/7YAIZFxyyiGE2KYpKMUZ55m6O8zrTccnHK16hMcQAymlwwDLAPtEzNvFMCMrpX/LTlCq4HsY8kMRZ2jPd4=
X-Received: by 2002:a05:651c:81d:b0:2ec:5502:b2f4 with SMTP id
 38308e7fff4ca-2ee5e707762mr20716781fa.45.1719752043665; Sun, 30 Jun 2024
 05:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com> <20240529133446.28446-19-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240529133446.28446-19-Jonathan.Cameron@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Jun 2024 20:53:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Ghfj74hcOQCn6yz4t-_p=WkYdmWRrw=v8FK6t+f_EkA@mail.gmail.com>
Message-ID: <CAAhV-H6Ghfj74hcOQCn6yz4t-_p=WkYdmWRrw=v8FK6t+f_EkA@mail.gmail.com>
Subject: Re: [PATCH v10 18/19] arm64: document virtual CPU hotplug's expectations
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Gavin Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, 
	justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jonathan,

On Wed, May 29, 2024 at 9:44=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> Add a description of physical and virtual CPU hotplug, explain the
> differences and elaborate on what is required in ACPI for a working
> virtual hotplug system.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
>  Documentation/arch/arm64/index.rst       |  1 +
>  2 files changed, 80 insertions(+)
>
> diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/arc=
h/arm64/cpu-hotplug.rst
> new file mode 100644
> index 000000000000..76ba8d932c72
> --- /dev/null
> +++ b/Documentation/arch/arm64/cpu-hotplug.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _cpuhp_index:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +CPU Hotplug and ACPI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +CPU hotplug in the arm64 world is commonly used to describe the kernel t=
aking
> +CPUs online/offline using PSCI. This document is about ACPI firmware all=
owing
> +CPUs that were not available during boot to be added to the system later=
.
> +
> +``possible`` and ``present`` refer to the state of the CPU as seen by li=
nux.
> +
> +
> +CPU Hotplug on physical systems - CPUs not present at boot
> +----------------------------------------------------------
> +
> +Physical systems need to mark a CPU that is ``possible`` but not ``prese=
nt`` as
> +being ``present``. An example would be a dual socket machine, where the =
package
> +in one of the sockets can be replaced while the system is running.
> +
> +This is not supported.
> +
> +In the arm64 world CPUs are not a single device but a slice of the syste=
m.
> +There are no systems that support the physical addition (or removal) of =
CPUs
> +while the system is running, and ACPI is not able to sufficiently descri=
be
> +them.
> +
> +e.g. New CPUs come with new caches, but the platform's cache toplogy is
> +described in a static table, the PPTT. How caches are shared between CPU=
s is
> +not discoverable, and must be described by firmware.
> +
> +e.g. The GIC redistributor for each CPU must be accessed by the driver d=
uring
> +boot to discover the system wide supported features. ACPI's MADT GICC
> +structures can describe a redistributor associated with a disabled CPU, =
but
> +can't describe whether the redistributor is accessible, only that it is =
not
> +'always on'.
> +
> +arm64's ACPI tables assume that everything described is ``present``.
> +
> +
> +CPU Hotplug on virtual systems - CPUs not enabled at boot
> +---------------------------------------------------------
In my opinion "enabled" is not a good description here. It is too
general and confusing. For example, in enable_nonboot_cpus(), "enable"
means make a "present" CPU "online", while in ACPI MADT, "enabled"
means "possible" but not "present". So I suggest rename "enabled" to
"pending" or "usable" or some other better words. Thanks.

Huacai.

> +
> +Virtual systems have the advantage that all the properties the system wi=
ll
> +ever have can be described at boot. There are no power-domain considerat=
ions
> +as such devices are emulated.
> +
> +CPU Hotplug on virtual systems is supported. It is distinct from physica=
l
> +CPU Hotplug as all resources are described as ``present``, but CPUs may =
be
> +marked as disabled by firmware. Only the CPU's online/offline behaviour =
is
> +influenced by firmware. An example is where a virtual machine boots with=
 a
> +single CPU, and additional CPUs are added once a cloud orchestrator depl=
oys
> +the workload.
> +
> +For a virtual machine, the VMM (e.g. Qemu) plays the part of firmware.
> +
> +Virtual hotplug is implemented as a firmware policy affecting which CPUs=
 can be
> +brought online. Firmware can enforce its policy via PSCI's return codes.=
 e.g.
> +``DENIED``.
> +
> +The ACPI tables must describe all the resources of the virtual machine. =
CPUs
> +that firmware wishes to disable either from boot (or later) should not b=
e
> +``enabled`` in the MADT GICC structures, but should have the ``online ca=
pable``
> +bit set, to indicate they can be enabled later. The boot CPU must be mar=
ked as
> +``enabled``.  The 'always on' GICR structure must be used to describe th=
e
> +redistributors.
> +
> +CPUs described as ``online capable`` but not ``enabled`` can be set to e=
nabled
> +by the DSDT's Processor object's _STA method. On virtual systems the _ST=
A method
> +must always report the CPU as ``present``. Changes to the firmware polic=
y can
> +be notified to the OS via device-check or eject-request.
> +
> +CPUs described as ``enabled`` in the static table, should not have their=
 _STA
> +modified dynamically by firmware. Soft-restart features such as kexec wi=
ll
> +re-read the static properties of the system from these static tables, an=
d
> +may malfunction if these no longer describe the running system. Linux wi=
ll
> +re-discover the dynamic properties of the system from the _STA method la=
ter
> +during boot.
> diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm6=
4/index.rst
> index d08e924204bf..78544de0a8a9 100644
> --- a/Documentation/arch/arm64/index.rst
> +++ b/Documentation/arch/arm64/index.rst
> @@ -13,6 +13,7 @@ ARM64 Architecture
>      asymmetric-32bit
>      booting
>      cpu-feature-registers
> +    cpu-hotplug
>      elf_hwcaps
>      hugetlbpage
>      kdump
> --
> 2.39.2
>
>

