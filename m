Return-Path: <linux-arch+bounces-3350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB8894633
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 22:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA0E281C2D
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6B54730;
	Mon,  1 Apr 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCwzi3Fp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htMHsfgK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D82A1BF;
	Mon,  1 Apr 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004375; cv=none; b=Kggal1wUxbY1ARHwGMnHDM+G4mwyrNAoJbwyGo+9SUZqAm7AwOn0E8w56px3vOjETdpOlR7tMTiraB4HM5K2iIk1goklU+/xHcSzTQiXGHRpHFNHQq2v3mm+dn9PIIwSQQPWCoiFD9x+Mv0Yzo1zw7qsSrpNQiCwi0h58G7xsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004375; c=relaxed/simple;
	bh=avBOhuX3GmEDNDJJHrH0PwxhZKKnjnL1k92PCok0jh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKdPAm+Xha/Q1GJwfpWSfUiI407OFrfadMttXbnMojoMDxoCzqk+XTHpN8JpH0L9126slhm3sDgsHtD3tPxi57eUUox6FXc/At2CM1dCP7pIYwSuLQt89JDUeu/UNx4a5WW+r9EOTeibMYjtWitFRCo4SQ8TBwpqN6tnc4hzZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCwzi3Fp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htMHsfgK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712004371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ouXpnTwZTCYF7FT9pTFvv/0pB2wPIrYopkk2qk0W9U=;
	b=RCwzi3FpOeLoPGiVcadqq9WkweHj4Kme43Ekqpeump0ROFpO4wCAD3pVhNtr2lGFwDWL1X
	ahgFiPHRpc6B1V1YLkXhRglCxiPuKIQmvDrNvGCBfz4reUT9t7Ht39Sw9nQyrdH6cZxyl9
	PS/7L6XoXGOI2HWFApOn/xEC6ypw2A225gntr/fi/huCMbmHcbLwW+LSfKqUm4q8YBJ1UU
	ddK/rrKTUBDBQzYHNRi9W9ril/RsC9LLFTudBj1F3pQx3DiOxaLLCpn+UMiJOFMqdzOsCQ
	7dizB8BjzoobnGaJkmELjIgzg3iF5zINH0eJO9Bpp7pM1zAc8kyI+ttpVfpooQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712004371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ouXpnTwZTCYF7FT9pTFvv/0pB2wPIrYopkk2qk0W9U=;
	b=htMHsfgKPbXrF8jOpfKKqJnUt3ExzvQDh8OLvonbPrTdII1wItINA3qb4hXrfoOr1zORyc
	W8h5oalSM7FNJjCA==
To: Sagi Maimon <maimon.sagi@gmail.com>
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
In-Reply-To: <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
 <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
Date: Mon, 01 Apr 2024 22:46:10 +0200
Message-ID: <87o7asdd65.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sagi!

On Thu, Mar 28 2024 at 17:40, Sagi Maimon wrote:
> On Sat, Mar 23, 2024 at 2:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On top this needs an analyis whether any of the gettimex64()
>> implementations does something special instead of invoking the
>> ptp_read_system_prets() and ptp_read_system_postts() helpers as close as
>> possible to the PCH readout, but that's not rocket science either. It's
>> just 21 callbacks to look at.
>>
> I like your suggestion, thanks!
> it is what our user space needs from the kernel and with minimum kernel c=
hanges.
> I will write it, test it and upload it with your permission (it is you
> idea after all).

You don't need permission. I made a suggestion and when you are doing the
work I'm not in a position to veto posting it. We have an explicit tag
for that 'Suggested-by:', which only says that someone suggested it to
you, but then you went and implemented it, made sure it works etc.

>> It might also require a new set of variant '3' IOTCLS to make that flag
>> field work, but that's not going to make the change more complex and
>> it's an exercise left to the experts of that IOCTL interface.
>>
> I think that I understand your meaning.
> There is a backward compatibility problem here.
>
> Existing user space application using PTP_SYS_OFFSET_EXTENDED ioctl
> won't have any problems because of the "extoff->rsv[0] ||
> extoff->rsv[1] || extoff->rsv[2]" test, but what about all old user
> space applications using: PTP_SYS_OFFSET ?

So if there is a backwards compability issue with PTP_SYS_OFFSET2, then
you need to introduce PTP_SYS_OFFSET3. The PTP_SYS_*2 variants were
introduced to avoid backwards compatibility issues as well, but
unfortunately that did not address the reserved fields problem for
PTP_SYS_OFFSET2. PTP_SYS_OFFSET_EXTENDED2 should just work, but maybe
the PTP maintainers want a full extension to '3'. Either way is fine.

Thanks,

        tglx


