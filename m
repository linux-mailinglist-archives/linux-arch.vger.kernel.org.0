Return-Path: <linux-arch+bounces-2938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306887954A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D21F22F76
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E37A15A;
	Tue, 12 Mar 2024 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a0mDb4pR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDFatT0+"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270715B1E1;
	Tue, 12 Mar 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251281; cv=none; b=C61Tlq9wpPL0nUlqZ4AH03jE/5XGYGQgtha7AS5yx/gmBl1gFSccYI0mXIjtknYGgECc4OiWSPWJAZweLSEFvXthZ+1LlV0go9kGL6KEisDG3AVI6RKoWQa9dde89NWw7eJyBm+RW6BUrMg3PUuE73XgUzcLL2opI39nC6+ry2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251281; c=relaxed/simple;
	bh=3PLdIJmYTKB6gkGFZ9Bne0cSJ5xec83W3smNXqUjWso=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QUwEUZDeT0FbTV58vV5LmOh1cKsqTlbQczCSxxMJhjjnH77wDtgeek9vrhuQfbw0bmBPpK+LXOoiJw8ZzjqWeIQ6+LytWe1QcInbajogIxYUz27I1xV+G+vn7t3+GMiSzS8TktDNpeJba8V97LK8RK3qqBKNtJamP6i7DwTSOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a0mDb4pR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDFatT0+; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CCA9A1C000A3;
	Tue, 12 Mar 2024 09:47:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 09:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710251275;
	 x=1710337675; bh=Bjy1wqXHISa4mvQY02jG8JIIsUcNLSlrmrkVMNTQWAQ=; b=
	a0mDb4pRPVrLP1HPtkBSgW5ZnB73TtkkPT/FZBnpMqxewQgvPuWImXb3uDemLx/m
	wSvjez4eA0/rIa1hZphVSvBUDbfuiNFsBl2VpcfTrTktFUy/J0PfsGGcg+sIxMUG
	9DQRTtKVZ8CU6I24rKRRhdpmSDAiWDHQM+k6TYBv4xG1pe34dOYklPduJmIoFhpS
	CrAzShryLlcID3SwMGy2utRETRh/LOuzSFiausMAYvZ/Uxxat6Nqx8w+P6ccrbET
	gXnzd1Dz9q6/RYQhp6beKDT1olhi+7dRcUKjJy1xMJa4GqkfeQQcCkESrG/lKobW
	Y0ll+aRUbwddS/axfJWbag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710251275; x=
	1710337675; bh=Bjy1wqXHISa4mvQY02jG8JIIsUcNLSlrmrkVMNTQWAQ=; b=l
	DFatT0+nF31R7ZyBzAe8mHgWuGi+srr48TLHIeBwT4u5C1KeQc3pKqj0sk7w6Lqc
	N2FyBjNcrgu5GBOEwZts/IFFVATcmzvDgx1rDTgGImMMqKxPXRkhIS+PmDaH1Isw
	KTqSbP7U3dpgoK95KM6l9Iig8lRwh4nM7CuwYxeGwvg2q6xACelIyOvP5bwgJC9g
	BXsjLudbuM7r10pO4VKbrARM1qCajmRD5WCFGArCa8URjWrAz+K/WrINwB73npMR
	QiWrmvpe7HGRxh1UXdSXwgt/yufpBxFksDod08NIuFZKJ7nGnj3BAykGvVJF8ter
	4O+SqYaU4F1kcF7SGIULA==
X-ME-Sender: <xms:CV3wZZWs9P2zX9yCI8RlclX0s0av5QUUrtKdQO6JzPxaznGMxGvAQg>
    <xme:CV3wZZl1jYtKseL0Oji4Uy3tb54p3lbwswOzMKrqDcc-5v0e7pEhPDaK3pijRwLA8
    Kdf7HafcHX7jADKjo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CV3wZVbgTpEeWDXrLXE4N0-I43eo4OF7LhSGGIX-fmoGMnDWP1pDFQ>
    <xmx:CV3wZcU0TmTecnXndyvJG_ls_NoyU3abBFWCmBnnsBMXA72Bo8Lnuw>
    <xmx:CV3wZTk6lbB_Vd0gtjRgz0uuMUUrd08nj2Dx3KR_fu41JBuOTpEj1Q>
    <xmx:CV3wZZecS909lb2jNM3D0mMNkhNEuuHtMGODT63XkGUlMgKkFgbSAw>
    <xmx:C13wZXyNzd7ziPJAGYzgNhfiJVr7M3VjwuKuW8M3dg-HEXju4t1XwCi0-TI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3AE4CB6008F; Tue, 12 Mar 2024 09:47:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a4e4505-cf04-4481-955c-1e35cf97ff8d@app.fastmail.com>
