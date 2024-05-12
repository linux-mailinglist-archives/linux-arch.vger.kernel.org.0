Return-Path: <linux-arch+bounces-4336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71858C3535
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 08:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75F9B20F1E
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF140F4E2;
	Sun, 12 May 2024 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GfsUTb9P"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B991EEC5;
	Sun, 12 May 2024 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715494654; cv=none; b=HStyOOZ/KMZLEkSnxIgg+GEBafXmSVsCEvjoNKY93RzSA8Z5zUzG5AebnqeWWpywcMAfaryBjCaLbZQIuOnJ/pbnW/6d+tgNceLHuWjOOss5mhPgaJmot3bfLmqqA0CfTdBvpVfmwHhTTP7GwqkT54yO8Klq/cdB6TMSzz3ig2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715494654; c=relaxed/simple;
	bh=gG9qtwz6AEuVBpuUnwTRmnEVW/awSwMFOyXg9NXDvmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mg8DJD9lKtjsw4rP8BZDMweZnPPyuJ3dNPGBPT8Z9GKrp3EEuxcEYAR+DIafy9Qe2bbrdeNOCmk+Ld7zXncEaTni7JtLGw6bNQk+YjjujoUraO/L0gFmRYkfF6tGc7oWOViT78qEQ+jThvyn3FvbfCBSSJQc4F01FEEOP/bwPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GfsUTb9P; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c/JXHF58umbTfPCiNG8MlHUsPoWqk2CyfMoD1L/vcWA=; t=1715494652; x=1716099452; 
	b=GfsUTb9PLmuFTMhgTTJNnYU4A7iNqK+GwEpPnJj6OuwNgpKME6cOAtmViWEgUYK2eTCBIjH+CQh
	I8ckjmfACW1Y8900tUjWrL5y3ZZqwtf4oA0sWqBCD7dcmxaAQfwhltEx0oPR/QZiVXMHVbIiYRup/
	UcNYIf1qcHQr8lABC36Z0pgme4Z9faxCImJl4Vadxluwrq8DwQ1gCfsZcXkuWHMs5C8EbjArIthP0
	hCDMERcfplFIGUdM/uHCzELV5L2G++ElUoJ2o0Upg9ryO2uGsr1m5QQ377TUEOCv9uhjsmbjOl7Fg
	YMnTR0L7pbG/Il8F30uOlUtcFFuY/Csx+drA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s62WX-00000000gmh-1SPg; Sun, 12 May 2024 08:17:29 +0200
Received: from dynamic-077-191-174-180.77.191.pool.telefonica.de ([77.191.174.180] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s62WX-00000000HLf-0Uxm; Sun, 12 May 2024 08:17:29 +0200
Message-ID: <b4adb884e4c1014ecce7d1857adb7feb48ba837f.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, 
 debian-alpha@lists.debian.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Date: Sun, 12 May 2024 08:17:28 +0200
In-Reply-To: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ulrich,

On Fri, 2024-05-10 at 23:19 +0200, Arnd Bergmann wrote:
> The following changes since commit fec50db7033ea478773b159e0e2efb135270e3=
b7:
>=20
>   Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git ta=
gs/asm-generic-alpha
>=20
> for you to fetch changes up to a4184174be36369c3af8d937e165f28a43ef1e02:
>=20
>   alpha: drop pre-EV56 support (2024-05-06 12:05:00 +0200)
>=20
> ----------------------------------------------------------------
> alpha: cleanups and build fixes
>=20
> I had investigated dropping support for alpha EV5 and earlier a while
> ago after noticing that this is the only supported CPU family
> in the kernel without native byte access and that Debian has already
> dropped support for this generation last year [1] in order to
> improve performance for the newer machines.
>=20
> This topic came up again when Paul E. McKenney noticed that
> parts of the RCU code already rely on byte access and do not
> work on alpha EV5 reliably, so we decided on using my series to
> avoid the problem entirely.
>=20
> Al Viro did another series for alpha to address all the known build
> issues. I rebased his patches without any further changes and included
> it as a baseline for my work here to avoid conflicts and allow
> backporting the fixes to stable kernels for the now removed hardware
> support as well.
>=20
> ----------------------------------------------------------------
> Al Viro (9):
>       alpha: sort scr_mem{cpy,move}w() out
>       alpha: fix modversions for strcpy() et.al.
>       alpha: add clone3() support
>       alpha: don't make functions public without a reason
>       alpha: sys_sio: fix misspelled ifdefs
>       alpha: missing includes
>       alpha: core_lca: take the unused functions out
>       alpha: jensen, t2 - make __EXTERN_INLINE same as for the rest
>       alpha: trim the unused stuff from asm-offsets.c
>=20
> Arnd Bergmann (5):
>       alpha: remove DECpc AXP150 (Jensen) support
>       alpha: sable: remove early machine support
>       alpha: remove LCA and APECS based machines
>       alpha: cabriolet: remove EV5 CPU support
>       alpha: drop pre-EV56 support

There are currently efforts to remove kernel support for older Alpha machin=
es
before EV56 such as the Jensen machines and I was wondering what the curren=
t
status of the Linux kernel on your machine was.

Arnd and Paul claim it's broken and no longer works, but not too long ago y=
ou
confirmed that Linux 5.14 booted fine on your machine.

Do you have any current data?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

