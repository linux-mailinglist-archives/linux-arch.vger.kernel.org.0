Return-Path: <linux-arch+bounces-10271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783AA3E7D7
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 23:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAA19C4D37
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D21264F81;
	Thu, 20 Feb 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q2GieosC"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B21EE00D;
	Thu, 20 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092216; cv=none; b=kCq9QrfVyGizHY6a55vhhQ9Z3yDZYjr2b1ud2L0Apd8P11y8QRSrxX7DtlCb2HMvzfjww3NEGLZmtTSx/VtaB2taRxXyIzmHPA9LNnx6ELFJS5XPCNyAceBtC+q7unw7o68MEEdDZl1BHZhUCcuF0hxAz+y7/SLyw4byWqnsmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092216; c=relaxed/simple;
	bh=jNbotbdljxASTCIceywi5vZ2u+PemybdGK21+XfLCm8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=onjG/a2glRwjWzLVpl+yX99MVU7YFJ8Jx0f4ZIp1jjJt+vzHjCj4w5i99Iv9kH8MKej4jm9ThYgee6xnOnJWyXkovvmj+HAcFKJCRlP1gxhIfdtOTj4/w74gWsGXiOuHlo/ZDxFGlwVKc7xJg60+losA/SCh+v7n608XYx1kj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q2GieosC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id B124E203E3BD;
	Thu, 20 Feb 2025 14:56:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B124E203E3BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740092214;
	bh=KlJ9o1tnOHtBaPAGwZpy5EIMcQfR5rWT7Vt3LiKDITw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Q2GieosC+3/oYYgrljt3B37PLvNhNYiMztvtqhlGOuRpi5Ru0KepULlpYPCdIUW+t
	 5+e1L9PeqJP6iAnpVjrYeNs22r1EIpjq34qfQXy5dNzHcjFJ1gIUWCrudkgl2ADUkN
	 Sat9JveKOeA4IyootCFsExr2mHOcF/a2WPNi4XKY=
Message-ID: <a29af204-e4a9-4ef2-b5b8-f99f2ac0a836@linux.microsoft.com>
Date: Thu, 20 Feb 2025 14:56:53 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>, eahariha@linux.microsoft.com,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
To: MUKESH RATHOR <mukeshrathor@microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
 <5980eaf9-2e77-d0ec-e39b-b48913c8b72f@microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <5980eaf9-2e77-d0ec-e39b-b48913c8b72f@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 1:59 PM, MUKESH RATHOR wrote:
> 
> 
> On 2/20/25 10:33, Nuno Das Neves wrote:
>  > Introduce hv_current_partition_type to store the partition type
>  > as an enum.
>  >
>  > Right now this is limited to guest or root partition, but there will
>  > be other kinds in future and the enum is easily extensible.
>  >
>  > Set up hv_current_partition_type early in Hyper-V initialization with
>  > hv_identify_partition_type(). hv_root_partition() just queries this
>  > value, and shouldn't be called before that.
>  >
>  > Making this check into a function sets the stage for adding a config
>  > option to gate the compilation of root partition code. In particular,
>  > hv_root_partition() can be stubbed out always be false if root
>  > partition support isn't desired.
>  >
>  > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>  > ---
>  >   arch/arm64/hyperv/mshyperv.c       |  2 ++
>  >   arch/x86/hyperv/hv_init.c          | 10 ++++-----
>  >   arch/x86/kernel/cpu/mshyperv.c     | 24 ++------------------
>  >   drivers/clocksource/hyperv_timer.c |  4 ++--
>  >   drivers/hv/hv.c                    | 10 ++++-----
>  >   drivers/hv/hv_common.c             | 35 +++++++++++++++++++++++++-----
>  >   drivers/hv/vmbus_drv.c             |  2 +-
>  >   drivers/iommu/hyperv-iommu.c       |  4 ++--
>  >   include/asm-generic/mshyperv.h     | 15 +++++++++++--
>  >   9 files changed, 61 insertions(+), 45 deletions(-)
>  >

<snip>

>  > @@ -34,8 +34,11 @@
>  >   u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>  >   EXPORT_SYMBOL_GPL(hv_current_partition_id);
>  >
>  > +enum hv_partition_type hv_current_partition_type;
>  > +EXPORT_SYMBOL_GPL(hv_current_partition_type);
>  > +
> 
> nit: if possible and not too late, can we please use more Unix
> style naming, eg, hv_curr_ptid and hv_curr_pt_type rather than this
> long windows style names that causes unnecessary line wraps/splits.
> 
> Thanks,
> -Mukesh
> 

Per https://docs.kernel.org/process/coding-style.html#naming

GLOBAL variables (to be used only if you really need them) need to have descriptive names,
as do global functions. If you have a function that counts the number of active users,
you should call that count_active_users() or similar, you should not call it cntusr().

Thanks,
Easwar (he/him)

