Return-Path: <linux-arch+bounces-12502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A709AED49C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 08:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902A57A8738
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6B192D68;
	Mon, 30 Jun 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="beqb5jR4"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76108199BC;
	Mon, 30 Jun 2025 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265039; cv=none; b=V7KYuYK3dYxAjCh2veM958wF/8CkTBx2GqgnbFPpx8B/eyuYGu6inoIstl4pLgYkABQU7Ft2jvvEzQc9jIjfind4BxdpEcg9DjVg8IeIWG2wrlvVlGZ3theG/WayWIFNo2iT9TnHSW/Dd2NHy8ti3ETYdVReth2FqehVEliYySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265039; c=relaxed/simple;
	bh=/zKwGHRLVmtHV5ZDqEHlLzo2qHfLtGPANLRESohAS/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jqYk9A6bklSqVS7S88hnGeF058peAoBhZS4jyVvtFcIzbRfoWz00iUFuISF4m/qNsrolU+I3TCictPc+jwMXu9+WkTiqGF7dLw3whABmhQ1kU3j1ZGKe4a8Y7+JFuG31mReIrteXYmKXMSc0XDfN5sVLq02vPVjP4gO4SeJA2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=beqb5jR4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u6N24uKZJPWfxouJOO+l/nhaXZaTitfTuyIghGfBZhE=; t=1751265035; x=1751869835; 
	b=beqb5jR4R9zU/6WCMvRA/YiB0lfSxAUpUhjdX4YzExWu5oLQifVngMa5v7TV9zg3JlZvZrg4XfX
	celI3DH4pH+DMWUEeP3qI8vGVHK9VmY56nhCYcXvKZT4lKkBhJBHB/tx/oXQfy1O2d5d3WDr9Dcxc
	7kOzCygpirBsrp3N6OP2cdDdEIUIeATWgXnltBoduN71+TdhbaylK3c1FA96wq4fwuIqAkF8uKHFF
	hVAetRTmQPn5v8RnGvtpSSdRVc5+BABM3FOjuYDIG8VCnmYanvWaDKcnpPm0LiunQTsYefvCYQO8k
	5qLcI4cCfnP6oiVUOPfgi8E0Nyf/zZMLLFWA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uW826-00000001rRO-2RxD; Mon, 30 Jun 2025 08:30:26 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uW826-000000010nr-1UtV; Mon, 30 Jun 2025 08:30:26 +0200
Message-ID: <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing,
 please fix
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, Dinh Nguyen
	 <dinguyen@kernel.org>, Simon Schuster
	 <schuster.simon+binutils@siemens-energy.com>, Linux-Arch
	 <linux-arch@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Date: Mon, 30 Jun 2025 08:30:25 +0200
In-Reply-To: <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
References: <202506282120.6vRwodm3-lkp@intel.com>
	 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

On Mon, 2025-06-30 at 08:14 +0200, Arnd Bergmann wrote:
> On Sat, Jun 28, 2025, at 21:59, kernel test robot wrote:
> > Hi Arnd,
> >=20
> > FYI, the error/warning still remains.
> >=20
> > date:   12 months ago
> > config: hexagon-randconfig-2002-20250626=20
> > (https://download.01.org/0day-ci/archive/20250628/202506282120.6vRwodm3=
-lkp@intel.com/config)
> > commit: 505d66d1abfb90853e24ab6cbdf83b611473d6fc clone3: drop __ARCH_WA=
NT_SYS_CLONE3 macro
> > > kernel/fork.c:3088:2: warning: clone3() entry point is missing, pleas=
e fix [-W#warnings]
>=20
> My patch only moved the warning about the four broken architectures
> (hexagon, sparc, sh, nios2) that have never implemented the clone3
> syscall from commit 7f192e3cd316 ("fork: add clone3"), over six years
> ago.
>=20
> I usually try to fix warnings when I get them, but the entire point
> why these still exist is that they require someone to add the
> syscall with the correct calling conventions for the respective
> architecture and make sure this actually works correctly.
>=20
> I don't think any of those architecture maintainers are paying
> attention to the build warnings or the lkp reports, and they are
> clearly not trying to fix them any more, so maybe it's better to
> just stop testing them in lkp.

I have seen that warning about clone3() missing but I was not aware that it=
's
an urgent issue to address. Do you have any suggestion on how to implement
that syscall?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

