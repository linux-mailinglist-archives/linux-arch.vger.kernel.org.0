Return-Path: <linux-arch+bounces-10432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3EA48739
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 19:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110FC188F11F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0201DE3B7;
	Thu, 27 Feb 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N5VvgVEs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D5199239;
	Thu, 27 Feb 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679444; cv=none; b=ALx+SALiKdHP5z3UDPDd7OjKtl4YAPM7HV2vHSaSmhHFPUiZljKOQIdr006bLjB90icJUlwHwKJ9wSf8yAp6zD3OlIjB0oIR6JicBLFnw9CTJkbg5vY/46Cvklv84qhatTDHCU20r88GmVzPtFjNLOZBjEWfyd4FlcO9ulLDKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679444; c=relaxed/simple;
	bh=ciJup7cZueX6EC7ctgREtCOeyD2wN6nXSOjZPLTfd6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3jFtya+YTyFxzmUp+9FKQc9ruUaZo0lJpUv9ZkdO22p58+bOLNPnTy3JRJkIneoI5pt3plg55A0miCcpXWbmnKsPUqXTvZ0r0CR04PukJEZ7vAh9tUJ6Mm/9g72J50tQDW1kWlWoroCik8VaP4dOZHrrK96ywXDciSw2xDGwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N5VvgVEs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 27A08203CDDF;
	Thu, 27 Feb 2025 10:04:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27A08203CDDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740679442;
	bh=9WmrN/v2+Jcmkh5sQdGcBhvL2d/KHxE/UQ/g9aHN8DI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N5VvgVEsfE4dRxu8kRxiR0V/M9q3QjZkP8lMR4Ee4SnaCJNHwkBXj0BgReU3YSLLc
	 VpUY+Yt/Lad7/yL/DRqkvYbyAdqiUmo9r87P6poD3f4Xq8RzJOzdYxaJr8yuDgtMXM
	 bTEJnvxkpawu/jAPsWJnSEv3h2LGrj3nZ47mbceI=
Message-ID: <f509907e-019b-4d16-a0d4-1a5acfe8592e@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:04:01 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> Factor out the check for enabling auto eoi, to be reused in root
> partition code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

I think adding "No functional changes" would bring some benefit:
that's an additional invariant to check against when reviewing.

-- 
Thank you,
Roman


