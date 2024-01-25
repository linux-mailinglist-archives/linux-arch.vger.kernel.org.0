Return-Path: <linux-arch+bounces-1700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07783CF4A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F701F27A5D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8713B7BD;
	Thu, 25 Jan 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWhY67+2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB46130E3C;
	Thu, 25 Jan 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221543; cv=none; b=GJjcvWEmatNYBG80N2jQZJvcibe6+lQE/8SY9wR2b6uiRgOHLGPNTGG98HYR+eqLXG4ZArSunv51qqjjefbrtGuSY+XeLS24Rxq2FrFtwuhpnUSj8EqMZKXESD/AUaOSWLI71wwAmXTRqdsKeZbPnRq+Tsc2l1LBo9qbJ5/h0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221543; c=relaxed/simple;
	bh=M1x7sdbxaUA9P4s6CLIfqzwLiLNP8PZ3MFdUmOh5aGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPi9NIbUuhpMBBID1Lk0WAMH9sXHkgK6ToOy3LmMKJy4R9XB0uCu0HtvoOxI4K1YSzHYIwlaqe4pSuU62Vv8mGn6KTgwJUFwInXhe2M5flukC9s4V3DNkvSWkj3lIkgCKVMlJ81JFAnNu9qBqR6AvAbtYHeh8itQZWHCbfdCYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWhY67+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91891C433C7;
	Thu, 25 Jan 2024 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221543;
	bh=M1x7sdbxaUA9P4s6CLIfqzwLiLNP8PZ3MFdUmOh5aGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWhY67+2p6a+wqDZgb7327OyCpkF5uFMJhLPWhQgGgERBIoY7QhFTVaRvvEJl/ZBf
	 Pgj7A3G74ZjygE+B75h8DTAD7tXvvQUwk2YBSgmxhToDiOfsp2/LV8Xo0Y3Qi2Il2H
	 dPCdvGYWF1zMU6r0sVf7WLipEYqVi5QnaZj+RD98UfZuAya/Rvmg7bYhWllplz7pYZ
	 u6YhVwF4W/HvQHQ1XUgcn+hDoyGkrGrdDwPMI9mvWbQWYWMekQ7mSBJ6DGDE81eeNx
	 4j93gVC9JPR5sioHHMjK40JAIxXCtI2H6UDP9A8d7wjH5F3znqpTASAw79YRKjede/
	 581i0o/4nlRfg==
Date: Thu, 25 Jan 2024 23:25:37 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 00/21] spi: s3c64xx: winter cleanup and gs101 support
Message-ID: <zbxkm5jbngci5dp3oxcjccnltpht7wsyrvvekozwcsfv5ly3r4@ms3c3bzxgqqx>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <e233f4ff-9ed9-42bd-8ffb-17b66bcf2b5b@sirena.org.uk>
 <7c998d34-919b-46e7-8942-75da94d5ac21@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c998d34-919b-46e7-8942-75da94d5ac21@linaro.org>

Hi Tudor,

> >> The patch set cleans a bit the driver and adds support for gs101 SPI.
> >>
> >> Apart of the SPI patches, I added support for iowrite{8,16}_32 accessors
> >> in asm-generic/io.h. This will allow devices that require 32 bits
> >> register accesses to write data in chunks of 8 or 16 bits (a typical use
> >> case is SPI, where clients can request transfers in words of 8 bits for
> >> example). GS101 only allows 32bit register accesses otherwise it raisses
> >> a Serror Interrupt and hangs the system, thus the accessors are needed
> >> here. If the accessors are fine, I expect they'll be queued either to
> >> the SPI tree or to the ASM header files tree, but by providing an
> >> immutable tag, so that the other tree can merge them too.
> >>
> >> The SPI patches were tested with the spi-loopback-test on the gs101
> >> controller.
> > 
> > The reformatting in this series will conflict with the SPI changes in:
> > 
> >    https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@linaro.org
> > 
> > Can you please pull those into this series or otherwise coordinate?
> 
> ah, I haven't noticed Sam's updates. I'll rebase on top of his set and
> adapt if necessary. I'll review that set in a sec.

it's a long series, please give it a few days before resending
it.

Thanks,
Andi

