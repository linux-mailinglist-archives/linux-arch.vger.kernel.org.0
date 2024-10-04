Return-Path: <linux-arch+bounces-7697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB9990860
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F19F1C217B3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190D1C82F6;
	Fri,  4 Oct 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gF4x0mXg"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619A61C82EE;
	Fri,  4 Oct 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057495; cv=none; b=S6XqXh5c4cOLpkIxG2IONj1AxZBwfj3d6Zzx8KDXwC5DlfllohP6eWamEGhS97cLBpwRVI+qW+cQeQuwY5nV2ujBdiuoMca6fjA5WWHm4kAH1BISj/ligZxGEzTAOOOkRUqzRumSvGBfVgCOxuGN/HiVIjd+rsG3n3MjfesWJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057495; c=relaxed/simple;
	bh=8uh4TNkp6twpeWAanVhV11PWicdwb1B5v29oz3feF58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCwkLbJF6j4pJ/qKH4UaOHz1lYY6D4MiiVXCPOXSX8Jr26XkJeI2Eq5RIZJPFM/J9M0+VuCKvSTqHETdIyvCUaqqA9VJZdh+mX+HnP1Z/akrrj/dQgn7OW/Go/yY4pqMcok0T+/UAv9xN9aDBtvLPNep84kUHdb4bETNZPEG5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gF4x0mXg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-73-193-101-196.hsd1.wa.comcast.net [73.193.101.196])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C52C20DB372;
	Fri,  4 Oct 2024 08:58:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C52C20DB372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728057493;
	bh=/pii58jwh0dxjUTnCB4wKd4qDYL0zJalmcFRaKg1Rk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF4x0mXgY2976aPpUyHfvCeU5mN01LE3LGlyOHoNNmhz8QucEf5NFFia21mNaMF+J
	 A9fhvHE8aJt2tUhuBAhwTZK0iABMpBt/d6Vl5LxteuF02PZuyT5njzYTAvaoKnCvMd
	 7onaHNpCblZSb2s/35ZJ8j+tjDmi+pvAwj4hrA2k=
Date: Fri, 4 Oct 2024 08:58:10 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
Message-ID: <20241004155810.GA15304@skinsburskii.>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

On Thu, Oct 03, 2024 at 12:51:04PM -0700, Nuno Das Neves wrote:
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 9d1969b875e9..bb7f28f74bf4 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <asm-generic/bug.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <asm/mshyperv.h>
>  

Perhaps it would be cleaner to introduce a new header file to be
included, containing the new define and including <asm/mshyperv.h> instead.

Stas

