Return-Path: <linux-arch+bounces-1495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C027839BAB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B7C1F256E1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6044E1D8;
	Tue, 23 Jan 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9Isv8OQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4A4E1D7;
	Tue, 23 Jan 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047291; cv=none; b=dis+14x7gyXE0C+FvDicXzKzjY9H7W8hSvGNMW24+gQ1HkfPtk+2KoFlLnE15ShpITmCZBNl93oDA1m75g8PvWfaB23FIbl9MLtnBXXrg9boKlqHDuqXy8zp1/6ZpurIuXJ9Qk5PYESpCQpj2fAEfkcLcSYWrRpT444HBToe4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047291; c=relaxed/simple;
	bh=pjyzUud5KlySPrvq7AIu5beN1GyIySO6QDXww6kfcQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trqMWLCe8volBhvdZpE2dCYlAwiwinyAkmDlNrrr4pHN+lRb9NWtH0AnJQUPBpesqg/lAD6GCNuAuwWkaPdRCX6HeUj7PPahc4LblgyTUAR2KJo7F4qX1NzZ1J3jE+0fAyqSfq2No2s5h+v0God5qIN9yC94n9F6Z+vxMBnGyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9Isv8OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30555C433C7;
	Tue, 23 Jan 2024 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706047290;
	bh=pjyzUud5KlySPrvq7AIu5beN1GyIySO6QDXww6kfcQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9Isv8OQd8GRjuFyskKTCe76BdmbbJy61HUWLIM5ZGWxLt3oCueyKO2aSll5tUrZy
	 1OJi37Y9sa+bMgNu/a53qE1lPFzuZMyKTYHEDu6/3ekr6kmZI7HEYuJoRrNyDB/kya
	 Rlg4BfnR4hdt3sRDFHYFymQGODitukTtG/9MgHCMvMfOUlG5ti8wHVBd4jzduTE9Py
	 Nr8HpNT+neeABSc1RqlV5/iXnpeIXD+mDTO5m3v3suDxqbP7a/l3njya60Pni1Dk7t
	 duIfFInV01BD6wnWqFZE+BiQ/9omDUpu7mxjRAGkkwSFPUisr2AQ65Ek+QPI340mMT
	 UMEW2sQK091TA==
Date: Tue, 23 Jan 2024 23:01:25 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 02/21] spi: s3c64xx: sort headers alphabetically
Message-ID: <k7xw5ygzcai7weoei3wcoyxzt3r62kl3n3euhz3kyhemedqffp@4ol4vrgok5kb>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-3-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-3-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:01PM +0000, Tudor Ambarus wrote:
> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

