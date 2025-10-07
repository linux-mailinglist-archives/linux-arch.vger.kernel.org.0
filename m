Return-Path: <linux-arch+bounces-13949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D46BC300D
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E70E3E36DE
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE4F25FA13;
	Tue,  7 Oct 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xVzri3LJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611723E35B;
	Tue,  7 Oct 2025 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881070; cv=none; b=E7/dk/bIa7payIQtOrHiA9ZGrKMIp7V+xXpHwqbn5Y6d7vAdWkzFyWOylWCEmuSLVNeMXkj9sW/XhnLh0XIC2p5yYln9UcddbG98t7HRtOH/wLXuhkkLTMZJVAqYHs0FI0NcTTCFzm1/wd5FnUVqIQ7AaNCvsF6dCG1Qyqhxed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881070; c=relaxed/simple;
	bh=4QyH1EVYZrIL8ROTUcvFrBkVfvsFyB/Ot/CJkrr+16A=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=b17daFuBxgdn2HiGdVoaB4i2Ty+F8fTpNbsG6AOb9xl2eQ7V45Nd0qtYablei9Q9OpTWEGxebJFrkCVAyu19FJ1Dtb7/e9n5grdZnx5aULnPVk1nUGVKw0R+PmXkps1rgSVQDn9RV29JvnV9NfOsAoQKtYyqxOrEHjFda3kC3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xVzri3LJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70AFA7A0053;
	Tue,  7 Oct 2025 19:51:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 19:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759881068; x=
	1759967468; bh=nbJ+bkF+lRtSSBYxfQH9cNkhYr225g6snGXYRYj7rYk=; b=x
	Vzri3LJEagBBhGyxDdDzdCB7NOmuy8eAXDl7JuKG26rL7TbMLa30iAOo7aOxhWuQ
	I4HdMj7HDaeBOrbczXzqlezVKj1yTg+AdKAVuCxEKHiIcjV3EkUdxmQKX1ehkxg0
	69RcN/wR3Ga886L1xV+3dcy+a1P+/tl9bhQQ77tKVwT3ZTkcxbfL2iK6oAiubggH
	8ui4jF5KGjPQXcGgt4sMjKvYdwifuRM1vEJmUk+cGkyU9T/1Ra8ne1Nrk2hV0+UA
	txmioGDFYKzMm2nWLj255zlfy1bFV3GMoayhRZsn9r3SlAgcQBFGw88BPbhOW9xe
	ZHTbs85e+i3+tgiXWNHvQ==
X-ME-Sender: <xms:a6flaF5LZ8eZzNwt1F9QiM6hE4tsFEHYgRaMNF29sA-0NcRmPGu5Sg>
    <xme:a6flaLBcWN6eEX46S9uJzkdzCxxWImeUm11oeufOysjz7sOhm2FFUzjx4O_8lSfxv
    JWTF2z86cxm8HzjqqnGt8dvpUVmKegzt0J65luCcq7QQTFfQL6H9mU>
X-ME-Received: <xmr:a6flaL-kvurzrk63AV4J0GH8bsMaws4ztAnb2U0JbrrR2XGp002cb9LkefxBvAUR8M1X-xI61Ywc1gzZYZ-sHIUjGMDbJNOUb_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehmrghrkhdrrh
    huthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bKflaOE9rg_E3XjD3r4Ol61lqvjBI5R0OF0FuJpU63cezh2JGs9J7w>
    <xmx:bKflaFSgJN97ZRsqrY1fOnJWNOQzCXDzhvS7VzoFuc_UhmaiT_eaUg>
    <xmx:bKflaFRbgfUusf0IoVObMd9e69u3ii8oSxOlnnN-qSBLBp80U91cXA>
    <xmx:bKflaI1le2JjbNg-XH0TBQdzz6aPAl-wC_JcgaicteSPDhPKdnWAEg>
    <xmx:bKflaJer47CwFBGKpXuVHp1ZFm6FMH2WAR1T1Hzezy4tJY93_Gy1zKxO>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:51:05 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Mark Rutland <mark.rutland@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@vger.kernel.org,
    Lance Yang <lance.yang@linux.dev>
Message-ID: <d5a0121eb3c9dc3645488d24a2f71aa55582e75f.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 3/5] atomic: Specify alignment for atomic_t and atomic64_t
Date: Wed, 08 Oct 2025 09:19:20 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Some recent commits incorrectly assumed 4-byte alignment of locks.
That assumption fails on Linux/m68k (and, interestingly, would have
failed on Linux/cris also). Specify the minimum alignment of atomic
variables for fewer surprises and (hopefully) better performance.

On an m68k system with 14 MB of RAM, this patch reduces the available
memory by a couple of percent. On a 64 MB system, the cost is under 1%
but still significant. I don't know whether there is sufficient
performance gain to justify the memory cost; it still has to be measured.

Cc: Lance Yang <lance.yang@linux.dev>
Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
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


