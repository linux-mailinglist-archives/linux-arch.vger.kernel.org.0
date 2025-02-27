Return-Path: <linux-arch+bounces-10439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC0A489E6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EB1166ADF
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBE26FDA0;
	Thu, 27 Feb 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyLTUH4B"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC851222576;
	Thu, 27 Feb 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688193; cv=none; b=eyGQkd+i16VMExmMBr65b0h9GrbbR9+AzOHE/rrhnytiYW3tw0YGFBg/Iog3PbQc/fxh6aKQHj3Db6LOMe+7ajf0r45YNVqaDKtsUWnO3mtq9h5BhDTosbpTeVsCQiyFfKNyrmBJhW3p1D4sAFY3vNWJ5xDQVPVUBSWeXKK+CgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688193; c=relaxed/simple;
	bh=2cybosVQHkRgv3r4+gwu1gpd5fZS7Gc+fStsIZV1ynM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eNmbOSaAT3OggyiDIlGWkQmtd0AGkarM4sALngePFgVnYwuVxnRte1WlOS29sM+ietXGtlAD9PqF/y0nfvSorHPRDVMJu9mNlxSuEEeYlO0bIbrkH016vm+4lJF3iNFXotm7zhkd2FyntkB5BEZ0EBwMeLYnMYmtag1ixOkw3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyLTUH4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C63EC4CEDD;
	Thu, 27 Feb 2025 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740688193;
	bh=2cybosVQHkRgv3r4+gwu1gpd5fZS7Gc+fStsIZV1ynM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cyLTUH4BoE4q96G95tspxn+UHwwCGbTdAbaqRIngaNqA62UaTIHyGk5jdlbA30ciq
	 qiYobGFaPRNL1+QTnDt69eSqVkBnCeURCp+9PPSjLsMEkkTsW7B+cedd8h/4LvhxZk
	 ul3Uxnra1ewphFFKtDcfSGUqorC1Z+ixvojNFqhSeQKI5i3hG5+9KChDmcpFoWasfp
	 m2Sj542TDjS24sLHr2xOuGvfu+F323cHV6+LlNi3SPP/3NyiK1S56R4Pib5JSDE8rw
	 eM5n0DH5RKw1xWjCOl100gbBGt26RYTXa4X62uAy8exLJVgSgmK1EfQL7aLDVwgWUq
	 4PlGk+5GNzcBg==
Date: Thu, 27 Feb 2025 14:29:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: hv: Use hv_hvcall_*() to set up hypercall
 arguments
Message-ID: <20250227202951.GA615709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226200612.2062-7-mhklinux@outlook.com>

On Wed, Feb 26, 2025 at 12:06:11PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset().
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Since most of this series touches arch/x86/hyperv/ and drivers/hv/, I
assume this will be merged via some non-PCI tree.

> ---
>  drivers/pci/controller/pci-hyperv.c | 14 ++++++--------
>  include/hyperv/hvgdk_mini.h         |  2 +-
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 44d7f4339306..b7bfda00544d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -638,8 +638,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  
>  	local_irq_save(flags);
>  
> -	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(params, 0, sizeof(*params));
> +	hv_hvcall_in_array(&params, sizeof(*params),
> +			sizeof(params->int_target.vp_set.bank_contents[0]));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> @@ -1034,11 +1034,9 @@ static void hv_pci_read_mmio(struct device *dev, phys_addr_t gpa, int size, u32
>  
>  	/*
>  	 * Must be called with interrupts disabled so it is safe
> -	 * to use the per-cpu input argument page.  Use it for
> -	 * both input and output.
> +	 * to use the per-cpu argument page.
>  	 */
> -	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	out = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*in);
> +	hv_hvcall_inout(&in, sizeof(*in), &out, sizeof(*out));
>  	in->gpa = gpa;
>  	in->size = size;
>  
> @@ -1067,9 +1065,9 @@ static void hv_pci_write_mmio(struct device *dev, phys_addr_t gpa, int size, u32
>  
>  	/*
>  	 * Must be called with interrupts disabled so it is safe
> -	 * to use the per-cpu input argument memory.
> +	 * to use the per-cpu argument page.
>  	 */
> -	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	hv_hvcall_in_array(&in, sizeof(*in), sizeof(in->data[0]));
>  	in->gpa = gpa;
>  	in->size = size;
>  	switch (size) {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 70e5d7ee40c8..cb25ac1e3ac5 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1342,7 +1342,7 @@ struct hv_mmio_write_input {
>  	u64 gpa;
>  	u32 size;
>  	u32 reserved;
> -	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
> +	u8 data[];
>  } __packed;
>  
>  #endif /* _HV_HVGDK_MINI_H */
> -- 
> 2.25.1
> 

