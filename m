Return-Path: <linux-arch+bounces-7712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EE991363
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEBBEB2270A
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1177F6;
	Sat,  5 Oct 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QwXm5TQI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC64C9F;
	Sat,  5 Oct 2024 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086880; cv=none; b=RFwVyn2+p2RSv3lZ/+NiQ7AKwKMnYoytW9G46KnB9jCdDbNTrSRq1ZemoM+LxP5a/FKr+kyOWHJML9s0MVu4oFDM6jIHQfGs91alfHQwbyS2f/LTGSDcLT2h766z5SmsCP4zuD9Qxb+qErqoMmNX4DkxFrcCD1he//KJ7/8OXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086880; c=relaxed/simple;
	bh=+MfI7OYcWAd2dMDXZEx5YG70J88IUHYEYwpDpb4OTfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOUs5mkGm58iKzfJ322IAndukiF9r2Dgvg/1GJcvuzRq30r5onNK2jH0Vq7O9MqWTH15ed1IrWlT5UsRq7QWLM0UKp3SmoSm3DRWQLaHKTTzBMLwElmXUhqoBSw8AqVqVral3ujQO0UJ51kATM05QGc6lvmoYAEKdp0uE8mJHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QwXm5TQI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6066F20DB37A;
	Fri,  4 Oct 2024 17:07:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6066F20DB37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728086878;
	bh=LBnzr8OIIg6knuVrAj3ZPsyJbh5bMJgu1ZuS7jAuHyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QwXm5TQI+PpevcOJwLiQCmf2iHFL2kqrYd0jPp70SOf4xm+OCFOAqJbgR3wBT8CJp
	 R/gJF6q6xzALLspZdmutH4Q3khZWgia3ohn/0g5Qh3Q/lC0UNfd1K1IdM1Y6f4Suuk
	 LDBu/TrXOY7jsq6vFSeig5g6GL1r0TQ5r0DbxDSU=
Message-ID: <3b2e7170-1229-4981-8905-02b16bd2a85d@linux.microsoft.com>
Date: Fri, 4 Oct 2024 17:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 mukeshrathor@microsoft.com
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
 <20241004155810.GA15304@skinsburskii.>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20241004155810.GA15304@skinsburskii.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/2024 8:58 AM, Stanislav Kinsburskii wrote:
> Hi Nuno,
> 
> On Thu, Oct 03, 2024 at 12:51:04PM -0700, Nuno Das Neves wrote:
>> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
>> index 9d1969b875e9..bb7f28f74bf4 100644
>> --- a/arch/arm64/hyperv/hv_core.c
>> +++ b/arch/arm64/hyperv/hv_core.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/arm-smccc.h>
>>  #include <linux/module.h>
>>  #include <asm-generic/bug.h>
>> +#define HYPERV_NONTLFS_HEADERS
>>  #include <asm/mshyperv.h>
>>  
> 
> Perhaps it would be cleaner to introduce a new header file to be
> included, containing the new define and including <asm/mshyperv.h> instead.
> 
> Stas

If I understand correctly, you're suggesting adding another stub named e.g.
"hv_mshyperv.h", containing:

#define HYPERV_NONTLFS_HEADERS
#include<asm/mshyperv.h>

Then in the roughly 24 places in this patch where we have:

+#define HYPERV_NONTLFS_HEADERS

Instead, we'd have:

-#include <asm/mshyperv.h>
+#include <hyperv/hv_mshyperv.h>

I suppose the current version is a bit opaque - it's not immediately clear
why HYPERV_NONTLFs_HEADERS is defined, and that it must be defined before
including asm/mshyperv.h - someone reading the code would have to go find
hv_defs.h to puzzle that out.

This improves the situation slightly by associating the #define with
asm/mshyperv.h. I'll consider it for v2, thanks!

Nuno

