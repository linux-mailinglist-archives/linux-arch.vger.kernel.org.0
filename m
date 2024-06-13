Return-Path: <linux-arch+bounces-4875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3A9062E5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 05:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D388B1C21BEF
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 03:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B088131182;
	Thu, 13 Jun 2024 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="YLtY4jl3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EA12EBE9;
	Thu, 13 Jun 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718251044; cv=none; b=rHleMCtI079IM4ksaxEkjbamluEF3xxWTbRxY9z4ZKxIFLRdEQzXXWlDCLNz3FVz6PzmSDCHeDZL1VCztyEgUBLx78Z9GMYoxYZITcT+m0DN842wGAdGEsvkwKTmpkGIJhrtpuT4Jlfsy/lcTB0ySCuqsx/GKGTz4ZiV/vURrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718251044; c=relaxed/simple;
	bh=Z+LgvOUc59Gim16Zn7vezBws0OOuIFE03isIuxruS+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV7QyJ8922HMGE9wje/IK3A2ntmARXCtadK57ICPoR6taZuk/JR++OLEDS4A6IHTQ8kliHYA0CtxuTMSCEy4/qSeZi0bW+cj70ZwZ8z4vWzCuge3tGEe4sikW+MEFCjR0T+FVv6s+OU8mIHzoU4EOrFvME1mTIt0TM02edNQPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=YLtY4jl3; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vm4GMiqmWdF5BUuXmosjQIp8baqxfdAQbkE641yS/yw=; b=YLtY4jl30fUeBh5dEKcOsWnAdt
	j8YOXyu1lWA2CYTLfaEXvkegedznRggQ/3cOTBjDF6JNaTgLXqJ10WRyDszcFknQXQboknM9NO+6N
	PLtV6qQUDaK02eH0w4OHiegGtlLmsaqTIL95J9AGrUCZBn5vmgJVkWA6jdJN//AX4m1Fu61ESycpJ
	jlkQIGJeILy88A18wgCcW7LkDH6CkOEsDVsh9pJG/QjJz5W5a1oE+/PWJbG7ZfzJIAEMw6m59M6UY
	wmb/DWKEUX1mnNh6FYgJZO8WgoHurlAje3iuXbe1Ve9meHpDL7dnR2v1mVDtq+R2tRw9UTHs+7ozH
	8LTH2pnQ==;
Received: from [2001:9e8:9f0:d301:3235:adff:fed0:37e6] (port=52066 helo=lindesnes.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sHbaB-006lkT-VZ;
	Thu, 13 Jun 2024 05:57:04 +0200
Date: Thu, 13 Jun 2024 05:57:00 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kbuild: remove PROVIDE() for kallsyms symbols
Message-ID: <20240613-monumental-basilisk-of-temperance-7dda6e@lindesnes>
References: <20240610112657.602958-1-masahiroy@kernel.org>
 <20240610112657.602958-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610112657.602958-3-masahiroy@kernel.org>

On Mon, Jun 10, 2024 at 08:25:17PM +0900, Masahiro Yamada wrote:
> This reimplements commit 951bcae6c5a0 ("kallsyms: Avoid weak references
> for kallsyms symbols") because I am not a big fan of PROVIDE().
> 
> As an alternative solution, this commit prepends one more kallsyms step.
> 
>     KSYMS   .tmp_vmlinux.kallsyms0.S          # added
>     AS      .tmp_vmlinux.kallsyms0.o          # added
>     LD      .tmp_vmlinux.btf
>     BTF     .btf.vmlinux.bin.o
>     LD      .tmp_vmlinux.kallsyms1
>     NM      .tmp_vmlinux.kallsyms1.syms
>     KSYMS   .tmp_vmlinux.kallsyms1.S
>     AS      .tmp_vmlinux.kallsyms1.o
>     LD      .tmp_vmlinux.kallsyms2
>     NM      .tmp_vmlinux.kallsyms2.syms
>     KSYMS   .tmp_vmlinux.kallsyms2.S
>     AS      .tmp_vmlinux.kallsyms2.o
>     LD      vmlinux
> 
> Step 0 takes /dev/null as input, and generates .tmp_vmlinux.kallsyms0.o,
> which has a valid kallsyms format with the empty symbol list, and can be
> linked to vmlinux. Since it is really small, the added compile-time cost
> is negligible.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

