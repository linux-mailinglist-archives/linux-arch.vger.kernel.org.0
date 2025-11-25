Return-Path: <linux-arch+bounces-15069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542CC83477
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 04:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83F53AD0BF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DC275AFB;
	Tue, 25 Nov 2025 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDH0zy4o"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59713AD26;
	Tue, 25 Nov 2025 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042738; cv=none; b=LjcbnxwDjzGqE90J2m9A4BoOU3g0KpJzu0jZLyYOJrcFt3iC9ovh7yzamLZrbyMdTjycDLGtiTn3AN7VC0wxa1CMgaszns3cfe5jVsgvPiNwnrIKZdfN9b+Sc40k6+SROGkXgdHm9CCPaqonUalIF8h8aZspcvIfKIJb1uvCQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042738; c=relaxed/simple;
	bh=HL2RIrxbaY+hT1cX9C3uaPVHQVuhrHWqIUhbEeLdw7w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gn9ji+9D7c7aPeLKCvYMsdJ46WfoZYVJAV0NxCZYP7hgjvDlDrIp/36JFQQJGV1SrGs35fsvi5sbX2onhztE/iPv+yHnbdyaLzby6hSXEjyOtAzFaSzvR5Lprj18Z94D7asU+xenN1uipGSYz9eERbo+lyNqn8sAHgO129d3dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDH0zy4o; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E12A14001C2;
	Mon, 24 Nov 2025 22:52:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 22:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764042734; x=1764129134; bh=ZoiqM/VdP8Zh4LcL4YUTBTDUnfzLnNQaQW8
	D5KI+HZE=; b=yDH0zy4o2V5cUr5C+8118YgDR1oD2fvLo47+dWZEwPARRZQD9mi
	KlFW3QKsxftJZBsipD0iVj2rVoJBjYJhRgtYTmhuJ4FH9Y40KOLDKlESWYTQiCe1
	uKEHd29d2A/yL1CYbUdtCpIyBks9YuCmRFxuB3vDau6GCa8uz4BtUuiwtn9zaDyK
	CrSLT+XDlPot8EknFc0ICfiR2r++5xw1xdELYk1A8RLUP07ulX2F04j5C7ZHgGXU
	ZQtSmL5ToLxDBpTJOElOviz1jOmtqj4WWA/wwgWccCMHmJtlswc3WwWX7QTPGN/z
	Dwi9QGPfIbkn0GGI1TCQ+vRXFr72rDfHSNA==
X-ME-Sender: <xms:7CcladD50EReW2_4t2KMghQWpO4fP84lR8rZBSZ-CewGTxMqqMRIxw>
    <xme:7CclaXYQELCK4216FyN6AH3jmBM3fj_w5OTkzh29he2J214IfDUeKFYfMrZpxTu0q
    xxVP_kWMOe8ozMSE0ipCqWzwG9y7psF025hMfxM_aEsyJyN1s7Yhfzt>
X-ME-Received: <xmr:7CclaVkhNLanpXFeNDpwRrUteiP-qnhrN4b8ANBpVwCQjjMQOzxkkjgvXJ_Ea0dZRRhmCu8F2IxOY4PGp5qGRwQPXJJx2lgM0Tk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehmtderredttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeevudekfeehgeetvdekhfeifeevgeejveeufefhgeejteffjeetuedvgfelfeet
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlsedtgidtfhdrtghomhdprh
    gtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeif
    ihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhr
    tghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    gvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    tghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7CclacqTZRPeV2bRVcRZjN87waTHkqZqhE93iQS-DT5glryhlA2LIw>
    <xmx:7CclaXCikLd9DKwchG5tTWUSIfjnharKL5mtnDUp-6gU9PKq9wONvQ>
    <xmx:7CclafEGdCw1I5LtJ1Z3lYw2AGo2rnE4R8SscxHDd-RlJM8g_S82Qw>
    <xmx:7CclaR0RWtb3oIwKJ2dzL7C0sZYpd04j1kcjDm34CLeapZ6DUzQ-gQ>
    <xmx:7icladwjGW6_pgY1XPDM5W8tSt1X6gStbVhH0mFMGxcPVxhCBkyDrVG1>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 22:52:09 -0500 (EST)
