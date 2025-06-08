Return-Path: <linux-arch+bounces-12284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65433AD1602
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 01:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CBA3A9699
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871A26738C;
	Sun,  8 Jun 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOEtAeuZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB22A1BA;
	Sun,  8 Jun 2025 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749426520; cv=none; b=FE0qDwTrm3z/8JeenzmVFJVbV+MjMoo2J9XZhweMosvp43rTX+2yi8L6Aq0IlhkKcDLc+c2VTNpAEt8l2oJphtYTfk0Wu1fgtwwwySOgN9sG6+Vdkxn/NXpM7n6+XeXJylpkIYyIoLGlK/GRid1xJHryWjLLxNLcaBtz2sZMt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749426520; c=relaxed/simple;
	bh=PNJP4F4SM5CKWVi44F6XN3CvXe0mnkBMQtyo2ioWp6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew85N6Pw8RXgCw+SlArvTUzyj3SXJAqqPDOtTNFN53EPyjr/ZC/G49MlZc74aZdw8vocPUZswrmUS5q2XiJ8qJIRruKbAMtPgU16mu6t9WovVDUQrtl908F1y0nOrTrQ7AKUxO3c1+CgtpvtHkH/ZkwUXDG82GzTJdclQwIk+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOEtAeuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB5C4CEEE;
	Sun,  8 Jun 2025 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749426519;
	bh=PNJP4F4SM5CKWVi44F6XN3CvXe0mnkBMQtyo2ioWp6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOEtAeuZjpWvk9z46QbzwFTvSH+ljw/hQKIzEhZJx7YF2EwgrcI3+lI1VVKscms0d
	 m3qcoPnMMDVh4lKObwmfsWuGFAfWfD9VrvL51JeF8gEdf9j5e89zlEOEgaCwxiok5N
	 /aXy/hTwK0fEa7Z/G4j2/UPMcbFCWgXgxCUhbLoCrXwDNwOBWfrQbnnk/HZXwh/U2/
	 WnpIAIMFGu/oqqi+ROzvz89sXkm5O6vGwJ/PQ3JdxSPps11zhBrcyuDg/46eion+ad
	 2/v4rAxctCfEtqWu0G117hIgv+MXBMm76WuvxTusmww2Scut4P917GLHnfL8cwD0i5
	 36P1VSkTzVNzw==
Date: Sun, 8 Jun 2025 16:48:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <20250608234817.GG1259@sol>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <aETPdvg8qXv18MDu@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aETPdvg8qXv18MDu@zx2c4.com>

On Sat, Jun 07, 2025 at 05:47:02PM -0600, Jason A. Donenfeld wrote:
> On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:
> > Having arch-specific code outside arch/ was somewhat controversial when
> > Zinc proposed it back in 2018.  But I don't think the concerns are
> > warranted.  It's better from a technical perspective, as it enables the
> > improvements mentioned above.  This model is already successfully used
> > in other places in the kernel such as lib/raid6/.  The community of each
> > architecture still remains free to work on the code, even if it's not in
> > arch/.  At the time there was also a desire to put the library code in
> > the same files as the old-school crypto API, but that was a mistake; now
> > that the library is separate, that's no longer a constraint either.
> 
> I can't express how happy I am to see this revived. It's clearly the
> right way forward and makes it a lot simpler for us to dispatch to
> various arch implementations and also is organizationally simpler.
> 
> Jason

Thanks!  Can I turn that into an Acked-by?

- Eric

