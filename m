Return-Path: <linux-arch+bounces-12962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4FB128BA
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 05:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD6F3B176D
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C91DDC1D;
	Sat, 26 Jul 2025 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXZnHIkt"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA309FBF6;
	Sat, 26 Jul 2025 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753500981; cv=none; b=l2MoXV7230Q3S+VEm3P0We1HT7ygZ3JW3d5cPq9L3SyZOHGiYO1K/GTfK9jgb0s/byTB5ppxrqBUoOtUUIacM1ElqRZNiN6BmpCCS9O3I3i3pSjbSR/cQRq6qnQ9MVfyHcHAwpb4qQR7xRdPERD/wEIjRVF+zow77suPB6SkiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753500981; c=relaxed/simple;
	bh=bv9AkDmHbGphZChItpP+S9WgbzA7cKwwpRDSVLcNUvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa9e1qopltyt4Qk7gRWLKmjiJrFJ6JaVY03J1QcPsX3kvMjGF0zBepDwyQa+nx3Y5oVTRP66hihc+DYuf7OBwuJCvyWp4xeTiU1JGaj28Hz0rU9IaIgcV1Ul7i4hcJ9U88tiogXpQKyrl0wYZuUntwBdUjElIR8FhOpCiYSFH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iXZnHIkt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0SqKK1itEFeyqao+wJaeXuZjHvB4xmHKjQAwZpz8zt0=; b=iXZnHIkt5XNkk41IakbLXc3TT/
	VlOBtt4hbBrKqRz9anPJNXv8D4IwuY6U36ttsi1mNzLyklsogRm5k8NebdKtPbrV477Us9lmRy493
	AG1leB9CMMSkhivLuTx2ibMe81Qi3VEJswvfeVLL1DmvB4EMgAtTKAFNjR5/LBJYtDSSRcaGMYQ0y
	wdyIbvS7ldyFKYgyNg9Dzi1EeX/GEtzL2Vlug9858seMBXcan3f4wWyXqO+tyDlpKH7ZV2aaolZSj
	9eTQxAVa1z/GT35Le6gy29VoN7MqpySiX69AmzKlOyr1Y+OmDhC9TQh6SfbmKoc4eF9bY5hcTpMtd
	4xy+Dt4A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufVhr-0000000B5Pk-0JWR;
	Sat, 26 Jul 2025 03:36:19 +0000
Message-ID: <0fa9e4e7-1247-4c82-8c0b-fa65b7fbb56d@infradead.org>
Date: Fri, 25 Jul 2025 20:36:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 01/29] kmemdump: introduce kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-2-eugen.hristev@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250724135512.518487-2-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/25 6:54 AM, Eugen Hristev wrote:
> diff --git a/drivers/debug/Kconfig b/drivers/debug/Kconfig
> new file mode 100644
> index 000000000000..b86585c5d621
> --- /dev/null
> +++ b/drivers/debug/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menu "Generic Debug Options"
> +
> +config KMEMDUMP
> +	bool "Allow the kernel to register memory regions for dumping purpose"
> +	help
> +	  Kmemdump mechanism allows any driver to register a specific memory
> +	  area for later dumping purpose, depending on the functionality
> +	  of the attached backend. The backend would interface any hardware
> +	  mechanism that will allow dumping to happen regardless of the
> +	  state of the kernel (running, frozen, crashed, or any particular
> +	  state).
> +
> +	  Note that modules using this feature must be rebuilt if option
> +	  changes.

It seems to me that this (all of the KMEMDUMP Kconfig options) could live in
mm/Kconfig.debug instead of creating a new subdir for it.

-- 
~Randy


