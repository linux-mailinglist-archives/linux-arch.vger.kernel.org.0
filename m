Return-Path: <linux-arch+bounces-4440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059408C6E65
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 00:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0481F232FC
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34915B569;
	Wed, 15 May 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MQyPlHhp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966083BBEA;
	Wed, 15 May 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715810662; cv=none; b=hGKd6XVfyb/Vkl8ZU35+jTr9ymJ8/5UE4ZBK8xAhEcQdYAWt3ONWt0iezHTOFTQ3EhNooi+ukd+YKdHAFnOERR7YvEbT9y1/BTaaeFZvR55EB5FEUevLJJ21BF/ldJZZ96UMJb3s53oS+59eINLGb1MDn2Rm3nbO6k+Y1EB/yd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715810662; c=relaxed/simple;
	bh=A2JE1wFblMMdWw30BZhpMz3CO8n24X5cU5MY3GMBBp8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+m3TASRLOMq1VcppBfe2iiuSWVaqKnfaCG0CGIQ/Jzs8UTHBNqNVcaQvCG+53LeT7QEfAo1+O1upoH9ZRQze3pqyDWCG3EED2ol4zwQ/9nQP9tLuV6JR6QeCiWFsCk6RO1Q9hTiTr3mRRRhu2Xxy/CAO7TFZmRthtkcMvYSPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MQyPlHhp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FLnG3L014218;
	Wed, 15 May 2024 22:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=QDBa3xO9SVZC0wA2OjFbS
	SGVBA+x1q/1DDGJo/BLO2I=; b=MQyPlHhp1n4fCWGyt3zgw7uZYWtpd92rUGJQz
	8lkiNoMpg9wNRG1Z4UMGpor453kwHi/95tOXEi9FnpUzhdtYoF5ZBz6MknfKWOqy
	sRysZ0+7h509TFYw35HozsSeq8qzkZJ1CSzcgZzGBUyKRbYxcQ2/N6kBzGg8bseg
	ws2hOTF7UNB5kTufM8+RQARntGoyzijoVFuqh5JYSxSIt2hzYUhnOEh7k9UEheLX
	VCea4kIgNhB9hnzH9/nFRMTusHl3joiCTv5YPVJD9cQBI9BRl8okPKU9wO1/Xhc1
	Y2G8g1X8/+Volxv+8CmSN5HhVoOEz9ImAVx2FWB6Ci2lIK3uw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20w224dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:02:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FM2tBB015195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:02:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 15:02:54 -0700
Date: Wed, 15 May 2024 15:02:54 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Roman Kisel <romank@linux.microsoft.com>
CC: <arnd@arndb.de>, <bhelgaas@google.com>, <bp@alien8.de>,
        <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
        <decui@microsoft.com>, <haiyangz@microsoft.com>, <hpa@zytor.com>,
        <kw@linux.com>, <kys@microsoft.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <mingo@redhat.com>, <mhklinux@outlook.com>,
        <rafael@kernel.org>, <robh@kernel.org>, <tglx@linutronix.de>,
        <wei.liu@kernel.org>, <will@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <x86@kernel.org>, <ssengar@microsoft.com>,
        <sunilmut@microsoft.com>, <vdso@hexbites.dev>
Subject: Re: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
Message-ID: <20240515143359142-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240514224508.212318-2-romank@linux.microsoft.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DgLWzryxOWhF7b4rEhDpYrNv9kFCQJeQ
X-Proofpoint-GUID: DgLWzryxOWhF7b4rEhDpYrNv9kFCQJeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405150158

On Tue, May 14, 2024 at 03:43:48PM -0700, Roman Kisel wrote:
> The Virtual Trust Level platforms rely on DeviceTree, and the
> arm64/hyperv code supports ACPI only. Update the logic to
> support DeviceTree on boot as well as ACPI.

Could you use Call UID query from SMCCC? KVM [1] and Gunyah [2] have
been using this to identify if guest is running under those respective
hypervisors. This works in both DT and ACPI cases.

[1]: https://lore.kernel.org/all/20210330145430.996981-2-maz@kernel.org/
[2]: https://lore.kernel.org/all/20240222-gunyah-v17-4-1e9da6763d38@quicinc.com/
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..208a3bcb9686 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,6 +15,9 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/libfdt.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
>  #include <asm/mshyperv.h>
>  
>  static bool hyperv_initialized;
> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  	return 0;
>  }
>  
> +static bool hyperv_detect_fdt(void)
> +{
> +#ifdef CONFIG_OF
> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
> +			of_get_flat_dt_root(), "hypervisor");
> +
> +	return (hyp_node != -FDT_ERR_NOTFOUND) &&
> +			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool hyperv_detect_acpi(void)
> +{
> +#ifdef CONFIG_ACPI
> +	return !acpi_disabled &&
> +			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
> +#else
> +	return false;
> +#endif
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +61,11 @@ static int __init hyperv_init(void)
>  
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
>  		return 0;
>  
>  	/* Setup the guest ID */
> -- 
> 2.45.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