In-Reply-To: 
 <CAMuE1bGkZ=ifyofCUfm4JVS__dgYG41kecS4TxBaHJvyJ607PQ@mail.gmail.com>
References: <20240312095005.8909-1-maimon.sagi@gmail.com>
 <7bf7d444-4a08-4df4-9aa1-9cd28609d166@app.fastmail.com>
 <CAMuE1bGkZ=ifyofCUfm4JVS__dgYG41kecS4TxBaHJvyJ607PQ@mail.gmail.com>
Date: Tue, 12 Mar 2024 14:47:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sagi Maimon" <maimon.sagi@gmail.com>
Cc: "Richard Cochran" <richardcochran@gmail.com>,
 "Andy Lutomirski" <luto@kernel.org>, datglx@linutronix.de,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Nhat Pham" <nphamcs@gmail.com>, "Palmer Dabbelt" <palmer@sifive.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Alexey Gladkov" <legion@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Miklos Szeredi" <mszeredi@redhat.com>,
 "Casey Schaufler" <casey@schaufler-ca.com>, reibax@gmail.com,
 "David S . Miller" <davem@davemloft.net>,
 "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v6] posix-timers: add clock_compare system call
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024, at 13:15, Sagi Maimon wrote:
> On Tue, Mar 12, 2024 at 1:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Tue, Mar 12, 2024, at 10:50, Sagi Maimon wrote:
>> > +     kc_a =3D clockid_to_kclock(clock_a);
>> > +     if (!kc_a) {
>> > +             error =3D -EINVAL;
>> > +             return error;
>> > +     }
>> > +
>> > +     kc_b =3D clockid_to_kclock(clock_b);
>> > +     if (!kc_b) {
>> > +             error =3D -EINVAL;
>> > +             return error;
>> > +     }
>>
>> I'm not sure if we really need to have it generic enough to
>> support any combination of clocks here. It complicates the
>> implementation a bit but it also generalizes the user space
>> side of it.
>>
>> Can you think of cases where you want to compare against
>> something other than CLOCK_MONOTONIC_RAW or CLOCK_REALTIME,
>> or are these going to be the ones that you expect to
>> be used anyway?
>>
> sure, one example is syncing two different PHCs (which was originally
> why we needed this syscall)
> I hope that I have understand your note and that answers your question.

Right, that is clearly a sensible use case.

I'm still trying to understand the implementation for the case
where you have two different PHCs and both implement=20
clock_get_crosstimespec(). Rather than averaging between
two snapshots here, I would expect this to result in
something like

      ktime_a1 +=3D xtstamp_b.sys_monoraw - xtstamp_a1.sys_monoraw;

in order get two device timestamps ktime_a1 and ktime_b
that reflect the snapshots as if they were taken
simulatenously. Am I missing some finer detail here,
or is this something you should do?

>> > +     if (crosstime_support_a) {
>> > +             ktime_a1 =3D xtstamp_a1.device;
>> > +             ktime_a2 =3D xtstamp_a2.device;
>> > +     } else {
>> > +             ktime_a1 =3D timespec64_to_ktime(ts_a1);
>> > +             ktime_a2 =3D timespec64_to_ktime(ts_a2);
>> > +     }
>> > +
>> > +     ktime_a =3D ktime_add(ktime_a1, ktime_a2);
>> > +
>> > +     ts_offs =3D ktime_divns(ktime_a, 2);
>> > +
>> > +     ts_a1 =3D ns_to_timespec64(ts_offs);
>>
>> Converting nanoseconds to timespec64 is rather expensive,
>> so I wonder if this could be changed to something cheaper,
>> either by returning nanoseconds in the end and consistently
>> working on those, or by doing the calculation on the
>> timespec64 itself.
>>
> I prefer returning timespec64, so this system call aligns with other
> system calls like clock_gettime for example.
> As far as doing the calculation on timespec64 itself, that looks more
> expansive to me, but I might be wrong.

In the general case, dividing a 64-bit variable by some other
variable is really expensive and will take hundreds of cycles.
This one is a bit cheaper because the division is done using
a constant divider of NS_PER_SEC, which can get optimized fairly
well on many systems by turning it into an equivalent 128-bit
multiplication plus shift.

For the case where you start out with a timespec64, I would
expect it to be cheaper to calculate the nanosecond difference
between ts_a1 and ts_a2 to add half of that to the timespec
than to average two large 64-bit values and convert that back
to a timespec afterwards. This should be fairly easy to try
out if you can test a 32-bit kernel. We could decide that
there is no need to care about anything bug 64-bit kernels
here, in which case your current version should be just as
good for both the crosstime_support_a and !crosstime_support_a
cases.

     Arnd

