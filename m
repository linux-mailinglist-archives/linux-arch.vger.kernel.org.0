Return-Path: <linux-arch+bounces-8920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E639C163F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 07:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E51A1C22C3A
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209501CEEB6;
	Fri,  8 Nov 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GaPry9vZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABA36126;
	Fri,  8 Nov 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045619; cv=none; b=oonvdCLqGUrOeMIGi9ZDJlhdf6ocVxZFLrbdpAogCAZ9i4l4RiXwLFEkVFUK4ndkELMD3sQ2ocKM+rSfaT5C5Jo3BNWnEVVaA/JqTjD0m2aWO74luxTYszvlbQuupJp97vV8X1A/bTqzE+5UiXehwk0ohUD59fupuJGdb9LY8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045619; c=relaxed/simple;
	bh=tlDIU3BOR7aSM8SWyTBM7c5q3bd6KmFhcWps+K5/pgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLxzxBVT76bVv7IycxsvjSUXd6raJe4dNsAjMidCLfoLyRPvu2+PM1rQiWjybgnIbHh/YS7gheyZalkQxlDBKmkPwd2zZAKknmxUBLp088MRVIm8s83KfTsKRq+1J2c4xNgoQqylM/hyT3kPMoEBZ9n0IKHn2xbz1MjV2DAwTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GaPry9vZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.103] (unknown [49.205.249.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47AD6212D516;
	Thu,  7 Nov 2024 22:00:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47AD6212D516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731045617;
	bh=JfGAY+SgJN3XN/2DmcBwbwpAyE9Jg5zKh8nkpRpQOEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GaPry9vZBpJ4Csbyy+XjXwBbb5PXQIRZpl+bL8WerrHnqdLQYdxQhcAh9bNdkoiwM
	 0rtOyqxosSzCXDs5w7d73GHL8PjRX14neKuGkeHWuPXg+GnCsZEBRD6wNTJ4ThdvID
	 VDRS5dHBu8xaBb7Hc7Vqtd1vOwq2eibskIz/48fs=
Message-ID: <ef2686dc-ec9e-4efd-9c52-5ba9434b7ce8@linux.microsoft.com>
Date: Fri, 8 Nov 2024 11:29:58 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hyperv: Add new Hyper-V headers in include/hyperv
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1731018746-25914-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/2024 4:02 AM, Nuno Das Neves wrote:
> These headers contain definitions for regular Hyper-V guests (as in
> hyperv-tlfs.h), as well as interfaces for more privileged guests like
> Dom0.
> 
> These files are derived from headers exported from Hyper-V, rather than
> being derived from the TLFS document. (Although, to preserve
> compatibility with existing Linux code, some definitions are copied
> directly from hyperv-tlfs.h too).
> 
> The new files follow a naming convention according to their original
> use:
> - hdk "host development kit"
> - gdk "guest development kit"
> With postfix "_mini" implying userspace-only headers, and "_ext" for
> extended hypercalls.

Naming convention for mini (which may have come from HyperV code) is a 
bit odd TBH. May be it has more to it than what is mentioned here or 
what I know. If more information helps, or this can be changed, please see.

> 
> These names should be considered a rough guide only - since there are
> many places already where both host and guest code are in the same
> place, hvhdk.h (which includes everything) can be used most of the time.
> 
> The original names are kept intact primarily to keep the provenance of
> exactly where they came from in Hyper-V code, which is helpful for
> manual maintenance and extension of these definitions. Microsoft
> maintainers importing new definitions should take care to put them in
> the right file.
> 
> Note also that the files contain both arm64 and x86_64 code guarded by
> \#ifdefs, which is how the definitions originally appear in Hyper-V.
> Keeping this convention from Hyper-V code is another tactic for
> simplying the process of importing new definitions.
> 
> These headers are a step toward importing headers directly from Hyper-V
> in the future, similar to Xen public files in include/xen/interface/.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

While I understand the motivation behind this series that this is going 
to ease out the process of updating the header files with respect to 
HyperV, I think, we will need to pay attention to what we are bringing 
in with these headers, whether there are any users of it or not, and 
make sure that TLFS document is updated regularly, to avoid having bunch 
of code with no information of it.
The code comments in these files are one step forward towards that.
And from your cover letter it seems that some changes which actually 
make use of these additional interfaces are underway, so things will 
make more sense later. For now, this looks good to me.


Regards,
Naman

<snip>

