Return-Path: <linux-arch+bounces-8919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E819C156D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 05:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9631B1C20FB2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCE28EB;
	Fri,  8 Nov 2024 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AbnCEhJ4"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A491DDE9;
	Fri,  8 Nov 2024 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039890; cv=none; b=aQAWghdoMHTTvTJM9hRpHLjz1OYrcQascARPVq4e0hinFXV57lFXITCJbWJOrMuovx1rJt+eA7Dfd9OHhFj2k8vgJY3kXQ99Tx4qUt2H6d2EKr7rq9sB98hhYQ80s4AqFRxdXhDBCUcriztJJpxAyRVGGHYfye8N1m0GohRetAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039890; c=relaxed/simple;
	bh=Sxa3WyzgpZHSaEwaXLKbf7C1Jii937eXY4EDdYhyahU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YYjP+6vdtYyU9HJgW2Njk0FnmM9fhzrNQmjF+ljPAGHSy1gFg4PdbNh0CaY5J2IUHb5RTc6hLmi91a7D9bTW3Swzez3LUkGI03JgZ0zRzyRzqHbU9Pwl8VmL/5EbpIoJV9Q7RPkyz9qiHmtwuqXr8BYgHLvUbvqLH+kSivqr0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AbnCEhJ4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86D04212D51D;
	Thu,  7 Nov 2024 20:24:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D04212D51D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731039889;
	bh=CW1YMxyLY4Ufdwscc+Sad9e5U0vNmqpGzoX9f3jzMOo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AbnCEhJ4o/VclSdAku7qgYUWX0b3uxgD1xfZhfwCWDdSTklsPG7KLZYd0XWL6atg5
	 l3qFFbGxzHn1zUPxTgC7xBhxFFko/na0EsK2aWF/ClYTMGZd96BdnB9gks88DAGlv+
	 joKptKzFlk0BgqA8lJO2+OltHhgrrl75JackwbNk=
Message-ID: <ee050247-92f2-4c9a-add0-a5a43dbab34f@linux.microsoft.com>
Date: Thu, 7 Nov 2024 20:24:47 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
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
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH v2 2/4] hyperv: Clean up unnecessary #includes
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1731018746-25914-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2024 2:32 PM, Nuno Das Neves wrote:
> Remove includes of linux/hyperv.h, mshyperv.h, and hyperv-tlfs.h where
> they are not used.
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c     | 1 -
>  arch/x86/hyperv/hv_apic.c       | 1 -
>  arch/x86/hyperv/hv_init.c       | 1 -
>  arch/x86/hyperv/hv_proc.c       | 1 -
>  arch/x86/hyperv/ivm.c           | 1 -
>  arch/x86/hyperv/mmu.c           | 1 -
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/include/asm/mshyperv.h | 1 -
>  arch/x86/mm/pat/set_memory.c    | 2 --
>  9 files changed, 10 deletions(-)
> 

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

