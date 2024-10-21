Return-Path: <linux-arch+bounces-8381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9939A7172
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E5A1C21882
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312A1F4FAF;
	Mon, 21 Oct 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJQY/rj4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570261CBEB6;
	Mon, 21 Oct 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533402; cv=none; b=sBmZoDA2+kHz2LcDdrbct6YhDt/mvO0Ao5y1VXPMMQxP7/OFd5hl/sQLzUZCPkhmXgpCDHegd1+yIO3LQYzEtaF5hg9ySOH83GHph36NCjOZXsggWE2WpEFiV1NgXA9qjxWzhUQaCCLXKkp7PjJsGdwgFemRPW6lCpKewyNCNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533402; c=relaxed/simple;
	bh=iOp6UPk7kp6624trt50V9GCSl7TCmUx91AXnl52vexs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyJL+OGZwtVdd0o9uu1OLks4L11/TH3IkqaNJ/QagCRCQPer47uMTTtxkS5zRdcryA0OnWTx4D3TrGBLmvWNtt/mvBMDFD4RqWntO67QMDSuLjIj3cKqnpK9pcDHmQTqegQp34/JwSFT7YrMhNn70sh2kyRSwCJ/eDw8NgEEUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJQY/rj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F2FC4CEC7;
	Mon, 21 Oct 2024 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533402;
	bh=iOp6UPk7kp6624trt50V9GCSl7TCmUx91AXnl52vexs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJQY/rj4pTIO5uEWlo1heoszsTNmf9jrwjFBD0lIbKoaTFxHVpdjurFhvf6qbFqVx
	 3p4d5v2zCCp/LbxdIlTGmC11dWGlMVeXXfBDk8A9Aml+/MAtk2IETKhnM8m6cKxkey
	 BZF/dYUet13hmxhgQOUCWlo2mvzJlbvIRi1nLRTDg+g177wJbtfgI05mwIy3+AOG+C
	 2RdO3YmkeY7RM1WJnyPqFT2fPe/8kLv+1aQd4pfj1zTvRhlxt250RD3qNZbbCGpcse
	 fs5+AtO+kgnLwq3Dm+Zt8UDEsdLr8Tbrkjy5WAyah1cfbA8sbkBGsmyodZGLNuMspU
	 cTEE/rSNQw61A==
Date: Mon, 21 Oct 2024 17:56:40 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 07/15] s390/crc32: expose CRC32 functions through lib
Message-ID: <20241021175640.GA1370449@google.com>
References: <20241021002935.325878-1-ebiggers@kernel.org>
 <20241021002935.325878-8-ebiggers@kernel.org>
 <20241021104007.6950-E-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021104007.6950-E-hca@linux.ibm.com>

On Mon, Oct 21, 2024 at 12:40:07PM +0200, Heiko Carstens wrote:
> What makes sure that all of the code is available automatically if the
> CPU supports the instructions like before? I can see that all CRC32
> related config options support also module build options.
> 
> Before this patch, this module and hence the fast crc32 variants were
> loaded automatically when required CPU features were present.
> Right now I don't how this is happening with this series.

There's just a direct symbol dependency now.  For example
ext4.ko -> crc32-s390.ko [crc32c_le_arch] -> crc32.ko [crc32c_le_base].
So, crc32-$arch.ko always gets loaded when there is a user of one of the CRC32
library functions, provided that it was enabled in the kconfig.

crc32-$arch then calls either the accelerated code or the base code depending on
the CPU features.  On most architectures including s390, I made this use a
static branch, so there is almost no overhead (much less overhead than the
indirect call that was needed before).

This is the same way that some of the crypto library code already works.

> > +static int __init crc32_s390_init(void)
> > +{
> > +	if (cpu_have_feature(S390_CPU_FEATURE_VXRS))
> > +		static_branch_enable(&have_vxrs);
> > +	return 0;
> > +}
> > +arch_initcall(crc32_s390_init);
> 
> I guess this should be changed to:
> 
> module_cpu_feature_match(S390_CPU_FEATURE_VXRS, ...);
> 
> Which would make at least the library functions available if cpu
> features are present. But this looks only like a partial solution of
> the above described problem.
> 
> But maybe I'm missing something.

This is not needed, as per the above.

- Eric

