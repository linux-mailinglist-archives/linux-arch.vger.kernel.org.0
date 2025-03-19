Return-Path: <linux-arch+bounces-10953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0BA6842A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A716CA42
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5122489F;
	Wed, 19 Mar 2025 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BBdngRFj"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52FABA3D;
	Wed, 19 Mar 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742357869; cv=none; b=C9oKu9VThXi06Qy7UwMBcOWISREre285kLPC8LiSOzb6AR25rbKV60tn2HV/+2Mf2gswma1h82qQdP1oHqiVtML2BR4aIufKXqxQHfqmdcOyXza9Th7jLVpID9AaSForoYdzNpA0QCjsLOVJG4E+ZcKICoVSp45raGIZpCDJjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742357869; c=relaxed/simple;
	bh=7tN0hl+UoM/pMwvlvpmI4JcFPRDTf9VN+CH+JWsq6dE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TiJG2cZ9zFClWaQXA/C6euo5A0nR06xFNMlfIJE6FcZyMC8xJ5t1azVPVJ0TO6B1rh6hpd/x105hPPgW4A8ImENEQDQPVVMueFhwVBVCE/OqyhJSmCHZztvpBgbOfbbapyLHh9Y0XGJyrZ90A46a1Ii7MTKVKFPwDMnB/QKbnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BBdngRFj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.26] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 834772025373;
	Tue, 18 Mar 2025 21:17:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 834772025373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742357866;
	bh=i81vfxx6rnbOmwz/BGTkep+/cjFf5C0tzqdntf/uZX0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BBdngRFjrm3qc8p3g6SsP6YR+S/l76EJSt+6UA9xAvo2M1xlEwANRzngSNQMKNQbI
	 cTdh29l+lduUf0ovrmFq6mD+e4+hi6eBh9M1vDbP9QZmnxv8RWuOSzRQTDwnauV4Yb
	 49k43AlBkgAET9m0J04z5EQLbb/kzxPuW8ODh9FM=
Message-ID: <06d2ad24-7554-4e7c-86f7-9e22828cb725@linux.microsoft.com>
Date: Tue, 18 Mar 2025 21:17:52 -0700
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
Subject: Re: [PATCH v6 01/10] hyperv: Log hypercall status codes as strings
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-2-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1741980536-3865-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/2025 12:28 PM, Nuno Das Neves wrote:
> Introduce hv_status_printk() macros as a convenience to log hypercall
> errors, formatting them with the status code (HV_STATUS_*) as a raw hex
> value and also as a string, which saves some time while debugging.
> 
> Create a table of HV_STATUS_ codes with strings and mapped errnos, and
> use it for hv_result_to_string() and hv_result_to_errno().
> 
> Use the new hv_status_printk()s in hv_proc.c, hyperv-iommu.c, and
> irqdomain.c hypercalls to aid debugging in the root partition.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c    |   6 +-
>  drivers/hv/hv_common.c         | 129 ++++++++++++++++++++++++---------
>  drivers/hv/hv_proc.c           |  10 +--
>  drivers/iommu/hyperv-iommu.c   |   4 +-
>  include/asm-generic/mshyperv.h |  13 ++++
>  5 files changed, 118 insertions(+), 44 deletions(-)
> 

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

