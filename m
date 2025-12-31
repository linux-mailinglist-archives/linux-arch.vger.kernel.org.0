Return-Path: <linux-arch+bounces-15617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6ACEB88B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 942E9300C747
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BB279908;
	Wed, 31 Dec 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1tTti8U"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F3267B89;
	Wed, 31 Dec 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767169937; cv=none; b=O5GbpfoTPp+kECYscmn4jtfGFoL1pAiFdCPYs8JXiE99G1X3ukGCdfksA3Rne47jo1FFR2HT5D0ZQw1h93YsmbmTlJ7lbMVPSgOGeV4kzF1JOFYMajkkMejSxcKSu5KfCfx5A0bf/3DEfbyE/gOyuxMJQM/Jb0UsfM9msCuPixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767169937; c=relaxed/simple;
	bh=6BaawB/5vhO7v/rumx07zT9BPZyyoYZDc4iUgex6uao=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=OjFnRPQ8e24yjHgfo0103QL9GTksGZzQ29zMFXVOfxCTvRBlt+pgnv9s2H4JDoWryJHhvxP50juwzyvZAiHFuV3TbfoB9nTSLo2dR4PMVAqe9HnWnEfqKSv9C3ZZ47ZUHR9iy5lsWaVnt3IkUa3xdHuXoFSSBLkHRCJqWdImyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1tTti8U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5DB77A00DD;
	Wed, 31 Dec 2025 03:32:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 03:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767169933; x=
	1767256333; bh=nL9oXUgaQPIU6S4mzvMLiKSGthFWHu05i1DeuxQmtGs=; b=r
	1tTti8Up8Zi+al8bvnYxDoJW3Jw48pwJGUd3uU2witdKmm68bwDFvju56NN7BRti
	hHfPal/dtoP0W4H6uCHkO7JiPXgYCv3i1z/V9mAS3+xJiQgErXtp3pmkBHAMzsbV
	mEm1zpriUVrKMVmHQF6w+ISYDrtS4T0Twevykb/r4Vr74jc8nVWKNFd/OA2iXUmK
	Uv9XooUtQO8+rdETxdEsVhqtQKLwOQ40u0KqWuVmLrx1Nz9iFiC5wctEQb67JuBc
	uosJaU6N1SztN4DIFQA7hsM/DzpXn67S1THmmUTSL9yYyxLgc3DrkDwIQ4Ig1M+q
	L4LRldDsdeso1zdw32oJA==
X-ME-Sender: <xms:jd9UaSwMn1ad5FrR2Qb43fRdfzD6Uvz9WIMaz9nacqYlI-MgAy0E5A>
    <xme:jd9UaSP-YfWKdhlX0-QxFqbrVCwl74mtvlATBYFc3vi4f6nVdl-rsO1vH1vCVeQ9t
    EK1b9XbTa5PgVnprmCVi8O3vFxq_Z5uJ6euK0y-AjdFnRwThELOAMk>
X-ME-Received: <xmr:jd9Uac3mDXBJw32kEkHPFkGID-ce3pBwKEjv0yhwzIC89PsfKWmBMvdn8NUl2ayrd8FRXoWVYA8DsDeSPRaRxwkqLWpBmNyc_do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvefggfdthffhfeevuedugfdtuefgfeettdevkeeigefgudelteeggeeuheegffffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrg
    hrnhgusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jd9UaSGEHzAqLqsjbJxBUukT5pt3uriUWUJQibBP7MRUqr2LKtu6SA>
    <xmx:jd9Uabg6VQnPHpxn5bA1b72dK01opgzEFaMN4zh5R9mXmIx2uhshzQ>
    <xmx:jd9UaTdi9DwSZg91lRr8y3_PTUNlSgd-t4NwU2O1w7lN4cUlqGHq5g>
    <xmx:jd9UaZxh8BAojZqUn9K3Moj8lALrxJK1GwzmUvfhCNRNcIG6Ti2LaQ>
    <xmx:jd9UacGA0SdXgnVdDyg2KD7qgiHC7rP_21drYT42WH5sPdBU5nFSMxvY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 03:32:11 -0500 (EST)
To: Andrew Morton <akpm@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>,
    Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>,
    KP Singh <kpsingh@kernel.org>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    bpf@vger.kernel.org
Message-ID: <5803c4a180975f102bc8f78a3251540f0396fa46.1767169542.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1767169542.git.fthain@linux-m68k.org>
References: <cover.1767169542.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 1/4] bpf: Explicitly align bpf_res_spin_lock
Date: Wed, 31 Dec 2025 19:25:42 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
changes, as it will do on m68k when, in a subsequent patch, the minimum
alignment of the atomic_t member of struct rqspinlock gets increased
from 2 to 4. Drop the BUILD_BUG_ON() as it becomes redundant.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---

Changed since v5:
 - Added tag from Arnd Bergmann.
---
 include/asm-generic/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 0f2dcbbfee2f..dd36ac96bf66 100644
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
index f7d0c8d4644e..8d892fb099ac 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -694,7 +694,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	int ret;
 
 	BUILD_BUG_ON(sizeof(rqspinlock_t) != sizeof(struct bpf_res_spin_lock));
-	BUILD_BUG_ON(__alignof__(rqspinlock_t) != __alignof__(struct bpf_res_spin_lock));
 
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
-- 
2.49.1


