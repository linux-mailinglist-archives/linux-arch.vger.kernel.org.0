Return-Path: <linux-arch+bounces-13989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF028BCA0CB
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E81C3AB65A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD72EE617;
	Thu,  9 Oct 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xBe/bGjA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ouVNeDff"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50B25A2A5;
	Thu,  9 Oct 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025737; cv=none; b=LH+vzVqAadwhUscgoVBnPg098WZSGvnuD6ROWHV29Dchz8k+zYe7A9WAmhmCFqShqfxTDEMAsmsF6j4WKlltDgsb7YbnP5gz94QP6VIWuMbkyB2JS+W9IL88itIN7kAmvVcQ3ZEBdXPTmMmggHTAyRJklZavSXwAavRc0UfW4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025737; c=relaxed/simple;
	bh=ZgkbsaGR+p8uFBJMvVarIMNRNMv6m94BVAIRPSS6iFw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rgN/Syj3b5Ptt5okUM54Rv0iK7h+OgXxatS5sZZVXfncJR0tyoWg1+vdB+NlHBsZh8JTwBnHI916dFiQkI8W+An6ZoObNwLpqr2W8dFcJ2F139ND4GegdiBSWZD7ykqCR0sLmpymo4rM15DxqGPBIBzRtKLskyqJtzsRSKRCKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xBe/bGjA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ouVNeDff; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 205D67A00A4;
	Thu,  9 Oct 2025 12:02:13 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 12:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760025732;
	 x=1760112132; bh=dQPpVRPurqlYcWNfk3cGaT/ROTfo4xz/DCZqhkfKNUU=; b=
	xBe/bGjAnLX5iaEVpiL58+d0UdziSAMpO94GITjdR3sDeHIqXgnh5+O48PPUZyaI
	hAfs0kurBEU3+LWTpGetKlFQ70B/yexkU+s+T90wb0J9kPd2RBvEPPSY9iGRuciH
	rotajF104Tiki4quiFjPGs7mHQMpbVb4Vg/0Lt9492BiihjzV5fBmLFUwYbaigJK
	ctTXc8FNNinIRVsGz4QLzUEgzn14C45GSP5xubifCEizrqFeOY28c2kiqs9PKetP
	Y981RxoGuklYOppSGXTrX+ainyygD2U7tMprmws2e87Vgtw9gXifq9hKkPcHUdb7
	ltdXnEMNz/WJVylkh6n0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760025732; x=
	1760112132; bh=dQPpVRPurqlYcWNfk3cGaT/ROTfo4xz/DCZqhkfKNUU=; b=o
	uVNeDffSsDqe7En8NeNXb4TYeNQIzIZsm36rG6MfAvHsZTNhGsk7O14rGCH2iLmq
	xqIbZCY8xRKNgb7/X/qYj7u6JlrIsitdHwzUN10tR/MW5VkgAqs62c2cvXx/YutA
	HZsZdSnU8HqmGbrM9Y/L6LHUFLTXhR8dYUFw4wFec/2zpmmfLsPKEx7VE+gl/QKp
	clVA2Jfx9MmR2HAsKdz6f26m2ti28hxCKrS8P55S5YU59Vm/knbRYb6UTZNB9tyW
	JmtGQ+QVy4P3RQYHsfa9a1ztaozj0192CFov/X/mFv9glNlMSfD+sQQGVeSnN/XK
	9tLOm2Z0ArJ5nZqGQUjgQ==
X-ME-Sender: <xms:g9znaIfRkxyOjMS04AQ2IEVXPZE_SKzFBUL39JrvvesqhW1Z8TQOFw>
    <xme:g9znaFBUMg_Bmrx6PZ30T4Ko6smNNIoeNeKYC8Flz9XwbS33j_D10sIMA59j-5OHN
    4gmTslBasx9hukLMAM0JB_DMD-B_ReB2q-BEwSYsREwS6CjInntRwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkrdhruh
    htlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhm
    vgdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrg
    hsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:g9znaPpZsnAQIYbFsvFAZxOJ1SZ5YGxs20NiDdIJ3KMaKvdwXP8pww>
    <xmx:g9znaFucPfRCIAw-IYM_9v_syXmWZKpoTNTIfp6pz1VvLmAcq3lwIg>
    <xmx:g9znaHhKCMC_SyuvjPwUdpUW6xL1gAmKiRIDFavYC7Q5ai6GcbQcEw>
    <xmx:g9znaB3ie_EZnAvk76oFXzavec17-5-EUaTLJVcjfjovnid55jpQwQ>
    <xmx:hNznaOr8LOfCWiHpBIgiTEgZSo1I-hRSq2JG-_jmkwtXwpC7F67q4-Kf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8363370006D; Thu,  9 Oct 2025 12:02:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlCDucMbeb7o
Date: Thu, 09 Oct 2025 18:01:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Finn Thain" <fthain@linux-m68k.org>, "Will Deacon" <will@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Message-Id: <b9ab4c28-52c8-4fa7-85cb-109ef4c0d7f4@app.fastmail.com>
In-Reply-To: 
 <CAADnVQK1GqQKxdoM9e1Z92QK68GEjqgMnC36ooVgS1uUNiP6eg@mail.gmail.com>
References: <cover.1759875560.git.fthain@linux-m68k.org>
 <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
 <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
 <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
 <CAADnVQK1GqQKxdoM9e1Z92QK68GEjqgMnC36ooVgS1uUNiP6eg@mail.gmail.com>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 17:17, Alexei Starovoitov wrote:
> On Thu, Oct 9, 2025 at 12:02=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
>>
>> On Wed, Oct 08, 2025 at 07:10:13PM -0700, Alexei Starovoitov wrote:
>>
>> > Are you saying 'int' on m68k is not 4 byte aligned by default,
>> > so you have to force 4 byte align?
>>
>> This; m68k has u16 alignment, just to keep life interesting I suppose
>> :-)
>
> It's not "interesting". It adds burden to the rest of the kernel
> for this architectural quirk.
> Linus put the foot down for big-endian on arm64 and riscv.
> We should do the same here.
> x86 uses -mcmodel=3Dkernel for 64-bit and -mregparm=3D3 for 32-bit.
> m68k can do the same.
> They can adjust the compiler to make 'int' 4 byte aligned under some
> compiler flag. The kernel is built standalone, so it doesn't have
> to conform to native calling convention or anything else.

I agree that building the kernel with -malign-int makes a lot
of sense here, there is even a project to rebuild the entire
user space with the same flag.

However, changing either the kernel or userspace to build with
-malign-int also has its cost, since for ABI compatibility
reasons any include/uapi/*/*.h header that defines a structure
with a misaligned word needs a custom annotation in order to
still define the layout to be the same as before, and the
annotations do complicate the common headers.

See=20
https://lore.kernel.org/all/534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fas=
tmail.com/
for a list of structures that likely need to be annotated,
and the thread around it for more of the nasty details that
make this nontrivial.

       Arnd

