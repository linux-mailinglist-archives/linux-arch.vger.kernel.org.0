Return-Path: <linux-arch+bounces-9285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E19E66AD
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 06:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A52829A7
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 05:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35189194C62;
	Fri,  6 Dec 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hvh0dBNK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41EA190470;
	Fri,  6 Dec 2024 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462085; cv=none; b=bq7qOBF83aoKwgMz3HalqyRnwNFSQkg3Nn2d0HY0tqON0jYDSFb/v5kbvmxeK0XFlFIpSjbm8Zn+W4H9W0FbAShFMxipjtv8k+W2cTzLm0OM1eITUIMooHDlxq+YPGSgrSjgiyR5tLghE+1TuCiC+Yq1FKr7Znqun4rtzOoynCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462085; c=relaxed/simple;
	bh=BqZvvQBe2NAiV555bybaFgTHIY65v4XFOh8d4y5vS50=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VvqM3+PqXVaKtklI1QgTNK46468dNgQktJNty7JLZ8yB4mVe6idlnwJpLS4UhlC7RT4leXOlKDYiDI99VjBPSGA5pUoyxKnzMXQxMSIh/BOVtbXu/bQQT7dCCpU3bBS2dQPgcARNtsNgSUw/3/3vH+kkxOE8krgR35GOc2itpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hvh0dBNK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.192] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCC3E20ACD8D;
	Thu,  5 Dec 2024 21:14:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCC3E20ACD8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733462083;
	bh=fmWPQyjFRGq2DUlJdZzT4Pg3mAFKTaqENTg3HM7bGXs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Hvh0dBNKckDBScVZZN9FBPxjIwxRPRWAjIktBLN2y3fC5OvW2S67m+oj9qsZDT5hY
	 5k/by83lopTusK+LIkgRxkvpxQHZO4xGi0XNZqz+P31Fxv45dLNto6oVXCgd8Spwwi
	 Q6b3836tPEjA0ievdJvUdmCOWAGIQMGjSvBrFuZA=
Message-ID: <92399e62-e07b-48eb-9a96-9747ad5b6eb7@linux.microsoft.com>
Date: Thu, 5 Dec 2024 21:14:40 -0800
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
Subject: Re: [PATCH v3 5/5] hyperv: Remove the now unused hyperv-tlfs.h files
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-6-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1732577084-2122-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2024 3:24 PM, Nuno Das Neves wrote:
> Remove all hyperv-tlfs.h files. These are no longer included
> anywhere. hyperv/hvhdk.h serves the same role, but with an easier
> path for adding new definitions.
> 
> Remove the relevant lines in MAINTAINERS.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  MAINTAINERS                          |   3 -
>  arch/arm64/include/asm/hyperv-tlfs.h |  71 ---
>  arch/x86/include/asm/hyperv-tlfs.h   | 811 ------------------------
>  include/asm-generic/hyperv-tlfs.h    | 883 ---------------------------
>  4 files changed, 1768 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
>  delete mode 100644 arch/x86/include/asm/hyperv-tlfs.h
>  delete mode 100644 include/asm-generic/hyperv-tlfs.h
> 

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

