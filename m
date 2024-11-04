Return-Path: <linux-arch+bounces-8842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3979BBC46
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C177A282737
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BBB1C2DA4;
	Mon,  4 Nov 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG0ZZ45e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E972176FD2;
	Mon,  4 Nov 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742521; cv=none; b=iqxlTHlEq3Iwk1iMKdJ4RwPoKRq3AmVHkgG2YWx8hdoVccQoc1w7o1cWRRJiczfpzNG20pwHgJnlJ8rKVePT0gOk2gaGuYJiR6HcEynayHqGYYHby1Pe0gdebsG5yNER1Nb1JfAZMAgY8/2kJgTJBcvTAsFGpitZauYsd302jHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742521; c=relaxed/simple;
	bh=kyMZ9fV6X+51trgRY65w1AUDjMP2XEnEX7GkvQFyuQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF1vjMXa9R8x0dQ+lsdq0YSxTKo+D1X6+DOsvt/8ZK/06eITZtN2Yn3CW0q0sk5XAKLHfY7T4b7ssSc5jGmncfhdsSgIRJAWHwNEd3Ta3ZGfjLzjY8zNeX7sABTtLdaKcQ//MPap1vSCoNJJsWlUkopK038/kB7QAEiX+5fLdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG0ZZ45e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1421C4CECE;
	Mon,  4 Nov 2024 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742520;
	bh=kyMZ9fV6X+51trgRY65w1AUDjMP2XEnEX7GkvQFyuQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG0ZZ45eSLTeSuURvGHB3h65F9t7QbkI04hRi4PIn9RQya+KVuOq+cKYwcM7OIRag
	 ftffa9p0RPzhxKxbKbO1phJPPDnrPKDiu3Z4Itvr9Wls0R3DzSPdYDwIWB6GC4b2Kn
	 OEWSQb/cisXjv+NDzmcx6uuXNdVsmOSyH1jBzLk86RwIVvV7yoI0yJMI8N5O1tLxWZ
	 sqPAibypRsiDduXZx2vz4SdLoEWaYuAYo/l7nO/C5PoaF6LQixrBB1eQNUAosrKHye
	 /gCeCfoWgbjXS3QMM1TfccoGnuhihV/zkZVDdun5Dof7x1e0ZdWeQe1z6JZskIC3qV
	 2uU8b6EJ5uv3w==
Date: Mon, 4 Nov 2024 17:48:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 15/18] ext4: switch to using the crc32c library
Message-ID: <20241104174839.GA1049313@google.com>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-16-ebiggers@kernel.org>
 <20241104155900.GH21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104155900.GH21832@frogsfrogsfrogs>

On Mon, Nov 04, 2024 at 07:59:00AM -0800, Darrick J. Wong wrote:
> Hmm.  Looking at your git branch (which was quite helpful to link to!) I
> think for XFS we don't need to change the crc32c() calls, and the only
> porting work that needs to be done is mirroring this Kconfig change?
> And that doesn't even need to be done until someone wants to get rid of
> CONFIG_LIBCRC32C, right?

That's correct, no porting work is required now.  'select LIBCRC32C' should be
replaced with 'select CRC32', but that can be done later.

> > @@ -3278,15 +3263,11 @@ extern void ext4_group_desc_csum_set(struct super_block *sb, __u32 group,
> >  extern int ext4_register_li_request(struct super_block *sb,
> >  				    ext4_group_t first_not_zeroed);
> >  
> >  static inline int ext4_has_metadata_csum(struct super_block *sb)
> >  {
> > -	WARN_ON_ONCE(ext4_has_feature_metadata_csum(sb) &&
> > -		     !EXT4_SB(sb)->s_chksum_driver);
> > -
> > -	return ext4_has_feature_metadata_csum(sb) &&
> > -	       (EXT4_SB(sb)->s_chksum_driver != NULL);
> > +	return ext4_has_feature_metadata_csum(sb);
> >  }
> 
> Nit: Someone might want to
> s/ext4_has_metadata_csum/ext4_has_feature_metadata_csum/ here to get rid
> of the confusingly named trivial helper.
> 

Yes, that should be done as a follow-up patch.

> Otherwise this logic looks ok to me, so
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D

Thanks,

- Eric

