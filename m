Return-Path: <linux-arch+bounces-13984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1943BC7407
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 04:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953C53AA23D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BF1C861A;
	Thu,  9 Oct 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMugnjF9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99E1C3027;
	Thu,  9 Oct 2025 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978598; cv=none; b=AbIRU+W3eACTfXJgagrC9dRNJWykfRGIEnYrk9j6xTq6I6PNbAP3uumaMKOTfz2hA829vxkBJibXsJiqTZ5levId3ghoy79tMOnm1l6cgBUc9KCMp4hGIzOP8KJcLbuxgrXF3NARCVxEH23T+0CqL1bv8du/jclPzj1Iq8TkzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978598; c=relaxed/simple;
	bh=vQOfMX/6QF2frKlgI4zbsMZqKYzIvryKIPH3yqqBjlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l2H+cQNVyugmxETS0CBFUbBSGhtyk2ab51E7NTYyfz35ayXgUFb0KwBqDuTRp/+Ze8UWE+mCfHrrKVWGYN4e74Nw2z3yXkoxg9lqF4zzjbinqC20q73F/6uM8QnheOnVtnfifsjfcYkqWXAMmFcR/KXdgQrHxmCZ+bczh0Q9PRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMugnjF9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C59A07A0055;
	Wed,  8 Oct 2025 22:56:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759978593; x=1760064993; bh=uL1Z46mIMlWDqH+R1NLQjW+DW0aqB/vjTR7
	Nvu5o2aM=; b=UMugnjF9bu7n2sl+cwKXR1JuyODQ4J9royl8Vmt8htBspEjb/K8
	3GThAi/OyKvUjC6TA1lNcLNT+MStYcOFa/EhVHOCfJPi2bZ3WH/CYpCjiMd3ylSp
	yshI7HkTa1W5pk551PpoeaUFDxcqMl6IvLElTTGuYEELG9u94+3c3cUg10jsBzSq
	oCaKUDWaW1he1jove+3hPNOM1cCOZ6ocAwEHB7NQ0TV9lV4Dx6CXJyxfbtCxiSk0
	QyQyUqaxXFNRuWD+1u0XvbhUP5AHYjKfzYkbPrJZO43gHmLzHeofgRXZSZ3h/Mb6
	BX7aBvbtL7UOxIam5hlAyMLzdzFRDpWgZAw==
X-ME-Sender: <xms:YCTnaIQgTpu88XeFOudQm1s8Mvwn9xUlf9lBt386_YtwmzENmA1qaQ>
    <xme:YCTnaB6fzBs00EbWXLDGUohKl6Z1Ev2fKT6SRPL0SmR2R3K_TBapYAoUaThxb0jje
    yyZ6A31xcv4edCFaJSaN-dh5Qs5RHSKIuVeBNH0ZxgrV6d1RfilIKg>
X-ME-Received: <xmr:YCTnaBoAB4kEA85ynV8CCRlJyOqOoZH60jZMXS94IR0Wlcm-Jfwknqvh2egzuxACMB6TLQUiEg0K9qpjDHTK5rXE-o948fB4W5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteehgeel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtoh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghr
    sghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsg
    gvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:YCTnaFUCZ9mbgctsCLbcsLNmMGb1mT-M1I_hBDo7nakitsT95jlwcA>
    <xmx:YCTnaBoNT_YxL6gQ2kLiKXTBz5pwXVtKMpLptTcjRTdoQo8l8d4X9g>
    <xmx:YCTnaMvl1N7XGHQ_G7jg7zlyGI-phTxv3lfe9xG0MoqHnoLwvwyQBA>
    <xmx:YCTnaHSWqgw3FZEAMa5JuYFUjdCRwmOgwdxA0Q12-9XxKZWoXCJ4AA>
    <xmx:YSTnaAw-_18wT2EamGw4uVXrGz7ejqXMMQC5arZ31uvydq_9YG0wh346>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 22:56:29 -0400 (EDT)
Date: Thu, 9 Oct 2025 13:56:19 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    Martin KaFai Lau <martin.lau@linux.dev>, 
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
    Yonghong Song <yonghong.song@linux.dev>, 
    John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
    Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
    Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
In-Reply-To: <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
Message-ID: <fdda632e-bac9-e830-8840-2fcd6b2292b6@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org> <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org> <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-14638117742092801439175997857935

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---14638117742092801439175997857935
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Wed, 8 Oct 2025, Alexei Starovoitov wrote:

> On Tue, Oct 7, 2025 at 4:50=E2=80=AFPM Finn Thain <fthain@linux-m68k.org>=
 wrote:
> >
> > Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
> > changes, as it will do on m68k when, in a subsequent patch, the minimum
> > alignment of the atomic_t member of struct rqspinlock gets increased.
> > Drop the BUILD_BUG_ON() as it is now redundant.
> >
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/asm-generic/rqspinlock.h | 2 +-
> >  kernel/bpf/rqspinlock.c          | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqs=
pinlock.h
> > index 6d4244d643df..eac2dcd31b83 100644
> > --- a/include/asm-generic/rqspinlock.h
> > +++ b/include/asm-generic/rqspinlock.h
> > @@ -28,7 +28,7 @@ struct rqspinlock {
> >   */
> >  struct bpf_res_spin_lock {
> >         u32 val;
> > -};
> > +} __aligned(__alignof__(struct rqspinlock));
>=20
> I don't follow.
> In the next patch you do:
>=20
> typedef struct {
> - int counter;
> + int __aligned(sizeof(int)) counter;
> } atomic_t;
>=20
> so it was 4 and still 4 ?
> Are you saying 'int' on m68k is not 4 byte aligned by default,
> so you have to force 4 byte align?
>=20

Right. __alignof(int) =3D=3D 2 on m68k.

> >  struct qspinlock;
> >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index 338305c8852c..a88a0e9749d7 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> > @@ -671,7 +671,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_sp=
in_lock *lock)
> >         int ret;
> >
> >         BUILD_BUG_ON(sizeof(rqspinlock_t) !=3D sizeof(struct bpf_res_sp=
in_lock));
> > -       BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D __alignof__(struct =
bpf_res_spin_lock));
>=20
> Why delete it? Didn't you make them equal in the above hunk?
>=20

I deleted it because it's tautological. I think "do not repeat yourself"=20
applies here.
---14638117742092801439175997857935--

