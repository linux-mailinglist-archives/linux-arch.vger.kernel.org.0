Return-Path: <linux-arch+bounces-9326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5549E9F49
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 20:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D91882493
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BC19343B;
	Mon,  9 Dec 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X79ao65h"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42758198A07;
	Mon,  9 Dec 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771967; cv=none; b=Zr/XsA8vC6QbneyJl5VmqL68xya4RL/YR/CnZ+CrpzIt2LPzRAm8VQssV+XWly+o19A9cRQjaUqpUdpPvhyrVpfUMIzrzQddTNTZUgvvoFO5mSQawsP1FQBoG1HmDMLDBduMpgOaCtX/a9f0LaYa/KW2jTgPgcXGr7av6bFbv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771967; c=relaxed/simple;
	bh=IkU30lh01yasDhhYl5DIZiX1actBPTKkOI868W5M7jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vs9deMVgYJxxWDIa/0JljpgAlf5mwG0dkgF6z6Z0fhwZLjfXW5qTWDROOFqibZ8m6sD7JvO/BS7gNpghA1SMPblx5YTy6ESiQBokFjiLH8FItg9mT55pjrcjx/cfePutzmzkAVWziiFSTdk8WKmdOq4JoFujQvCuegyxBd1uAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X79ao65h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id A64AF211F951;
	Mon,  9 Dec 2024 11:19:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A64AF211F951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733771964;
	bh=aNTJR2KnZDmn2B9w7QnkiUuDqNvJl6jmEMliRyXtV4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X79ao65h/u13GLNKxSqyMJ9uUvtBpp3rw2v4gWdlaDngbyQZXN55Xh0ffA4IZXRhV
	 QT6eYndeymBwoYWDgPYJwOjTDoq9oNVdrDHwkzAldgCCnjvKQkd2EPP2EZ64G6LAZ0
	 D3aklNFCdRwoxFPP+bj7TYr2I59tP+ffoezRugPw=
Message-ID: <a76d129c-2956-4bbc-bd14-cb12737b64df@linux.microsoft.com>
Date: Mon, 9 Dec 2024 11:19:23 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hyperv: Move hv_connection_id to hyperv-tlfs.h
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 kys@microsoft.com, haiyangz@microsoft.com, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 eahariha@linux.microsoft.com, horms@kernel.org
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-2-git-send-email-nunodasneves@linux.microsoft.com>
 <Z1Y0uJlVn-86KHE8@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Z1Y0uJlVn-86KHE8@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/2024 4:07 PM, Wei Liu wrote:
> On Mon, Nov 25, 2024 at 03:24:40PM -0800, Nuno Das Neves wrote:
>> This definition is in the wrong file; it is part of the TLFS doc.
>>
>> Acked-by: Wei Liu <wei.liu@kernel.org>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> One comment about the ordering of the tags. It is better to organize
> them in the following order:
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> I've made the change for you while applying the patch.
> 

Thank you, noted for next time.

> Thanks,
> Wei.


