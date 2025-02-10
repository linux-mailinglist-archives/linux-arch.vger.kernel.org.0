Return-Path: <linux-arch+bounces-10070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DEDA2E1E3
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 02:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D007C7A26C1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F19F9C1;
	Mon, 10 Feb 2025 01:10:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B485625;
	Mon, 10 Feb 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739149829; cv=none; b=hDGekIXMQRA0TweTJ8Khr8Mhutg+hyo/yN1bh8fwrf3sb900NuyG3B3bJ62YLBErQWwfkijB7DOH8d2x+jDmPhWqOK2DAkYF2/cqI/GIG8qx1Q2VdfItFX/cnf42yRZ2zoVimrOroPFtKJmCp+aOquOD2Cx/CflVsW7U1rfJr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739149829; c=relaxed/simple;
	bh=+W4hbUJf28Gl9qNEThEm55N/PJ9IbzHZk/DqSQ8Pvk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THyO0LMWddnMsFR1rBihoE9pgqaTuuYThCp8LYAaeepdcBk9UHCD6LaTQaLSNQpVdpxFwhwJrW5OzWLZFGNCqSW0whmZZbNlPptniVipGeVOreNBo/qhwUeyL+L+AmNJV83i3LHNNJz1+Rt7CH0cuNINUXWp49M2vAFFt9LtuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thIJ5-000000005Mx-0xoS;
	Sun, 09 Feb 2025 20:09:51 -0500
Message-ID: <15734b32cecddde7905d3a97005a0c883383cc74.camel@surriel.com>
Subject: Re: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
From: Rik van Riel <riel@surriel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, David Laight
	 <david.laight.linux@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner	
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov	
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, Mathieu
 Desnoyers	 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dan Williams
 <dan.j.williams@intel.com>, 	linux-arch@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, 	kernel-hardening@lists.openwall.com, "Paul
 E.McKenney" <paulmck@kernel.org>
Date: Sun, 09 Feb 2025 20:09:51 -0500
In-Reply-To: <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>
References: <20250209191008.142153-1-david.laight.linux@gmail.com>
	 <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
	 <20250209214047.4552e806@pumpkin>
	 <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Sun, 2025-02-09 at 13:57 -0800, Linus Torvalds wrote:
>=20
> So on x86, both read and write barriers are complete no-ops, because
> all reads are ordered, and all writes are ordered.

Given that this thread started with a reference
to rdtsc, it may be worth keeping in mind that
rdtsc reads themselves do not always appear to
be ordered.

Paul and I spotted some occasionaly "backwards
TSC values" from the CSD lock instrumentation code,=C2=A0
which went away when using ordered TSC reads:

https://lkml.iu.edu/hypermail/linux/kernel/2410.1/03202.html

I guess maybe a TSC read does not follow all the same
rules as a memory read, sometimes?

--=20
All Rights Reversed.

