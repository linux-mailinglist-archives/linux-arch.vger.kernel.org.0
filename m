Return-Path: <linux-arch+bounces-9284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94CE9E66A6
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 06:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA25E282CC1
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 05:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C9195FD5;
	Fri,  6 Dec 2024 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p0sZCFI0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227161925AE;
	Fri,  6 Dec 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462017; cv=none; b=tq4BQiQ25RGPxuG1YtVCRouEPvoB/09sQuwgGj5rd2+K49D2RL+di0fbGUKm38nXi8gHRtdupPvNKfpsQj+/HbWAom//p+3gCUycfdLHYKwVtUrWtBHsXUGhORf6q8TDEsSbtHTReVw5r7w+lF3a0Wob1/FphdFtvZ3LKb0+XYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462017; c=relaxed/simple;
	bh=moyw06gCadeLLR6ekyVEokSeigNLHLuxHOJoCq+LZG8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hhv1DsdmGczoj6Jf+lp2IZ8ibd/3/9F/pRVAPMMmqNE/4hJwmp3xyZXh8yvza/+yQGkgnB4xZCpW4PrC6Iso+2u7n4lRpD1FBlM8Sdcvhh+cqSKKg+z08If+TlklXG5o1p/7vpsBVDmlAVgrU54TM+x5ZPfKXnSJC0u3135C/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p0sZCFI0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.192] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E44620ACD8D;
	Thu,  5 Dec 2024 21:13:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E44620ACD8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733462015;
	bh=SzjW0WRwHutz7m5U6kusET8ShP4S41Chtpc64SA8Q60=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=p0sZCFI0tsDiifhEbWHqn2DoqZJRV/ZUxtoMpWcFIrU0eeD6kg1+0CTUscOkeovcU
	 +0J/3inAHktEmKoVWvAarzPCWSw5DgW9URIIDAJl143QZ5PCfTvu94e7Tp7SETBYEQ
	 ELCm01CjscFtlHT+1/uB9cUpALaaAQ3fJ47XdOIY=
Message-ID: <34cd1209-f9d3-4cdf-b7c1-7028a9abe46c@linux.microsoft.com>
Date: Thu, 5 Dec 2024 21:13:32 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 horms@kernel.org
Subject: Re: [PATCH v3 4/5] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1732577084-2122-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2024 3:24 PM, Nuno Das Neves wrote:
> Switch to using hvhdk.h everywhere in the kernel. This header
> includes all the new Hyper-V headers in include/hyperv, which form a
> superset of the definitions found in hyperv-tlfs.h.
> 
> This makes it easier to add new Hyper-V interfaces without being
> restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).
> 
> To be more consistent with the original Hyper-V code, the names of
> some definitions are changed slightly. Update those where needed.
> 
> Update comments in mshyperv.h files to point to include/hyperv for
> adding new definitions.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c        |  2 +-
>  arch/arm64/hyperv/mshyperv.c       |  4 ++--
>  arch/arm64/include/asm/mshyperv.h  |  7 +++----
>  arch/x86/hyperv/hv_init.c          | 20 ++++++++++----------
>  arch/x86/hyperv/hv_proc.c          |  2 +-
>  arch/x86/hyperv/nested.c           |  2 +-
>  arch/x86/include/asm/kvm_host.h    |  2 +-
>  arch/x86/include/asm/mshyperv.h    |  2 +-
>  arch/x86/include/asm/svm.h         |  2 +-
>  arch/x86/kernel/cpu/mshyperv.c     |  2 +-
>  arch/x86/kvm/vmx/hyperv_evmcs.h    |  2 +-
>  arch/x86/kvm/vmx/vmx_onhyperv.h    |  2 +-
>  drivers/clocksource/hyperv_timer.c |  2 +-
>  drivers/hv/hv_balloon.c            |  4 ++--
>  drivers/hv/hv_common.c             |  2 +-
>  drivers/hv/hv_kvp.c                |  2 +-
>  drivers/hv/hv_snapshot.c           |  2 +-
>  drivers/hv/hyperv_vmbus.h          |  2 +-
>  include/asm-generic/mshyperv.h     |  7 +++----
>  include/clocksource/hyperv_timer.h |  2 +-
>  include/linux/hyperv.h             |  2 +-
>  net/vmw_vsock/hyperv_transport.c   |  6 +++---
>  22 files changed, 39 insertions(+), 41 deletions(-)

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

