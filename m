Return-Path: <linux-arch+bounces-10444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05594A48C59
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0ABF7A4B9E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423D23E333;
	Thu, 27 Feb 2025 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qkPpQObi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83522576A;
	Thu, 27 Feb 2025 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697516; cv=none; b=MwIzSgue59gDcYqnMIP5XyGfDKqZyF38JreqRPQBk9o+fqMjFDXlnK+syqUljdPDlvAE3prcF0r/7PnGjmNgO1tcWrx2OP0OmrlK/OVwW3GVZwuy8uZkSL1SV9Rn5rk4AMmYWRDX5CuVJOCyfO1GsHqUzwff+fzoYZlbc6ZQTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697516; c=relaxed/simple;
	bh=qTLFHhLq8Bo9TwUvIbv0W9sWnxrDof9IYRyG59P20N8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mTmT4m1qtiXmqwXu90oMgOz1w4JwmY4ptbmPDh/n4b0BxjdCFViVmUf8NioXeyujkioTv1QXr+oJIVhboKKrVsDFx9BeG85PKzj1zheu/5RGgShnCMvDxn70asgFeq9X+qfOgCYbUq1Ov7lfJFuLL2Wphtezazi1beL566PylxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qkPpQObi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 769CA210EAC0;
	Thu, 27 Feb 2025 15:05:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 769CA210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740697511;
	bh=dCjZ9jMbRkmsPS+4OvPLxv/lO9UYo97B0D5ofNvRttk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qkPpQObiOfq236VL3tI2mDXngA4cs30KZVyxnx7UZmqoO4Z+PP1V3dKTXgl0ym5W7
	 qMXyfTC13t91+BJwaSAJFCTKnoPVNvcXzrl4l2RzeByTYqZTGZ/27ctSzlj4kptFmW
	 OeOnUXHhnxrYZun4MyIOGtSDxPpwz48NiW+qy72Q=
Message-ID: <51612cb0-fa25-45c4-9d49-dc2580706a41@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:05:09 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 05/10] acpi: numa: Export node_to_pxm()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> node_to_pxm() is used by hv_numa_node_to_pxm_info().
> That helper will be used by Hyper-V root partition module code
> when CONFIG_MSHV_ROOT=m.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/acpi/numa/srat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..ce815d7cb8f6 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -51,6 +51,7 @@ int node_to_pxm(int node)
>  		return PXM_INVAL;
>  	return node_to_pxm_map[node];
>  }
> +EXPORT_SYMBOL_GPL(node_to_pxm);
>  
>  static void __acpi_map_pxm_to_node(int pxm, int node)
>  {

FWIW,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

