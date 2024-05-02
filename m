Return-Path: <linux-arch+bounces-4134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5138B9A12
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198631C21685
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5A5644E;
	Thu,  2 May 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WfHmcFXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IksWbokK"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5423224DD;
	Thu,  2 May 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649483; cv=none; b=MjZsPVcYCnndi+RqtB4NNyGPPjontSNWjOY2aJ+hFY5QuM3T+OKTLwBGcn7otXQqdpv+j81wz70+Ow9/v3aQ4IwUPz6UEzpKnPXO5q+GSsZUDQP4wYiFUfRJvE9tS5WI1MDDqp5wiymi4N+xiF8hMUhWrXH7hFZEA+TXGimaX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649483; c=relaxed/simple;
	bh=YcXal5CY5KaXmO3QDfbafOfHBwhNBEGSaCfs7JI9MhI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FCQfDj/WNVvPRJT7i3X8/0s46FN8kMy2FClS6syAdjpNhwLxJ588q8P5gGX9e1WzqSMeaTO/PtdxZ2PaQEEVfYEowOaPrbAXhsG2BlaHCVYUkBATEUAu2F2/9Hl48RIdgHnbweaivSzetCFr4eKkhuS/HqRKJ8o0hExRAxLbxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WfHmcFXG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IksWbokK; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id BB0C01800185;
	Thu,  2 May 2024 07:31:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 02 May 2024 07:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714649479; x=1714735879; bh=NLsj9iUxTH
	Tn2bffJD6DDAckEglOChxRWMTdItwVvmc=; b=WfHmcFXGX6eHVZdNs/XURoFADQ
	kiXo+a8biVfeD0vKUsizUf8Kb5HpItSI53IkOl1+LwBJIPwB22Np4Bg4eZOh2eKd
	XyOmpHOk3zoPY6ZoEsCtdvVTTKyS7miR67sHdPVdHjJL81ri5LpZVB+zJyQQgceJ
	t/41zEs5ARYWaW3zY+MQFwWLcaNW5W/aj8W0NQ8QDxu2FR0F5EmfLO3JTa+7Tlbw
	aTlYyvvbsFXRbWsn4ifDVi58zdRF9gK8DVucjFtGj7B0mbNV0+p4JauDCORq6hsV
	v1IxYeuia8pz56Qm46IlawplHLiwCYbtUEOp1wC7Eh3vF6eUY0BuOk1n4crg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714649479; x=1714735879; bh=NLsj9iUxTHTn2bffJD6DDAckEglO
	ChxRWMTdItwVvmc=; b=IksWbokKoG8VRvqcXu23DETEzhVELEDsPKBdKBRGItaO
	QIbsNhUrODK87vXDm0oKIuBJHZPiCJf84/s0lIuzL/O0ECUEU3KMZNfXpDtrNrNb
	v6DVPmOMVaja2878HmxS/sviCeJID0hHFlsI3Vuto8GCahdQQqw4G4ZCrAuOim7L
	BcGihvFuf3CtG9JPfeTGwpW1ts2VHGhfGJqWRCKVK/z/pmthZgLYzmSBqaGa2Q9g
	Hz+Sf72u1wTWqLJBPEN0O8MmJy7iJe1pk+1tN973qgKYknHgStz/Y1d7gZVGzQnb
	723oL1SA4EDB9bDEdbaC2ZnjDF2vmUOyzp6+Rilb5Q==
X-ME-Sender: <xms:hnkzZiE0ifyeczcq3m6NAgCiDzqOzUmcC93sTsBcTnftKNIXX-F_sQ>
    <xme:hnkzZjX0or-ZWOAHk5Wue3RgzY-PqLdp5XBainuXEWAZLMQCC08QZfMhcAAdJahUD
    MNDaTzcLzZfYjB6Om0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hnkzZsLwBQ7SOz3HXJH80HlN6N1TtaQSmyqRxKAGZi7YWwQ-RuJPPw>
    <xmx:hnkzZsE6kcIwTYuYTVLIdfB0Y-O1dB5_MmChbcipOaLEBWb5qMOBdg>
    <xmx:hnkzZoUuzxaQzZOv6Mp5Yxk8eo9Oux494-Z__lUyKl7JGG3P78zcnQ>
    <xmx:hnkzZvPohJOaNxgMc8WSyBeAvvi8pHO-jF9Dw4kEA7tEy0EcPbYATw>
    <xmx:h3kzZkknNf43aCnbvVYISmq-FSQ44yvSsggFsFpv8_gfve6hzQZHSj6A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A15DCB6008D; Thu,  2 May 2024 07:31:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-416-g2c1796742e-fm-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <31ed4654-094a-4e1e-9182-973b43ae3464@app.fastmail.com>
In-Reply-To: <23A87C03-EB55-49A1-BB55-B6136117F0B6@gmail.com>
References: <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <23A87C03-EB55-49A1-BB55-B6136117F0B6@gmail.com>
Date: Thu, 02 May 2024 13:30:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "D. Jeff Dionne" <djeffdionne@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Marco Elver" <elver@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Doug Anderson" <dianders@chromium.org>, "Petr Mladek" <pmladek@suse.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>, kernel-team@meta.com,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Content-Type: text/plain

On Thu, May 2, 2024, at 07:42, D. Jeff Dionne wrote:
> On May 2, 2024, at 14:07, Paul E. McKenney <paulmck@kernel.org> wrote:
>
>> That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?
>> 
>> Or am I missing something subtle here that makes sh also support one-byte
>> (8-bit) cmpxchg()?
>
> The native SH atomic operation is test and set TAS.B.  J2 adds a 
> compare and swap CAS.L instruction, carefully chosen for patent free 
> prior art (s360, IIRC).
>
> The (relatively expensive) encoding space we allocated for CAS.L does 
> not contain size bits.
>
> Not all SH4 patents had expired when J2 was under development, but now 
> have (watch this space).  Not sure (me myself) if there are more atomic 
> operations in sh4.

SH4A supports MIPS R4000 style LL/SC instructions, but it looks like
the older SH4 does not.

      Arnd

