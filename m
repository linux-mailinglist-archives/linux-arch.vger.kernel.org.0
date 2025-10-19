Return-Path: <linux-arch+bounces-14196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F15BEEDDB
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0913F3E296F
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241C23EAAB;
	Sun, 19 Oct 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbEHeOa3"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C3238D52;
	Sun, 19 Oct 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760911184; cv=none; b=SIAmMln3PB25iBuFwOxe3u9n+kbjY5WWhS+Y3VnzfwFrCiZx0oCzNh7VPbpe/EeiFa9MNPEPOxZGfcnxEyILGyNMqaSEB+Jc5nj6l8pmTZZH2Vuo3X0SCrSsMme+JH9YhGaeVqoEJHoX7zEFXHum/CN89cRxvOfSV4pJb1lqU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760911184; c=relaxed/simple;
	bh=9gJD+/z6WMKuMzZ+vMbZPsjUTts/7SWAlnCvg+NXSBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n44+KLZwpIfLRLo92mzWKSMr6LsbruvLMf/hvXQ6f+QWVMtx7A9HkQi/Z7tvGpFGVtWII6h+/U5LoRSfSH9Cefv71rOePnco4GAE0+JgKgLAaa3us5u2p9ro+3CNeWxtIj7B0oOJu+YAXDrDywdeI/hJjZqqmpIQ2lwzwy4FeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kbEHeOa3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JSzkyJlxHWH5gCJ/x765U9+rz4V46GcyOEbOO4wKhNc=; b=kbEHeOa3BIhnDinxourF5kBpW/
	QGJuTsj77UfC0Hmnbd6v9sPTa8DByiW8rJhowA3iULWWiBCOP26ZdZ3NbUvZkKQz3ORxJEjvK6YLk
	o8MSkt/gAA6TjJ8kkhaXk33S4FnoxZtyljoz2N51vb9FwNn3MYoNp2hzHcSMNingo8nmJpTTLiUSN
	5PTaI3PXs+I+41nF2BVXvCHJBKW696mVxa9p0TQPSfiNPC/gCPY/sd6RKQoMt/Kb7pmLd6+Y7AR0N
	Tj+afTosjCTbC2kXTOBoEmBsTO+yA7B7oSxNDppPFwe7rSb5aMzq2nyt2BDpUPdTvS1eRqbqkNObL
	twkeE0DQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAbRG-0000000BU2M-1bb9;
	Sun, 19 Oct 2025 21:59:42 +0000
Message-ID: <1bf734c8-ca29-4ed6-a10a-9595b2c844b8@infradead.org>
Date: Sun, 19 Oct 2025 14:59:41 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] csky: Remove compile warning for CONFIG_SMP
To: guoren@kernel.org
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 linux-arch@vger.kernel.org
References: <20251019110214.3392011-1-guoren@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251019110214.3392011-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/25 4:02 AM, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> When CONFIG_SMP is enabled, there is a compile warning:
> 
> arch/csky/kernel/smp.c:242:6: warning: no previous prototype for
> 'csky_start_secondary' [-Wmissing-prototypes]
>   242 | void csky_start_secondary(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> 
> Add a similar prototype with csky_start in sections.h.
> 
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/csky/include/asm/sections.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/csky/include/asm/sections.h b/arch/csky/include/asm/sections.h
> index 83e82b7c0f6c..ee5cdf226a9b 100644
> --- a/arch/csky/include/asm/sections.h
> +++ b/arch/csky/include/asm/sections.h
> @@ -8,5 +8,6 @@
>  extern char _start[];
>  
>  asmlinkage void csky_start(unsigned int unused, void *dtb_start);
> +asmlinkage void csky_start_secondary(void);
>  
>  #endif /* __ASM_SECTIONS_H */

-- 
~Randy

