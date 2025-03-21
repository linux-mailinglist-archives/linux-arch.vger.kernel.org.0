Return-Path: <linux-arch+bounces-11032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A554FA6C413
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE873B49A8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC6322FF2D;
	Fri, 21 Mar 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nJQqDG+/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB141514F6;
	Fri, 21 Mar 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588341; cv=none; b=uscrw2b1R67AQHmgNbpGava1Orm8Zyaml50ymuRb44Sp8LmMImN6RFCrYz/fX1x32jxZbmjMaPnt6KVG3Fe4Q/TamtkaJ3iB8ji4srvzcvFCZ4K33jn8W7dTobUAQFWmHvnQFjI3f7GSfRcJjwekRm90/3vUN+KZsceL5CdkC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588341; c=relaxed/simple;
	bh=u9h3D5TcVApK93PEhixGg4MPkVduLY519FMbBoFkk0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+S/G8H2JX7wY88TcBSeL+fqY0JlQ57WhcrWj+r7Eye1ep+ImPRV+Jp/6eO0L63WQ/xo53TuyAagB0p+lorWRu0uoQ6nZZDPCb87AmfVwI5bRyX14aIsx1Ed5VpmbGDRVrMN8ML7E7J5dB2K9G2ygAorNENTFr8dHqwr8GJ00Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nJQqDG+/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D28E2025388;
	Fri, 21 Mar 2025 13:18:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D28E2025388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742588339;
	bh=gcXc9gPVhG3Zqqp66/fZMukytwmnYZmakgzchvvsPRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nJQqDG+/ZYHaPvuqYHMXwraeNV8cIuprWxRBqEBZxLj9NVi6+twj19R9iw+iLjdwS
	 I3pPySp+zM3NKeLDxcoANzsm7UlB4V1cidT71KIRyxGGIr2YxlMpgNSi1i9PHgtEHM
	 IenH318joM24lZGeY71hKyAFyfZVEMkDD+eXqsns=
Message-ID: <34de36fe-f4f6-4ec3-848d-9191fd1e8b9f@linux.microsoft.com>
Date: Fri, 21 Mar 2025 13:18:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] PCI: hv: Use hv_hvcall_*() to set up hypercall
 arguments
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-6-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250313061911.2491-6-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset().
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> Notes:
>     Changes in v2:
>     * In hv_arch_irq_unmask(), added check of the number of computed banks
>       in the hv_vpset against the batch_size. Since an hv_vpset currently
>       represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
>       512 bytes and there should always be sufficent space. But do the
>       check just in case something changes. [Nuno Das Neves]
> 
>  drivers/pci/controller/pci-hyperv.c | 18 ++++++++----------
>  include/hyperv/hvgdk_mini.h         |  2 +-
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ac27bda5ba26..82ac0e09943b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -622,7 +622,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	struct pci_dev *pdev;
>  	unsigned long flags;
>  	u32 var_size = 0;
> -	int cpu, nr_bank;
> +	int cpu, nr_bank, batch_size;
>  	u64 res;
>  
>  	dest = irq_data_get_effective_affinity_mask(data);
> @@ -638,8 +638,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  
>  	local_irq_save(flags);
>  
> -	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(params, 0, sizeof(*params));
> +	batch_size = hv_hvcall_in_array(&params, sizeof(*params),
> +					sizeof(params->int_target.vp_set.bank_contents[0]));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> @@ -671,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
>  		free_cpumask_var(tmp);
>  
> -		if (nr_bank <= 0) {
> +		if (nr_bank <= 0 || nr_bank > batch_size) {
>  			res = 1;
>  			goto out;
>  		}
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

As with the prior patch, I don't think this is worth changing. The
code in hv_pci_write_mmio() is more complicated as a result, and
changing the array means the struct no longer matches the Hyper-V
struct 1:1.

Thanks
Nuno

>  } __packed;
>  
>  #endif /* _HV_HVGDK_MINI_H */


