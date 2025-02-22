Return-Path: <linux-arch+bounces-10325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E1A40514
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 03:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F687019DC
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45F17E00E;
	Sat, 22 Feb 2025 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1YVU2h2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FC3224;
	Sat, 22 Feb 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740191529; cv=none; b=AxETb3zXVfkv636WUEowjgFglgfQHTZWoMKcJYC6Z7TnXkw+9arwbu1Nv9DdiBsjjKOlmHAVE0e9X2lM79psQFBIZbnscb8T23IrXOZphdrCqGEavbHM8qwYhGXRANLJekUgir+1m77kipqdw7KND5oj9OvOd/ymhDDDaDxpOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740191529; c=relaxed/simple;
	bh=FZnMFdDa2eWIl4oFcL24l5BAuNQWfTpFEGTebUgjJk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgBgqEclgpmsTJZbub5q3WWOoWd7DxSB+fNyD/ZX+QweXbiBiUN/Tk8jUG6ex87fZo/Wcx/lo2SvLsOJsmM6iSeeVnsUuanW/0KZ6SEoqL9DQVEV0lWD8uRkTsP7yotwvicpWLRKImHq1LkZgtCG9+NZ3aXj1VmRGDlVZJzB0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1YVU2h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F89C4CED6;
	Sat, 22 Feb 2025 02:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740191528;
	bh=FZnMFdDa2eWIl4oFcL24l5BAuNQWfTpFEGTebUgjJk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1YVU2h2yeY3oks9GLiIqAziMoxE84y+9gFwXdo+kGhQdEkbgSefJim69X1+OjmxB
	 sUl+TKn1d7tnDfsRtl6LqPpN4Zqp5FCE/T1tCHT91DI2AiTUJSqykBnBhxGLOsfpRJ
	 nHL8Rq0zDyXPQzxne70Hsg50VNNcBJDXXcQrCmocIJK/QeKSWlP4/iL/yyDEnSsOGy
	 jeR2zK3eXpNSi8hfI+/26IVx3Q4rxYprYdcA+0+chH4C+7rAPJM86cWqwytsMIUF0L
	 7Cuk393b/czhZL+xrIt2EJL5/a/jZSuA/oT4F6sDau4qKPMwDg7Z2kKUcv2z1n+/0H
	 PiWAzh7xsQqYg==
Date: Sat, 22 Feb 2025 02:32:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev, mhklinux@outlook.com,
	eahariha@linux.microsoft.com, mukeshrathor@microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] Introduce CONFIG_MSHV_ROOT for root partition code
Message-ID: <Z7k3Jh9O8noNZXGt@liuwe-devbox-debian-v2>
References: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Feb 21, 2025 at 11:56:32AM -0800, Nuno Das Neves wrote:
> Running in the root partition is a unique and specialized case that
> requires additional code. CONFIG_MSHV_ROOT allows Hyper-V guest kernels
> to exclude this code, which is important since significant additional code
> specific to the root partition is expected to be added over time.
> 
> To do this, change hv_root_partition to be a function which is stubbed out
> to return false if CONFIG_MSHV_ROOT=n, and don't compile hv_proc.c at all,
> stubbing out those functions with inline versions.
> 
> Store the partition type (guest or root) in an enum hv_curr_partition_type,
> which can be extended beyond just guest and root partition.
> 
> While at it, introduce hv_result_to_errno() to convert Hyper-V status codes
> to regular linux errors. This is useful because the caller of a hypercall
> helper function (such as those in hv_proc.c) usually can't and doesn't
> interpret the Hyper-V status, so it is better to convert it to an error code
> and reduce the possibility of misinterpreting it. This also alows the stubbed
> versions of the hv_proc.c functions to just return a linux error code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

No need to sign this off. :-)

> 
> Nuno Das Neves (3):
>   hyperv: Convert hypercall statuses to linux error codes
>   hyperv: Change hv_root_partition into a function
>   hyperv: Add CONFIG_MSHV_ROOT to gate root partition support
> 

Applied to hyperv-next. Thanks.

