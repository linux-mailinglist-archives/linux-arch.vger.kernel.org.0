Return-Path: <linux-arch+bounces-8854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28979BCCBF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C571C226C9
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15D1D5AD8;
	Tue,  5 Nov 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lhnflyte"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C81D5148;
	Tue,  5 Nov 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809813; cv=none; b=LftFAZy989H8jZo1Jj2TEN3p1UqiZdL83TKjqw3D7qCqHoZ0VzmQyn1UTx3yrHM70fldIIMqFmaJfHYfiuGXjcG8NH1f30D4AYRp2yuc7xc0NDV0sl7hsDDBHLe7/j1sgFrI2S4o67xkK/61KQld//xdV4IHlrfwuIVRp9aHxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809813; c=relaxed/simple;
	bh=Qm3b4MpO1Fe8e/Ld3u4VhVsn8ejPDFe9CniAc0VZjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmDV+cHnIkULSKHC5p/aMGWwO32PWjFJaQk0Cm0LqXjoL6+kiTN+a44Rx8pDN2SjI5TRn73vMHc8HGUVc8430cNrONahm++LYaMTL6ehLVtmXsYyoojFcTYtyLxF3p4aNTDTqRDPquUSDQ7UPDYvNX25HaWdF7Lh5hgMf5Q8cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lhnflyte; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 828342A8B28;
	Tue,  5 Nov 2024 13:30:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730809809;
	bh=Qm3b4MpO1Fe8e/Ld3u4VhVsn8ejPDFe9CniAc0VZjro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhnflyteDCFgrl7hoScfNJdXzKoh8q1nT7KsLVnYL2t47AM3vEXud7R+r/GG/4nTb
	 5/GGnUglaeNF1/IlEi2PU1csYiBH7oWD8d63lkcfiFV9HHZSw3f398mwT+SShVtp4F
	 S29LC9FmADRrAiFaaxm+33MP0D1+olJvL+Ix39kNH7rApvBMDTbC2I+Iz0+LR/jM7K
	 KHzi4l5ovisi/OTxFUJGVUdQV1bQYK0W0r1xfQRYCXrNcY+1M85rvmm6Gx+hxxpJPz
	 jGrENVIDBx09vfZaf+FIm0EdCwkkbesfh7HOMj2AuT9ySAPvIRpFuDi+OXUYFqo9AE
	 gFj5Q6hcAN3FA==
Date: Tue, 5 Nov 2024 13:30:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, jgg@nvidia.com,
	kevin.tian@intel.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	pandoh@google.com, kumaranand@google.com,
	Uros Bizjak <ubizjak@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
Message-ID: <ZyoP0IKVmxfesRU8@8bytes.org>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101162304.4688-4-suravee.suthikulpanit@amd.com>

On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wrote:
>  include/asm-generic/rwonce.h   | 2 +-
>  include/linux/compiler_types.h | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

This patch needs Cc:

	Arnd Bergmann <arnd@arndb.de>
	linux-arch@vger.kernel.org

> 
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 8d0a6280e982..8bf942ad5ef3 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -33,7 +33,7 @@
>   * (e.g. a virtual address) and a strong prevailing wind.
>   */
>  #define compiletime_assert_rwonce_type(t)					\
> -	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
> +	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(__dword_type), \
>  		"Unsupported access size for {READ,WRITE}_ONCE().")
>  
>  /*
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 1a957ea2f4fe..54b56ae25db7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -469,6 +469,12 @@ struct ftrace_likely_data {
>  		unsigned type:	(unsigned type)0,			\
>  		signed type:	(signed type)0
>  
> +#ifdef __SIZEOF_INT128__
> +#define __dword_type __int128
> +#else
> +#define __dword_type long long
> +#endif
> +
>  #define __unqual_scalar_typeof(x) typeof(				\
>  		_Generic((x),						\
>  			 char:	(char)0,				\
> @@ -476,7 +482,7 @@ struct ftrace_likely_data {
>  			 __scalar_type_to_expr_cases(short),		\
>  			 __scalar_type_to_expr_cases(int),		\
>  			 __scalar_type_to_expr_cases(long),		\
> -			 __scalar_type_to_expr_cases(long long),	\
> +			 __scalar_type_to_expr_cases(__dword_type),	\
>  			 default: (x)))
>  
>  /* Is this type a native word size -- useful for atomic operations */
> -- 
> 2.34.1
> 

