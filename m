Return-Path: <linux-arch+bounces-9374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF09EFE69
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 22:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B128C063
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30C11CEAAC;
	Thu, 12 Dec 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olHk7jG7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3019995A;
	Thu, 12 Dec 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039456; cv=none; b=q6/mnV+AzOqLutTaOicvTx/6t5L1jaq2oUf2DA35Q++vxKXpVSrbkVa5H6j46wYZs0sL+5IVRVU0rPW6qDIUU7QU03VWbgZFc6zoy7OfFYkBsV9PfMOO6ozXSVK8hNWL3P/W2X1Kn6s8Df7aTLUBvyNwFuApXlqMjaCRJlR7q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039456; c=relaxed/simple;
	bh=hF4mJhnVVXZXfZmgDwcher6bwGaSHVExWyvvXFEjp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXyxX5qTluJ/tJdDP3BHIOmLiPaozIW0VSzxubc39ffq124jgIqvMCmlpNBhxnvDXLPoe2EYrNpE+c1AJLxRtxFc3ro3bSVh4DXqzNBnyXiNj2THGFtNJ7st5QbWt6d8f4yv4AmROoCgzSmhTwbsDvKZqu6zJtNNG6k609b0/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olHk7jG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE1CC4CECE;
	Thu, 12 Dec 2024 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734039456;
	bh=hF4mJhnVVXZXfZmgDwcher6bwGaSHVExWyvvXFEjp2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olHk7jG7/rj4jRsPenllCQhTf5QGq/o+IXUWAK82q6pCJzN6i0SdtI7XXvHvfiYLW
	 o7Yb2dtL1CH8VNEjEG8A5mpzTFx8yH0hEIFW7L1nUsgKKc9ugXfj5gaT9OXUqTDi58
	 6N9jkLSNkjhUTqlAcmvg1HLxdVRSD5WcssiicIJ2Nxmvr9M6pJD1wQCUfPhz2WNC+t
	 2xdjNIS1+MX5kC7hdRX17/1bm7hIdvOxPxxX9hHKaS50L38XE0/FImLbSAiegVPTIq
	 VSrgB1QqyjlJeR5aTe0UIkwwE/K4CIPz765ubY7ooteF3fveq0wORNZ7ubo5V6o5Xr
	 rY71XaqihMshQ==
Date: Thu, 12 Dec 2024 13:37:34 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 00/19] Wire up CRC32 library functions to
 arch-optimized code
Message-ID: <20241212213734.GB39696@sol.localdomain>
References: <20241202010844.144356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>

On Sun, Dec 01, 2024 at 05:08:25PM -0800, Eric Biggers wrote:
> This patchset applies to v6.13-rc1 and is also available in git via:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc32-lib-v4
> 
> CRC32 is a family of common non-cryptographic integrity check algorithms
> that are fairly fast with a portable C implementation and become far
> faster still with the CRC32 or carryless multiplication instructions
> that most CPUs have.  9 architectures already have optimized code for at
> least some CRC32 variants; however, except for arm64 this optimized code
> was only accessible through the crypto API, not the library functions.
> 
> This patchset fixes that so that the CRC32 library functions use the
> optimized code.  This allows users to just use the library instead of
> the crypto API.  This is much simpler and also improves performance due
> to eliminating the crypto API overhead including an indirect call.  Some
> examples of updating users are included at the end of the patchset.

FYI, this patchset is now in linux-next via the crc-next branch in my repo.
Additional reviews and acks would always be appreciated, of course.

- Eric

