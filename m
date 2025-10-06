Return-Path: <linux-arch+bounces-13934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FABBEF94
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D5E4F4657
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 18:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314442D6E77;
	Mon,  6 Oct 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aFf4iSCN"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B671D618C;
	Mon,  6 Oct 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775442; cv=none; b=VXdyu1IiwTS+nm0GlhyuWcwPeqtjLK9lYhewZbw7ze5dqcCUGW1LkeSgfW4OC4a7Z93lCb3j7t4NQH5iekigv9Kw4LPqhKcVSvhEUgboVFPMRs9kGjXx6itse9fnaLGa7eSHOBrPErvVKb5psv2YQT5Vp/mwov4Qf4lJ6GlPfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775442; c=relaxed/simple;
	bh=iUCByOCa4O0HN9ykRHF9A6sRhtXzXxF8NdZt7hDemZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7oMe5DOrW1izZKiQoiFvL+CFeZvazEhTVEpwQ8RZZRalW2mabSTJj4qcSKfoYzvBKtgqfkk/61unuAQooiaR7Mg672PTsFMFWyf5AN2cn1xwXjZUFAItk1RjCQrSLXyLv26TaVnaMi7XorK6TSVJjFopRji7Ju6XDfrZuiOu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aFf4iSCN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0D97211CDEF;
	Mon,  6 Oct 2025 11:30:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0D97211CDEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759775440;
	bh=cyxIx+MJtrd6uNL71MuB7b1PPIy+SoA2XMGIG2qal7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aFf4iSCNj2NMfgURX6QLKtEU8RIrB9LGM1bU4rzVOPieXcWuZm3GScH0g+exvsvJ9
	 wZNdVSY6qiBOsLYigB9SXJZpPM74lauBNchPeOlQp/bC+7GQHTkt+vs6rGmqRnseuX
	 eN+EuQ36+nsqr4JLccXFNKOJXDWHtJ7wVh5OX384=
Message-ID: <6a8176dd-ffa7-4ec1-a373-6ab61abd962e@linux.microsoft.com>
Date: Mon, 6 Oct 2025 11:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 05/17] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
To: Michael Kelley <mhklinux@outlook.com>
Cc: "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
 "corbet@lwn.net" <corbet@lwn.net>,
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
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-6-romank@linux.microsoft.com>
 <SN6PR02MB41571BD37714C5F0AB770CB5D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571BD37714C5F0AB770CB5D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/2025 9:55 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, October 3, 2025 3:27 PM

[...]

>> +/*
>> + * When running with the paravisor, controls proxying the synthetic interrupts
>> + * from the host
>> + */
>> +static bool hv_para_sint_proxy;
> 
> This needs to move down a few lines and be under the #if IS_ENABLED(CONFIG_HYPERV)
> in order to eliminate the "unused variable" warning reported by the kernel test robot.

Thanks, Michael, will do!

[...]
-- 
Thank you,
Roman


