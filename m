Return-Path: <linux-arch+bounces-3355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D948F894EA5
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DF7281268
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799FE57875;
	Tue,  2 Apr 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQZucdhh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7amywlH"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C557323;
	Tue,  2 Apr 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049917; cv=none; b=AFPgrTvZmFRE8IH8Fz7h3wCYHlJACVwxVN7j8k14AXQKzj+Z0C8eElpiI4+q0+wISlmz3K3FB2PEIjqMMoNANskX4h/D2xBlyB0/lITXkKam6j98H20L19GKN5fXlsNe5FzhY3i3V5pf70pMiPXxkzlyLEpH88JiPqi7kT5nKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049917; c=relaxed/simple;
	bh=D+pmTJbWD+F5FqLLVUmPGKhvuuWcaJlICv2fiuRLyOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiMtNEjEZyJkTlGaRJ2TsJZ9y1j9M3fW2ULkFCT4Qm3cYkDRyIr4UW1Gba4Hx3LMTU6MGsvpZHZvUFAAuxTnKJNSBPo8kXQi5J5ZlZtSfUoYbx8dwz1vJfw0KZakXG3QhWiSzNnCIPVQgiDljsqjvWkV9KKpFw2W/+uTMKdz/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQZucdhh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7amywlH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712049908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxnU7oHDRvp2KKF4I0w+Kk9loooljsfq/6TvcopJ+7o=;
	b=sQZucdhhQgMO5Ub+2Bs5zKZwhGZhWDZq8Mzo8Nb6wtWyyY8QiM6jWdXjFlN1EzlOxDD8GS
	3mq6hIH/aPV9iVke03eUBejlFlW5yYzEkfTdoUZKgnpMD6Lb+/n2wuV0JPlP8u5ArNpCgA
	Dx12Z25LyjjUJPiGJsrhWpHJOl+R30Qv2pGyq5eholxM2Qn9nnUUVkIX5yqqu41iZcTZQK
	pybYPVzDYdB9rdXq1OlYPJ8ubMLy1de8gRySvOznWT2ffzJaAAEz0kW/lZUGw5335D92Qu
	pnMgy/B3GR7ml4RHAspOuGp4hpotADKcxTmFW+kfAGoNs6/JIyn94/fUfY6S6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712049908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxnU7oHDRvp2KKF4I0w+Kk9loooljsfq/6TvcopJ+7o=;
	b=t7amywlHQ/7Ooi3w3AkZlkjifY46KwOg8Sjbg0P2ctA3ECbK6LB+5mh1AhvWM28e7KRWuZ
	7k9GgRKqQPwWpsBQ==
To: =?utf-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
 =?utf-8?B?4KS+4KSwKQ==?= <maheshb@google.com>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org,
 sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com,
 palmer@sifive.com, keescook@chromium.org, legion@kernel.org,
 mark.rutland@arm.com, mszeredi@redhat.com, casey@schaufler-ca.com,
 reibax@gmail.com, davem@davemloft.net, brauner@kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx>
 <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
 <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
Date: Tue, 02 Apr 2024 11:24:59 +0200
Message-ID: <87il10ce1g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01 2024 at 22:42, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:
> On Mon, Apr 1, 2024 at 1:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> So if there is a backwards compability issue with PTP_SYS_OFFSET2, then
>> you need to introduce PTP_SYS_OFFSET3. The PTP_SYS_*2 variants were
>> introduced to avoid backwards compatibility issues as well, but
>> unfortunately that did not address the reserved fields problem for
>> PTP_SYS_OFFSET2. PTP_SYS_OFFSET_EXTENDED2 should just work, but maybe
>> the PTP maintainers want a full extension to '3'. Either way is fine.
>>
> https://patchwork.kernel.org/project/netdevbpf/patch/20240104212436.32760=
57-1-maheshb@google.com/
>
> This was my attempt to solve a similar issue with the new ioctl op to
> avoid backward compatibility issues.  Instead of flags I used the
> clockid_t in a similar fashion.

Works as well. I'm not seing the point for CLOCK_MONOTONIC and the
change logs are not really telling anything about the problem being
solved....

Thanks,

        tglx

