Return-Path: <linux-arch+bounces-9949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B74A215CA
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87530167345
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421715445D;
	Wed, 29 Jan 2025 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Tp33LE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111D1802B;
	Wed, 29 Jan 2025 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112145; cv=none; b=poczDA42pqG3GtBoNzqKMRMSE2y20NfcExG505sRePQeC+Q5Y6oyNL2wpXykRQlHxiFXu7IYSpX+zt1Wt0ghUsWRCZijKYqx3zkdGXDf+Ox4YtHtqVbkvak9Qx7XJUaoqPkcRqvGF+Orc4cExBCSd8KM+Du/YWb38JVeGgBrImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112145; c=relaxed/simple;
	bh=7lLgfsbUvvXkuZ/CHyObEqTqK07OIPpnMi3L8CLFkWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tcURMQ1kJUM89KLMAAj6OEf3EAPGPnoDjhpWS/TXL+Ss1qZswUn8jHlpP+ihclsGe18ra6scr5v9PQ+Ui1Eks8OmjrHU4A5zYqeP+YxTxGE/fNmIKyCkjW7cqgYNlEZXMta8d/aXcl0bKTk2uUkySa+2KCLG8IqpBxHhmSC7GDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Tp33LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E2C4CED3;
	Wed, 29 Jan 2025 00:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738112144;
	bh=7lLgfsbUvvXkuZ/CHyObEqTqK07OIPpnMi3L8CLFkWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0Tp33LEr5mdpx4Jdes8W04nWqwEaLorvXlTwLQeltYmYb4klZ+1dz2ywlTC1b8vX
	 3+k4ui1fUmLbcFjL5APZZHqXajEfDw8XK18yEtuoVQbYLE2/KJ3OWDxcoyJSsIsYNE
	 DtQEthCyYqS56sQa1kB1Swn6qPUBhCaLAgWkwja3f55uChLvycrhuijZWm8POhmtni
	 ykUeyJuvAvFNmoLZJQP4RIXBzVayDzL59pE6M7xHqHJCz+rWiTvl4EPHbNFmFx8Chm
	 4j7efWWME8OF3uvIkfJk+9cFoNkYjHICLOSesiRjPTBgLZGNKhAvpDasPjs5mHTnv5
	 F99y903Tt3oVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE01380AA66;
	Wed, 29 Jan 2025 00:56:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 00/19] Wire up CRC32 library functions to
 arch-optimized code
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173811217076.3973351.8137382917166262630.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 00:56:10 +0000
References: <20241202010844.144356-1-ebiggers@kernel.org>
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-ext4@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Sun,  1 Dec 2024 17:08:25 -0800 you wrote:
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
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,01/19] lib/crc32: drop leading underscores from __crc32c_le_base
    https://git.kernel.org/jaegeuk/f2fs/c/0a499a7e9819
  - [f2fs-dev,v4,02/19] lib/crc32: improve support for arch-specific overrides
    https://git.kernel.org/jaegeuk/f2fs/c/d36cebe03c3a
  - [f2fs-dev,v4,03/19] lib/crc32: expose whether the lib is really optimized at runtime
    https://git.kernel.org/jaegeuk/f2fs/c/b5ae12e0ee09
  - [f2fs-dev,v4,04/19] crypto: crc32 - don't unnecessarily register arch algorithms
    https://git.kernel.org/jaegeuk/f2fs/c/780acb2543ea
  - [f2fs-dev,v4,05/19] arm/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/1e1b6dbc3d9c
  - [f2fs-dev,v4,06/19] loongarch/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/72f51a4f4b07
  - [f2fs-dev,v4,07/19] mips/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/289c270eab5e
  - [f2fs-dev,v4,08/19] powerpc/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/372ff60ac4dd
  - [f2fs-dev,v4,09/19] s390/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/008071917dfc
  - [f2fs-dev,v4,10/19] sparc/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/0f60a8ace577
  - [f2fs-dev,v4,11/19] x86/crc32: update prototype for crc_pcl()
    https://git.kernel.org/jaegeuk/f2fs/c/64e3586c0b61
  - [f2fs-dev,v4,12/19] x86/crc32: update prototype for crc32_pclmul_le_16()
    https://git.kernel.org/jaegeuk/f2fs/c/1e6b72e60a5a
  - [f2fs-dev,v4,13/19] x86/crc32: expose CRC32 functions through lib
    https://git.kernel.org/jaegeuk/f2fs/c/55d1ecceb8d6
  - [f2fs-dev,v4,14/19] bcachefs: Explicitly select CRYPTO from BCACHEFS_FS
    https://git.kernel.org/jaegeuk/f2fs/c/cc354fa7f016
  - [f2fs-dev,v4,15/19] lib/crc32: make crc32c() go directly to lib
    https://git.kernel.org/jaegeuk/f2fs/c/38a9a5121c3b
  - [f2fs-dev,v4,16/19] ext4: switch to using the crc32c library
    https://git.kernel.org/jaegeuk/f2fs/c/f2b4fa19647e
  - [f2fs-dev,v4,17/19] jbd2: switch to using the crc32c library
    https://git.kernel.org/jaegeuk/f2fs/c/dd348f054b24
  - [f2fs-dev,v4,18/19] f2fs: switch to using the crc32 library
    https://git.kernel.org/jaegeuk/f2fs/c/3ca4bec40ee2
  - [f2fs-dev,v4,19/19] scsi: target: iscsi: switch to using the crc32c library
    https://git.kernel.org/jaegeuk/f2fs/c/31e4cdde4d8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



