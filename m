Return-Path: <linux-arch+bounces-10951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D08A68411
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 05:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C43BC623
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD3204F97;
	Wed, 19 Mar 2025 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="soiaoN3d"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EC1F61C;
	Wed, 19 Mar 2025 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742357088; cv=none; b=leF+ftUK7Q8IQ3Uk/g8/oZl/5phAFzvXVlzOviur5MnJTzxRN80EEku1r8uxE++nqZ0xv6gWZT7+oKj+qHcExKtN5yhao82JJ5HyL1+AF5vHsZhUFauBVcFJUMoGVpuBl7TuYEj3Xon6gVvUnpIPWjrJgwVuW0POLBuFH/bcTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742357088; c=relaxed/simple;
	bh=RDKOUPZXQHijQpbLkNQGf6rVGLFwWEeHCz7rGjNGo4E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uR60GxeEIzbiRo2HflyATGghIOqVOTAh6xG5MaVMAjfer1bYpLWyu1Ypd4AoSrQCvV6iXCl+4bspcIH8c4JekIIIdJt3zcdna0WxrZ1G70IUDA/CZFoZtiKEI6cBxdKLXAsqFES8pu/owI7KcufXoPeheLd6Dhnznkyk/pr812k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=soiaoN3d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.26] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09A992025371;
	Tue, 18 Mar 2025 21:04:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09A992025371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742357086;
	bh=8DvSI50HiKGef1YUibfVt0rtJdAcZaAM9wyDZdjj/cc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=soiaoN3dlB8MxzFcORFWIbRZnkKHKt4BMBHge5TVI1y9gc/QdP77qZfiMfqhrzHZ3
	 PmFFmJX6xvzUSe8sIEsoGEt0YLL2X1ypuzPaMtXIQnFwmPw6jLQekOOVfAGAke8dC3
	 HqlThwdykTRWA4Pm30QTnSqysPzOcw3BbmzPp8cQ=
Message-ID: <d1da11e5-519c-4b8c-bff8-c266d984a950@linux.microsoft.com>
Date: Tue, 18 Mar 2025 21:04:51 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, mhklinux@outlook.com, ltykernel@gmail.com,
 stanislav.kinsburskiy@gmail.com, linux-acpi@vger.kernel.org,
 jeff.johnson@oss.qualcomm.com, eahariha@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
 corbet@lwn.net
Subject: Re: [PATCH v6 09/10] hyperv: Add definitions for root partition
 driver to hv headers
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-10-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1741980536-3865-10-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/2025 12:28 PM, Nuno Das Neves wrote:
> A few additional definitions are required for the mshv driver code
> (to follow). Introduce those here and clean up a little bit while
> at it.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  72 ++++++++++++++++++--
>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>  3 files changed, 284 insertions(+), 11 deletions(-)

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

