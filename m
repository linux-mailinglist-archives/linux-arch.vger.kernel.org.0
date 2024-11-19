Return-Path: <linux-arch+bounces-9138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF89D2208
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508241F22A0B
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AD1AE006;
	Tue, 19 Nov 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlziSZGm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C61AA1FA;
	Tue, 19 Nov 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006807; cv=none; b=AZAWc6XyS4zO4xHacXGreMsNx4Yfwo9lV8DMmZEnXknWF0TB2BnmHd6mSXFN6ozG1fK4JsA/lMOYgY5ucoj0q7JlYjhwIxxWhyF8/1fAuKz7zpqXFDP2DRL7HuhRPBu1/M9GSz1/64IMHuqEbg6LwAs1wQZs5oTecEwSYcy5fsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006807; c=relaxed/simple;
	bh=s8xwzMSQqRRhgWbEzyj1PJULHTCex8PmVGVdqmaYwow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch9p5CWPnwptMyWty1FsXCPcNihi3ZI2XIszjmdVBo14GawPmer4DFkuHOkLI+SJ1eevdOKyN8ZGGLQSN+s1KnicdTi/IpWBs7g2i6WqcoYDcObaEyxrhG9q40/LfWpDTscjqFkLAAViGNkSNNwrWgu13v8FURLReycR8S9O798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlziSZGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E75C4CED6;
	Tue, 19 Nov 2024 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732006806;
	bh=s8xwzMSQqRRhgWbEzyj1PJULHTCex8PmVGVdqmaYwow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GlziSZGmgL17KEpUWxgzaWOsXBlCH5SlK3CTGZSKb3Kjzg46uJCRjm55rJ5VEKQgX
	 RazWTGA7VUdOd0vadOXm/Ei4Npvau9DSDhZBxgdhcsTEFLqwUSto2eS6g84Kksg8Yf
	 ud9m/WvWYQEu8/yjHjxlYLvAO3qkruoPRf9PbcYkd19M0wRaag7acSN+i8eMkSyOy7
	 3Vm1PyCJE9iHlAr761csU/bDq2lB/s20SLZaAfOcioYyigqdG4wX8ti2HFKy9y2tx0
	 ZPuMpYMyj85QId7YFztdUxnRwiIeYe8nfTuFcnW6ZPUz5ESS7rSRd/iWkIfUjW67Wq
	 gH3SFim+Vt1/Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da3b911b9so4548479e87.2;
        Tue, 19 Nov 2024 01:00:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMt+8pFHZUpFZEix1yFon1Qov4lFOr1NUsOxPhpolxCyB6u+NulGEAttS0FkQl4k4wdBY+BPFtWVpJ@vger.kernel.org, AJvYcCXYS6FJLdMv23b9Vr0lWihi+bWbNDtEbX3fUxId34wEAV27ZZufdhXew7w1vM+DI18UORNiA831sVHwEL0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtXCj97xwd37+6QekYtPCjRZDFD06WiNv70e0E8UJvGUYa19R
	8pFecHXZFEkLrAziO01hDsjLkjg0sdlXxhQkt9uGmEcWrUEcOyhZKYi0FmYlu+mopDJa9LLfrfs
	CiP7byOV7CN+xf0K6Lyo8l+WovKg=
X-Google-Smtp-Source: AGHT+IGB5F8WlM471SFc1V5UKClWXgSP36FaXp9LSspKRLXsBt4jIufb/Zaq1Z6bYkALOF5/F3wzsN456cYehpKsaQs=
X-Received: by 2002:a05:6512:31ca:b0:539:fb30:1f75 with SMTP id
 2adb3069b0e04-53dab2a659dmr6164698e87.24.1732006804616; Tue, 19 Nov 2024
 01:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117002244.105200-1-ebiggers@kernel.org>
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Nov 2024 09:59:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFA15AuT5wd0vMJ3X94uysvnGLy42FAQt8fxJsW31UdAg@mail.gmail.com>
Message-ID: <CAMj1kXFA15AuT5wd0vMJ3X94uysvnGLy42FAQt8fxJsW31UdAg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Wire up CRC-T10DIF library functions to
 arch-optimized code
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	Zhihang Shao <zhihang.shao.iscas@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 01:23, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This patchset is also available in git via:
>
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-t10dif-lib-v1
>
> This patchset updates the kernel's CRC-T10DIF library functions to be
> directly optimized for x86, arm, arm64, and powerpc without taking an
> unnecessary and inefficient detour through the crypto API.  It follows
> the same approach that I'm taking for CRC32 in the patchset
> https://lore.kernel.org/linux-crypto/20241103223154.136127-1-ebiggers@kernel.org
>
> This patchset also adds a CRC KUnit test suite that covers multiple CRC
> variants, and deletes some older ad-hoc tests that are obsoleted by it.
>
> This patchset has several dependencies including my CRC32 patchset and
> patches queued in several trees for 6.13.  It can be retrieved from git
> using the command given above.  This is targeting 6.14.
>
> Eric Biggers (11):
>   lib/crc-t10dif: stop wrapping the crypto API
>   lib/crc-t10dif: add support for arch overrides
>   crypto: crct10dif - expose arch-optimized lib function
>   x86/crc-t10dif: expose CRC-T10DIF function through lib
>   arm/crc-t10dif: expose CRC-T10DIF function through lib
>   arm64/crc-t10dif: expose CRC-T10DIF function through lib
>   powerpc/crc-t10dif: expose CRC-T10DIF function through lib
>   lib/crc_kunit.c: add KUnit test suite for CRC library functions
>   lib/crc32test: delete obsolete crc32test.c
>   powerpc/crc: delete obsolete crc-vpmsum_test.c
>   MAINTAINERS: add entry for CRC library
>

Nice work. The shash API glue was particularly nasty, so good riddance.

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Happy to take a R: or M: as well, if you need the help.

