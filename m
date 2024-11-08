Return-Path: <linux-arch+bounces-8918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24569C1564
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 05:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4491C20ABE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 04:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4E1C460C;
	Fri,  8 Nov 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q5wLvscP"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F6158DD9;
	Fri,  8 Nov 2024 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039834; cv=none; b=PIus5hrSAXWugpv2fGNUumiyWhdOSvM9eaasDh408LjWyWihn8fDiWTNG1lqg9v6TbppZHAQQzYd86g+/KByMiYL3QQVAsovLnhOTBOxU50PXNpeqbVPF1h1WHxPxoRrLacX9Gy1L1w5aHH1sfbz7xTCnvR58EwF+duIE5lGEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039834; c=relaxed/simple;
	bh=IL+Z1A+RYJKXWgVRSM/zbnEhSrswwv/z7vE6GX/X4C4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PcbqG/vXYkO/XhKgV2QFy44Fb02XU5FrPuOZBfKMlCrLCNP9imtBJ+s75EtbIwHVrDCDDUBfse/zL5CmxlRsBgJeNFgFbQo8m5tjkZ+byjQidG/j7S79xa5rCI118s6lUY29FwoeFjdxYPb9K6zCX4mRfGziIvO9bkNKRjTluMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q5wLvscP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3146E212D516;
	Thu,  7 Nov 2024 20:23:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3146E212D516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731039832;
	bh=A0vEUFyfwb+AHUDrN438og+hVkohgSw0iUoCdoRA1Ko=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Q5wLvscPYwSE2Gv2RNViaS+MQCJVhbLsRYc+QH7A59zAaVXAzXr/CNHosZHtn9oIq
	 ItpyTxzuVdw1CtCC0hgVWJRvWivgrK8UAAjT83gKTtJwz4K7phvj69liK8jbr9hC/M
	 tba1rtqTZHWTlxyISa5uv33pRbr+1jMCNc2u1wGk=
Message-ID: <ff6ac9b5-0903-498c-be2a-2949e9bee8d5@linux.microsoft.com>
Date: Thu, 7 Nov 2024 20:23:51 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH v2 1/4] hyperv: Move hv_connection_id to hyperv-tlfs.h
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1731018746-25914-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2024 2:32 PM, Nuno Das Neves wrote:
> This definition is in the wrong file; it is part of the TLFS doc.
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 9 +++++++++
>  include/linux/hyperv.h            | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

