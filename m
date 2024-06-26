Return-Path: <linux-arch+bounces-5151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5882918231
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36221C237CE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF113CFBC;
	Wed, 26 Jun 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjAgiLLL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D6F18E10;
	Wed, 26 Jun 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407904; cv=none; b=pp/vyCrC84jOlE8q832q5W/nzRcGGmM5CPhkOEBFX4qNpq+0BxaRPZF9mrUcl0xm339vCpvt0FD0ui6vxpTkc6Fm2pq55DL2Ba1kTpYJ9uXeFV+NBzCWt4clj6H2/h5IOSTGn6FqMBuN88v4hrpQAoYv/iCMZq6aO6IY2sa1GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407904; c=relaxed/simple;
	bh=Xk8ky9rWubFRDvOqNNCu5URqZvtq2rKG2Zujpppq++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSOtqy4PXPduLjt2Y56cG2U7yHaVCvodx5Ac+s7ZWlc82RZyg6iDMGNoEaZYD4Pc/YzF/ohZL1ZZxJ8s2JUdKrDAUC6DZqVx+tF5jbP+/r8/JEYP1DBRwgqB8f0Kw+TaJ/WsWqlyZMd2xW0rl34gJ72OgSzWD6w3dkOVow+bwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjAgiLLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6430C2BD10;
	Wed, 26 Jun 2024 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719407903;
	bh=Xk8ky9rWubFRDvOqNNCu5URqZvtq2rKG2Zujpppq++M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjAgiLLLqdOjLAXy1WPPe0Qq09T3mCgkYwQSQ1Buiz33FYBwU63D/hE8OSzvPenaT
	 6xrl1z0tZSkIISV/+nz0ip2gLgD+yR/Qa8pIJztGnksbnQ9DdtkPEJ8NrN1xCyQazq
	 mXbRt69GDe8JAfS69u5G56ObwSVho0t7aYL/Appwg4QB21kQFlVpeAb0Axf0wkOAG/
	 zBiZt9vJuO09RYXW5rlvjwIsln1AQzAMAcvRQtLGakdg85o2qgVyWFOL7mKVznS0BM
	 VYiln/kHHtVACFxPGtxVTCkWB4jum853XAfWe4pFAzIuaDxThTaW4QTfWuLpJQf3DX
	 eegTc/XOHanzQ==
Date: Wed, 26 Jun 2024 21:04:19 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Message-ID: <ZnwR0_MkAJW6i5sk@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>

On Tue, Jun 25, 2024 at 11:12:16AM -0700, Linus Torvalds wrote:
> On Tue, 25 Jun 2024 at 00:22, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I think the only bets we really need from an architecture
> > here are:
> >
> > - __enable_user_access()/__disable_user_access() in
> >    the label version
> 
> KCSAN wants user_access_save/restore() too, but yes.
> 
> > - __raw_get_mem_{1,2,4,8}() and __raw_put_mem_{1,2,4,8}()
> 
> You still need to split it into user/kernel.
> 
> Yes, *often* there is just one address space and they can be one "mem"
> accessor thing, but we do have architectures with actually separate
> user and kernel address spaces.
> 
> But yes, it would be lovely if we did things as "implement the
> low-level accessor functions and we'll wrap them for the generic case"
> rather than have every architecture have to do the wrapping..
> 
> The wrapping isn't just the label-based "unsafe" accesses and the
> traditional error number return case, it's also the size-based case
> statements ("poor man's generics").
> 
> The problem, of course, is that the majority of architectures are
> based on the legacy interfaces, so it's a lot of annoying low-level
> small details. I think there's a reason why nobody did the arm64
> "unsafe" ones - the patch didn't end up being that bad, but it's just
> fairly grotty code.
> 
> But apparently the arm64 patch was simple enough that at least RISC-V
> people went "that doesn't look so bad".
> 
> Maybe other architectures will also be fairly straightforward when
> there's a fairly clear example of how it should be done.

>> We have something like this already on powerpc and x86,
>> and Linus just did the version for arm64, which I assume
>> you are using as a template for this. Four architectures

Yep, this series is inspired by Linus's patch series, and to be honest,
some code is borrowed from his arm64 version ;) I saw he improved
arm64, then I thought a nice improvement we want for riscv too, can I do
similarly for riscv? 

