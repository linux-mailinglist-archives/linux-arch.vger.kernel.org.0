Return-Path: <linux-arch+bounces-11492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35CFA959C6
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 01:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012F416FE93
	for <lists+linux-arch@lfdr.de>; Mon, 21 Apr 2025 23:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23922ACCA;
	Mon, 21 Apr 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CRuJz68c"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D829224252;
	Mon, 21 Apr 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745278063; cv=none; b=pYZZGW43fdq3mO6q8l5DnUg/kWnDzGX/SAPkqgD1HZn2wZfrRTAxJov0DlKVMwKFOiuilmAPjRMT3qEzDunb+B9x6jx9TMtdx9Z2HxP0z/MRfBVAmQbJzl10Gedu8NVVjZ//tfRmEG1PBkhwjUk2pJCDaei3k+8qIMrLR4LAd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745278063; c=relaxed/simple;
	bh=plS0dj7xUaRPgtvF1xd9b6EwHUtv+3iwNa8IBnlG1Uo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZyByOMt9chhsuXDozEqskyOw3sYtETHViwo0P63BfgNd1R8pptTqRjIvHH+bxmmDbROSnDt6a/rV7odcZmBrTjhObReHujRnS5VZyz8JcgKk0KnoorvsbpcShYc36cyBQDs4yLAr1NHe4oFjmYbdZnjyO9pTTyFbzIdx6IHX3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CRuJz68c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.83] (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F082203B86E;
	Mon, 21 Apr 2025 16:27:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F082203B86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745278061;
	bh=rgCwyON/e1COr+m3vQYBYaC1jT0qx4BriodovWWJ2oM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CRuJz68c0/VQgI89fv0oIv2W1+wJ6nbRbkUekWMt/Ew3z5Wji+LLNADl8AGPl9Hgj
	 z2tW+nHV3yRZuoNrIOJWIrRIEuhgCsNwONreCFWQWOGgaZpeQYTAW+pUR10uTUHWjt
	 ehWsanjMICKHh2ULuzsHzwkly+e6YlVc9Duc81ME=
Message-ID: <1643d6a8-7d4f-4d6e-aeab-f43963644a1f@linux.microsoft.com>
Date: Mon, 21 Apr 2025 16:27:40 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
To: Michael Kelley <mhklinux@outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f2ccf839-1ce3-4827-997e-809ec9d3b021@linux.microsoft.com>
 <SN6PR02MB4157FEE08571B84B6CEBFC92D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157FEE08571B84B6CEBFC92D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/2025 2:24 PM, Michael Kelley wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Monday, April 21, 2025 1:41 PM
>>>

<snip>

>>>
>>
>> This is very cool, thanks for taking the time! I think the function naming
>> could be more intuitive, e.g. hv_setup_*_args(). I'd not block it for that reason,
>> but would be super happy if you would update it. What do you think?
>>
> 
> I'm not particularly enamored with my naming scheme, but it was the
> best I could come up with. My criteria were:
> 
> * Keep the length reasonably short to not make line length problems
>    any worse
> * Distinguish the input args only, input & output args, and array versions

I think the in/inout/array scheme you have does this nicely

> * Use the standard "hv_" prefix for Hyper-V related code
> 
> Using "setup" instead of "hvcall" seems like an improvement to me, and
> it is 1 character shorter.  The "hv" prefix would be there, but they wouldn't
> refer specifically to hypercalls. I would not add "_args" on the end because
> that's another 5 characters in length. So we would have:
> 
> * hv_setup_in()
> * hv_setup_inout()
> * hv_setup_in_array()
> * hv_setup_inout_array()
> * hv_setup_in_batch_size() [??]
> 
> Or maybe, something like this, or similar, which picks up the "args" string,
> but not "setup":
> 
> * hv_hcargs_in()
> * hv_hcargs_inout()
> * hv_hcargs_in_array()
> * hv_hcargs_inout_array()
> * hv_hcargs_in_batch_size() [??]
> 
> I'm very open to any other ideas because I'm not particularly
> happy with the hv_hvcall_* approach.

Between the two presented here, I prefer option 1, with the "setup" verb because it tells you
inline what the function will do. I agree that the "args" is unnecessary because most
hypercall args are named hv_{input, output}_* and are clearly arguments to hv_do_hypercall()
and friends.

Since hv_setup*() will normally be followed shortly after by hv_do_hypercall(), I don't
see a problem with not referring specifically to hypercalls, it should be clear in context.

For hv_hvcall_in_batch_size(), I think it serves a fundamentally different function than the
other wrappers and doesn't need to follow the "setup" pattern. Instead it could be named 
hv_get_input_batch_size() for the same length and similarly tell you its purpose inline.

I am continuing to review the rest of the series, sorry for the delay, and thank you for your
patience!

Thanks,
Easwar (he/him)

