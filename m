Return-Path: <linux-arch+bounces-10535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74EA5531E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45893A966B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF32147FD;
	Thu,  6 Mar 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6+jMDYe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C319D8B7;
	Thu,  6 Mar 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282329; cv=none; b=CvPqiQEVZBdAqOf1ODZw53G7VTsaQrUQDCxVltvxxSGb3KUnQjm+mYXsca6hm6pf/3AB1KSUKwyoR9tHF3z/U8QC1nD8mwVVY4cwZS2HHFWvZrnAb5fHUSRbpe7V869lFIkx8YkCrrcttP1c9BsO0yCmIQOkdzMnD1snR4U1Ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282329; c=relaxed/simple;
	bh=Pk2ue5j/pk+6zhxGTLAOxyRNOC5jmc+8Ec9aVHb3TOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNBu6ZKxIkxcnWqpxuGOpjXnBxlq1qOAbl4UvwI0XpzA+oWTxzPdhaHPwvO8DdKxt0MP1C5VNs/QO5UQlqfCQRB7cEQ3jyrUniQaA7ueCc1WN/3f4ro+3rIQAT7lFL9o3lOJ39exE/fQ1RlXKWGAZ3cN7ZX0rIjjiV3vfyq2BhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6+jMDYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254D6C4CEE0;
	Thu,  6 Mar 2025 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741282328;
	bh=Pk2ue5j/pk+6zhxGTLAOxyRNOC5jmc+8Ec9aVHb3TOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6+jMDYe1JuTTkwoB6+8AIctO24faWlduIkpVx8m0Q/YtQ2oW6RkY8pSkT3gQpqhj
	 hsuJqphwB/otmYETcTSRVrcSYLDLMjeVWRkVBYS9gmu/d6e95ue4XA8Tt5EAppu+ch
	 ooORaobj/7p9zQlknngSLmJgAyi/CrtRfN4obZR/RNuNGVGpV1vh4IqeOH8pWy4Ace
	 eUYXHWK1Zbd/TgrgiU2BxA1m308egnrUbcnkZAcfUHYZxc7Pe2vnzAWfBI4YoWDyq+
	 AQ+4LfmsOvPcgY9RaRWnOjX4RCzabvvXyphlZv6onjJDTYyWK/2rv+QRFeukJVvWZB
	 hJ9ZvwIHb2wpw==
Date: Thu, 6 Mar 2025 17:32:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, ssengar@linux.microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	stanislav.kinsburskiy@gmail.com, gregkh@linuxfoundation.org,
	vkuznets@redhat.com, prapal@linux.microsoft.com,
	muislam@microsoft.com, anrayabh@linux.microsoft.com,
	rafael@kernel.org, lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Message-ID: <Z8ncFkwzxi9qJFD3@liuwe-devbox-debian-v2>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>

On Thu, Feb 27, 2025 at 10:50:30AM -0800, Roman Kisel wrote:
> 
> 
> 
> On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> > Provide a set of IOCTLs for creating and managing child partitions when
> > running as root partition on Hyper-V. The new driver is enabled via
> > CONFIG_MSHV_ROOT.
> > 
> 
> [...]
> 
> 
> As I understood, the changes fall into these buckets:
> 
> 1. Partition management (VPs and memory). Built of the top of fd's which
>    looks as the right approach. There is ref counting etc.
> 2. Scheduling. Here, there is the mature KVM and Xen code to find
>    inspiration in. Xen being the Type 1 hypervisor should likely be
>    closer to MSHV in my understanding.

Yes and no.

When a hypervisor-based scheduler (either classic or core) is used, the
scheduling model is the same as Xen. In this model, the hypervisor makes
the scheduling decisions.

There is a second scheduler model. In that model, the hypervisor
delegates scheduling to the Linux kernel. The Linux scheduler makes the
scheduling decisions. It is similar to KVM.

We support both. Which model to use largely depends on the workload and
the desired behaviors of the system.

This is purely informational in case people wonder why the run vp
function branches off to two different code paths.

> 3. IOCTL code allocation. Not sure how this is allocated yet given that
>    the patch series has been through a multi-year review, that must be
>    settled by now.
> 4. IOCTLs themselves. The majority just marshals data to the
>    hypervisor.
> 
> Despite the rather large size of the patch, I spot-checked the places
> where I have the chance to make an informed decision, and could not find
> anything that'd stand out as suspicious to me. Going to extrapolate that
> the patch itself should be good enough. Given that this code has been in
> development and validation for a few years, I'd vote to merge it. That
> will also enable upstreaming the rest of the VTL mode code that powers
> Azure Boost (https://github.com/microsoft/OHCL-Linux-Kernel)
> 
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> 

Thank you for the review.

Thanks,
Wei.

> -- 
> Thank you,
> Roman
> 

