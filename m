Return-Path: <linux-arch+bounces-15448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8DCC12A2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0296305BC65
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823B31AA8C;
	Tue, 16 Dec 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpBLfDbU"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0732A3F0;
	Tue, 16 Dec 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867147; cv=none; b=c4+rnCtK+ZAXq4j//TnKmczjIU2FMkSQLd7RGOAvuFZoIYKcEXnvlZeWl8vrwNmQK+b89JTCpODC9QyxxLZsq801F5O+U7IHe5na/GsyA27DlC93HVB8Y1tYju1OXHE2IhSZHGG11ZyQuA2bDZDjAOrGB/f2ADctsEc/l1r8fzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867147; c=relaxed/simple;
	bh=fPHD9wAISu5t6qKPTwCQaRmuWT8pn+zT9hLSLbiHlQI=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=K4Ijp1+M7oWNRsDEqOakcyE+v3Ze0MAFArsb3jP1sgy8+Gzsy69rOsFL4aIYVK6yMQqO/fqcGQ+klTzWEAH7rSkfzvJktyljaD8hxBLuISH2IZESr0mReJlRE7WEF5HOaEo9MO9j2JKDIsUJXdzgnvTxgwcXMk+T+1MBv8x4b/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpBLfDbU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D4897A0170;
	Tue, 16 Dec 2025 01:38:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Dec 2025 01:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765867127; x=
	1765953527; bh=T1SyiRwGt1GmfJ2gdn1v9a00qpjb2VwL5bJ4qN3bC5s=; b=w
	pBLfDbUGT5d3beptG9LnvPiHXYaa/WPLMabnM437MJkbdx894E7MX6vDQP+XMJ2m
	gxwZAGFgNrOGZGDZLHARDr7B/mV+s25G3ZOZ3+3Fh8a5m/OzsR4GcAw6p29HwahP
	ntIttt36mkI61t+5tnyhRhcgMeNoZ0kTmqp8SCjWy9xnTZqu2/W7S9qFnq5xwGze
	GnHquMfEJac5LslRCHHkDBMqTyuW4C0IfiqlofDZc6hxDsCpTx2MAm8gfj5Uq/Xn
	/mYwrhf+5L7izWvTVyFZzxxWxaodJX7d/pOQzwcwoe6h0sZCgHWnL0eKHw1A2BoW
	0q6SlbA/y1jeh57j64I9g==
X-ME-Sender: <xms:d_5AaXhG9qsnhS6IzK-qR14vd4vEc7u1Xm0dwOmC936XwZgUeONmog>
    <xme:d_5AaY7EHIRDSygdyXvQ8xYy_f-aNWnRhQHQ3S5qb7-wz74nWe02EC1na-ZKR1rJ_
    fAKQsY36ZT211rcAmkgAwREFqFCygSGIH6SLDtyeWUXAYZELFcI5-4>
X-ME-Received: <xmr:d_5AaUpV68e9IRnVSP-DsQ4b0PN99A3Y0lPs1WcewatPuOktdXx5EpxoSjjLFSKTFEWYp36qC39GYzErshMMpvMlWzeopMbCgOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:d_5AaWWcrmawSHSTzqVc702kMBMGVf8V7b1enP2lePh71AzOEQkbcg>
    <xmx:d_5AaT6uP_gBLTp7daE1JIIBDrM4iNBo8JYpejdEpxuNkB-yYcvWTw>
    <xmx:d_5Aac0r-xyHfBdoyud0STNnfbFBUV4raaW7IxUF01wfNMKxsSm2Aw>
    <xmx:d_5AaS8UBXBlNQaDcCoSLy7SPKAFx93v5KrK9-A2q71BMBp2yQr_1A>
    <xmx:d_5AaeZN9fJPxhk_8N1VPYHU1gV5l6PwhIVSq3bOuWu4ZsC75_zjKZFc>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 01:38:44 -0500 (EST)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    Guo Ren <guoren@kernel.org>,
    linux-csky@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Dinh Nguyen <dinguyen@kernel.org>,
    Jonas Bonn <jonas@southpole.se>,
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
    Stafford Horne <shorne@gmail.com>,
    linux-openrisc@vger.kernel.org,
    Yoshinori Sato <ysato@users.sourceforge.jp>,
    Rich Felker <dalias@libc.org>,
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
    linux-sh@vger.kernel.org
Message-ID: <d6cd17b387fa4b4cf9f419ec586ac4756bc7aaeb.1765866665.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 2/4] atomic: Specify alignment for atomic_t and atomic64_t
Date: Tue, 16 Dec 2025 17:31:05 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Some recent commits incorrectly assumed 4-byte alignment of locks.
That assumption fails on Linux/m68k (and, interestingly, would have
failed on Linux/cris also). The jump label implementation makes a
similar alignment assumption.

The expectation that atomic_t and atomic64_t variables will be naturally
aligned seems reasonable, as indeed they are on 64-bit architectures.
But atomic64_t isn't naturally aligned on csky, m68k, microblaze, nios2,
openrisc and sh. Neither atomic_t nor atomic64_t are naturally aligned
on m68k.

This patch brings a little uniformity by specifying natural alignment
for atomic types. One benefit is that atomic64_t variables do not get
split across a page boundary. The cost is that some structs grow which
leads to cache misses and wasted memory.

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Link: https://lore.kernel.org/lkml/CAFr9PX=MYUDGJS2kAvPMkkfvH+0-SwQB_kxE4ea0J_wZ_pk=7w@mail.gmail.com
Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v2:
 - Specify natural alignment for atomic64_t.
Changed since v1:
 - atomic64_t now gets an __aligned attribute too.
 - The 'Fixes' tag has been dropped because Lance sent a different fix
   for commit e711faaafbe5 ("hung_task: replace blocker_mutex with encoded
   blocker") that's suitable for -stable.
---
 include/asm-generic/atomic64.h | 2 +-
 include/linux/types.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 100d24b02e52..f22ccfc0df98 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 typedef struct {
-	s64 counter;
+	s64 __aligned(sizeof(s64)) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..a225a518c2c3 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	int __aligned(sizeof(int)) counter;
 } atomic_t;
 
 #define ATOMIC_INIT(i) { (i) }
-- 
2.49.1


