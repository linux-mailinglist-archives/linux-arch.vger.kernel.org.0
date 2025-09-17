Return-Path: <linux-arch+bounces-13667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD890B811E0
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8733D1C0677A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F602FC867;
	Wed, 17 Sep 2025 17:05:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFE2FA0F3;
	Wed, 17 Sep 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128749; cv=none; b=WKznutb2OP55vTwLSD2xbQiGysWhx9tOUac97yEbBxeN9kJB9vbwGDS9a+V8qtWAUoVuEjaj1JJIDEKIulYklQhcZMJ2+kYmuhns63tmSkGdfjL2Lu2cvHC8RDiWGyyTj234A3i3YrFUgA0yOdxR7nFz8tzruuojxIR0KZLV380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128749; c=relaxed/simple;
	bh=CpxMlm1/qsToXu30rGUcKeukNcXMktn8ngCrfJSWTrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjYcjP1vo/7/5M5DeaIxGgCO42GFV3q9r7kw41p3bHxo5/k9Mf3f/0+HTarFbZhozf5GIjKk0Ql8ry5TmuXUavaBwnZV/DEORvFojxFq/tXnNg+Z1bNzaWUEg12MOwotqU8wjlTVxCsP9ILt1kDG7LAluqENJ+mktFXnW8gEZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4cRlJ45XMLz1r5hT;
	Wed, 17 Sep 2025 18:55:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4cRlHz2k0Pz1qqlg;
	Wed, 17 Sep 2025 18:55:11 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id FyDczJ_snocr; Wed, 17 Sep 2025 18:54:51 +0200 (CEST)
X-Auth-Info: UWGvPdzziKTyr0vIulDVWeS8odfve31015jT5V3nU7N9Ds/7k6kKhuWDOeOz4Mai
Received: from igel.home (aftr-82-135-83-112.dynamic.mnet-online.de [82.135.83.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 17 Sep 2025 18:54:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 565EB2C1C80; Wed, 17 Sep 2025 18:54:41 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Brad Boyer <flar@allandria.com>
Cc: Arnd Bergmann <arnd@arndb.de>,  Finn Thain <fthain@linux-m68k.org>,
  Peter Zijlstra <peterz@infradead.org>,  Will Deacon <will@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Jonathan Corbet <corbet@lwn.net>,  Mark Rutland
 <mark.rutland@arm.com>,  linux-kernel@vger.kernel.org,  Linux-Arch
 <linux-arch@vger.kernel.org>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <20250916213858.GA12681@allandria.com> (Brad Boyer's message of
	"Tue, 16 Sep 2025 14:38:58 -0700")
References: <cover.1757810729.git.fthain@linux-m68k.org>
	<e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
	<20250915080054.GS3419281@noisy.programming.kicks-ass.net>
	<4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
	<20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
	<8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
	<57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
	<1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
	<534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fastmail.com>
	<20250916213858.GA12681@allandria.com>
Date: Wed, 17 Sep 2025 18:54:41 +0200
Message-ID: <877bxx10ku.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sep 16 2025, Brad Boyer wrote:

> I believe it depends on the exact CPU. The 68060 user manual has a
> section called "Emulating CAS2 and CAS Misaligned" discussing the
> handling of such instances through software emulation. The 68040
> user manual doesn't have any similar section.

The 68040 still handles them in hardware.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

