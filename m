Return-Path: <linux-arch+bounces-11858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC4AABB51
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7907ACA47
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F553233D92;
	Tue,  6 May 2025 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIRkTWuY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161F6FC5;
	Tue,  6 May 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512400; cv=none; b=U8qldhBDD/x4a3GxK+Mm2nNIV+VyqG3tif8llBz8Cop5vPY/m/LyUR79vRgwe9Bp2QOcEexNWyNshCX7K8X9BIBzAkZAfayKRGSjKXapMgK4AffoiXQBkpAbJrW57GAHjE4/N2bP174DFWDkwn5YsP8m1Ppj39af0UwBbaw9V3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512400; c=relaxed/simple;
	bh=IaknPFqcP0N7YD+hkdGoIITlQSTa3FqWiaGwJ4M7xOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q62u78yke+Jb7HoPIJT9y/SetEu0tjcjfqjhgFstE6Ie3LoxSRytYFTSGdjA+2dSqhyOFdI2kpPhKflb+AfyTl2J03ucem5EtMEfoYIe1kvP1ZKLStyycn/lSUS10JeQQaWH8n1iNxNggotXV511797AFYw+KHO4DOC3f75XzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIRkTWuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE70C4CEEB;
	Tue,  6 May 2025 06:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746512399;
	bh=IaknPFqcP0N7YD+hkdGoIITlQSTa3FqWiaGwJ4M7xOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIRkTWuYiswfaOZhaA9mMbfIsTR/ZTklZu2Oe44c9xSTzghAJERx/3W0TESSm787U
	 CLR3YOKZjtiYprxUIhVt6kY7tF0oYRoYxYxEpdimHmXA+u4dadKipt6WARl1mkRAU9
	 DYMKW2mOUDdVzhaqf4Wxjsbw0BSWwQ66y/4ruC2EQ9FcSOQ6GdVOrAsYjqHoIEiGnQ
	 rtslXz2wkE5IQdgaxJYYNss6cFHmKoW2P6+1getUhQIgG1bZT6T7bDzYUHGdGuJQJW
	 R2M8i144n5z2YDH+umSx8sNUXhYwLbUKuUn2WZam2i7g8mOIGx5KAiU/OrXh/rGPk4
	 3T3KMLHJBsjfQ==
Date: Tue, 6 May 2025 06:19:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, conor+dt@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com,
	krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
	lenb@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
	maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev,
	rafael@kernel.org, robh@kernel.org, ssengar@linux.microsoft.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v9 00/11] arm64: hyperv: Support Virtual
 Trust Level Boot
Message-ID: <aBmqDU_UjxIAx2lP@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250428210742.435282-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428210742.435282-1-romank@linux.microsoft.com>

On Mon, Apr 28, 2025 at 02:07:31PM -0700, Roman Kisel wrote:
> This patch set allows the Hyper-V code to boot on ARM64 inside a Virtual Trust
> Level. These levels are a part of the Virtual Secure Mode documented in the
> Top-Level Functional Specification available at
> https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm.
> 
> The OpenHCL paravisor https://github.com/microsoft/openvmm/tree/main/openhcl
> can serve as a practical application of these patches on ARM64.
> 
> For validation, I built kernels for the {x86_64, ARM64} x {VTL0, VTL2} set with
> a small initrd embedded into the kernel and booted VMs managed by Hyper-V and
> OpenVMM off of that.
> 
> Starting from V5, the patch series includes a non-functional change to KVM on
> arm64 which I tested as well.
> 
> I've kept the Acked-by tags given by Arnd and Bjorn. These patches (1 and 11)
> have changed very slightly since then (V5 and V6), no functional changes:
> in patch 1, removed macro's in favour of functions as Marc suggested to get rid
> of "sparse" warnings, and in patch 11, fixed building as a module. Please let me
> know if I should have not kept the tags.
> 
[...]
> Roman Kisel (11):
>   arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID

I notice there were review comments from multiple people on this patch.
To the best of my knowledge, those comments have been addressed in this
version, but I only had a cursory look and am by no means an expert on
ARM64.

My assumption is Arnd's review is good enough for this patch to get
merged.

With that assumption, I have applied this whole series to hyperv-next.

ARM64 maintainers, please let me know if you have an objection -- I can
drop the series and let Roman address further comments.

Thanks,
Wei.

>   arm64: hyperv: Use SMCCC to detect hypervisor presence
>   Drivers: hv: Enable VTL mode for arm64
>   Drivers: hv: Provide arch-neutral implementation of get_vtl()
>   arm64: hyperv: Initialize the Virtual Trust Level field
>   arm64, x86: hyperv: Report the VTL the system boots in
>   dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence
>     properties
>   Drivers: hv: vmbus: Get the IRQ number from DeviceTree
>   Drivers: hv: vmbus: Introduce hv_get_vmbus_root_device()
>   ACPI: irq: Introduce acpi_get_gsi_dispatcher()
>   PCI: hv: Get vPCI MSI IRQ domain from DeviceTree


