Return-Path: <linux-arch+bounces-3144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803A887C69
	for <lists+linux-arch@lfdr.de>; Sun, 24 Mar 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C0A281793
	for <lists+linux-arch@lfdr.de>; Sun, 24 Mar 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCF175A5;
	Sun, 24 Mar 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7zxPixu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zP5b/bm"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC92171B6;
	Sun, 24 Mar 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711278267; cv=none; b=oVqCPF1Se4RQfCcQz+VHvJWsBxVZhclnn60wwuTydp8C2o/gqvxsqVTNxJpbSJ9gYpwudEQQUPjlO5onDr+uXVRvC9adJd+Ryv6TEmnagbQIScPISN5MZc2NkgfZmnL4PV/eXl0ZRHQpyDp1K1YGXT3NQXW7JFNNHFn2RH/u1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711278267; c=relaxed/simple;
	bh=oVWt1URKKwcX1yBL2A/VUlUd8pg+WwR5QCUkGAW00E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwhjuIlr3QFth+i4t4U5wl7GHSJk7sC2MqPyVjJYkzTWws5iEj6WS6rJvWGSIlH9myVN0xW+WrRtD8/hFeyd0L4ESQqN0r+JpvVoggfhrNewAkfOsLqr1z4Sj7udOA/m6FWVc45IvP7QgtDYgTaSeO1DCjNCtpgDNmL2oWodg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7zxPixu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0zP5b/bm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711278262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/mH+jshQDq36UblDsSyrijdM7u3yitlRALbmDQiFhQ=;
	b=t7zxPixu7qaYG51JCvo1ZOQWA/ACxTuuj8zFnDgHzHPztgwklM3NQLGEeGfO8BtnUwz/9i
	pMirW20R4/jgtZHyn4BZtu2Aw10yVVIbYif1WtvymjBtuXW6Zq1kE8o3Ub5vLfyVU7QfxG
	0UvoNfkcKVyNQgQNJYAtQZTDia3pdd9N/ttYXkZL5zIN0Qlcjw7QPiLkgaz6k5y0x62R9d
	gb4gV1ENpfo41Fs4Vh9hxDWidwK3q5uwumbcrHQ6ypY/0fa2+ZRexzovLfG0d0Iuv2RrWA
	6nfB/08D+O2qpTLhxDIfCO1B7j8WuvenOW9n9RbCBDfUh2ZAZfAWfLtdRXNmtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711278262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/mH+jshQDq36UblDsSyrijdM7u3yitlRALbmDQiFhQ=;
	b=0zP5b/bmPCg1ZQGyVupWSN3TpJwnNzP0yHkov/wwsnDRr2CvA/XIPR6n90Ossh1xnUewt0
	gBjxUzMze3k1OaAQ==
To: Thomas Gleixner <tglx@linutronix.de>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org,
 hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com,
 nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org,
 legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com,
 casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net,
 brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <875xxdhj8k.ffs@tglx>
References: <878r29hjds.ffs@tglx> <875xxdhj8k.ffs@tglx>
Date: Sun, 24 Mar 2024 12:04:20 +0100
Message-ID: <87msqnrivf.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Sat Mar 23 2024, Thomas Gleixner wrote:
> On Sat, Mar 23 2024 at 01:38, Thomas Gleixner wrote:
>> PTP_SYS_OFFSET_EXTENDED moves the outer sample points as close as
>> possible to the actual PCH read and provides both outer samples to user
>> space for analysis. It was introduced for a reason, no?
>
> That said, it's a sad state of affairs that 16 drivers which did exist
> before the introduction of the gettimex64() callback have not been
> converted over to it within 4.5 years.
>
> What's even worse is that 14 drivers have been merged _after_ the
> gettimex64() callback got introduced without implementing it:
>

[...]

> 2020-11-05   drivers/net/dsa/hirschmann/hellcreek_ptp.c

Oh, my bad. Let me switch this one to gettimex64() then.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYACLQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkX6D/0Up3j+XE9kDqSQoc2pu9NoxF6Srmub
lTxnMPB7Vq5dkXM1EYUhK4Mji31dmYDdt70y0O9DrAke9RcGbWk3v45Yb2fMMWNe
UHjol/JoZIuFdqOw8Tm8soYkB76mf1vTBgZvwDJrmBoJhVYHGZgpQhd7/VxRp1Kn
TON3EpUj1kH9BoZTmzai8NFVivqMPrkdJTtErYZckaD7uO3lqxzTQsQ1C3SPaqZM
TGe/WHSDudT6vov8ousEzNxoHPJt/JcJj9CFJnyYVk1wtaGBrbuU68tht4AgBd7o
v6jiTKxpGFFqtMZISPLUgYasPwUjxCgsrEVxQmQGBzZOG+nHfP+kKKEwgafV+HSc
jZOK52LBnaaVCdGIlwEMJUOpk8AVN6rReeUqWIHJEcezKUVn6Elo3RRyrH33aq5t
L6sm3k1IzMGHwyhmLgp6ep/YDBHgWbSJ3qXyEr7Bet7Zq99IiynTLg11GX68QSc2
MVBb1zldKucN3BnFl2B6sqwexbtxPNGNm5dXPJWKLLIdmh47kVFOH4+0fvwBpveu
5Gwp5q+JZYSlqit9SfLkt2jRORt1MZmwxn4JH06+23CQ+fT/+uQBZMA8AfUtK4PJ
7+R8WDXAZnr/ZDjXzv5zJbj49Z3X8CPKFFGWfQdCC16VMpUQPDLLslO4nZFnrXtM
Ig6ltOiLusm+Ew==
=e9pu
-----END PGP SIGNATURE-----
--=-=-=--

