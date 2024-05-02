Return-Path: <linux-arch+bounces-4130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC58B9423
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 07:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72782830CF
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 05:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8B1CFBD;
	Thu,  2 May 2024 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="PrgAVRaa"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569021CD2D;
	Thu,  2 May 2024 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626719; cv=none; b=XaZesm2qkkRa78wXaZIyKGpHuAUlnqNv8LXLKmdODks+lk7RbXnrHRFcZJB+P3QimbGg+P2RPUsTa4sIEIe7ySQcBbsvkquC0sbvz1b6UJ/Umw0M//U4aUTH1i3UQdkdOVKrWYaQTigoUI31h/hPJ2bXPudlrejNpAA0VumNpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626719; c=relaxed/simple;
	bh=O585nGdzNnTnC6USi0DOSwyhOSgyO5m/b1EV7zBQIxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FixHFm8V6dB+xonPE8poE2cqUeSEsgefKlCZhkueHx7PhQurHwUT5Pb1oJKmgO/uznnugjrNQlvc5/CH4PGjZZqW1UYcfBg1MpDbEUxbpKGo4XxiksvIlYJC6ZnsITSUMMpiW2RQQDpMu/5135kAtZExx0UBOhVB1YMZAMBym4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=PrgAVRaa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=utnjLft+cCCmNqwYGOcYhyYisPt1R0D1THzGmrMh7Z0=; t=1714626717; x=1715231517; 
	b=PrgAVRaaP2LlsXY+G0bEogYKs6l2+YKY2oWZCUHbOpFhpvR2SYEz0cxBdBGm2ohLx5Nyp7Uo6eE
	E3X2/ygHHDw95bf2xHnxrpo1wKOf083hgfEQmPdRGwM/rAv7lOfw4f4acH805p05GMtv2FziuJN8g
	bbxehGC3ymyvzjFfGNYDFjlNH24pbReLxECxOh/HA46Ebz8E3y6uqrg59h/ZT09BOGsyFbF27SMh0
	9uxHRr+C7r/T9tfiLtluButoeStTLF1vaWBPcIVjhZ4Pa2cdchIJZqSek6u/7SCxdNPTe4nLOMM//
	ZmOT7MVkzxuYf4zUZCfNFkYcARzVgCr1jPHw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Oja-00000003yrB-0LCb; Thu, 02 May 2024 07:11:54 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2OjZ-00000003JKb-3Ubj; Thu, 02 May 2024 07:11:53 +0200
Message-ID: <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 elver@google.com,  akpm@linux-foundation.org, tglx@linutronix.de,
 peterz@infradead.org,  dianders@chromium.org, pmladek@suse.com,
 arnd@arndb.de,  torvalds@linux-foundation.org, kernel-team@meta.com, Andi
 Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Date: Thu, 02 May 2024 07:11:52 +0200
In-Reply-To: <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
	 <20240501230130.1111603-12-paulmck@kernel.org>
	 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
	 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2024-05-01 at 22:06 -0700, Paul E. McKenney wrote:
> > Does cmpxchg_emu_u8() have any advantages over the native xchg_u8()?
>=20
> That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?

Indeed. I realized this after sending my reply.

> Or am I missing something subtle here that makes sh also support one-byte
> (8-bit) cmpxchg()?

Is there an explanation available that explains the rationale behind the
series, so I can learn more about it?

Also, I am opposed to removing Alpha entirely as it's still being actively
maintained in Debian and Gentoo and works well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

