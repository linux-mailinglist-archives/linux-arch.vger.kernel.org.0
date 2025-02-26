Return-Path: <linux-arch+bounces-10376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42691A46041
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444B1165F31
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766501891A9;
	Wed, 26 Feb 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME+RHoIL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C413AA2A;
	Wed, 26 Feb 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575333; cv=none; b=qRxB5bfXZAIXoIY03iAHIEFz2bWngqwy32Cn7fKAF9Po5VZjkWZkZacH1/kfvaEPr/aOF8GLviCw4wR4urah9VSDeUUfVAvtPGWxq54HKEzRQ4aaAtd9tvFnCP5I2Yiu14T0P0gjVuiW+O6mAthNtFEGjVqp26H6UWygyHWUUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575333; c=relaxed/simple;
	bh=nTMS76C2pWow6+Hfgqh3RiybiXmTOBQMbdZsndNGZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSBrWr5YNZHG8wkmQy2B9sIXg+Osobe5ctlrY61lzqKsfYVq8weQtkia4++R6vq6YDtof5I/x8dmtkJFsU0EZ+HHa1vaK7IQB7mq/+fyOXhWMKNvxgbsNhyMG3EIcUhyIrE+p2o9dmDFB6jp2HeoUQvUxht4KDZoAKu1dIzjZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME+RHoIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF9C4CED6;
	Wed, 26 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740575332;
	bh=nTMS76C2pWow6+Hfgqh3RiybiXmTOBQMbdZsndNGZwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME+RHoILBMzVIp4Bd4JiiRk4Zlv7nlYJbwH5NzZqAcRGuI6rJKgUlU1llm7Vtw3Tf
	 4ebQiXFU0kNxnVHeQgCvfouU9KvoefwQA2t/HfFgGDKgKSdVFdpofwLTAPXkXRvMUH
	 SH2P2YslThNNKFayVjaBX9SX5grXSi+2YFekWeerRDXyUTszrOm4wNHRJSgeBVv/+5
	 cMspK3A85HxXWQrUjM4LwqB4ZlOMkauTW9nyVFPdjNYMnRhho5h4aC5MtTiPa7sbPA
	 84fYFnfO5fN8F5jpzVYHhLZkqznILr1ANJCJmDnK+veGUA50chEcnihUHeQRC9PZuN
	 ZC1MjBx4fMNBQ==
Date: Wed, 26 Feb 2025 14:08:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, briannorris@chromium.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Message-ID: <Z78SVdv5YKie-Mcp@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-4-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217202745.1402932-4-benjamin@sipsolutions.net>


* Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The init_task instance of struct task_struct is statically allocated and
> may not contain the full FP state for userspace. As such, limit the copy
> to the valid area of init_task and fill the rest with zero.
> 
> Note that the FP state is only needed for userspace, and as such it is
> entirely reasonable for init_task to not contain parts of it.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")
> ---
>  arch/x86/kernel/process.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f63f8fd00a91..1be45fe70cad 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
>   */
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
> -	memcpy(dst, src, arch_task_struct_size);
> +	/* init_task is not dynamically sized (incomplete FPU state) */
> +	if (unlikely(src == &init_task)) {
> +		memcpy(dst, src, sizeof(init_task));
> +		memset((void *)dst + sizeof(init_task), 0,
> +		       arch_task_struct_size - sizeof(init_task));
> +	} else {
> +		memcpy(dst, src, arch_task_struct_size);

Note that this patch, while it still applies cleanly, crashes/hangs the 
x86-64 defconfig kernel bootup in the early boot phase in a KVM guest 
bootup.

Thanks,

	Ingo

