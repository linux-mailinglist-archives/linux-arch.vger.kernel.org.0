Return-Path: <linux-arch+bounces-13792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC4BA456B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDB56376B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2A1E51EC;
	Fri, 26 Sep 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="iBANSipG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6D86329;
	Fri, 26 Sep 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899036; cv=none; b=rwpGe1lrp8iLH8tZTTZovU/5TOHgPt2lY66UbPAjpx6LzoXthdM9KjX8gOj5RYHwcmDBzeQx+F5g7Crr5F9WJkfK08gr/A80axP02DK89LSvM2uxx4g4e313iA6kWbhFrskX7XQQtDVurmvG2kTveiBDrQRn8yly0fHzsmWF7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899036; c=relaxed/simple;
	bh=tyQNtexv4vqHVKnELrfjkmBZZDlHLHKP1QOEpcldlbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezR2ze0Z1uUhhl2A+fTg5H9BG+54ft1kz3t10ioTkk2xtaLeMrmiqqA7USHT3jM7SDCjBCsoLs5QVm9bHpDeuLNf77qHrhTznN0y0Lt4RLTpIBV5cIguyULoWhslIErlbfM/QEVFljj5rO/YIdzO44ODZWDYhs8SRRp4GaVkRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=iBANSipG reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYDPM19p9z1Fb3J;
	Fri, 26 Sep 2025 17:03:51 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYDPL67lMz1Fb3j;
	Fri, 26 Sep 2025 17:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758899031;
	bh=nuq7yc+8y+lfFVfRlGX+mFqUCjk7Lx2J3L9Cn8VsGtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iBANSipGmx1h+BcUdKycuA7RKD+lgU8C0kRvmrQ+jIpTREwU1IeThUTSlUlvKy9F+
	 A29Vytid7PKZQX3RaHqCEU30/fXkw5mVT8AuThLda6inonID4+q9MeinMTfhUy5aLW
	 Uj6lNsoj+Cq094FjKAKp1et0ORne2HtE/uqeXTbNjHsJTgB0uQY3oguaGMgipVGmC0
	 LNqWIX2QC54ZFwlX12ZZLoCvfmEnlfIEyJ3bBkl6t1FHweRb61sKG11WhtZxrEGPJN
	 Nq6e1qCZXUCo/zp8URho2esk+FSduxtUpTyt5GNQ8Ckjpw9zBhfQv2DQZyW/t2feUx
	 2OLrzzpLTzHOA==
Message-ID: <179e1d67-0599-42ba-be6e-06314f8af798@gaisler.com>
Date: Fri, 26 Sep 2025 17:03:50 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-34-thuth@redhat.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250314071013.1575167-34-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-14 08:10, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/sparc/include/uapi/asm/ptrace.h | 24 ++++++++++++------------
>  arch/sparc/include/uapi/asm/signal.h |  4 ++--
>  arch/sparc/include/uapi/asm/traps.h  |  4 ++--
>  arch/sparc/include/uapi/asm/utrap.h  |  4 ++--
>  4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


