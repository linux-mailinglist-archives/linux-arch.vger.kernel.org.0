Return-Path: <linux-arch+bounces-10952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B936A68419
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 05:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6133424C79
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 04:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A320DD7D;
	Wed, 19 Mar 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QCHO07m7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA42AEE2;
	Wed, 19 Mar 2025 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742357292; cv=none; b=BCJKsrBiadc9Wgaio+p7svQCt7wBAZuGf3ttwhXk19ql/h0bQqisR31O9ZO2+fcnlJvlN4jpz/j2UES6iFiHpKwjtgB/jj2nLbJqTc+bXYQTvaqUT4ca3LL3TF1+uipK/fZ7mOYid9Pnv5Rlq9TCvchShKX9vLBvopWaZXQ7UTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742357292; c=relaxed/simple;
	bh=aXxiyaT5dJvoxqaVKrkZrfJmcohOnXPw7gbvR+WA4Lo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lCipVFsdBswzl/7dk1gw6aqElickCg2H+uiQ+/8/IFpOFOVlUDt2EOyBLXRtpx22xeQPty7FXsRXoOTIGFM4XYlObt0sK5x42ege5u2Th+Jh5zIILI6DdXx+vQalULsBvtsi+/Kja3wC4JOMt+cbleeag0RrAbe30OcP6uVf13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QCHO07m7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.26] (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF9092025373;
	Tue, 18 Mar 2025 21:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF9092025373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742357291;
	bh=ONzR6HCwazaLp6Y5MCq95xw25jXEGlNy15BjbvDTfa4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QCHO07m7FpcYme3eveUH4scwJxhTwlntXMBs+EPRpfKCCcTXCFuKDticTp8t3de3x
	 gyuFRbSvX+QysyHSsHhqX/3WT8FgeDuzFH9Nss+Kt6sIr2qv4aUbv49Tyr+tJTnrlT
	 usYh3V7lmxcE5jboBQuAqbZ04GiOUg+TOyIQ3fDY=
Message-ID: <1a60c4f3-b93b-4bc2-9ded-07a1acd9d754@linux.microsoft.com>
Date: Tue, 18 Mar 2025 21:08:16 -0700
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
Subject: Re: [PATCH v6 03/10] arm64/hyperv: Add some missing functions to
 arm64
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1741980536-3865-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/2025 12:28 PM, Nuno Das Neves wrote:
> These non-nested msr and fast hypercall functions are present in x86,
> but they must be available in both architectures for the root partition
> driver code.
> 
> While at it, remove the redundant 'extern' keywords from the
> hv_do_hypercall() variants in asm-generic/mshyperv.h.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h | 13 +++++++++++++
>  include/asm-generic/mshyperv.h    |  6 ++++--
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

