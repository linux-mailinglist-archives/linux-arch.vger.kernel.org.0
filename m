Return-Path: <linux-arch+bounces-8794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A99BA5CE
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F5228162B
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC83172BCE;
	Sun,  3 Nov 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgyAPyUV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F1E552;
	Sun,  3 Nov 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730642253; cv=none; b=ZBXmgZ0cqbZi5vHhV2ERij70wZq4JibuDCHPS0KcAq8nwCgKBw28CsRI/Z3okA8EsCh0Y5c6K7s2jKv7Bdx6Cfj/xvTf/8V3sykMqGD4UlCsFIUAFJrqCE5ty37dAUbinMYgEYtejW1aV7qaqIVRO8sEmhmjJjK1cKl6GW6RqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730642253; c=relaxed/simple;
	bh=VxXH6aqpqHLHF5oRJ5vnT5vpm2uvtxBA9AHVL/CAjN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHUAdbtVg33r6Jk88Ja/xm7sNB77wMOkYKE1j36tvHmayjw/dgGT0WqQ3HypDXUp2SVYh4jMF4Krl5lZ371bciCk902mZ/aLg/NvcAZLgxsnZHoXTUuISXMGTZZHc9oXTWWU35YDTKOmUCcr5b/RKrTQthZdL33cT7u2c82I1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgyAPyUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014DBC4CECD;
	Sun,  3 Nov 2024 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730642252;
	bh=VxXH6aqpqHLHF5oRJ5vnT5vpm2uvtxBA9AHVL/CAjN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgyAPyUVzD+RX89LUiOchP3Aw0Js3GqP/DtnP8pAtBfaDedVT967mnJ82pBpE9KRN
	 ftK066xUf9/ky+dJfz8zo3ZrlOBBIwzAtGdFfjJW9BVBxme/2A7kncMayzUKYZ5xhE
	 Vmbx+QZrBR8d8lG3rs/hr5GcPBgei7uWbzXvPZxURjQuM+X2Jr3q9fjSTk/A+86b8b
	 PyY1dLiWpn2qN/lGx/OjiSXOJsgO36lUUbVoSgk7DuHWX2RDImBvvO7ui25Wr0tZYV
	 0Xe+h5Xj9lpyGr/BCNqgwMBTm5cG9eqiST44/fbsaiqt3sqcAsOAptCwqbnUAM9n9Z
	 n3EbHG0jaagjw==
Date: Sun, 3 Nov 2024 05:57:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, kernel@xen0n.name, chenhuacai@kernel.org,
	xry111@xry111.site, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through
 lib
Message-ID: <20241103135730.GA813@quark.localdomain>
References: <20241025191454.72616-7-ebiggers@kernel.org>
 <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>

On Sun, Nov 03, 2024 at 09:36:55PM +0800, WangYuli wrote:
> Even though the narrower CRC instructions doesn't require GRLEN=64, they still *aren't* part of LA32 (LoongArch reference manual v1.10, Volume 1, Table 2-1).
> Link: https://lore.kernel.org/all/0a7d0a9e-c56e-4ee2-a83b-00164a450abe@xen0n.name/
> 
> Therefore, we could not directly add ARCH_HAS_CRC32 to config LOONGARCH.
> 

There's still a runtime CPU feature check of cpu_has(CPU_FEATURE_CRC32).
See arch/loongarch/lib/crc32-loongarch.c.  So it's the same as before.
ARCH_HAS_CRC32 just means that the file will be compiled.

If you're trying to say that you think this file should be built only when
CONFIG_64BIT=y, then that would be an existing bug since the existing file
arch/loongarch/crypto/crc32-loongarch.c was built for both 32-bit and 64-bit.
But if you think this is a bug, I can fix this too.

- Eric

