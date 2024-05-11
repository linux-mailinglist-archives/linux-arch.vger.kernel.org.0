Return-Path: <linux-arch+bounces-4332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B68C33AF
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843601C20AEB
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B522032D;
	Sat, 11 May 2024 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lcBk53jC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1+cFDux"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DA200C1;
	Sat, 11 May 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715458166; cv=none; b=BvtZ/eVwvN5bZTHUK2hTTXGqTttlW/iBAQ4O/olXPt3esWdbjAhOCEsW+v8ciA4n2pwaC5FN+fXN3r4ftpzwxjW5juhBQOXbb3g3cDkcsAJFM1GEF/VOY+eLXuuM/ucgEFEA5+oUXxjmbb2SpLQw5luZ0uCb9aoZiwkZrJlhLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715458166; c=relaxed/simple;
	bh=wgbkZOngIgE+nsdfV9G/puBvKYsmjScbDDIwPrE+KsI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=suQmr7i6thdtXMaB9G6zLK0oIyo+QYrnjw4UMf+Ej8aBl1Y3r2Rg/3zYXEFqrObuLP8a3KA+jAf/unWmRf9kiifO2EQxE7vbAiG0iwwOLZ9qa2zBGJjxyBTAU7MmMJoKiSWrTIIjIUPOwozUT+kUYHXQzDgstoVJTVZ/iPMP7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lcBk53jC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1+cFDux; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 15F7D18000F6;
	Sat, 11 May 2024 16:09:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 11 May 2024 16:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715458161; x=1715544561; bh=HPItATo5fx
	8l5WFkFOeYczqSjME8h6efh0zZWmdoRF4=; b=lcBk53jCOF2+k/udzhE5d+j8Yy
	UTO9UYQqHGvmZ4W7oHim4+rSOuEWnwnTGmggF5b+qzg0Sav1/lRrF68Kejrx7w21
	YIhCp61jso33ua95WDRkcqQGQIntJn2Y/1GXFeRxX4H3o9LG3QjVQ6Y4NNFbITaa
	3n1tSK+m2mQLZEZ5tJqmCjD9QNrff0iGp2VBkId/BmXHx2UF/tioJQW6qNinXN8C
	ygMJNWtf4IuE7Z75Jgcn9Id/DFWhaHSGC30IUA3zoQjJ9ySOdVCHSWYMMK6rmJtA
	gjqgzX98afev9mI6YDcXBC0nAxyQhxMnuPHZswUu5Ilx79XrofD8YFCi1tZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715458161; x=1715544561; bh=HPItATo5fx8l5WFkFOeYczqSjME8
	h6efh0zZWmdoRF4=; b=S1+cFDuxjUirv18s+Y7mRUSPhU/wMjYf7igtpXaM4mkH
	ksHg/ZjSUmY4b1ciOm3UaS+ik+IJtakDA1qzxa+XlH1/YOC4Z/tPghntGIzQAYOl
	v1zh8RBNDpe6nn4Hp2Pl8Vy8NApaJxr/PiUiRDEIIoPc1jBrscxhP11IKbB1NPF3
	o1kTdYm86G/2B8vkbHe2t7h0tqmqFJ46R9Ot6mQ2OstTORRH6IL61CN4LDRhE8yK
	HzWXiuAnNMdIYhN5TMyVg4aQUTN61nuvmvUQoW+cjHYTH5PjSRSC/TFxz1CRfmW1
	J4vqTqtulCCD46pc//q+7nvRK1j3piaCCywULv3phw==
X-ME-Sender: <xms:cNA_ZgzQ7m2qRSKp7wiBz3da-tHi_Axg6FsUbf1gEKnfaefauS9fhg>
    <xme:cNA_ZkR5n9hh5FTWx_AwPSlXAHPnXH5YF5nGmJMRf195f9Z6FQ6wVuYqmwFKZUNq3
    -trPuZAjcTH3e__ybM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cNA_ZiUS6jxwzpKYQDyldzqtrwFJffvUYUN3EV5-5pY9SFDxK3Cg_w>
    <xmx:cNA_Zuhj9lCHE7UNwvDMkrMvIEWpMC7zqTYTEw3atDXxbOKkHqi-Ig>
    <xmx:cNA_ZiC-zlxi0RWwt79vA0g-FKPi3Un2bMnhZ9_xdVxHdjn3Lod2vg>
    <xmx:cNA_ZvJPPsl_3Y1js_C_DD1Gpf12K9kcE32JU0SQAYogCCE5dIOOVA>
    <xmx:cdA_ZqtOjN34gO8_apgMuOhjEIiitTau6HgswL2H4PGFF-Le0g7jppDy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AE36AB6008D; Sat, 11 May 2024 16:09:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>
In-Reply-To: <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
 <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
Date: Sat, 11 May 2024 22:08:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Content-Type: text/plain

On Sat, May 11, 2024, at 21:37, Paul E. McKenney wrote:
> On Sat, May 11, 2024 at 08:49:08PM +0200, John Paul Adrian Glaubitz wrote:
>
> The pre-EV56 Alphas have no byte store instruction, correct?
>
> If that is in fact correct, what code is generated for a volatile store
> to a single byte for those CPUs?  For example, for this example?
>
> 	char c;
>
> 	...
>
> 	WRITE_ONCE(c, 3);
>
> The rumor I heard is that the compilers will generate a non-atomic
> read-modify-write instruction sequence in this case, first reading the
> 32-bit word containing that byte into a register, then substituting the
> value to be stored into corresponding byte of that register, and finally
> doing a 32-bit store from that register.
>
> Is that the case, or am I confused?

I think it's slightly worse: gcc will actually do a 64-bit
read-modify-write rather than a 32-bit one, and it doesn't
use atomic ll/sc when storing into an _Atomic struct member:

echo '#include <stdatomic.h>^M struct s { _Atomic char c; _Atomic char s[7]; long l; }; void f(struct s *s) { atomic_store(&s->c, 3); }' | alpha-linux-gcc-14  -xc - -S -o- -O2 -mcpu=ev5

f:
	.frame $30,0,$26,0
$LFB0:
	.cfi_startproc
	.prologue 0
	mb
	lda $1,3($31)
	insbl $1,$16,$1
	ldq_u $2,0($16)
	mskbl $2,$16,$2
	bis $1,$2,$1
	stq_u $1,0($16)
	bis $31,$31,$31
	mb
	ret $31,($26),1
	.cfi_endproc
$LFE0:
	.end f

compared to -mcpu=ev56:

f:
	.frame $30,0,$26,0
$LFB0:
	.cfi_startproc
	.prologue 0
	mb
	lda $1,3($31)
	stb $1,0($16)
	bis $31,$31,$31
	mb
	ret $31,($26),1
	.cfi_endproc
$LFE0:
	.end f

      Arnd

