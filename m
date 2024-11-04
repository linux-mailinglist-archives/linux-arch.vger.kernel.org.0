Return-Path: <linux-arch+bounces-8844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE99BBCE8
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE42834C1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F601CB9E6;
	Mon,  4 Nov 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMfO1/O0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260A179958;
	Mon,  4 Nov 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743828; cv=none; b=o+pE9KC8wE/u5ao+w01qeRcXdBFDx19011Mwjc1EvczYMcCR0B27XCEQYVrfwo1SFCXuOKhzy5RSJRd/YLj8Xk6vay8WL2hRMg/K+PwowEjdwkgjA2a74F7QslAhvoJDUY5F/xheSYF2O6U3FFTKTVoMF7qG0o5JKPeMggTzgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743828; c=relaxed/simple;
	bh=A9QEobhM0Tk66PTKUxkoy2PH75AkXVl7kAtDO3RqV40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOV6DPlq1Mc9DQ6U52srcznqkmxy74+v00RZTkFo/+ZZj/K76iinpZ+f91xKDpp6kyqMpkn17c8/7Wra90l+b89ZmYd8Irvc3ZYRpDU9ViaByPh5FSUMaeavEdCgnQ8oaehEzFWm5+IXIo3DRmCC4QafFPSO3NusmuqF4VotuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMfO1/O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F8FC4CECE;
	Mon,  4 Nov 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743828;
	bh=A9QEobhM0Tk66PTKUxkoy2PH75AkXVl7kAtDO3RqV40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMfO1/O0f3WTFHcevl3ZKLDtacBxMdE3BT7RFEx/b3+uCvKbbdhBTvloMt0wa0OwX
	 n90Z5gcaPjxU3VikQM87AaL+farAbSj6GceGjTrdFooAVP1M8KvLcXwQ38fUeWBv8N
	 nSueT0gGDtEoY8EFJAIpvIVUUWXl5Q+eF6EU53irRc2UnkG16rz8Z0sqp62Nd22MA5
	 VHQu3uGLJaQJEr8WHqAb0R2V4++l7ByYkHuVDtoe7B8G75lQBftyc2Y6tQRfZwmKhm
	 h8Lgj1UBc9z/xdcPqGhAJ2c/yL+WIAA6KPIsfzCpa8AVQaSz9Mv0vPpuMxziyvvJML
	 5V3YtcPfQjK/A==
Date: Mon, 4 Nov 2024 18:10:26 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 05/18] arm/crc32: expose CRC32 functions through lib
Message-ID: <20241104181026.GC1049313@google.com>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-6-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103223154.136127-6-ebiggers@kernel.org>

On Sun, Nov 03, 2024 at 02:31:41PM -0800, Eric Biggers wrote:
> -static int __init crc32_pmull_mod_init(void)
> -{
> -	if (elf_hwcap2 & HWCAP2_PMULL) {
> -		crc32_pmull_algs[0].update = crc32_pmull_update;
> -		crc32_pmull_algs[1].update = crc32c_pmull_update;
> -
> -		if (elf_hwcap2 & HWCAP2_CRC32) {
> -			fallback_crc32 = crc32_armv8_le;
> -			fallback_crc32c = crc32c_armv8_le;
> -		} else {
> -			fallback_crc32 = crc32_le;
> -			fallback_crc32c = __crc32c_le;
> -		}
> -	} else if (!(elf_hwcap2 & HWCAP2_CRC32)) {
> -		return -ENODEV;
> -	}
[...]
> +static u32 crc32_le_scalar(u32 crc, const u8 *p, size_t len)
> +{
> +	if (static_branch_likely(&have_crc32))
> +		return crc32_armv8_le(crc, p, len);
> +	return crc32_le_base(crc, p, len);
> +}

kernel test robot reported a build error on this patch,
"undefined symbol: __kcfi_typeid_crc32_armv8_le".  It's because crc32-core.S
uses SYM_TYPED_FUNC_START(crc32_armv8_le), and this patch makes crc32_armv8_le
be called only via direct calls, not indirect calls as it was before.  I will
fix this by replacing SYM_TYPED_FUNC_START by SYM_FUNC_START.

- Eric

