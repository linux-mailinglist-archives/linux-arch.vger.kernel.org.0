Return-Path: <linux-arch+bounces-12583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C8AFAC47
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 08:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4152C172107
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C92797AB;
	Mon,  7 Jul 2025 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZQhomku";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5YDzv/Bz"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CE27A452;
	Mon,  7 Jul 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871478; cv=none; b=SMIstRIyMFihklWLf9yZFxnMugvEcqhz6Jj2cjck4bAcekslGsrKECIEIsjRVAht5qGAsyD0enIJK+Qg86A8YRGhx5bC6UUqv5dvWy+qUEYB7MdVI552vAql470NYCUm3+j/rPk5hoING5P1dMhzdpvo/rbbXQVZVo1D5msxa7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871478; c=relaxed/simple;
	bh=NXHEgli9h3ltIyqQ10u0/R2ceBI7JNlBI7uUa4Qbnag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZn7pegQq9sD02awUg5xrRvqQT+bDAuKW8STgrdK76d+qVvyixZTELHmMqVkOoemAEatQVQzcDfXdclQg0ypfL256oph0vqsLQePblG1tWqvxtuibam7x4W56HAa1VbykSzJ34gl+DTDinbeytdOnMPs9ccfXuG4X+47Suo+xH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZQhomku; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5YDzv/Bz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751871475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuuSwo0zQBBN7R4fcUaWhBlskzzr3dByqm+DcqkM4YI=;
	b=RZQhomkugkDWET94Yk1EOld3uTTrnlT2ny2nAOIi6lXODNKA16WNheYxZSiIzX72vyhBQm
	qiBzwlzjTtgkeH2V8yD+7sTesxD3KuQX0ZiRJfHINndrCkowqWHT+r7qCEZhc1ObgngpyC
	h1i1L3FAmOkbpohyervvPWsobN3ff+ed4ZP6wbbtnZunG3emsz1eJ1UhBX3X6PZPAYdshl
	zUi2nJ2071psoygiVPOA9kZqu2Lj4FH1XZ/c+AQuU7PRX8BazarPMQjIaVtrhrE/bNXQr1
	7um3shwV7yuk9gkbL+glDtG+WoBGW4irz8uyY2loBw5hygbhbaP/5q1Vhcew8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751871475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuuSwo0zQBBN7R4fcUaWhBlskzzr3dByqm+DcqkM4YI=;
	b=5YDzv/BzqznvW8xhNlqNiTSvwyy3bssfcOYC/6kIheF1XlwtmRKvG2SCCwIiJOdQHLKYVS
	HJ5LqlP3+f/mhzBg==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski
 <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah
 Khan <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 11/14] vdso/vsyscall: Update auxiliary clock data in the
 datapage
In-Reply-To: <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
Date: Mon, 07 Jul 2025 08:57:54 +0200
Message-ID: <877c0ksd1p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
>=20=20
> +#if defined(CONFIG_GENERIC_TIME_VSYSCALL) && defined(CONFIG_GENERIC_GETT=
IMEOFDAY) && \
> +	defined(CONFIG_POSIX_AUX_CLOCKS)

CONFIG_GENERIC_GETTIMEOFDAY requires CONFIG_GENERIC_TIME_VSYSCALL, but
that's not expressed anywhere. This stuff has grown too many config
options over time:

GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO, GENERIC_VDSO_DATA_STORE

All architectures except SPARC64 use the generic code and the generic
VDSO data store implementation. That config maze wants to be
consolidated.


