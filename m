Return-Path: <linux-arch+bounces-1498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7A839C2D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A34B2AAC9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF964F215;
	Tue, 23 Jan 2024 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx8jUSqR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5005B1FE;
	Tue, 23 Jan 2024 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048760; cv=none; b=RGC+EQ4OBuj+nh9UVR+ClYtwE2ssH30n7tyMWg8m6zaTt67pX4SFq2h9jcsWVMwwTlp+OX3mO5GLx2LQsrOp3w5ZO10gldZ//qLe/OhdLRD4wuULPBDpkcRsbcPzBibEU5HQH7G4+OTdxIr39gTP1C9l9qaiLgUG4MLKLtqCq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048760; c=relaxed/simple;
	bh=B1kmLh0XTuUciawhYX2WtVS7ycXcBHNZJ+aUpLr1nNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIFasShcfTRgSrf8agVBrYWCxUIGBmfWeaT6RoWuWfciSg0bce99W4c4vWYAYhxhw4F0ExZjINv7WoDLD06ud4so6cldPv0bjgI4fuJ+1XO9ZxZh3G9RhxNZIH3VuUNwt3PjBeHgbsk+UWS4k2SlaIeL3U9vJRvPs8+kJkBvdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx8jUSqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DBC433F1;
	Tue, 23 Jan 2024 22:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706048759;
	bh=B1kmLh0XTuUciawhYX2WtVS7ycXcBHNZJ+aUpLr1nNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xx8jUSqReIgJXbH9PETzh+aNrwDM/CVN6bUXqCsUjm3Wz0cLfGrPPZOfHujwkIYJB
	 5Ai1+h1BMemRK0XA3RidktCgA5BLg+aelQtfIZoylDcClP7tGzH5sjYpYFzsDLffFE
	 E4NCO6al9a7DAbgryQBpAgw1N/vYsESPHBrt3C5EpHLL6gRZeY46Omfo9tblYJ2STU
	 gLLQbU8b+eMOrMVDPHEPT/hSEs93gT7YBEi2+chR2vjcyxJ187uA+6XU0mirlf1j0N
	 XeeE2rIjtJFwVSFThXYe51UL5ORG88V2hP+NabXrMOQQVWv3KJM2x6GfKALX5XP9RD
	 qy3l/Y5A74v1A==
Date: Tue, 23 Jan 2024 23:25:55 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 04/21] spi: s3c64xx: remove unneeded (void *) casts in
 of_match_table
Message-ID: <2csebdjr3ayq4v5zz27ygu7bcpwzymjyg4j2gcx74fjovkfrxz@rjancstkwnmz>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-5-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-5-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:03PM +0000, Tudor Ambarus wrote:
> of_device_id::data is an opaque pointer. No explicit cast is needed.
> Remove unneeded (void *) casts in of_match_table. While here align the
> compatible and data members.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

