Return-Path: <linux-arch+bounces-14981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A358BC72BAB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C4C6029C12
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EF302758;
	Thu, 20 Nov 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pcyMLUAn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4k+Yt5/S"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF5DDC5;
	Thu, 20 Nov 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626271; cv=none; b=QhOvsutqSV+VUAvkn0fzdvTkZmyL5mGx7L3C+Y8c3xP8T+QxMD2341Eojj2mFqfaxwHF5rWZFBVmc4xIlBPsgp96bOe4Wir+/3DacsvcrN7TB1qXq2ZjD3JGmcrkOb6JGoVyEVDKh9GBbFB/hTjFdz1U0qIsGtKyuQY07NmOBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626271; c=relaxed/simple;
	bh=fykwePHW8ytxw3u8+h55MdAwS49Cj0vEfXtlPgQ7oFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3Bxacv3S0aikF1f60DhsF0FBu7CnZxvdSNZO+l9EEHNctbj5vv5mejum6fkdQeLrYUTZgNnx/+tKf0KEOjJFpox3QTCpKRk0fUfRTHINwQKSsxrNbF1EfC6YASdc4tjYImjOpvyQ7viVkUCPyVR2vNBr8hOdHq4Vc8jF3FrtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pcyMLUAn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4k+Yt5/S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 09:11:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763626266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHSpqa5Dvi4RHVPBYa6gTgdWwp96h2TS52M5RDQyHrM=;
	b=pcyMLUAnrVim7Bywz2ipzXSKymHbSSFEIvvEDilfT6RQ2zTHLKhcahlR0+e0rkj1JXnFZX
	QzxV3B1PEWAqt3S0bltnpaB7ISuKKECpKwytcmqIqbUBDurr7WdIdgje4jn/R6r2zMAWrO
	l69o9mLv/goYdhgiafj/qZk1cYM+GUh0HwS7NEvqOVNfe+A+fOi2c7SLdz+5kUIZzft5Gh
	I4PNg6Xr/xHq/dUHrvo0xqfxOpoEcpu9NXSlwDcx+ZKPkYjg+FDEFtxaXiOof2Gm5Zh5Ak
	s23VwcccFdO4Rq747gPaWVFXQCTQXR6XE7jiosv6RCOs3Eg7DSZwiz4Q0Ys4cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763626266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHSpqa5Dvi4RHVPBYa6gTgdWwp96h2TS52M5RDQyHrM=;
	b=4k+Yt5/SSl244gdbQZVjALQqir3ha4793v38HUazdVreTh2q3xAWbuCBWdDADzjfLKPuyh
	zbHe3svdvanSNfAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for
 32BIT/64BIT
Message-ID: <20251120090846-746f973f-e08a-46ab-a00d-87a5be759941@linutronix.de>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118112728.571869-14-chenhuacai@loongson.cn>

On Tue, Nov 18, 2025 at 07:27:27PM +0800, Huacai Chen wrote:
> Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> loongson64_defconfig (for 64BIT).
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++++++
>  ...ongson3_defconfig => loongson64_defconfig} |    0
>  2 files changed, 1110 insertions(+)
>  create mode 100644 arch/loongarch/configs/loongson32_defconfig
>  rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (100%)

KBUILD_DEFCONFIG also needs to be adapted to this rename.

FYI the cover letter says the series is based on v6.16-rc6, but the series
doesn't apply to it.

(...)

