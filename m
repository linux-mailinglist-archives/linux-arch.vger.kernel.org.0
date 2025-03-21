Return-Path: <linux-arch+bounces-11026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE9A6C363
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA861726CD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6922E412;
	Fri, 21 Mar 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c/PbSQNi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4461D54CF;
	Fri, 21 Mar 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585766; cv=none; b=bYoEroNU1R9hkx1Y/u4M/rjMzF9vI4uvA3SpC85TC/2W1QSDa0WqfD9gIVX4L8w/m2qX775o0afHshUDVFTySS0Go9y7ULVIj7UMaYGEQI3YoIetiFIxvleAPTAXS0OTh8GxOGDiBjeEGFMf5fBOoLzjaxYtE+96Os9Ix6hJIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585766; c=relaxed/simple;
	bh=C++Y8u3ya02o1vKzmoM0dnDY7A2chUdCqKyyJh4SfA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtkCq3HF+pKugQTT5vIi/g+ECi8JWS2tckIqJaud+hx8RT20E9sCj48qPPRauRej/tAsNYMFicn+z9s8a8IzytnkSGBt5WFssoO4BFqDCsovdUxHl77GpbYgR7xy/ThscpktrYBASF7yf04+iPpJiAWLvtxgU/spiEtue8HJFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c/PbSQNi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E7672025389;
	Fri, 21 Mar 2025 12:36:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E7672025389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742585763;
	bh=i3HSKurM5BztT+SIxfmwMikTCwCikJk6+44/qfduWSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c/PbSQNi6xW7xt4qq/YZKnryb+JE1EPhc6+zDpfT6yk2I5a8iVpVIWvCazf9pjqjI
	 qTi/0ZJr06K3vQ+l7bHQ90m7I2zIF+LEXr+wHsFQ3kvpMuVPaUjubkaBXnXnxHNbFc
	 z5liRIDSpGRGa0jRI78+VxZ292ebAiKWTRi2KogM=
Message-ID: <96f2c859-790a-4282-9eef-9863ffb42ee1@linux.microsoft.com>
Date: Fri, 21 Mar 2025 12:35:57 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] x86/hyperv: Use hv_hvcall_*() to set up hypercall
 arguments -- part 2
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-4-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250313061911.2491-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset()
> and explicit zero'ing of input fields.
> 
> For hv_mark_gpa_visibility(), use the computed batch_size instead
> of HV_MAX_MODIFY_GPA_REP_COUNT. Also update the associated gpa_page_list[]
> field to have zero size, which is more consistent with other array
> arguments to hypercalls. Due to the interaction with the calling
> hv_vtom_set_host_visibility(), HV_MAX_MODIFY_GPA_REP_COUNT cannot be
> completely eliminated without some further restructuring, but that's
> for another patch set.
> 
> Similarly, for the nested flush functions, update the gpa_list[] to
> have zero size. Again, separate restructuring would be required to
> completely eliminate the need for HV_MAX_FLUSH_REP_COUNT.
> 
> Finally, hyperv_flush_tlb_others_ex() requires special handling
> because the input consists of two arrays -- one for the hv_vp_set and
> another for the gva list. The batch_size computed by hv_hvcall_in_array()
> is adjusted to account for the number of entries in the hv_vp_set.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> 
> Notes:
>     Changes in v2:
>     * In hyperv_flush_tlb_others_ex(), added check of the adjusted
>       max_gvas to make sure it doesn't go to zero or negative, which would
>       happen if there is insufficient space to hold the hv_vpset and have
>       at least one entry in the gva list. Since an hv_vpset currently
>       represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
>       512 bytes and there should always be sufficent space. But do the
>       check just in case something changes. [Nuno Das Neves]
> 
>  arch/x86/hyperv/ivm.c       | 18 +++++++++---------
>  arch/x86/hyperv/mmu.c       | 19 +++++--------------
>  arch/x86/hyperv/nested.c    | 14 +++++---------
>  include/hyperv/hvgdk_mini.h |  4 ++--
>  4 files changed, 21 insertions(+), 34 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

