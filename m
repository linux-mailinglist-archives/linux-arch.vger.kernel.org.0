Return-Path: <linux-arch+bounces-14234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A61BF3EF1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8202A540E2C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE8330305;
	Mon, 20 Oct 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkAbctiN"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2492ED86E;
	Mon, 20 Oct 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999769; cv=none; b=jkgK2lSY14L8qRV5ERyfs5mEjCXbJi09LV9PgmkQ+1gct17RMjccShT74aRSPSqrlkNJsfH4k+ZCCCF4BuktC2cXzghInJ1GVaTsGPBcWFPYZw9FsPx5x0o8KQ++3bKEfU4Q37cxdaQdxxATylO9HcVP90ZPiBE4oh0onj6t9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999769; c=relaxed/simple;
	bh=oAbST0+JKJTESwBm/MGfnCEeNdAFwq9mPXtX42hpaxc=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Ad4/yb/Q/Hn5aiw76lty6mcSEZ0iTfjNtw5+SLWrHf2H8GKHOt6gqihSoWwjsUb3MrWrg5tABcm5g46RPInisf9T865C/W+OPhSYDjzLkk+OyVmgapiVOfRXQR9C1lKygTUPKoLQy9YtMIQmetqp0DdZ7bExAxlfZ+3wijzsVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkAbctiN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C5EF1D00171;
	Mon, 20 Oct 2025 18:36:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 20 Oct 2025 18:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760999765; x=
	1761086165; bh=hZe/xPiV9af0NGQdc+AfTV2g1Y0rwHK7nJNIcATbYOc=; b=S
	kAbctiNvsln/6UOsZUJ3lqpKOe95dTwLJaw8SQ9aTHpX9Cd/Onqu6tNorGpkojYI
	XOfLOx5o3fSP3tIYF79nqrd936DhITZVkBYfIZ78Mf8QQp4QfzllkjDjb5E70PZP
	m2cMbc8PZ1ZBpL8xXnHYOqkuFpYI0NaYKa1E4b5T22oPttNiIB0gox6lj7xiP6u8
	k20vw8+InycTefwtk5rO5ix75Gim5cvP0Rt2qlOMv8Vs+i6LfJzCjpUbziNEid30
	le3DuSOxmg+PkzUqfgF4LQKw3pWk6W5ohW9L3O0QdSj1vO87lZ1iDzHiMmEJsxSJ
	fpeBf0ijonVu6wDGfoOJg==
X-ME-Sender: <xms:VLn2aJcXfwV4YOvxLwmFMiXPGTQH9uJ4_qaziRLn29EsGX4wCcynDA>
    <xme:VLn2aDk1Y3jXONlouTy2sKRJYM0i1pD2jGGhoIAzAT2HCwdAe27yfXWz_iPn_EqQT
    ZRN9uLiP7u5rVQhT55snQTxC7vP31Gtlw5Y7zWsmUxXq0FU5Kr89qg>
X-ME-Received: <xmr:VLn2aG9wViXXnmQxfcJSkkLSJKORnWEWTTsAKUgNuS0P02M79r2tlqZXRikfs0rzFT7H-rnMVsuAUfKBEF-yTLds1nJyuUxKu0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghrnhguse
    grrhhnuggsrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhmieekkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VLn2aBGuWv61dhrfKZ_EZUIaKzlFCQ27OjuF58uMI3C0bFxyxzoM8Q>
    <xmx:VLn2aCIDcqcwegKqcWunhMOjem7DUPDsv-XkB1s81LeSM5QmgFzc8Q>
    <xmx:VLn2aJkFGzVNql4nNCPqFNm3F1EwxOfUwo6e04BHiyvZknIUhK93Yg>
    <xmx:VLn2aDzdv04jWwrOBgHTo5Q3lKKuT9VLOe40LE_BXyivKb71eV-j7A>
    <xmx:Vbn2aLX-rTZ_BiNByC0iCU3WfksSsoSuAzYwyz4w7V7SmnMtnaTEw_Yt>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:36:01 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>,
    bpf@vger.kernel.org
Message-ID: <4ad2b350b2b4123058d56c15ab092de9a882f5c8.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1760999284.git.fthain@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 1/5] bpf: Explicitly align bpf_res_spin_lock
Date: Tue, 21 Oct 2025 09:28:04 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
changes, as it will do on m68k when, in a subsequent patch, the minimum
alignment of the atomic_t member of struct rqspinlock gets increased
from 2 to 4. Drop the BUILD_BUG_ON() as it is now redundant.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
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
index a00561b1d3e5..02f1f671e624 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -692,7 +692,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	int ret;
 
 	BUILD_BUG_ON(sizeof(rqspinlock_t) != sizeof(struct bpf_res_spin_lock));
-	BUILD_BUG_ON(__alignof__(rqspinlock_t) != __alignof__(struct bpf_res_spin_lock));
 
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
-- 
2.49.1


