Return-Path: <linux-arch+bounces-13708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B4B8F749
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F378D18A06F6
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365927BF89;
	Mon, 22 Sep 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwM4pKAi"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB42FD7A5;
	Mon, 22 Sep 2025 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529021; cv=none; b=YLcb/62naLb6kY3tM0CXGcmyioAnp5UFxfTwYlFvoNWHuW8IR8tWBeBrfP/h7MQY56kWBVks3NSrCmGjLWUMeSZQnHoZ0U2vVxuG/etKRdo5um5S8tGgQiQFo/fBge2xx9yand+EH59EGaV+r+DoL04KYRVcQT4fixL0pqY0+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529021; c=relaxed/simple;
	bh=UyOU1xRxcm24PTawkUcIYuxEXyz2/rhe3tOT2tO4aJQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F1f7vntsHIOX/K6zzkwjTPs/HbKFJyHFxl7B5eTCXtSjKgjDt7JIEpd1f/CINVrEQ0tdF8e/1U+JLRiwvHuT8a+zITqPbMCK74ZIaZq+P9bVCeYpM4tWbXpQ271F1SFetCAznRE9j+z9fyaXDd+POt4XRKXk1G8c1iGLcPVHXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwM4pKAi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 010921D001E2;
	Mon, 22 Sep 2025 04:16:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 04:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758529015; x=1758615415; bh=LSyQ0eho+Rkj9jDVCYjCdGVibMqOOq8P7k3
	4yc9M2bI=; b=NwM4pKAisCx5wsCT64JF1nefSw/lQdqSS5csYDqkpzsJLReiG6H
	LY8ctKjbS2gAgnCh30VvloBz9RWF7XXAxus1beBfNt4iQjv/nl1QkyFy3kWz8YFS
	JB9snNnka8ttrDyNNF9G8t2aemo3O80hHdktuSSuO1+x5riOMPkOEttxEZEFkJDg
	8j17QPkXBiRIc6MqCpIItka4q1C5lOpCU6EhQ3/7/K5ZebLs8IblMlcGlUz60Wkq
	JLFLByZLiIqOlpFfxptC3kl8y9CxzCfipQ3Zn+rsTJc6rnGhWnfyk+fjIJUDfVqu
	7rQWFDzGrUkwAgO5tPO99AX+qncCO7Pyj6A==
X-ME-Sender: <xms:9wXRaND8V60QO2YldHVU2_TYSvSs9lWp1SdH7bF8xdaMtf46sWxhBg>
    <xme:9wXRaF-S8hREq4KwDa5S-BwVI_lA-W5l2hjY_ZUGqtrLWv-nddcCSUTVR110Yoz_8
    3t2gRZP_Ldl3sEeqZM>
X-ME-Received: <xmr:9wXRaAEryH5gvxAeuevo-2-Z3cfBIBdjNgapw3WTt4qtLKsiLNZOWw-NBdWv2M3okeUzX4EL3e4xywtttSgrG5S09exMkGZcbTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesmhdtreertddtjeenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepudegleeujeefgeduvdejveevveejvdejveekkeekhfejfeeufefgueffkeekteej
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgu
    segrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9wXRaPRWudEGSfbl_26KWpIrDRXm_p62tMbRrjSck5seFAgnapWV6A>
    <xmx:9wXRaHTdZvby3HCnjBSmclq462v3MuvWxHpFmmTrcAM-dgNGxfvVNA>
    <xmx:9wXRaC2NnKxJbyC6pcGAuDvxR42Nwlhe_O6fDD38Nv-zxx_4m3c5lA>
    <xmx:9wXRaBzWpF7HCiyC1MWYe6RQED3o5AsIsCX3JS_iBhV-KUOF8WsfTQ>
    <xmx:9wXRaIKSXe0ycNqFkxkeyg2OnCF3AuKQNetP-y3Ity40TkW-SFqr2rK0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 04:16:52 -0400 (EDT)
Date: Mon, 22 Sep 2025 18:16:43 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
Message-ID: <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-14638117741591782072175852900335

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---14638117741591782072175852900335
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Mon, 22 Sep 2025, Geert Uytterhoeven wrote:

>=20
> This triggers a failure in kernel/bpf/rqspinlock.c:
>=20
> kernel/bpf/rqspinlock.c: In function =E2=80=98bpf_res_spin_lock=E2=80=99:
> include/linux/compiler_types.h:572:45: error: call to
> =E2=80=98__compiletime_assert_397=E2=80=99 declared with attribute error:=
 BUILD_BUG_ON
> failed: __alignof__(rqspinlock_t) !=3D __alignof__(struct
> bpf_res_spin_lock)
>   572 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:553:25: note: in definition of macro
> =E2=80=98__compiletime_assert=E2=80=99
>   553 |                         prefix ## suffix();
>          \
>       |                         ^~~~~~
> include/linux/compiler_types.h:572:9: note: in expansion of macro
> =E2=80=98_compiletime_assert=E2=80=99
>   572 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro
> =E2=80=98compiletime_assert=E2=80=99
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
>    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #cond=
ition)
>       |         ^~~~~~~~~~~~~~~~
> kernel/bpf/rqspinlock.c:695:9: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON=E2=80=99
>   695 |         BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D
> __alignof__(struct bpf_res_spin_lock));
>       |         ^~~~~~~~~~~~
>=20
> I haven't investigated it yet.
>=20

Yes, I noticed that also, after I started building with defconfigs.
I pushed a new patch to my github repo.

https://github.com/fthain/linux/tree/atomic_t
---14638117741591782072175852900335--

