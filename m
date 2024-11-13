Return-Path: <linux-arch+bounces-9078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821649C7ECC
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 00:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48FEB23979
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244418C342;
	Wed, 13 Nov 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k8PVw4nb"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B717C;
	Wed, 13 Nov 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540759; cv=none; b=LUZACpPnuG9syEI2s5itnt0XKyP5mzcEBdEFzowj1YdNuVw9Ej4Wj7fjk0929uNp9sX7Br9BjTrE5A6o8j37FAGuPxD7AgSFNDO2R7vnYkmWgH2LGl4GZTsrwzTIv7SqhFAhqcK1hyDdRDbodQ3g+HabXn7nO7lCMZFRcnFewuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540759; c=relaxed/simple;
	bh=BZz8M8dA30sPg7gVl2T2380eKnaxbf2iUQX4W3szZMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfJfgzbsnGx+oQN1vJN1MnP1o2jIfnBqzqJ11nfBOX3GpM5IQe508yzZuUURpyNtxhJbZHMFYjB0IRQn9mVsIGo2hHHClEct/7gXUbve/aIF7Stkp9GCibuiyBr4PlP2WHyjX1Lro/9kyNZM5V1G9xbgIIxqTwsoAKl8f/x8x14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k8PVw4nb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 67C2C20BEBE8;
	Wed, 13 Nov 2024 15:32:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67C2C20BEBE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731540757;
	bh=18HJxeyRm3uSI4Swy2JMMEvrdkL3oWWV9AKPCAM4Vjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k8PVw4nbkREJts0W0LLdSZ42CRybu1r1Xhyg6//i5lh5h22jmKQC5Lcd8aMOB/jYM
	 HLQu6/qNMJUeGZmWA1itysWr/etRtR5KK0CiaR/7bY7XLVFMzfApOBiyev/vQ/vj4+
	 bnJU3aZtjNHiFSBT13DVIlauDGkjJGEyGoyLGSkQ=
Message-ID: <6d2a6bd4-a7cf-4672-9fb0-975acdc8ed31@linux.microsoft.com>
Date: Wed, 13 Nov 2024 15:32:32 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hyperv: Add new Hyper-V headers in include/hyperv
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-4-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB4148025D8757B917013297E0D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <b8ef1f71-9f13-48c3-adab-aa52b68d2e33@linux.microsoft.com>
 <SN6PR02MB4157AA30A9F27ECCAE202BC2D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157AA30A9F27ECCAE202BC2D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2024 11:31 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, November 11, 2024 10:45 AM