Date: Tue, 25 Nov 2025 14:52:43 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Daniel Palmer <daniel@0x0f.com>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
    Boqun Feng <boqun.feng@gmail.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, 
    Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC v4 3/5] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <CAFr9PX=MYUDGJS2kAvPMkkfvH+0-SwQB_kxE4ea0J_wZ_pk=7w@mail.gmail.com>
Message-ID: <25208400-a203-fb5c-d0c3-2934a4d227e3@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org> <93055d50d71662261fbcc04488536e7330975954.1760999284.git.fthain@linux-m68k.org> <CAFr9PX=MYUDGJS2kAvPMkkfvH+0-SwQB_kxE4ea0J_wZ_pk=7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-14638117742116190217176404272535

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---14638117742116190217176404272535
Content-Type: text/plain; charset=us-ascii


On Mon, 24 Nov 2025, Daniel Palmer wrote:

> On Tue, 21 Oct 2025 at 07:39, Finn Thain <fthain@linux-m68k.org> wrote:
> >
> > Some recent commits incorrectly assumed 4-byte alignment of locks.
> > That assumption fails on Linux/m68k (and, interestingly, would have
> > failed on Linux/cris also). Specify the minimum alignment of atomic
> > variables for fewer surprises and (hopefully) better performance.
> 
> FWIW I implemented jump labels for m68k and I think there is a problem
> with this in there too.
> jump_label_init() calls static_key_set_entries() and setting
> key->entries in there is corrupting 'atomic_t enabled' at the start of
> key.
> 
> With this patch the problem goes away.
> 

That's interesting. I wonder whether the alignment requirements of machine 
instructions permitted the "appropriation" of the low bits from those 
pointers...

In anycase, a modified jump label algorithm that did not use/abuse pointer 
bits would need to execute as fast as the existing implementation. And 
that might be quite difficult (especially a portable algorithm).

Recently I had an opportunity to do some performance measurements on m68k 
for this atomic_t alignment patch. I tested some kernel stressors on an 
AWS 95 (33 MHz 68040, 128 MB RAM, 512 KiB L2$) and also on a Mac IIfx (40 
MHz 68030, 80 MB RAM, 32 KiB L2$).

The patch makes the kernel faster or slower, depending the workload. For 
example, the fifo, futex and shm stressors were consistently faster 
whereas the splice, signal and msg stressors were consistently slower.

