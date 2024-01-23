Return-Path: <linux-arch+bounces-1500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D9839C3B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496831C26B2B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4850245;
	Tue, 23 Jan 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNWj2e2K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797347F5D;
	Tue, 23 Jan 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049038; cv=none; b=GpX14rPu0iVijeVSmayI9j/3cRbGbkNLNv9o0ISok94jO/EfNDnoYqaVBxDSvgOfaf44hHMXb20YSOQXEwAigkGvsHXvDbJYqhnp6f6eYspouTrPf75PUn0N/JkjVQwM9keySxJ/BLp+LqqN/RSztrwigk26BF6t6EFBURROJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049038; c=relaxed/simple;
	bh=7kKINHb5Nt5WfKDy0Peg36VTWJrVWe+U4ainCLwsCCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT9JtuNMyJN8D9txxtROJBW9qMufgoiur/c4EjqL/lJ5kOXQut6s66ACsUKUY3Add8NfQKujl4JrpWpOC9uIOKUtCOYFtIIGhnTN7BdpCeHvwiNnhCbjAF+7a5A97uxFdsLUjt0S1W5n6JN6y3nucQwkr3ZmQWS08NUkSI2xUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNWj2e2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0777BC433F1;
	Tue, 23 Jan 2024 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049037;
	bh=7kKINHb5Nt5WfKDy0Peg36VTWJrVWe+U4ainCLwsCCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNWj2e2KF5kboOy/ZwF+ZoQHyhJlhtd06op6ThgR3s5Z9AgIZZ0wgx0Xmpw+SfMfK
	 tvTcZWn8C9bLwIu9Lo25Xf4meDgFN4QpbN6lODh37YNDgOrvObge5IrLf1OZypR4d7
	 Jf6GLy71Ag0nPcCad4n+RquDWnEL+sIEAfWdbyzkdvJRtVUNReB+gbrZSru6fuL86W
	 6OPSSjrFuzDHjFazCvld5KWpaL5vnDlfZMx+rLAKh6iEKduz933fhsHu67NL5v2nuF
	 bgscNY2QVJyUWJkc/fOGH4p1AREA6/+lxV8xzaTVcnWhwRxrK1itQFT5bnDja9FtWV
	 CFKHQIXWwtuKg==
Date: Tue, 23 Jan 2024 23:30:33 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 06/21] spi: s3c64xx: remove else after return
Message-ID: <hanxpspn5sogibyku5hl45vukin4qgjrmizoxfdzfobz5td5t6@3bgmrtg5mgsp>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-7-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-7-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:05PM +0000, Tudor Ambarus wrote:
> Else case is not needed after a return, remove it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

