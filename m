Return-Path: <linux-arch+bounces-10405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E2A46F62
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CDD3ADBF5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756125DAFF;
	Wed, 26 Feb 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QRHB5n/B"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE125DAF2;
	Wed, 26 Feb 2025 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612380; cv=none; b=JEDsM7tHC8wgRrXa9Md4c7TSjoPJKSaZDZF8U+ZS3Alcz7dWZoqLwgMyrL4EsFQ8fed+GI6ILWYKKMYUIb+Wr30TRdfeRR0eYRUeog9mOR1Mv1WoRjmzBXS50+7ydhfCZVJUUPfS9Ic7TyXlw3VUtXSvwiF+1d2KcvWRyaWC0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612380; c=relaxed/simple;
	bh=dOTj7AtJcS9cSVTwR/ySWYZMZs7llSQ0HQIPBqHDFW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSYvUyKw+I89691bACFsp7LllHOIZAqPRyV901owV+BnS26czrlMmxjMfbKZdsWT9nj7GnfhoHcASrHcHvT0V8BJjJunWitu8aWf49losK5jgzpYmLrA/LNfQclyVIUyG7GF2PTADzrmRo1xHMj4nGJLXGiglhsduVk38qAYeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QRHB5n/B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1F5C210EACA;
	Wed, 26 Feb 2025 15:26:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1F5C210EACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612378;
	bh=rGrI6nAX4nCRtePDyYEwyLt8sd0vFatzh0dTirTXVmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRHB5n/BwWwjybWsdCNB5VfjPzZD1F81cg1tOqoOTWFpj/E+2a0diKph99mozzpjC
	 RTwswAhsL0o5kgdjfSP051gSwIKm5rwqxffU/xii0NrPI8dY5jpJ5I7Stb3EYL+9tP
	 xsbT5cjD4mQcz7Wu1lwehl/9OhyuPnWcFq4Q9oIQ=
Date: Wed, 26 Feb 2025 15:26:15 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org, vkuznets@redhat.com,
	prapal@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Message-ID: <Z7-jF8rB5bDgSBiy@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:07:55PM -0800, Nuno Das Neves wrote:
> Introduce hv_result_to_string() for this purpose. This allows
> hypercall failures to be debugged more easily with dmesg.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_proc.c           | 13 ++++---
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 74 insertions(+), 5 deletions(-)
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

