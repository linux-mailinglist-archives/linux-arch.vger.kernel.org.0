Return-Path: <linux-arch+bounces-8973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DE9C4453
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A9B2A848
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12791A9B3E;
	Mon, 11 Nov 2024 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nejyAANH"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023019F113;
	Mon, 11 Nov 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347773; cv=none; b=CQQ1Aq+hXwnFtO3YrOzz1jOlOWveJdIHj+dcSjvEPfrns9KO1kvouV9ks6d+VGJz+MOHxH2QMddUvDgGqOfmcbW3CwE9DhuN0aMGirRMiu4jnw+vcA8iogB+pO+zpSrGWFYDMYorKV1woffDZC063Xi8BrDsK8FRTkmhkhGlQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347773; c=relaxed/simple;
	bh=UhScj4HpDOH4p4UAdARMSOnIjb6CiQWNTlqjF5ncNO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiA62wTjWsiZ9tA+U0555ZztAcC5wQ8kIo9nOfz0B3LLhYAdlR7F0bfc/MjlXQWlJ/JapgAqjmNpudikhUlNkMxFKT2adJ5Gmt7UjbgX7aSiNWsGdm+1tf/4mLo1+H7eJuLWcqa8hLgsrEcTDCefejmMvZMMfmlrThhAPkPo75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nejyAANH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54F1A2171FA8;
	Mon, 11 Nov 2024 09:56:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54F1A2171FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731347770;
	bh=9vJd/Xt8CL3/r6fhnnHBJNHCUCe8NNZ/NF76sGIG8Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nejyAANH9MJ0obK6mmW65iWVfPeQ6DB9jkiusgAdjWTcADeLJ8qQkOD2WkR7mSn++
	 G8hlwRLrMiApiVnWsLvQi/iqx+8zcBiNOnzc6qA2kGe15l1xQW3qk2fNVMj8W7HBkA
	 P9ROuFGDwmH27ODflklr6wrod7Zn0iL59Y3cBZyo=
Message-ID: <403306e2-bc7a-491c-ab4e-033456a9fbea@linux.microsoft.com>
Date: Mon, 11 Nov 2024 09:55:53 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hyperv: Add new Hyper-V headers in include/hyperv
To: Naman Jain <namjain@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 virtualization@lists.linux.dev
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
 <ef2686dc-ec9e-4efd-9c52-5ba9434b7ce8@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ef2686dc-ec9e-4efd-9c52-5ba9434b7ce8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2024 9:59 PM, Naman Jain wrote:
> 
> 
> On 11/8/2024 4:02 AM, Nuno Das Neves wrote:
>> These headers contain definitions for regular Hyper-V guests (as in
>> hyperv-tlfs.h), as well as interfaces for more privileged guests like
>> Dom0.
>>
>> These files are derived from headers exported from Hyper-V, rather than
>> being derived from the TLFS document. (Although, to preserve
>> compatibility with existing Linux code, some definitions are copied
>> directly from hyperv-tlfs.h too).
>>
>> The new files follow a naming convention according to their original
>> use:
>> - hdk "host development kit"
>> - gdk "guest development kit"
>> With postfix "_mini" implying userspace-only headers, and "_ext" for
>> extended hypercalls.
> 
> Naming convention for mini (which may have come from HyperV code) is a bit odd TBH. May be it has more to it than what is mentioned here or what I know. If more information helps, or this can be changed, please see.
> 

The naming is originally from the Hyper-V code. See below: "The original
names are kept intact primarily to keep the provenance of exactly where
they came from in Hyper-V code, which is helpful for manual maintenance
and extension of these definitions."

>>
>> These names should be considered a rough guide only - since there are
>> many places already where both host and guest code are in the same
>> place, hvhdk.h (which includes everything) can be used most of the time.
>>
>> The original names are kept intact primarily to keep the provenance of
>> exactly where they came from in Hyper-V code, which is helpful for
>> manual maintenance and extension of these definitions. Microsoft
>> maintainers importing new definitions should take care to put them in
>> the right file.
>>
>> Note also that the files contain both arm64 and x86_64 code guarded by
>> \#ifdefs, which is how the definitions originally appear in Hyper-V.
>> Keeping this convention from Hyper-V code is another tactic for
>> simplying the process of importing new definitions.
>>
>> These headers are a step toward importing headers directly from Hyper-V
>> in the future, similar to Xen public files in include/xen/interface/.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> While I understand the motivation behind this series that this is going to ease out the process of updating the header files with respect to HyperV, I think, we will need to pay attention to what we are bringing in with these headers, whether there are any users of it or not, and make sure that TLFS document is updated regularly, to avoid having bunch of code with no information of it.
> The code comments in these files are one step forward towards that.
> And from your cover letter it seems that some changes which actually make use of these additional interfaces are underway, so things will make more sense later. For now, this looks good to me.
> 

Yes, we do need to be careful about what interfaces we add here. Not just
anything can be copied from Hyper-V code into these files. The exact
process is a matter we can discuss internally. But, as you say, there are
upcoming patches (previous versions can be found in the mailing list) which
use the new root partition interfaces.

Updating the TLFS and documenting the interfaces is a different matter.
I can't speak to the best way forward for documenting these, but in many
cases the use of the new interfaces will be self-evident from the code
that uses them, and/or comments as you mentioned.

Over the years many Hyper-V definitions have already been added and used
in Linux which have not been documented in the TLFS or elsewhere. This
patch series makes that fact more obvious and sets us on a path towards a
more maintainable method (i.e., publishing headers directly from the Hyper-V
code, hopefully).

Thanks
Nuno

> > Regards,
> Naman
> 
> <snip>


