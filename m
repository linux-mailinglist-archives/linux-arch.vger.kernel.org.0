Return-Path: <linux-arch+bounces-10261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50AA3E476
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AB417C00F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3A2641E3;
	Thu, 20 Feb 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lUMMvA48"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81019263898;
	Thu, 20 Feb 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077799; cv=none; b=H3srRWbb9EzmbGL35PD93wUKv04J9GNQxPH1BhQuQppJpMzV3hTDrkip+fmUmz2sWdjh+kRVfEC5ShxXvcnPY3XlCKRHU7dT2TKIBrI4ikZnDJlbL7ybFI5aLef9L3/h4bhFjM48aE9Q+vd4sk5Z7o8RUAmBswtlTM0/wsHuFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077799; c=relaxed/simple;
	bh=GbolloFT2FOCDbksbZ+RzhZEXPurL+z5bLmVpj7y08o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=egecmz/9EklqjUK4dxwJ+9MRyutij4mJaBJK0dR5Wu/XqbyMlV+NM7GoSATBxDLssl9f5E45haWExAtejyk0gkZYmOxtNBCeBiqh5sJs8wVtfWqr5HNNhFPIKOWafy8iUgjG5GBj9yV5bs0x1S/GVQ9Vyi0fmEozDFyhWwVN6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lUMMvA48; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3FD35203E3A2;
	Thu, 20 Feb 2025 10:56:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FD35203E3A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740077798;
	bh=x5G2E+vUtbY0uD73lnb0uFLzyVFiAj2xuYirRrBVabo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lUMMvA48ESzUkTcMMWbiIOhiwtv/5Arnq9nEGx0Opzkkyf/25jcaIaXOcbLSbB1CI
	 ZRKu+5PZFWAm1gHdFNiE9YEbERuun9hBsF4ziOTScybHjKQm/XVkGxfVqkKj36Rl+z
	 ZECAN3e9WjMqh5k0vLnnmZyqpA39OUrA31KrWvJw=
Message-ID: <db2015a0-63a3-4005-9ad1-9b2f0b57ccb1@linux.microsoft.com>
Date: Thu, 20 Feb 2025 10:56:37 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, mhklinux@outlook.com, eahariha@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 10:33 AM, Nuno Das Neves wrote:
> Introduce hv_current_partition_type to store the partition type
> as an enum.
> 
> Right now this is limited to guest or root partition, but there will
> be other kinds in future and the enum is easily extensible.
> 
> Set up hv_current_partition_type early in Hyper-V initialization with
> hv_identify_partition_type(). hv_root_partition() just queries this
> value, and shouldn't be called before that.
> 
> Making this check into a function sets the stage for adding a config
> option to gate the compilation of root partition code. In particular,
> hv_root_partition() can be stubbed out always be false if root
> partition support isn't desired.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>  arch/x86/hyperv/hv_init.c          | 10 ++++-----
>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++------------------
>  drivers/clocksource/hyperv_timer.c |  4 ++--
>  drivers/hv/hv.c                    | 10 ++++-----
>  drivers/hv/hv_common.c             | 35 +++++++++++++++++++++++++-----
>  drivers/hv/vmbus_drv.c             |  2 +-
>  drivers/iommu/hyperv-iommu.c       |  4 ++--
>  include/asm-generic/mshyperv.h     | 15 +++++++++++--
>  9 files changed, 61 insertions(+), 45 deletions(-)

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