>>
>> On 11/10/2024 8:13 PM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday,
>> November 7, 2024 2:32 PM
>>>>
>>>> These headers contain definitions for regular Hyper-V guests (as in
>>>> hyperv-tlfs.h), as well as interfaces for more privileged guests like
>>>> Dom0.
>>>
>>> See my comment on Patch 0/4 about use of "dom0" terminology.
>>>
>>
>> Thanks, noted.
>>
>>>>
>>>> These files are derived from headers exported from Hyper-V, rather than
>>>> being derived from the TLFS document. (Although, to preserve
>>>> compatibility with existing Linux code, some definitions are copied
>>>> directly from hyperv-tlfs.h too).
>>>>
>>>> The new files follow a naming convention according to their original
>>>> use:
>>>> - hdk "host development kit"
>>>> - gdk "guest development kit"
>>>> With postfix "_mini" implying userspace-only headers, and "_ext" for
>>>> extended hypercalls.
>>>>
>>>> These names should be considered a rough guide only - since there are
>>>> many places already where both host and guest code are in the same
>>>> place, hvhdk.h (which includes everything) can be used most of the time.
>>>
>>> Just curious -- are there really cases where hvhdk.h can't be used?
>>> If so, could you summarize why?
>>>
>>
>> No, there aren't cases where it "can't" be used. I suppose if someone
>> doesn't want to include everything, perhaps they could just include
>> hvgdk.h, for example. It doesn't really matter though.
>>
>>> I ask because it would be nice to expand slightly on your paragraph
>>> below, as follows:  (if indeed what I've added is correct)
>>>
>>> The use of multiple files and their original names is primarily to
>>> keep the provenance of exactly where they came from in Hyper-V
>>> code, which is helpful for manual maintenance and extension
>>> of these definitions. Microsoft maintainers importing new definitions
>>> should take care to put them in the right file. However, Linux kernel code
>>> that uses any of the definitions need not be aware of the multiple files
>>> or assign any meaning to the new names. Linux kernel uses should
>>> always just include hvhdk.h
>>>
>>
>> Thanks, I think that additional sentence helps clarify things. I'll
>> include it in the next version, and I think I can probably omit the prior
>> paragraph: "These names should be considered a rough guide only...".
>>
> 
> Omitting that prior paragraph is OK with me.  The key thoughts from my
> standpoint are:
> * The separation into multiple files and the file names come from
>    the Windows Hyper-V world and are maintained to ease bringing
>    the definitions over from that world
>    
> * Linux code can ignore the multiple files and their names. Just
>    #include hvhdk.h.
> 

Agreed, thanks for helping clarify the points.

>>>>
>>>> The original names are kept intact primarily to keep the provenance of
>>>> exactly where they came from in Hyper-V code, which is helpful for
>>>> manual maintenance and extension of these definitions. Microsoft
>>>> maintainers importing new definitions should take care to put them in
>>>> the right file.
>>>>
>>>> Note also that the files contain both arm64 and x86_64 code guarded by
>>>> \#ifdefs, which is how the definitions originally appear in Hyper-V.
>>>
>>> Spurious backslash?
>>>
>>
>> Indeed, thanks.
>>
>>> I would suggest some additional clarification:  The #ifdef guards are
>>> employed minimally where necessary to prevent conflicts due to
>>> different definitions for the same thing on x86_64 and arm64. Where
>>> there are no conflicts, the union of x86_64 definitions and arm64
>>> definitions is visible when building for either architecture. In other
>>> words, not all definitions specific to x86_64 are protected by #ifdef
>>> x86_64. Such unprotected definitions may be visible when building
>>> for arm64. And vice versa.
>>>
>>
>> Is there a reason you specifically want to point out that "Such
>> unprotected definitions may be visible when building for arm64. And vice
>> versa."? I think, in all the cases where #ifdefs are not used, an
>> arch-specific prefix is used - hv_x64_ or hv_arm64_.
>>
>> The main thing I wanted to call out here was the reasoning for not
>> splitting arch-specific definitions into separate files in arch/x86/
>> and arch/arm64/ as is typical in Linux.
>>
>> Maybe this is a bit clearer:
>> "
>> Note the new headers contain both arm64 and x86_64 definitions. Some are
>> guarded by #ifdefs, and some are instead prefixed with the architecture,
>> e.g. hv_x64_*. These conventions are kept from Hyper-V code as another
>> tactic to simplify the process of importing and maintaining the
>> definitions, rather than splitting them up into their own files in
>> arch/x86/ and arch/arm64/.
>> "
> 
> Yes, your new paragraph works for me. Your original statement was
> "the files contain both arm64 and x86_64 code guarded by #ifdefs",
> which sounds like the more typical Linux approach of using #ifdefs
> to segregate into x86-specific, arm64-specific, and common. I was
> just trying to be explicit that full segregation isn't done, and isn't a
> goal, because of wanting to maintain alignment with the original
> Hyper-V definitions.
> 
> It's "Hey, we know we're not handling this in the typical Linux way,
> and here's why". Your revised paragraph covers that in a less
> heavyweight way than what I wrote. :-)
> 

Ok, great. I'll use that for the next version then.

Thanks again!
Nuno

> Michael
> 
>>
>> I hope it's reasonably clear that it's a good tradeoff to go against
>> Linux convention in this case, to make it easy to import and maintain
>> Hyper-V definitions.
>>
>> Thanks
>> Nuno
>>


