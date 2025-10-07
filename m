Return-Path: <linux-arch+bounces-13948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1DBC2FF8
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C73134ED126
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87242255F2D;
	Tue,  7 Oct 2025 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pJp0OnNO"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0876248176;
	Tue,  7 Oct 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881059; cv=none; b=ONzdvhofxC/2k+B/Gp1yk0kkCTLRpLdIef+hYcKIQlif+WxQFqNyy5DmaWB/WRCb36o+v+Rg3uaJM0vdpu0YDt2SKs9nAe2Ffw2sEkE4yxkkGJJK35i3V7QKhkTQVQ1ykLAaVZfQBpfcxseaaFe7LHie+77i87XZy6vfYfnlHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881059; c=relaxed/simple;
	bh=rftrhfEKfapeHxVgZj6mK1Ft6S55T/bo4rn2OTQignY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=SfmULJrpDJrIk14TICmN/QTdomkWLw7UZcQQyTETBiMgvwhO152gC63Bfd9Dw3KG4YDE7f6cKbWRnsUJJVfLgo5iCaCJRNDfSZeWfa6KGGSoVK2Kx+sCU6wD+Ira/J+1fRZA6piLwTP0OnDpJd1vPoeJQtRlQIDw1XGv+/DU+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pJp0OnNO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63C427A0195;
	Tue,  7 Oct 2025 19:50:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 19:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759881056; x=
	1759967456; bh=4/txBbaCQdAI1HAyCzg1zorpr3/M/73CrArjyktCXZU=; b=p
	Jp0OnNODYtgpPt0sHEvxgkDuQTWwktZg3Y3nOMb378CZkTq1UeLBqWFcTF7Ct8u4
	a1n7jeYh+1UIGfTc6AM3IIPJyR7jDorwx69+qWnVf6E2MuhVPAwjH7vW3KvLcTbA
	E1J7tlHyuRQQf7DgGZ1MDlbYkQ3SCpBebtJ3mOmjjZlUJdKyXbj9EIyhQUzjbtwc
	5sVa9GvG1NPCG1bSxyWP4AtFoys+O0dx5dFtTprPbXXOTojs9ydOd3QVQ0+N2epN
	bnpURsQNzrvmUGLssBCAh90ArOzuzxXX7I5XGVSBdEOANOZc5WGGwOwAXLiXuqJA
	MNDqKWJA6NpOCJXvYHgSg==
X-ME-Sender: <xms:X6flaPETfGMRZNp9QeS3iRk3EEToJdISClQvwajJUelay9NJGTc4EQ>
    <xme:X6flaINDqH4QSlSN7l13gCbhcAZ5wWIWa1rwluKl7tXMB75XKJMVuMRGMStiVmu9C
    AaHX94b0QmhzCr5EKZ0ZhOeB0O3d6X9I_o6hnVkClWc0joGWOTWUa4>
X-ME-Received: <xmr:X6flaJ-B7GKo6jQB19cMM07WyvZo4Bjvpi_1LgkI7IOa62YnqMQ3V7KEQLqGtmGf5WYQmV3-CcdiDB09C4glujN_33ZLBDqJTk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshht
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogi
    drnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    gsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsggvthes
    lhifnhdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh
X-ME-Proxy: <xmx:X6flaF5dhMq9ZwyVWq4lKNZEZ9Coc7YrkQhc5EBw1aEyPmvMEYdmSA>
    <xmx:X6flaOVGL7wJvs_qRVR1-eH38JcgXg9qRp85xx1Kt_lr8T4TiIWW7A>
    <xmx:X6flaLIT4Np-WJcIP4ULGtfzlnxkiTd-kmmKDvp29cVSsXcIR1YHyA>
    <xmx:X6flaLR91F8ii6raqLqY78kHCIzpGZ26Qh9eTSlZKhYat9hUkH1u7g>
    <xmx:YKflaAcJfA1g-zZ17C1bwr1-CLnT2FataLtDiXm1305Ej5JWvVML2RTw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:50:52 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Mark Rutland <mark.rutland@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@vger.kernel.org,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>,
    Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>,
    KP Singh <kpsingh@kernel.org>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>,
    bpf@vger.kernel.org
Message-ID: <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
Date: Wed, 08 Oct 2025 09:19:20 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
changes, as it will do on m68k when, in a subsequent patch, the minimum
alignment of the atomic_t member of struct rqspinlock gets increased.
Drop the BUILD_BUG_ON() as it is now redundant.

Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 include/asm-generic/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..eac2dcd31b83 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -28,7 +28,7 @@ struct rqspinlock {
  */
 struct bpf_res_spin_lock {
 	u32 val;
-};
+} __aligned(__alignof__(struct rqspinlock));
 
 struct qspinlock;
 #ifdef CONFIG_QUEUED_SPINLOCKS
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 338305c8852c..a88a0e9749d7 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -671,7 +671,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	int ret;
 
 	BUILD_BUG_ON(sizeof(rqspinlock_t) != sizeof(struct bpf_res_spin_lock));
-	BUILD_BUG_ON(__alignof__(rqspinlock_t) != __alignof__(struct bpf_res_spin_lock));
 
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
-- 
2.49.1


