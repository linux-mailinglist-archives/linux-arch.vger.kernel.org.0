Return-Path: <linux-arch+bounces-8737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145119B830B
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 20:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B6B20C1E
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B21C9DFC;
	Thu, 31 Oct 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hpo6SU0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738980BF8;
	Thu, 31 Oct 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401544; cv=none; b=cy2mElxQsX1gBOfnOS9D4DD9Gzh2MX5rcvYoahRVUbQEVILv07QquuvqIhoSOoQdiBhY3xz+fD7vrn7/c6BAf3GKMvqyn6Ee9CTl5zw4a9NJJ0S8rySzjTLaCVv0xHRPlTwppN01mTug95spUMCwplXqhbuFLD0djathUajb7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401544; c=relaxed/simple;
	bh=zUCcq0xYQ2KKg0AT6UPYv9J6GsZf4ooeo11L3JZIdKE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F0OOs7WmQ5t0ngfo0gbHUOx9YB0YDEEwS4g/6jUID/s8bVuYTymdcJJNKWvyxV81FoOQeCuwaffhJv0mvKwX9WPVoMJJiM4mgGCo55nTx15j97Hd6tMzbrcSAPcKPVDPeg2lh/GtMdB2eJISyyQVIzF7YLpXK37BDY7dCF2XzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hpo6SU0a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88002206941B;
	Thu, 31 Oct 2024 12:05:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88002206941B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730401542;
	bh=cN8Xg10U0hJwzdbYn0VLyyefwmZ46aiJ79KkG/dl5eA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=hpo6SU0afc10BLlq+7xOtaqNTlNryyZQ1hVTr2+F0JZkMwx6tqTL8xrReF0N6K2rS
	 vHSMJHOSxp9ExDGq/GZb95dKbKIUW276jmEdymGvMLyCodqFAUiZhHl17EitlPUL5+
	 XN7PgRReK+aW6PF7Bcp7ugC2kCaxM5XtYbtJB7r4=
Message-ID: <fc47d535-ed52-4ca5-80cc-30003efdd464@linux.microsoft.com>
Date: Thu, 31 Oct 2024 12:05:39 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 0/5] Add new headers for Hyper-V Dom0
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 tyhicks@linux.microsoft.com
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/2024 12:50 PM, Nuno Das Neves wrote:
> To support Hyper-V Dom0 (aka Linux as root partition), many new
> definitions are required.
> 
> The plan going forward is to directly import headers from
> Hyper-V. This is a more maintainable way to import definitions
> rather than via the TLFS doc. This patch series introduces
> new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
> derived from Hyper-V code.
> 
> This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
> in Microsoft-maintained Hyper-V code where they are needed. This
> leaves the existing hyperv-tlfs.h in use elsewhere - notably for
> Hyper-V enlightenments on KVM guests.
> 
> An intermediary header "hv_defs.h" is introduced to conditionally
> include either hyperv-tlfs.h or hvhdk.h. This is required because
> several headers which today include hyperv-tlfs.h, are shared
> between Hyper-V and KVM code (e.g. mshyperv.h).
> 
> Summary:
> Patch 1-2: Cleanup patches
> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
> Patch 4: Add hv_defs.h and use it in mshyperv.h, svm.h,
>          hyperv_timer.h
> Patch 5: Switch to the new headers, only in Hyper-V code
> 
> Nuno Das Neves (5):
>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>   hyperv: Remove unnecessary #includes
>   hyperv: Add new Hyper-V headers
>   hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or
>     hvhdk.h
>   hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
>

What is the model for Hyper-V code that has both guest and host roles
where the corresponding hypercalls are available for both? As I
understand it, those are supposed to be in hvgdk*.h.

For a specific example, IOMMU hypercalls can operate on stage 2 or stage
1 translations depending on the role of the (hyper) caller and the input
values provided. Should a driver using these hypercalls import both
hvhdk* and hvgdk*? What about hyperv-tlfs?

Patches 4 and 5 seem to draw a bright line between host and guest roles
while the reality is more gray. Please do correct me if I'm wrong here,
perhaps the picture would be clearer if Stas' suggestion of a new header
file is implemented.

Thanks,
Easwar

