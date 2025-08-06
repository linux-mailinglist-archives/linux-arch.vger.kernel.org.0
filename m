Return-Path: <linux-arch+bounces-13072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A867B1C004
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 07:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B92818397E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 05:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCF1F4C85;
	Wed,  6 Aug 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kW3/uy4g"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B81F09A8;
	Wed,  6 Aug 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458959; cv=none; b=QGkKyds3SL8GHLneKX5ktFDuKEOlEdqSHp7tXpG81/yu1XaDoLu2GNTqABzirhBpJi0vdCVMXzBz/6OZlrI/q5D/38AOb+GA0ITUwWDWY+bf70wiqFjagxRJ9ND1mneyyj3dOorpqowHo9ZWZFgAi0mXWTIL1Mu4civD0ZR00wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458959; c=relaxed/simple;
	bh=4WOcYCIkmSR9nXRqGd43B9VZhrPC4iRxJuZH4l7kAWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pObFgVQh7AwwqxDTWGhaU7quAjMefXSjBt3SXWTzpTZ4FAmLWBmHB77fkuyep8PlTpXXUjmNt10RxSpybfoSlGfLWaOF9vhmTkqtX83xn4H9N5exvxEbAhbDNkClin38Xft5LgxjV3/uioGhctB8bU1x5ECypjKNFPe+F3iAz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kW3/uy4g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD3A7201BC83;
	Tue,  5 Aug 2025 22:42:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD3A7201BC83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754458955;
	bh=Rp4jbB/NMqohWFFzvZoeYY1mcjE/0qmQQfELC7tKuoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kW3/uy4gvLIl7d8YJDD4K9A9qlv410K+hyToHaGX6g+EPbDeYEcACnqCAx4lOmSNL
	 gEM0lMTSsyDLfVVVky1PdCc4Ko0q3OKHHj1WfkXdMrNskOVVAN+/aLFB9jCqwteUmX
	 82PAvmXeJIP47NahDiQrbC1zSSoe7SkzLLligpro=
Message-ID: <83ae59ce-99f9-45b2-b6f8-4b4859b191c2@linux.microsoft.com>
Date: Wed, 6 Aug 2025 11:12:29 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V5 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V
 platform
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 Neeraj.Upadhyay@amd.com, kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804180525.32658-1-ltykernel@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250804180525.32658-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Secure AVIC is a new hardware feature in the AMD64
> architecture to allow SEV-SNP guests to prevent the
> hypervisor from generating unexpected interrupts to
> a vCPU or otherwise violate architectural assumptions
> around APIC behavior.
> 
> Each vCPU has a guest-allocated APIC backing page of
> size 4K, which maintains APIC state for that vCPU.
> APIC backing page's ALLOWED_IRR field indicates the
> interrupt vectors which the guest allows the hypervisor
> to send.
> 
> This patchset is to enable the feature for Hyper-V
> platform. Patch "Drivers: hv: Allow vmbus message
> synic interrupt injected from Hyper-V" is to expose
> new fucntion hv_enable_coco_interrupt() and device
> driver and arch code may update AVIC backing page
> ALLOWED_IRR field to allow Hyper-V inject associated
> vector.
> 
> This patchset is based on the AMD patchset "AMD: Add
> Secure AVIC Guest Support"
> 


NIT:
Generally RFC tag is meant to be used for the patches which are probably 
not ready for merging, and is mostly intended for having a discussion 
around your changes. Since this is now reviewed by multiple people and 
have gone through multiple versions already, if you feel this can be 
merged, you can remove RFC tags in next version, if you are planning to 
send it.

Regards,
Naman


