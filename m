Return-Path: <linux-arch+bounces-7012-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0596C1CC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78CCB2D856
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21D1DEFC0;
	Wed,  4 Sep 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCvDF9pP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C381DCB07;
	Wed,  4 Sep 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462181; cv=none; b=C+CFNhxJGoR6MwCR87QJT+GvzNmmxk/n5oNxsRFfCVSTjH70HfjiVQKw07JwNI2xbxMHNXDTTtXXryP7MOg3V2TXlQd6ytszkNieu1hS/pOE1oXUOyA1Q44eAm2wZjy4giG8b3NcUORAR0JfWt6iaUq0tncqpOGh7sZF5G/IpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462181; c=relaxed/simple;
	bh=Rr62ZUBbhFRmGxMpSUooVTp/zwJrJMHB5CDDGvfY9ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ+IQSX8CLmUNn12eqeR3eWjpppZ/By+EJ9EjfofYiCNCQ/vDb5pVuRzMqTmcXiHj/Iv4gH00wq2+nTF368I4MjomsO11MLA53S4GZKuu0W06+WtLgJGM2XEMeD6VpOoVOykUjcIZd0RBR/JG+orpWZR899eiitgsKyq2pWVzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCvDF9pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288FC4CECA;
	Wed,  4 Sep 2024 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725462181;
	bh=Rr62ZUBbhFRmGxMpSUooVTp/zwJrJMHB5CDDGvfY9ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCvDF9pPNqn4yahTr0CnU/WFUi7+1ghrRvy6PWj450wswPOAS+28oHQG0vlbB5FC+
	 KljOX4XpT1YT8GCi0ee0rlp+W3fXLkUs3RZUpM5Mb3P8wsgpzWDP+A0xwI1mbNX4zY
	 0UA4lRQTS5VG3rnyuSf24yGSP1jrVflo2ikxpiumpXOycy9poiwiZKWeib7qMGZTEs
	 3JwwRB8VEmJzPAzT80N9yd/NGpPkOjCnZVj+xpBfrstAkSxdKohUpz9xG0UW5hyAyZ
	 C+IW7l8yLKgGEnH1fG12VarTdXr7ClwGsahV5L2NWwXC98pxId52Rp3m7Ve9SKpKqc
	 LylTiw7g38R2w==
Date: Wed, 4 Sep 2024 16:02:55 +0100
From: Will Deacon <will@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
Message-ID: <20240904150254.GA13919@willie-the-truck>
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
 <20240904120504.GB13550@willie-the-truck>
 <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>
 <ZthmZrDUcau5Ebc6@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZthmZrDUcau5Ebc6@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 04, 2024 at 03:53:42PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 04, 2024 at 02:28:32PM +0200, Ard Biesheuvel wrote:
> > On Wed, 4 Sept 2024 at 14:05, Will Deacon <will@kernel.org> wrote:
> > >
> > > +Ard as he had helpful comments on the previous version.
> > >
> > 
> > Thanks for the cc
> > 
> > > On Tue, Sep 03, 2024 at 12:09:15PM +0000, Adhemerval Zanella wrote:
> > > > Implement stack-less ChaCha20 and wire it with the generic vDSO
> > > > getrandom code.  The first patch is Mark's fix to the alternatives
> > > > system in the vDSO, while the the second is the actual vDSO work.
> > > >
> > > > Changes from v4:
> > > > - Improve BE handling.
> > > >
> > > > Changes from v3:
> > > > - Use alternative_has_cap_likely instead of ALTERNATIVE.
> > > > - Header/include and comment fixups.
> > > >
> > > > Changes from v2:
> > > > - Refactor Makefile to use same flags for vgettimeofday and
> > > >   vgetrandom.
> > > > - Removed rodata usage and fixed BE on vgetrandom-chacha.S.
> > > >
> > > > Changes from v1:
> > > > - Fixed style issues and typos.
> > > > - Added fallback for systems without NEON support.
> > > > - Avoid use of non-volatile vector registers in neon chacha20.
> > > > - Use c-getrandom-y for vgetrandom.c.
> > > > - Fixed TIMENS vdso_rnd_data access.
> > > >
> > > > Adhemerval Zanella (1):
> > > >   arm64: vdso: wire up getrandom() vDSO implementation
> > > >
> > > > Mark Rutland (1):
> > > >   arm64: alternative: make alternative_has_cap_likely() VDSO compatible
> > > >
> > 
> > This looks ok to me now
> > 
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Great. Thanks a bunch for your reviews, Ard.
> 
> Will, if you want to Ack this, I'll queue it up with the other getrandom
> vDSO patches for 6.12.

I won't pretend to have reviewed the chacha asm, but the rest of it looks
good to me. Thanks!

Acked-by: Will Deacon <will@kernel.org>

Will

