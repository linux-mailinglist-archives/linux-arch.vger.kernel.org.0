Return-Path: <linux-arch+bounces-11875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A65AB0228
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 20:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB041C4342A
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF226280F;
	Thu,  8 May 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6qe3Xtz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7B38384;
	Thu,  8 May 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727612; cv=none; b=Q1naJ2n2GwZe6L+RbEe7eoerawyw4xeOd7zr/KiC5yTOzmU+c05De1NXgN66VmDhr1NwVlAY6Y9WyktA2ZA+C+nYCv3xccAJTJKq3fIMfUiri3Oo094+Ukw8hz1dwfsxATZBxxOjjw4FcbM1r21n4on5U604fWoa1x+3OPVV02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727612; c=relaxed/simple;
	bh=T3fd8i3e9m2qTXLSzLMLI6WreQFWFZts5ieUhzAtv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcxZ4Sxm01eSVLMQb8OVBAVBNn77oJAMLSDnAjeR7V26oNN42P8+B8xZS4VGPvnHXwhfol63WMfPW+HwZ2/q4s2A5AMFMo1DAzJjHt7BIBhxGBbVeNNd9wbgEWgGF+TFIupJYhbklY1s6QHrkwLMHmiOvo/kfYi8QnLz9A/PbnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6qe3Xtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4981EC4CEE7;
	Thu,  8 May 2025 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746727611;
	bh=T3fd8i3e9m2qTXLSzLMLI6WreQFWFZts5ieUhzAtv50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6qe3XtzC0dgxeaQP4aahmUFX24uY2iZ3t2sb6neITe69z8y/KsV14e0Un9m1jGK2
	 /tEnt3sdoHSmcStSrNJVclL2CaRyAjciHa73CCjMdKHpFD9blJNdWaOeeI77jtdubT
	 DjtKSPu29fda7idtTVch/6nzYVK1BqOW14ORfPccTGLKQkDdqmisXANhvptuC0tB9O
	 TerEWeAPM8x2xKoI4x/n0y4Zk27bbk+n6O4fipuNoakdGt6dvd4xUAiMHt3nza9IMh
	 HApWd5IFoifI1COGvPPwFJuVoSUh2d1oXeBxiuf/SD+xDmuqoXrGs3cG3w0fU5dfXY
	 FVGqTmzoMkKbQ==
Date: Thu, 8 May 2025 18:06:49 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jason@zx2c4.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 07/13] crypto: riscv/sha256 - implement library
 instead of shash
Message-ID: <20250508180649.GA570496@google.com>
References: <20250428170040.423825-8-ebiggers@kernel.org>
 <mhng-0b1a0c43-eff8-4ea0-9aaa-46727504555c@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0b1a0c43-eff8-4ea0-9aaa-46727504555c@palmer-ri-x1c9a>

On Thu, May 08, 2025 at 10:45:39AM -0700, Palmer Dabbelt wrote:
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I assume you want to keep these all together somewhere, so I'm going to 
> drop it from the RISC-V patchwork.

Thanks!  Yes, this series was already applied to "cryptodev"
(https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/).

- Eric

