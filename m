Return-Path: <linux-arch+bounces-214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA47EAD3E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFCE1F23734
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB5168C3;
	Tue, 14 Nov 2023 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VBueanTJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72314168C6;
	Tue, 14 Nov 2023 09:46:53 +0000 (UTC)
Received: from xry111.site (xry111.site [89.208.246.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B5C12C;
	Tue, 14 Nov 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1699955206;
	bh=satinxlx0MAD+yis9bfpesgap/Kipwt793BTW81wdaY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VBueanTJYrYcd14G9qi/23MRd4/ENc28NIPvSkbLnkOfu2wW8bUfj6KMzGRFItt/O
	 FPZK6G3PQDSI+moLq/5mMrcyCGcB/8/PLABOaiw51SMGlnL7gFN4YZhNMGNXGhhREN
	 ElwF7VG4CoZSuNSVnw8P7P6NKK+aNPCet4cyzJN8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7CF0D66A03;
	Tue, 14 Nov 2023 04:46:45 -0500 (EST)
Message-ID: <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
From: Xi Ruoyao <xry111@xry111.site>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	libc-alpha@sourceware.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-mm@kvack.org,  linux-arch@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>,  =?ISO-8859-1?Q?Andr=E9?= Almeida
 <andrealmeid@igalia.com>
Date: Tue, 14 Nov 2023 17:46:43 +0800
In-Reply-To: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 02:33 +0800, Xi Ruoyao wrote:
> Hi,
>=20
> With Linux 6.7.0-rc1, several tst-robust* tests time out on x86_64:
>=20
> FAIL: nptl/tst-robust1
> FAIL: nptl/tst-robust3
> FAIL: nptl/tst-robust4
> FAIL: nptl/tst-robust6
> FAIL: nptl/tst-robust7
> FAIL: nptl/tst-robust9
>=20
> This does not happen with Linux 6.6.0.=C2=A0 Do you have some clue about
> it?

Bisected to the kernel commit:

commit 5694289ce183bc3336407a78c8c722a0b9208f9b (HEAD)
Author: peterz@infradead.org <peterz@infradead.org>
Date:   Thu Sep 21 12:45:08 2023 +0200

    futex: Flag conversion
   =20
    Futex has 3 sets of flags:
   =20
     - legacy futex op bits
     - futex2 flags
     - internal flags
   =20
    Add a few helpers to convert from the API flags into the internal
    flags.
   =20
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Reviewed-by: Andr<C3><A9> Almeida <andrealmeid@igalia.com>
    Link: https://lore.kernel.org/r/20230921105247.722140574@noisy.programm=
ing.kicks-ass.net

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

