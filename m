Return-Path: <linux-arch+bounces-9421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E089F6041
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 09:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1142D16E755
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F20D165F18;
	Wed, 18 Dec 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lNbKQX7v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF5176FB4;
	Wed, 18 Dec 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511093; cv=none; b=j4FEat4QqOe51Dkca7XK3BYlz9dyQIeHtCNsNh7ikEnHLnfKbRQmF5azfG4r1uyOz3EqlGb8cQjtOZn+/ffngtVNgx8JSuh1bvEsLzNZH1dUtkEay/ftk4v9b4a7/KtRZ+IkpS0xS8Ho+p5LmKb7Txf6aUa0JgK4pmCQDYQ4JAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511093; c=relaxed/simple;
	bh=9cBpC7Jzg7EStrooikSrqAoz0ndVmDWUvCOWsQYskTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOKOwEP+UDtEIeGPuTCo8t6m0C0Te/u/ekFMlLYYLR3QbzC4vztOCZ+lYnEHigV9admn2Bte7aO2b+bi/0zUCvwKyCChB7+hleZc3f6fuUkmyNRmSKmVvFprf+Oudd7d+wLHa0fLmNyeDTR1ucaiSZvK4il1H0o2HzNHVualQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lNbKQX7v; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8CA7D2C1E66;
	Wed, 18 Dec 2024 09:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734511090;
	bh=9cBpC7Jzg7EStrooikSrqAoz0ndVmDWUvCOWsQYskTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNbKQX7vWaZAAA2/78lj+Bh/6xIcAHnp0k+hgn6dxxla+ubQrJdN80rm/o8Yi+TQ/
	 0R4egM63XVom4IQRRWwNcCiP7R83th5j4bA3KYa2tBkIuuZXbW90pc+1RRe0gaKYSN
	 rPvp71kP3TS7K22jkAm+apdEe/l1WMnB/zxPIIpoeuAvqx94Z7D9CZ+rb79oqxxfsU
	 c0DsdT9lpG7dAA67A4KP701K7NML1hVO1af4jLyf+ZM4HqQd5GppK5r9GQZsltauAl
	 OE4VWrPuhtNnWJ6hcq8zqihyuc3o8q/PcemR2jZJggoic3YYyGzCCR0oUeqR3A1Gpp
	 EtcA6h5YbfrtA==
Date: Wed, 18 Dec 2024 09:38:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, arnd@arndb.de,
	ubizjak@gmail.com, linux-arch@vger.kernel.org, jgg@nvidia.com,
	kevin.tian@intel.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	pandoh@google.com, kumaranand@google.com
Subject: Re: [PATCH v12 0/9] iommu/amd: Use 128-bit cmpxchg operation to
 update DTE
Message-ID: <Z2KJ8SGMoTfx_t76@8bytes.org>
References: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>

On Mon, Nov 18, 2024 at 05:49:28AM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (9):
>   iommu/amd: Misc ACPI IVRS debug info clean up
>   iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
>   iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE
>     flags
>   iommu/amd: Introduce helper function to update 256-bit DTE
>   iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
>   iommu/amd: Introduce helper function get_dte256()
>   iommu/amd: Modify clear_dte_entry() to avoid in-place update
>   iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
>   iommu/amd: Remove amd_iommu_apply_erratum_63()
> 
>  drivers/iommu/amd/amd_iommu.h       |   4 +-
>  drivers/iommu/amd/amd_iommu_types.h |  41 ++-
>  drivers/iommu/amd/init.c            | 229 +++++++++--------
>  drivers/iommu/amd/iommu.c           | 378 +++++++++++++++++++++-------
>  4 files changed, 440 insertions(+), 212 deletions(-)

Applied, thanks.

