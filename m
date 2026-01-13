Return-Path: <linux-arch+bounces-15758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7BD16B74
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 06:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B0F5300C638
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6A35B127;
	Tue, 13 Jan 2026 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkdaaE9/"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B622C235D;
	Tue, 13 Jan 2026 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282692; cv=none; b=VeKn8ExdHP0vhTwm2gSKXvk551/qQcXm349ENWphCY6seDTYVyfo+JMirne9BzZpfOe/QCMaIMxtQcnCmetrvfBiyvPmiOCCFVr6tKqZ4REoiheiji3cOIZffbLnXODwOokn1j+ZR5fufSBltVhMkBQNOH+P3YzeIaqgBkqJr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282692; c=relaxed/simple;
	bh=6BaawB/5vhO7v/rumx07zT9BPZyyoYZDc4iUgex6uao=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=joqkWf3zcI9ENORlrSHPkQLBUrtFBg7CIVtfX5wNbcmQLSk4z/lU7m7AW/IDIWh/ZlE5pXjcSBncU7tnjBE2Keb5M0igFqouUuLu1KVkiVWDyIhOiWe4U3qFYjUcr3dSOwoo0SeuoHH0VxiveoZq04FPck3RUp1sExVcRlmWNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkdaaE9/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E5EA7A0095;
	Tue, 13 Jan 2026 00:38:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 00:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768282689; x=
	1768369089; bh=nL9oXUgaQPIU6S4mzvMLiKSGthFWHu05i1DeuxQmtGs=; b=B
	kdaaE9/oX7QGz5QHKWUNZ4An3q2fXEMCkfsh4lC+F9/IEaVj1yMi10ugkkWh4O9X
	1/M3K8L0CEozQLX7MnMDdc8sc9aAucY5J2IUrhom4LApPHwQ0Yz0qdg6YTG0drtw
	LzrS+P/p9tHKdwmQE0hVAqqMwuPbbhJNY51ydx4rgXtzJQ72GA1KnNIqoDZGmV7e
	8C6RmkBR7ZBGbQwqK5zwsLZxCM/VQR727BCqvFxhc5r1WfU7L3xQdq2/yoTitzO4
	ngADxD4rYNH3cOdIK34ws/L23izVcc+CZzh2hS+ngTMyBZnGyVYar0IzTBix98rP
	u4pdL9xHfPudO3ShY4y0g==
X-ME-Sender: <xms:QNplaTkNm-MXZh55LywoqMCdyW4erTATlkQ8LhMM8vliQp3qx9igvA>
    <xme:QNplaawenKMlmyo-hM1sXO_Us1nq3JDv6tv6L5a4i2qeLkzM9tJvSUrbQusjE9VZJ
    nnsnbPBQBxyqJS5lOLQ8nk8BkGBJabYF3erA8fiEkSbmDsyRzpFFljo>
X-ME-Received: <xmr:QNplaSLXVKQLjzX-d3nSWRzEI6H3fYIKeWi2Amaw9UZGw2Cl2Rokvo7y8pZoDU4nQDas3hQ_XigtowQRG9NpilunoRkFUqBto_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhguse
    grrhhnuggsrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehmrg
    hrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QNplaVI2nHIzCqJKwkB5l4wLlFnPQm97_sanwjp-zHyc5csrSwzTWA>
    <xmx:QNplaZUfsSO-12B5sDfCU-hUUWWyPDSBywHSK8P5H39fjJSs_9j60g>
    <xmx:QNplaVBib6f_91lccA9oDuxMDoDwq72ZFoe1yr9HFRKr5I8bSbMonQ>
    <xmx:QNplaUHica4Gso_m9XvYzOEYqrkEPVrrd6SmZo1V8w_3iQDN1bsVFg>
    <xmx:QdplafqODDGdKEJwDRbWQFCeOxok8dv6lwO73Ib2Moyr-nVggvQamg8A>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 00:38:05 -0500 (EST)
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
Message-ID: <8a83876b07d1feacc024521e44059ae89abbb1ea.1768281748.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1768281748.git.fthain@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v7 1/4] bpf: Explicitly align bpf_res_spin_lock
Date: Tue, 13 Jan 2026 16:22:28 +1100
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


