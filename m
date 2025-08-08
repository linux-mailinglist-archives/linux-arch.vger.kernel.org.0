Return-Path: <linux-arch+bounces-13093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C26B1E53B
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6718A3516
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED426560A;
	Fri,  8 Aug 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SyZ4QNJH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12026B75A;
	Fri,  8 Aug 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643697; cv=none; b=jamPmZlqLZNbLPMhQNnx8FWCsuH/Vo2rNz2mS/Xe/ZVd+XEbfxuYcQgsnvLb6JsoVELJaM3zBm0xB5n8DYmXmucaRWO+x1DxX8eW/j9EQ1z+gY7AgQROoA0ynbQ8flmGnRVy/a/gfomH13NJVOLpDOmKNBLhBseOu2ja4vbTRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643697; c=relaxed/simple;
	bh=FQ1EJ/sG0DyQKEGjTRNDzfkeJDMTyX6d/epsw1JW2bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdruUjF9TIQt0D2Qll/QQg0Ku0ommBWjtLTwbRI+f7ILqNxJGFMlKfu7GLHOycOBWyy8Bi4utxdde7s/U/7R9zJLrWKEcICqvAeAGLZp2zIk5BLfl/gI49XFYX3FghqJcUTuymDdSC1y2pSuUfAVLRK2lgbbj/CtfxsMqcgZRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SyZ4QNJH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754643692; x=1755248492; i=deller@gmx.de;
	bh=b3YIymOeHVKEzXIDr/yZ9ChtsMESOOKxemtGa7qMHGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SyZ4QNJHJx8oFytlKBm4G9teUKryIyXPQsP8ThESzq3whB6W0h8sSKnlHQGWuG6U
	 HBVL3inESTPO1QVAG7U7qhAsoEEEqSP7tHRVxv77mSWk32Ys1ISSEFNR7L/7kJ/Wf
	 tU/T0IgEuQWUAc99m7zAF1q6wvVIGAfewh15L9xlUJc6jYfEkdEsLvfKxyIShIWml
	 wMvWxWDQpHli37PZASjKV/8xQeCm/yBi/89H4yCKLbPxCpoE+So5lARTHR2cyEe9H
	 PslK2pX3u7ZSFqDCsOMw+eSGiLUzfnzNf2dipGzZfnXIhM0Aiux/Y3UrNf8TnEyaZ
	 l2dULSSLEAec6fBpeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.84]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1uiMEx33D1-006I95; Fri, 08
 Aug 2025 11:01:32 +0200
Message-ID: <aa0d0695-5af4-4986-b6ea-24dd2da9f747@gmx.de>
Date: Fri, 8 Aug 2025 11:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] parisc: Add __attribute_const__ to ffs()-family
 implementations
To: Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-13-kees@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250804164417.1612371-13-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WGilPeYeSuAMh5xTrsHsv8JewI8Y385RHrF1XUZfTWcZHiXNt1t
 7azDyju7G5kjLqLNpBv4tHKyt69ybNmXCoa3fQJxuChaaghVnD5yEeFKoCNKiof29WUy/jf
 ZU/gKTKBfn7QpqLep82y+XMA49sjmncExSaPMe29JjSDVeZitS9+/3IPNs/aoNWA4cnIo0U
 SDKlgcJttgtyrSa1LVRnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RGeTuXs9L+0=;73s8AjJf+D+BxdsLEUNOBmMXWiQ
 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

On 8/4/25 18:44, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added stati=
c
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
>=20
> Add missing __attribute_const__ annotations to PARISC's implementations =
of
> ffs(), __ffs(), and fls() functions. These are pure mathematical functio=
ns
> that always return the same result for the same input with no side effec=
ts,
> making them eligible for compiler optimization.
>=20
> Build tested ARCH=3Dparisc defconfig with GCC hppa-linux-gnu 14.2.0.
>=20
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   arch/parisc/include/asm/bitops.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Helge Deller <deller@gmx.de>


