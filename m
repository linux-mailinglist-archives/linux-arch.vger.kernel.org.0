Return-Path: <linux-arch+bounces-12977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E695CB14103
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D0A3A3F95
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16511C862C;
	Mon, 28 Jul 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ISRKPyRX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33114EED8;
	Mon, 28 Jul 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722732; cv=none; b=ncZA+H1ARpAit4m5x6Kcrbk0ISqNVcQY5puLAb5k191Gumw6ls7teLLg8iOjzS9TykcCwvy6yOhx3yoEteAy+1BP6NSaV9uV0JrLBwVmrZBNkgl62CAtYJXgrArQ6IOuRcZ9qtQPT2P/QVcTb7Ftv8Ga8901xldpDWt3dGtM+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722732; c=relaxed/simple;
	bh=jm8GHfoU8DWdKYSCTigI98dUJfuD9vlNqLzgT9PHHwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8T0rTYsPNg+l0MO9ekPBzn2jGfz3KtwYOo1wFg4f1+l5SCLCOFrPXqjg+8N5qk6tYPNTW0GV/BKp45TMkKlVuGTeqly4STylEHGyNc4K+xKFETEexgTFYCLb5TDFAiAJFokjJd8sUxhqYQbd5Wz0+yWaEcBoUiiUjVmSK88M1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ISRKPyRX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.206] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E84F2114274;
	Mon, 28 Jul 2025 10:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E84F2114274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753722730;
	bh=/O3Zq1iAdcSb7vXbke8ttLkPel/qXHUJTuDYYr+EkFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ISRKPyRXDJnUgLM62BqlHo8k+3QddOaPibWcTOkOmmzvIbImRFP++2q4iZ9S+OOml
	 L0BTHhKHh7JOMPygtGqeduCRxsHOVi5Sd582dIJ0FDFggrTbUJaWPEKghqqw50aN8i
	 QMBVEvIe6NbRiXNVrVmdP+sr7kUpFZJRiKfXllCI=
Message-ID: <e823efbd-892b-45c6-a747-9a7dc1caf48c@linux.microsoft.com>
Date: Mon, 28 Jul 2025 10:12:09 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI: hv: Use hv_setup_*() to set up hypercall
 arguments
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-6-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250718045545.517620-6-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_setup_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset().
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> Notes:
>     Changes in v4:
>     * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
>     * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
>       [Easwar Hariharan]
>     
>     Changes in v3:
>     * Removed change to definition of struct hv_mmio_write_input so it remains
>       consistent with original Hyper-V definitions. Adjusted argument to
>       hv_hvcall_in_array() accordingly so that the 64 byte 'data' array is
>       not zero'ed. [Nuno Das Neves]
>     
>     Changes in v2:
>     * In hv_arch_irq_unmask(), added check of the number of computed banks
>       in the hv_vpset against the batch_size. Since an hv_vpset currently
>       represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
>       512 bytes and there should always be sufficent space. But do the
>       check just in case something changes. [Nuno Das Neves]
> 
>  drivers/pci/controller/pci-hyperv.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index d2b7e8ea710b..79de85d1d68b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -620,7 +620,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
>  	struct pci_dev *pdev;
>  	unsigned long flags;
>  	u32 var_size = 0;
> -	int cpu, nr_bank;
> +	int cpu, nr_bank, batch_size;
>  	u64 res;
>  
>  	dest = irq_data_get_effective_affinity_mask(data);
> @@ -636,8 +636,8 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
>  
>  	local_irq_save(flags);
>  
> -	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(params, 0, sizeof(*params));
> +	batch_size = hv_setup_in_array(&params, sizeof(*params),
> +					sizeof(params->int_target.vp_set.bank_contents[0]));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> @@ -669,7 +669,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
>  		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
>  		free_cpumask_var(tmp);
>  
> -		if (nr_bank <= 0) {
> +		if (nr_bank <= 0 || nr_bank > batch_size) {
>  			res = 1;
>  			goto out;
>  		}
> @@ -1102,11 +1102,9 @@ static void hv_pci_read_mmio(struct device *dev, phys_addr_t gpa, int size, u32
>  
>  	/*
>  	 * Must be called with interrupts disabled so it is safe
> -	 * to use the per-cpu input argument page.  Use it for
> -	 * both input and output.
> +	 * to use the per-cpu argument page.
>  	 */
> -	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	out = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*in);
> +	hv_setup_inout(&in, sizeof(*in), &out, sizeof(*out));
>  	in->gpa = gpa;
>  	in->size = size;
>  
> @@ -1135,9 +1133,9 @@ static void hv_pci_write_mmio(struct device *dev, phys_addr_t gpa, int size, u32
>  
>  	/*
>  	 * Must be called with interrupts disabled so it is safe
> -	 * to use the per-cpu input argument memory.
> +	 * to use the per-cpu argument page.
>  	 */
> -	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	hv_setup_in_array(&in, offsetof(typeof(*in), data), sizeof(in->data[0]));
>  	in->gpa = gpa;
>  	in->size = size;
>  	switch (size) {

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

