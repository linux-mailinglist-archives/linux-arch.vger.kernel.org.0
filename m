Return-Path: <linux-arch+bounces-10267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D51A3E713
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F43189D41C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4A214805;
	Thu, 20 Feb 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XtGknKWp"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1387213E8C;
	Thu, 20 Feb 2025 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088642; cv=none; b=NpKQB+rNFp/c9Cowz8y13XPmhu6+I+hlchrrC07EtI51G59XLS3LP9duXQmMrAyoQD8daJeyCPeuR1A2VxSBiG0HZ0DrdjeKv7JKHGxu4zi3H8hORMm/QiijbxQPCj5daSoTFdraxwfAZ0OEVCU8qKAyZZR04JuMK3UdH3eMdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088642; c=relaxed/simple;
	bh=gMZs+9OrG5fzn9MS/2Mbfn4Nc4iUTMVd0t0TT/zYzk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If2JwhTP4l/IkJtVnzyvkj39nUQzggganT9s1Puf7T+pDlpa+1us7exqGX9GFZqh03mso1gPRIX5l7UcHpsPkJ9Afd1j8CoX4DfFnziP7I1Bu3jv8Ya7cVURuk8WmBVTSwvx1tmMVAaG0fOKtxC84V+IZlhRlMB+UbslvCJOnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XtGknKWp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id A2784203E3BD;
	Thu, 20 Feb 2025 13:57:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2784203E3BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740088640;
	bh=hXGH9Z+OdViyLyaeNdj+evSOC05tFiOwgQvPxQsepcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XtGknKWpWoB+evSUfsY6KBr3Lhb1Ju2CCc638EfX+cLZ0/PDofVE7HCnnownVNu6h
	 4q03qcOPhOmEu8nMMTIoirXxamdOrA8OY90k3D6HNMHI2nfHmrb2v9C7eVGgeTUR9m
	 kpqR+22342pJd/TO0Iag2Y5Yo5rxJLEmTX8xeSjk=
Message-ID: <6e7d0116-82b5-4a39-997e-24143d7d3584@linux.microsoft.com>
Date: Thu, 20 Feb 2025 13:57:19 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415703DF0CD1EB3523E3C79AD4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415703DF0CD1EB3523E3C79AD4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 11:17 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, February 20, 2025 10:33 AM
>>
>> Introduce hv_current_partition_type to store the partition type
>> as an enum.
>>
>> Right now this is limited to guest or root partition, but there will
>> be other kinds in future and the enum is easily extensible.
>>
>> Set up hv_current_partition_type early in Hyper-V initialization with
>> hv_identify_partition_type(). hv_root_partition() just queries this
>> value, and shouldn't be called before that.
>>
>> Making this check into a function sets the stage for adding a config
>> option to gate the compilation of root partition code. In particular,
>> hv_root_partition() can be stubbed out always be false if root
>> partition support isn't desired.
>>
>>
> 
> [snip]
>  
>> +void hv_identify_partition_type(void)
>> +{
>> +	/* Assume guest role */
>> +	hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
>> +	/*
>> +	 * Check partition creation and cpu management privileges
>> +	 *
>> +	 * Hyper-V should never specify running as root and as a Confidential
>> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
>> +	 * to exploit root behavior to expose Confidential VM memory, ignore
>> +	 * the root partition setting if also a Confidential VM.
>> +	 */
>> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>> +		pr_info("Hyper-V: running as root partition\n");
>> +		if (IS_ENABLED(CONFIG_MSHV_ROOT))
> 
> I'll have to rescind the "Reviewed-by:" that I just gave. There's a patch
> sequencing problem in that CONFIG_MSHV_ROOT doesn't exist yet.
> It's added in Patch 3 of the series.  Because it doesn't exist, the
> IS_ENABLED() will always return 'false', which isn't fatal in the sense
> of causing a compile error.  But the code won't run in the root partition
> because hv_current_partition_type isn't set.
> 

Oops! Thanks for catching that, I'll just move the check from this patch
to patch 3.

> Michael
> 
>> +			hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
>> +		else
>> +			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>> +	}
>> +}


