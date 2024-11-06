Return-Path: <linux-arch+bounces-8869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605339BDAD0
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A081C22E76
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8037F126C10;
	Wed,  6 Nov 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JEsGig4D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A513C918
	for <linux-arch@vger.kernel.org>; Wed,  6 Nov 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854851; cv=none; b=ttISdV192xH9bhBcPU9CTCyhfBLxsdOEDI/qRQaFKpYFuaeT3vM1lw4R63Iovzo/LEmOlPgfYqa7bd3KiBdVK0Qm66sQ4sh1YO31pRevlm0y7qmNV/nHSySQAwSH7heypWjBi8gAwW/mL4I3x5FYxW+uMOZBTFiiXpp/6iF2OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854851; c=relaxed/simple;
	bh=IKgrnniVBDUOdYJDQSGCjagO607qV4tQBaXh0igYrV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNbJTwb9YXqeuSruvQZu2k2Wmzzk2Qdh6qkkkV/W0xXGTVVlcn26s7aZGx2Z13enVGquPXZR8Nw7JwGmeljnR1TJj4pHWolIGDwIkcbYlOfgqWUjXawcXjXzWPf67dP+EQX0IqUzSdAhHp4U4LQOaUgD1kv5l+wk3JV912dJWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=JEsGig4D; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730854844;
	bh=LMlH0g+4qQ4OGP6MLRSf9K788q8uLfk7t7uCIz5/bzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JEsGig4DCP63nvbgdEs6PnxcR+MECBZZxmYY5k+78SesGTz7IAWTvWHUpoGVvnX4k
	 PEufyOv7GLpGbGFCQPMJT4KarwvwhyJD1gVDxT7PoxvJkAlByAdKs+kBoPFBG7YtSo
	 sWlqWua1Ej6T43jCWNkHhlWqa3i9AsxM3hskTdKKFjnFJg8UgIBGGCPT8UdHuNvcFC
	 mFWoen6pOxpqh+ztBNA7GJ0T/1M8BZEPJhlVGI+2p5giVhf1hme5QspkoQw6wL5K8H
	 yDZ1K+JHPHLveH1zylFPIwyXqQYERr0KXF2XMtrJwJAqJysCfNKMNr85w4pG+2OdsU
	 xuIfrRoSvDPKQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xjn233DGGz4x9G;
	Wed,  6 Nov 2024 12:00:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org,
 acme@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Sandipan Das <sandipan@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, nd@arm.com, Yury Khrustalev
 <yury.khrustalev@arm.com>
Subject: Re: [PATCH v3 1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
In-Reply-To: <20241028090715.509527-2-yury.khrustalev@arm.com>
References: <20241028090715.509527-1-yury.khrustalev@arm.com>
 <20241028090715.509527-2-yury.khrustalev@arm.com>
Date: Wed, 06 Nov 2024 12:00:42 +1100
Message-ID: <87ttcl89c5.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury Khrustalev <yury.khrustalev@arm.com> writes:
> Memory protection keys (pkeys) uapi has two macros for pkeys restrictions:
>
>  - PKEY_DISABLE_ACCESS 0x1
>  - PKEY_DISABLE_WRITE  0x2
>
> with implicit literal value of 0x0 that means "unrestricted". Code that
> works with pkeys has to use this literal value when implying that a pkey
> imposes no restrictions. This may reduce readability because 0 can be
> written in various ways (e.g. 0x0 or 0) and also because 0 in the context
> of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
> actually means "no restrictions". This is important because pkeys are
> oftentimes used near mprotect() that uses PROT_ macros.
>
> This patch adds PKEY_UNRESTRICTED macro defined as 0x0.
>
> Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
> ---
>  include/uapi/asm-generic/mman-common.h       | 1 +
>  tools/include/uapi/asm-generic/mman-common.h | 1 +
>  2 files changed, 2 insertions(+)
  
Apparently you're not meant to modify the copy in tools/, there's a
script that does that, which is run by acme, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

cheers

