Return-Path: <linux-arch+bounces-13935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C4BBF0AB
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A213B342C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660422A4E9;
	Mon,  6 Oct 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GHrYyZ0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BDD2D29C8;
	Mon,  6 Oct 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777099; cv=none; b=BnTbVbO/cQ9hXF08rtJIqBfnFUQRAlPTyyZrtf0OYhB5nHUTAMiqmNM0AyPUOUvxJe76KlwGfwU2vN8nRzRjWJsp86ehIIuAPtWy0y06pX0GF6cQTlHZ+08seGP8+PEn5wpvIzxDhSOWrvT5Dbj2IvJekL1VlG4KCHMnodIskWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777099; c=relaxed/simple;
	bh=ADpUC5a/KbGr9ijN/AYgIQQjKvQHxqzoQFuxlJkwsY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8n1m/pEXiQ4rL6dI7CQzTbwxrlDseZFCN1IvY+B2eEaPf+P4RVCT8W14PBm9+m4RqG2n1rWsi4VrTR+CgsRnwEiGN48vy8o405Rf+8y26zE939nSc7dBS1Ij+oXVySMaB+thqoUXsf1FTaqm0rXtbAUuUnlmi45Q2NtAZRjP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GHrYyZ0a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3794B2117F86;
	Mon,  6 Oct 2025 11:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3794B2117F86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759777097;
	bh=CG4uNAr7eRV79CEdokFEBr+fu5qn0tGaU9OYH2B1EFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GHrYyZ0acgVf/vYwMfmEjWbvU6Q5eb0OAWGGV8X/ezTDgfVQoa79WAJ9rAR1UYHbW
	 Lb4eh5TWutTsNpaMES6jvLQmr9iBdPVeV4UDb6k4MCwcbc7p9/UGbmbZg0peHlQesX
	 /Vbso1ntAltNROqKYB4I9iEgSN52ujV/nSrFta9k=
Message-ID: <93371148-87c3-4429-a9de-4115e10cda1f@linux.microsoft.com>
Date: Mon, 6 Oct 2025 11:58:16 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 00/17] Confidential VMBus
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <SN6PR02MB415707D796045E8BD30396D8D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415707D796045E8BD30396D8D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/2025 9:55 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, October 3, 2025 3:27 PM

[...]

>>   include/linux/hyperv.h             |  69 ++++--
>>   15 files changed, 793 insertions(+), 306 deletions(-)
>>
> 
> Nice! The net lines of code added is now 487, vs. 591
> lines added in v5 of this series.
> 

Thanks, I appreciate your help throughout the multiple versions very
much!!

> Modulo the contradiction above in this cover letter, the two typos in
> the documentation in Patch 1, and the simple fix for the error reported
> by the kernel test robot for Patch 5, I'm happy with this entire series.

I'll wait few days just in case and will send out the fixed series :)

> For the series,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

-- 
Thank you,
Roman


