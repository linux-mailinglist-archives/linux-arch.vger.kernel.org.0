Return-Path: <linux-arch+bounces-12961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F0B128B8
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098761C8327F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF561DEFE9;
	Sat, 26 Jul 2025 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4A2//fp"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BEFBF0;
	Sat, 26 Jul 2025 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753500796; cv=none; b=sNQIFrszTb15csTbk7XAeKnvzLQiWHBDZwi6/xxdrVt/HSqrUd8unNHYu0+Go0bwDXV0W3zdnj44L+Dj/Rm/tK9tl93PgN4rTzU2oL4jBDaP13ql9U5Ad21RkXg4+rklyANXtZtHv/OV8u6nGpZ0J/y/2gGJ/bSXyLxXRIKi5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753500796; c=relaxed/simple;
	bh=WcmAxnFzR1c0YNXoC3/ZiynZy2ZT+5+Nwpw1Chif4Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaX22mwasRMNZr7P5STcsnXTjjR703/LintJanVDhDoIFCae++C0hIrB9UZr2qyZh+In8Lu4kI3j1mylcCUQ0IUhx4L/iDeXW33b86IrUv4DN2MutVcm8YrQkcwaLc4Tazdzr/qQOArNH5NRtAv0J2DJqG8AoHn9g/gz28BHfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4A2//fp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sOf/JsoJMrRn21goOdJm4+ac5LJbqkVW+ltM27ZJiRM=; b=T4A2//fpP7ng2tgBSTerx+g2CY
	Tw9hKP6h0ejao7H8r3Vx4CVlTBadoL9hwhlPqq3xJCrGPwdL+lPQCBmQ6OHPFHvW7myRAUIV5Zjg/
	/CmL0RnpxfZKlzph6nJFMoOx9iKbfYTyEjBIIsvKQBSSJptrb3hAc14Gzx7RebRFftfmx2BijBL3E
	BCSX48jOUiaKzZ9ENw+kc1/RM2dC4dVjZ/3Y3lIt55M0u3lbwan3zkvdfbY9ammRDVki2DWVETgf3
	lTx/GNO0rVr9wDOC/d9uGHvYXlvg+WgBp3O6gbmVNyEbrx06sOypAQEAAkAutsLyutbAoKUOLB/Qn
	KR648+1A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufVeq-0000000B5FQ-1bOC;
	Sat, 26 Jul 2025 03:33:12 +0000
Message-ID: <05ee7001-6425-43ab-a929-e1e7924d1d0e@infradead.org>
Date: Fri, 25 Jul 2025 20:33:11 -0700
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



On 7/24/25 6:54 AM, Eugen Hristev wrote:
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index e0777f5ed543..412ef182d5c2 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -245,4 +245,8 @@ source "drivers/hte/Kconfig"
>  
>  source "drivers/cdx/Kconfig"
>  
> +source "drivers/dpll/Kconfig"

Why adding dpll here? It's already in this Kconfig file.


> +
> +source "drivers/debug/Kconfig"
> +
>  endmenu

-- 
~Randy


