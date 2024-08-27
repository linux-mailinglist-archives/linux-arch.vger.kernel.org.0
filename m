Return-Path: <linux-arch+bounces-6643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AF9603A5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CD32839D7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472217BEA4;
	Tue, 27 Aug 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AvLSq1li"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4010A3E;
	Tue, 27 Aug 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745009; cv=none; b=rSIs0DjXHSL9rYiSlUfM247FwffekDffjqJQFXgIKGC2p0m33G71+MP8H6LG6w+Y9NDVVf05SL7WuUW6oxjFEH317adul8gsOcV3FtJQgoLcN4oVEsb+uf8RxTcsJcYqu3PwTiEnIMyOrjBigJEm/PoCLgM2uY5NS883ntlIk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745009; c=relaxed/simple;
	bh=SEKQ47l58YXx4pQAN0NESAzmOHxp921vON8OtCzeuB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM4Ff8eKS60cGLDJ86+MNACVpycGPjtQ5RrXElcF2YfBPLP0Q2vqwsA1SOrJjjHIcQFsO88sQT3pC/r7Sx6DdeVyvMuPkxdMRJq2SG2S0dgWeXSGBW4zVIGRPxSWUzECPD7sjzoiLq6vEmu8WPhq5KokvwvMS2Hp1exSYw5vMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=AvLSq1li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D1AC8B7A1;
	Tue, 27 Aug 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AvLSq1li"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724745005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsVTygwiPAx+mbzXcALN6I1jJ8O7/LG8tnvncTUnNiE=;
	b=AvLSq1liPMAWhRkU2qPW2ccOzu0/8Bbc20sYqlkinvQDThtPaVyWyY9nR/HWohJD4DS6uG
	li8PlXAe9yVsGb03yr0VvCrnFmB76C+De4wa+koiV/kjvol5PqJ6u14cn58l/XY4MGPhOH
	vR9cunuxE0dF6UuoZt8NN21M41GJAfo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 86529e27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 07:50:04 +0000 (UTC)
Date: Tue, 27 Aug 2024 09:49:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] random: vDSO: Don't use PAGE_SIZE and PAGE_MASK
Message-ID: <Zs2FJku2hM2bp4ik@zx2c4.com>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
 <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>

On Tue, Aug 27, 2024 at 09:31:48AM +0200, Christophe Leroy wrote:
> -	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
> +	const unsigned long page_size = 1UL << CONFIG_PAGE_SHIFT;
> +	const unsigned long page_mask = ~(page_size - 1);
> +	ssize_t ret = min_t(size_t, INT_MAX & page_mask /* = MAX_RW_COUNT */, len);

I'm really not a fan of making the code less idiomatic...

> An easy solution would be to define PAGE_SIZE and PAGE_MASK in vDSO
> when they do not exist already, but this can be misleading.

Why would what tglx and I suggested be misleading? That seems pretty
normal... Are you worried they might mismatch somehow? (If so, why?) 

Jason

