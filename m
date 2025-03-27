Return-Path: <linux-arch+bounces-11158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04513A72E4C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AAA3B9E9E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607920F067;
	Thu, 27 Mar 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mBbNXLnV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjcI4p80"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61E207E19;
	Thu, 27 Mar 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073171; cv=none; b=b5NW2jgOm4cs8cPfThIrLadABhXYL/ndcSFrA0oEwATuFpr4ummnyH68w8o4G2o8V8EX4d2BqcZu9a+3W4tQr7Bab8oazhaibcF6DBp660PFDV0MCamOyU3KFp8TwaIsCKhQtsi09kJy7yZq1hushDwB9MHIgLL7dU9fT5G/duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073171; c=relaxed/simple;
	bh=JQbfQcJMqO9KshIZqN0e5ofOQ06DagmcUNwy6pAgmUU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=njRiLK+0mVy2EaMatGLsGnZNGkAcScYydTb27aVcUdkajCYh8upxXYoqk7I2tedElC6TjuMkpL7O8OWLlxT8PolIhrerVSDkfJbEUgx8MTRrzEKluFIeMZTMXy58DfUaSs+fFIRK75qJNF7+n5VBhR0kJxdN9iYoWwrPUyIWc6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mBbNXLnV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SjcI4p80; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4B332540109;
	Thu, 27 Mar 2025 06:59:28 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743073168;
	 x=1743159568; bh=YrbNA33LfsBoyoaksZ9yYlyDO700K4iNcAaTAar7X8c=; b=
	mBbNXLnVNAJBFfNY+oUqBv5migTyd6bCUFDzy/w3jYASv85pePYKgmJ7sgfwAMcM
	Aa4TDnKLOzu6fG3CPAr/eDR558UJMLsk+v2UwLthvRahRPps+jwffGVZFTBGXHdE
	cRS/M7izgCc4wXzB0n9Br9GdppAHoc5IxTqENHpbI0W+iVGNV3rmIVDN5+JIEpnO
	q5F5NOpXgX2CtnbDkZQCtcc9mL8x5TA0Z7X7102zloew/MNFxulR3f2wh7PqIhtb
	ROxddjpkrxmMDtvzjj5PDbV9bwdDtdqQZWjq5IYel9Lslve/M2+b1SgWiXt/qcjs
	5nDnx3LK2mOzCY0uzfI3XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743073168; x=
	1743159568; bh=YrbNA33LfsBoyoaksZ9yYlyDO700K4iNcAaTAar7X8c=; b=S
	jcI4p80d2RB81VQVEqbg1fLpWgzmfWm+/IkchwiS+p+GrjVZAx48jAvLtukU0Ym3
	Q3vnKCBwwcGwNdC6QhXDcq7YCMLtxrEEGhIcACfkYnQFAL3A1PdIzWXIsIxA3L0O
	nPYOssXs5DszOjzxdPRCtNtUgrsowOfOSGoLLsNAAedt4MDv6QRcQZN6R9BieLqc
	nxuy4errHKBQH6/lqSPPChyZm30o+GnqAIFGWgPDSobmEks5eO2WB+1ywafVG4b8
	RwE4A01FmSxxxHTVnZc4Wh5uLkoxf95qHYv0tJS6KbwfYNU+Eu0bFJYODdbAfepu
	wZhz0nfjzrRCyG5KlNGNA==
X-ME-Sender: <xms:kC_lZ1hXZrd5eWnXvrtCfdPwvhWrQnHgg_8OJcthm7W7O3HZbdurCg>
    <xme:kC_lZ6BcIiZMVZbK11-WBh_8eG_LzXq6ZwDxl9EoeX79bHApfbV8Yd2cBc-qRDESj
    7Szpwy55xexQG01fAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrghnnhhh
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:kC_lZ1GIuTak-ptIzc-WMZTfu_1XVVYaBYtHajI4Z_UU8RxpUFh7qQ>
    <xmx:kC_lZ6Q8BytdyfvRgKgQXMbW2iB6bUZbi5OghYJV9VvRhXOO02iLKg>
    <xmx:kC_lZyzuAy70j41D7273XlBs_M6yC3o4I9tapqDJ3KFZqVy_EiNM5w>
    <xmx:kC_lZw6NHlkmRTKtrca6EEz6ONaYeFDyRundAIi4w6Uyn5hfylPEsA>
    <xmx:kC_lZ5pMHzs8x_aTI9Mt31-tMnEYH8Y2K-mebk0St3ZwZQx1GqVGsrfV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 390832220073; Thu, 27 Mar 2025 06:59:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4094621b06357a4d
Date: Thu, 27 Mar 2025 11:58:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Marco Elver" <elver@google.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <0149da8d-957d-47e2-8711-6043a7701b6d@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wgJRECUF-7yt9pNxW_bc=4nJcxn5H3duW_HefY3pKwZag@mail.gmail.com>
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
 <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com>
 <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
 <20250326225444.GA1743548@ax162>
 <CAHk-=wgJRECUF-7yt9pNxW_bc=4nJcxn5H3duW_HefY3pKwZag@mail.gmail.com>
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned read
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 27, 2025, at 01:49, Linus Torvalds wrote:
> On Wed, 26 Mar 2025 at 15:54, Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> > Put another way: I wonder what other cases may lurk around this all...
>>
>> That change has caused only one issue that I know of, which was fixed by
>> commit d3f450533bbc ("efi: tpm: Avoid READ_ONCE() for accessing the
>> event log"). I have not seen any since then until this point and I do
>> daily boots of -next with LTO enabled on both of my arm64 test machines.
>
> Ahh, ok. That makes me happier.

I've sent a new v2 pull request now.

> I guess unaligned READ_ONCE() code really shouldn't exist in generic
> code anyway, since some architectures will fail any unaligned access.

Even if the unaligned READ_ONCE()/WRITE_ONCE() doesn't fail, it may
be surprising to callers when it is not atomic.

> But those architectures tend to not get a lot of testing (they are a
> dying breed - good riddance), so "shouldn't exist" doesn't necessarily
> equate to really not existing.

Unfortunately, they don't seem to quite die out just yet, as both
riscv and loongarch have gained support for CPUs without unaligned
access even though they started out requiring it:

https://lore.kernel.org/lkml/20231004151405.521596-1-cleger@rivosinc.com/
https://lore.kernel.org/lkml/20230202084238.2408516-1-chenhuacai@loongson.cn/

ARMv7 also has the annoying behavior of supporting unaligned word
access, but not unaligned multi-word load/store with ldrd/strd
on u64 variables.

     Arnd