There are no hardware counters for cache misses that might account for 
part of the slowdown. OTOH, alignment also reduces instances of locks 
split across page boundaries, which might account for the speed-up. (I 
didn't look at VM performance counters.)

Finally, I should note that the stress-ng man page says "do NOT use" as a 
benchmark. OK, well, if anyone wishes to reproduce my results, I can send 
you the statically linked binary I used. The job file is attached.

I wonder whether others have done any throughput measurement for this 
patch, using their favourite workloads?
---14638117742116190217176404272535
Content-Type: text/plain; charset=US-ASCII; name=aligned-atomics.job
Content-Transfer-Encoding: BASE64
Content-ID: <f33f9f04-1c1e-57de-00a9-6b89fecc77fc@nippy.intranet>
Content-Description: 
Content-Disposition: attachment; filename=aligned-atomics.job

cnVuIHNlcXVlbnRpYWwNCm1ldHJpY3MtYnJpZWYNCnRpbWVvdXQgMTgwcw0K
bm8tcmFuZC1zZWVkDQpvb21hYmxlDQp0ZW1wLXBhdGggL3RtcA0KDQpjbG9u
ZSAxDQpjbG9uZS1vcHMgNA0KDQpkZW50cnkgMQ0KZGVudHJ5LW9wcyA4MTky
DQoNCiNkZXYgMQ0KI2Rldi1vcHMgMzAwDQoNCmRldi1zaG0gMQ0KZGV2LXNo
bS1vcHMgMjANCg0KZG5vdGlmeSAxDQpkbm90aWZ5LW9wcyAxMjAwDQoNCmZh
dWx0IDENCmZhdWx0LW9wcyA4MDAwDQoNCmZpZm8gMQ0KZmlmby1vcHMgMjQw
MDANCg0KZmlsZS1pb2N0bCAxDQpmaWxlLWlvY3RsLW9wcyAyMDAwMA0KDQpm
dXRleCAxDQpmdXRleC1vcHMgNDAwMDANCg0KZ2V0IDENCmdldC1vcHMgMzAw
MA0KDQpnZXRkZW50IDENCmdldGRlbnQtb3BzIDEwMDAwDQoNCmljbXAtZmxv
b2QgMQ0KaWNtcC1mbG9vZC1vcHMgNDAwMDANCg0KaW5vdGlmeSAxDQppbm90
aWZ5LW9wcyA0MDANCg0KaW9wcmlvIDENCmlvcHJpby1vcHMgODAwMA0KDQpr
aWxsIDENCmtpbGwtb3BzIDE1MDAwMA0KDQptZW1mZCAxDQptZW1mZC1ieXRl
cyAzMm0NCm1lbWZkLW9wcyA4DQoNCm1tYXBmb3JrIDENCm1tYXBmb3JrLW9w
cyA0DQoNCm1zZyAxDQptc2ctb3BzIDMwMDAwMA0KDQpub3AgMQ0Kbm9wLW9w
cyAzMDAwDQoNCnBvbGwgMQ0KcG9sbC1vcHMgODAwMA0KDQpwdHJhY2UgMQ0K
cHRyYWNlLW9wcyA1MDAwMA0KDQpwdHkgMQ0KcHR5LW9wcyAyDQoNCnJhd3Br
dCAxDQpyYXdwa3Qtb3BzIDgwMDAwDQoNCnJhd3VkcCAxDQpyYXd1ZHAtb3Bz
IDE1MDAwDQoNCnJlc291cmNlcyAxDQpyZXNvdXJjZXMtb3BzIDMwMA0KDQpy
ZXZpbyAxDQpyZXZpby1vcHMgNTAwMDANCg0Kc2VlayAxDQpzZWVrLW9wcyAx
MjAwMA0KDQojc2VtIDENCiNzZW0tb3BzIDQwMDANCg0Kc2VtLXN5c3YgMQ0K
c2VtLXN5c3Ytb3BzIDMwMDAwMA0KDQpzZW5kZmlsZSAxDQpzZW5kZmlsZS1v
cHMgMTUwMA0KDQpzZXQgMQ0Kc2V0LW9wcyAyMDAwMA0KDQpzaG0gMQ0Kc2ht
LW9wcyAxNQ0KDQpzaWdjaGxkIDENCnNpZ2NobGQtb3BzIDUwMDANCg0Kc2ln
bmFsIDENCnNpZ25hbC1vcHMgMTUwMDAwDQoNCnNpZ3NlZ3YgMQ0Kc2lnc2Vn
di1vcHMgMTAwMDAwDQoNCnNvY2sgMQ0Kc29jay1vcHMgNTANCg0Kc3BsaWNl
IDENCnNwbGljZS1vcHMgMTAwMDANCg0KdGVlIDENCnRlZS1vcHMgMTUwMA0K
DQp1ZHAgMQ0KdWRwLW9wcyAzMDAwMA0KDQp1dGltZSAxDQp1dGltZS1vcHMg
NDAwMA0KDQp2bSAxDQp2bS1vcHMgMjUwMA0K

---14638117742116190217176404272535--

