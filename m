Return-Path: <linux-arch+bounces-12585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D186AFB25E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7032F7A6E85
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C07299928;
	Mon,  7 Jul 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DBhmpZn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apoLr9eR"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEE26057F;
	Mon,  7 Jul 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888115; cv=none; b=bKR/FPuzKJZXub+LxNfTNkj82O/3nAiQsgd6D438F4ZRYXqNnczwv0BviPLznY+VF9zs9XbK0Qqe79UXu01rV8W3rEiGpDsAkOT2mkS8ilWpPYik1J0+1/ltTA7Gzvjy6hBbTfzHHp3ag+AquKVhrWoZqV1ozAiCyCk8P/PM450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888115; c=relaxed/simple;
	bh=xsounmBckqXT0I3aHzOjw9zrEEH/ZiLn1RjzAXk2HR0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mFDZqz2raFkLlfJ2JYQD2ItUqqlJQAhB3L8VBG2Rt/OV+5drxl6wnvNK067mWbt8wI/j09C5On0yt2e45HMazJGF3RHy38sW28Bh0FVxr27Vo4ZscC76jLF0CG7hwqeH0ixqRz4z79vp0L+Oe9EvVILpjQkpc0MNDGnj4oP18Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DBhmpZn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apoLr9eR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B20927A024A;
	Mon,  7 Jul 2025 07:35:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 07:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751888111;
	 x=1751974511; bh=PCGPfsy1pxa191INMAVM66YRgrGVVyJxnFps2kupCoc=; b=
	DBhmpZn73HaS/+kZdc3rSSgFh+wA0Vfq/rg1YJNZjXKGgA68xeXfA2Fd6PAtG1Sq
	lj2A41evxwcSoO5TSzUZ7DZb0Pa/p4+xOZGJgVVEyfrSNdcBkb47PdrV4rGTKcWv
	CQrpZmTfhNL9Av6OTNGe4+h2WBzF5VRsVtTeaD3dPmVQXtbZqEFn5oRic1Vkwi++
	GAlLflf+jVFDzw9op+/Z0DJJgcqvBRkOo1KG5m15yPAv3W7qwqrTC+nTZAThRVoj
	Uy6WahQCnUkPWB3W+KQaIBtvI2bCF+eg4kKUGOaHbZ2bN4QAbUL82N3QgekVxJq5
	AYm2IDbHKW9GbJBq9Gk/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751888111; x=
	1751974511; bh=PCGPfsy1pxa191INMAVM66YRgrGVVyJxnFps2kupCoc=; b=a
	poLr9eRr+YKPz6oEdEOyX5EEGjYyI78gb8EGsaBl+PqHfsxAF0Nbu4n+waXYEvrL
	6Mp2GgYx3cuDRUSnmj9QoTwQdlSwPhehknnzhfzRm7NlS8N3lvpSZP3sGWry8zVW
	XLbLXoMqY8Osqkpkq9xmVrKhQ9YuKWh4b8eMqmVGemmFxekr98e3ub098koiLKwX
	6KfH4tWosBxxjh1XHTnIzJW6OU1MIDYk99vk61cUZUzJ1t8bjopHfN8ves7eYZkD
	TTss9xLcjrURWG35OyxTqRcmQidHozYTuVwzU+wa2xGPPZt3zPsYdv6uo1rgo815
	ccpiBDiPJxArwdu4wMLOw==
X-ME-Sender: <xms:7rBraKUhB51fkfyZCEJ3Ze7F0jpWpd2EI8pDLE8Y4J9btd52DcAy3w>
    <xme:7rBraGmtVabI68dRoZEJBvKDpoeIiLSyCndHAOEZ8XTEvefWRsbBzyJeew6ixi2PT
    K56vB0t2HoM3o_FLlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthht
    oheprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepugifmhifvdesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopegthhhrihhsthhophhhvghrrdhsrdhhrghllh
    esihhnthgvlhdrtghomhdprhgtphhtthhopegrthgvnhgrrhhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhuthhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7rBraKau-agsLHnE-ISJfm9OKPvCc2yOQSSoXw-1p2J6vq9fUmpiRA>
    <xmx:7rBraIKRbJIuvwXrMoKkYRH2aQyXtO1Q8vbKoQuWxtrBlyjpisv75w>
    <xmx:7rBraD2Qb89NZ1yPl_xTDhDDK_Dy0pt_IpCVfJGZxjTATEIj6AYykg>
    <xmx:7rBraDaRmwjUh7CYm2YLtLcwwHBrFyg3Sp7gqwFTxkNWL7qhqiCz_g>
    <xmx:77BraIT7QpWds9bsUn4Mt-kQAHxyZ-gfaH1BcIC2-YDZH9V662UWZJvI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7C283700065; Mon,  7 Jul 2025 07:35:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T22a9fd8a498db8e8
Date: Mon, 07 Jul 2025 13:34:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Christopher Hall" <christopher.s.hall@intel.com>,
 "Miroslav Lichvar" <mlichvar@redhat.com>,
 "Werner Abt" <werner.abt@meinberg-usa.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Kurt Kanzenbach" <kurt@linutronix.de>, "Nam Cao" <namcao@linutronix.de>,
 "Antoine Tenart" <atenart@kernel.org>
Message-Id: <2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fastmail.com>
In-Reply-To: <877c0ksd1p.ffs@tglx>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
 <877c0ksd1p.ffs@tglx>
Subject: Re: [PATCH 11/14] vdso/vsyscall: Update auxiliary clock data in the datapage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025, at 08:57, Thomas Gleixner wrote:
> On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
>> =20
>> +#if defined(CONFIG_GENERIC_TIME_VSYSCALL) && defined(CONFIG_GENERIC_=
GETTIMEOFDAY) && \
>> +	defined(CONFIG_POSIX_AUX_CLOCKS)
>
> CONFIG_GENERIC_GETTIMEOFDAY requires CONFIG_GENERIC_TIME_VSYSCALL, but
> that's not expressed anywhere. This stuff has grown too many config
> options over time:
>
> GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO, GENERIC_VDSO_DATA_STORE
>
> All architectures except SPARC64 use the generic code and the generic
> VDSO data store implementation. That config maze wants to be
> consolidated.

Would it help to replace the custom sparc64 vdso with the
thing that parisc does and call the fallback directly?

I doubt anyone still cares about the clock_gettime() performance
on sparc64, and removing it would remove all those special cases:

 arch/sparc/Kconfig                  |   1 -
 arch/sparc/include/asm/vvar.h       |  75 --------
 arch/sparc/kernel/Makefile          |   1 -
 arch/sparc/kernel/vdso.c            |  69 --------
 arch/sparc/vdso/Makefile            |   2 +-
 arch/sparc/vdso/vclock_gettime.c    | 340 +++--------------------------=
-------
 arch/sparc/vdso/vdso.lds.S          |   2 -
 arch/sparc/vdso/vdso32/vdso32.lds.S |   3 +-
 arch/sparc/vdso/vma.c               | 265 +---------------------------
 9 files changed, 28 insertions(+), 730 deletions(-)

(the added lines here also fix the missing clock_gettime64,
which was equally blocked on the sparc64 oddities)

      Arnd

