Return-Path: <linux-arch+bounces-5494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B9934B06
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734621F23CDD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237938002E;
	Thu, 18 Jul 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gU4B0fXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqCwNVUW"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7C25634;
	Thu, 18 Jul 2024 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295359; cv=none; b=H49Xl9N8IqOGvSxAycuczBGf8RtrTNYZhVPqEdyoV2Q1qo9Y27asfvTd8UOGllGNPKHwM+lk/0eo1fr82323CAOKRqFQVrifEtPvJA38NWaJimMynnns9v5bYHM4Ncn0KUgAkFhFyX/Uo2N7rpE43/17NwH8rQPE/hB1OnCZ4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295359; c=relaxed/simple;
	bh=pSQ976eQYW5rH1Dwdz8iHxLbSbZIasTSAP2Pi//gvd8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ICI/lgMULOOkuISFGfzykAghHilBUGBeHc/xj+4dEIJGeTWclnyB6ySl9QDZFw3H3VWi8WobhfBCC4viykgasIbOsZLz/+pHrhByda1vB9BJ4XgPwP7Gp3DGGWEkGd6nWmBSi8gYp8rHZhsAerAsvAbyoGdbXqwiRyPUz80g5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gU4B0fXC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqCwNVUW; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailflow.nyi.internal (Postfix) with ESMTP id C6660200379;
	Thu, 18 Jul 2024 05:35:55 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute8.internal (MEProxy); Thu, 18 Jul 2024 05:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721295355;
	 x=1721302555; bh=N6nNE9JphcqfhA9xYmwmZhMShW3TQ025Yd0UOM/gNrs=; b=
	gU4B0fXCqkX23adCeJk85Axa5jUwIyl2PAu5Ak58NhKTY5MGrxcxHywaBGqjlaGB
	EHsmg/15YoGQfdmZCYVXT+LjUEdSD0uzfnnd5L5TbEG5Dhu+w0ZOVwK2HlMoAlCI
	j8KXiOBnjIj2EeW9VRecxF8+AeBiM1JW7reYXEc+/zkwWcl4uB1vB3uJkEEWVkiR
	1IrFONzrwTmHIic+SnrFRljnryEgjhlferPDCLuxNkIOEVMoSZll3T4YpenCZN1W
	NmHG9cdqmsX9jyksmjDXS4sLQXMnkHU7Pn8Cuyq2UK2R3G2omcVxTpdZ3vitrwuN
	QuU2zVwT9e5Je1uubi5v8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721295355; x=
	1721302555; bh=N6nNE9JphcqfhA9xYmwmZhMShW3TQ025Yd0UOM/gNrs=; b=Y
	qCwNVUWArrKsuH3XSXEL2at8TMuVuiHdG97DnqrCWM5CsyjiTDjYeWySKzCM9a5X
	c6QinnvARAcLFd9hZoPUtGyw9+/LI3lIq6Qbe48MRe7dNQljWbQMes+JIfYvvo7m
	oYJIBfsRNqGhzu911wZlNVVbLtMd4Kn4Xxah8gF4tKfjZ44KVMYbTaoxoldx8fc+
	LsMudcXvuyR9pqoPxoBFQDrdyg9EAxzzLRufov5ld9hAaBICevK2Shfq1SSAnDdg
	JvuABd0B9MNYzLb5SHPS6eF+Zs0dPYz57j0fivAhapFnnI7u7WZ7Ok1b20wnyvNy
	stFA93tV2c6Szw8SMC7mQ==
X-ME-Sender: <xms:-eGYZobX7watBK66SlOkFWX8j2mli9VQrXnkc79BfMDLam_kc43OJw>
    <xme:-eGYZjZEP5tNQKPr4sPK1teVhX24U_OMpdGSDSKsn_bNGpC06EFRzx9cCzJK3ybiP
    -_9sFU52xvoYZvTiX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-uGYZi_nYJ6l6x5T5whB92TMlTXEZQkzD86YnoaUEbG3NR0qXVQM4w>
    <xmx:-uGYZioVLqWSaVJ4ihMviX4Gt7w3sTkp7IigwP8e_XQ3MJVeSZ8KMQ>
    <xmx:-uGYZjqDnuZAVNTLENuotI0unpAmAdj7Bc7vorLX-THOTr66pD32dQ>
    <xmx:-uGYZgSYwmHS_csi4cZb8qGiLFRlYGRXTw11ai_V_m4MnFO748FyNQ>
    <xmx:--GYZqe5KPCggtd0FZfIGawTHeZsKcprciCM8oF5gq8PvHD_NuuwKu_C>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BADAB19C0062; Thu, 18 Jul 2024 05:35:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da057e38-a3e1-42d8-8b7d-4e2dfed6d7b7@app.fastmail.com>
In-Reply-To: <20240718-stammer-envy-f77637a8d039@wendy>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-6-alexghiti@rivosinc.com>
 <20240717-94b49fbac3c6bf97a0f96281@orel>
 <CAHVXubi33T-5y9g1cqa+meM7q7b=0M54o+wrBeYmwfYpWAgAmQ@mail.gmail.com>
 <20240718-stammer-envy-f77637a8d039@wendy>
Date: Thu, 18 Jul 2024 11:35:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Conor.Dooley" <conor.dooley@microchip.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc: "Andrew Jones" <ajones@ventanamicro.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Andrea Parri" <parri.andrea@gmail.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Leonardo Bras" <leobras@redhat.com>,
 guoren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] riscv: Implement arch_cmpxchg128() using Zacas
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024, at 10:33, Conor Dooley wrote:
> On Thu, Jul 18, 2024 at 09:48:42AM +0200, Alexandre Ghiti wrote:
>> On Wed, Jul 17, 2024 at 10:34=E2=80=AFPM Andrew Jones <ajones@ventana=
micro.com> wrote:
>> > On Wed, Jul 17, 2024 at 08:19:51AM GMT, Alexandre Ghiti wrote:
>> > > +
>> > > +union __u128_halves {
>> > > +     u128 full;
>> > > +     struct {
>> > > +             u64 low, high;
>> >
>> > Should we consider big endian too?
>>=20
>> Should we care about big endian? We don't deal with big endian
>> anywhere in our kernel right now.
>
> There's one or two places I think that we do actually have some
> conditional stuff for BE. The Zbb string routines I believe is one such
> place, and maybe there are one or two others. In general I'm not of the
> opinion that it is worth adding complexity for BE until there's
> linux-capable hardware that supports it (so not QEMU or people's toy
> implementations), unless it's something that userspace is able to see.

I don't think you want to go there at all: maintaining an
extra user space ABI (or two if you add 32-bit BE as well)
has a huge long-term cost, and there is pretty much zero
benefit for a BE ABI these days.

Adding it to arm64 turned out to be a mistake. We did have
a handful of users in the first year, and it technically
still works, but I don't think there are any users left
after they managed to fix their nonportable legacy
userspace from that was ported from big-endian mips or
powerpc.

     Arnd

