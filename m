Return-Path: <linux-arch+bounces-1496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B35839BB1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE002286BF9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA647F5D;
	Tue, 23 Jan 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djcqF3MT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74533CCA;
	Tue, 23 Jan 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047343; cv=none; b=jY2VOKLOGRdLBTUSghVACOZLXsoKgPkTZLEVcj6T3k4GmrRjMKt1lQjkJ/gzxwYMJbN2uCUdsnzmEOarxhOM641DdeeXHK/Hm1weMezPTtHjo9hx+NGkJEsvGonv3py1SzbLrloMvI3UdVrIsWa5tjZC7tPEEraRMvBFeEU+nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047343; c=relaxed/simple;
	bh=4HVCIMW9jegO7DdwXxGq8xD2G6WMuSGV2thJ1slP9ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXs0qTynX/CRlLjbit7LRsP1f0hG9a6RqB6x9X8PNT/d9d1g0O6wzexKy8sfdC17+tCSgt6eXxJK5MOu2apPPnXvoWYEeZQIAzQKN/QL6CnWqdhmcQ+RiN7TCJOdz5nbwRZnXZtpR70sukZEP/01Do2XVGRAE042R51eEXOmPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djcqF3MT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B72C433F1;
	Tue, 23 Jan 2024 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706047342;
	bh=4HVCIMW9jegO7DdwXxGq8xD2G6WMuSGV2thJ1slP9ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djcqF3MTjHJi0ezjRRNQ1VUOWBdLie556/pxBjc80e1EAKg8+z2cXEefU93+wOJ6X
	 tr14lHKrQikvnuQxln8zrS5QbzJglO1i/tlWtupYWImXP5EeUB8RVpnm4l4Ofc7inV
	 UHGuiaJU9vwOgSS3XcSNiib9m90QvfiUuijGvKYKrRjYZvipeuE9r1e4kNToZ9Bs5/
	 MMMxU2XKUk+pRmdE0IHEmzsZnHEMk7hFgEnNUgPry4qK19UefoOAOtRD6b2lujtMts
	 LbQvmPxz67eybCdawgkZFUlDigBcDb3rXHH/QYk71pNxWYWnH5nOAYPnAfY9IGZK6e
	 HQQKwFZhEWE0A==
Date: Tue, 23 Jan 2024 23:02:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 03/21] spi: s3c64xx: remove extra blank line
Message-ID: <vizhwnmixyfkinkqty2jwzbm3bxixuidseedcovwmsqzhctkbx@iymsguvna4em>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-4-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-4-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:02PM +0000, Tudor Ambarus wrote:
> Remove extra blank line.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

