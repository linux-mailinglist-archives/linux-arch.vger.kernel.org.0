Return-Path: <linux-arch+bounces-3004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F287C2EF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D36A1C21AF7
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043F74E29;
	Thu, 14 Mar 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4F7ym39";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+JfS7kT"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151E73161;
	Thu, 14 Mar 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441775; cv=none; b=X/0RC08tI+NnXpFsKFz17ByLaF9fBrBbApc/f0t/IdvnFgq6OVlC+w7ekMF7+cLjNp4LzKT2kdJjVBpypH1KmZ7YbMtUkI55/29S40iEsTHow4210Wrqq/IOkNl9UFs6q3e0uu8Aoc9tU/TTue353tV/RP+OELEFEFc5IdsIK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441775; c=relaxed/simple;
	bh=9fQNmauwXVLbx3l/9AQwaKv4QnHJbY0M91gE202lHGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gb5wsuc9gVn0nVD442v6QSOtpjQLWFsX/XO4e/W1xQuUao5sy6a6c7j7j1d1NmM3YlBSb077a+ARUiqoMmV2r8QqPjqKeNVl03NbGDreICIwfjk3uEn9PYyDE2tZ+CuwASGl0k1MMElRZjXIBF6+gRBVcBoRmwqJrCx2Lt9zx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4F7ym39; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+JfS7kT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710441771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRBdz+TTjKnmNqSOMdgZyda1Ih+01wkUCAjYAj7VG7M=;
	b=f4F7ym39ldanAoN48evdVViY2cckN4OqtXrPyrUuVexxb7uyU0Z1axPpdretXXxXus/rdj
	HVPnULNDcgB+UqtcNZULb+r2VYrEC4QUzaUl4BW0Jwmjx7QiR+VP+MYFvk5+YH5OQNrFww
	VzXbn1MHx2Lm/3C9Ja1TYaiyGHLEK0K+mSdAh5zy0UTYS+YOyiWl7OVnotCmRI5Cy7N3fT
	41svQsMQvwYl+r4ezy7OJN3KTvbO8P+Sco/nmgCsUBA7xMHGVgzrmL+7L/RsviBZgvPxmn
	XnJWwIhPd7IXO66ln4wTY9fma2C/Z0K6OtYfWLiUvP+9np1kk3vUxESDXPfuBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710441771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRBdz+TTjKnmNqSOMdgZyda1Ih+01wkUCAjYAj7VG7M=;
	b=J+JfS7kTuRvMpuzDrlI3qwNlwu3mRLdXk5S7Kxx42qW2KPIf6vQyzaa7wztnI7fSRzK0Zz
	48vKeFN4z0EkefBw==
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, datglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org,
 peterz@infradead.org, hannes@cmpxchg.org, sohil.mehta@intel.com,
 rick.p.edgecombe@intel.com, nphamcs@gmail.com, palmer@sifive.com,
 keescook@chromium.org, legion@kernel.org, mark.rutland@arm.com,
 mszeredi@redhat.com, casey@schaufler-ca.com, reibax@gmail.com,
 davem@davemloft.net, brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <CAMuE1bHOm2Y1bOpggStMOjZhN5TaxoC1gJea5Mdrc+mormQg0g@mail.gmail.com>
References: <20240314090540.14091-1-maimon.sagi@gmail.com>
 <87a5n1m5j1.ffs@tglx>
 <CAMuE1bHOm2Y1bOpggStMOjZhN5TaxoC1gJea5Mdrc+mormQg0g@mail.gmail.com>
Date: Thu, 14 Mar 2024 19:42:51 +0100
Message-ID: <87y1aklkno.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14 2024 at 17:46, Sagi Maimon wrote:

Can you please trim your replies? I really have better things to do than
doing detective work to find 10 new lines within 200+ irrelevant ones.

> On Thu, Mar 14, 2024 at 1:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Please read and follow the documentation provided at:
>>
>> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>>
> I have missed this part on prviews reply.
> I have read the documentation above and I think that the variable
> declarations at the beginning of a function is in reverse fir tree
> order meaning from big to small, but I guess that I am missing something,
> can you please explain what is wrong with the variable declaration,
> so I can fix it.

>> > +     struct timespec64 ts_a, ts_a1, ts_b, ts_a2;
>> > +     struct system_device_crosststamp xtstamp_a1, xtstamp_a2, xtstamp=
_b;
>> > +     const struct k_clock *kc_a, *kc_b;
>> > +     ktime_t ktime_a;
>> > +     s64 ts_offs_err =3D 0;
>> > +     int error =3D 0;
>> > +     bool crosstime_support_a =3D false;
>> > +     bool crosstime_support_b =3D false;

It's not about the data type. Look at the three layouts and figure out
which one is better to parse.

