Return-Path: <linux-arch+bounces-3250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198288F0DB
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B96C29C37F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69624153509;
	Wed, 27 Mar 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ho0uWBKv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CF47A7F;
	Wed, 27 Mar 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574718; cv=none; b=nAk5v6EfsViUsgYxMCSWx3sPMp9RZ9NqWRPdi1VuPRxHWwEYWlC4nzTZgLdA4AZsqbG6waRWPOISh+zYfI1eRFpF1oUNDE3EPTJCGgD6iGZ+SgHoKotYGT531I9MCdnJgrNrsh7UhEak84m9Uab97ymXaKothWHxVuNrP8cqvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574718; c=relaxed/simple;
	bh=JRSXPxdrQqrWLSPd70fIgarnQxXYvf0ykL1MJXBFB/U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LswJD2ti7Mp8wL2pCSGdDCNbUMRivP5t7lSG2D/uA5nOiQHLHaaNg659ecvpBDdOs2U9FeJ87KxS3Q7ILu8duSzZPYF+ltNsenMDnFyz7CALKLDKRrmOeOwIT5m52/U16kMTC0V+1shyyxHnwWAsNcTJ6y4i8l7PXlXt/94SWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ho0uWBKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68782C433C7;
	Wed, 27 Mar 2024 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711574717;
	bh=JRSXPxdrQqrWLSPd70fIgarnQxXYvf0ykL1MJXBFB/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ho0uWBKvGFwgWY4CwVS1HcMdq7K6bPpP4DYyp/5qYDCJkxHKyU9vfNSJ7YDhaG3zs
	 w3HHQhQsufkKDmNXyX7K32z9CSG2dRF1a/R+ETw4hPgnu3feqOxD1j3PpcNoutpnv1
	 /CZN0jYTBBzf1bA4kpx/bG1sv4UaAmth1BnFQfHc=
Date: Wed, 27 Mar 2024 14:25:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, Christoph
 Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v3 12/14] drm/amd/display: Use
 ARCH_HAS_KERNEL_FPU_SUPPORT
Message-Id: <20240327142516.e4b1f9ba6e2ec7bc300e4d58@linux-foundation.org>
In-Reply-To: <20240327200157.1097089-13-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
	<20240327200157.1097089-13-samuel.holland@sifive.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 13:00:43 -0700 Samuel Holland <samuel.holland@sifive.com> wrote:

> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
> 
> ...
>
> @@ -87,16 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>  	WARN_ON_ONCE(!in_task());
>  	preempt_disable();
>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
> -
>  	if (depth == 1) {
> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
> +		BUG_ON(!kernel_fpu_available());
>  		kernel_fpu_begin();

For some reason kernel_fpu_available() was undefined in my x86_64
allmodconfig build.  I just removed the statement.


