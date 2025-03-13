Return-Path: <linux-arch+bounces-10750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB223A5FFE5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDED7ACA95
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6C1D63D5;
	Thu, 13 Mar 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c029q20h"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C968D1DDC23;
	Thu, 13 Mar 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891621; cv=none; b=oMmTayKdTDJdHloUjobSKFk7h5cVSUhTHL8K6fAWrL6vcJZfWSRJLS9xxXLHeKeQb2EXIBKh7VbhVMdGiRxzZlzurmIlH33KK81zh5u7AMRq09pCQgV7abrnbl/wZsLtoOdyLz39xdyIOAcIobZm0lDeOng3FJWrC5GcERh5SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891621; c=relaxed/simple;
	bh=0pcwQ9vLas23Kk5/y+wVBp5txvPs/bUozChqyYxLVOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6pReY6t3Bp8Rctmf6xFrD2hI9Xniki3bTvcYbb9Oj1c0ztKzzfI+6l2wol+nCJCIlbkBQ2aEcik1sQFwt75DhDG5wbqwtSizM2ue0Ht680MNevAMip+Z5jiSZ8w0XpGPtx9NmdWFxFCoVeyzdxmILTftCcka4Kgq8JtSweWrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c029q20h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE024203342A;
	Thu, 13 Mar 2025 11:46:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE024203342A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741891619;
	bh=nt8jkVfaRzuUqauG7agUplFqSQ7P9hL/iQtfhXt7daM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c029q20hO7p9pMytBoFbb4lvO9ZDTqP8ojMLWrK9hbwLYNc57V4N0Aa6gWzzJFcHr
	 esb6o3L0vE8YHyp+7RG+sJdxsuqky6Zy4qUPq4udmjKBOq899yOQu3eWe+Mhi7Jmax
	 CS5/4KC7mWI6F/acsg68bV6b8QdxWShafCvHoxSA=
Message-ID: <81612b52-a47b-4d9c-9d50-c74ad66286d9@linux.microsoft.com>
Date: Thu, 13 Mar 2025 11:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 08/11] Drivers: hv: vmbus: Get the IRQ
 number from DeviceTree
To: Rob Herring <robh@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, ssengar@linux.microsoft.com,
 sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-9-romank@linux.microsoft.com>
 <CAL_JsqLmS4EEoPkOmaH6F_0XtQu5wkM-WEfxFvjLA=bJroEUVw@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAL_JsqLmS4EEoPkOmaH6F_0XtQu5wkM-WEfxFvjLA=bJroEUVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/13/2025 11:44 AM, Rob Herring wrote:
> On Fri, Mar 7, 2025 at 4:03 PM Roman Kisel <romank@linux.microsoft.com> wrote:

[...]

>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq == 0) {
>> +               pr_err("VMBus interrupt mapping failure\n");
>> +               return -EINVAL;
>> +       }
>> +       if (irq < 0) {
>> +               pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
>> +               return irq;
>> +       }
> 
> I don't think why you couldn't get the interrupt is important. Just
> check for (irq <= 0) and be done with it. I'm not even sure if
> returning 0 is possible now. There's a long history to that and
> NO_IRQ.
> 

That will certainly make the code look much better!
Thank you very much for the idea!

> Rob

-- 
Thank you,
Roman


