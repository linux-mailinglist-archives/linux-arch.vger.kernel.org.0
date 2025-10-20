Return-Path: <linux-arch+bounces-14236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BABF3F12
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7449318C5CE5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93932F39AF;
	Mon, 20 Oct 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Up9ZbkoA"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7F2F39A4;
	Mon, 20 Oct 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999791; cv=none; b=CJHGaK/ZcuCdcXum8wLb0xY0bKQJkhybQtnCjUt3SvYxVVfrZqCQE2YsO2iTPCuK0tokLST6IZ0zWNqtBYu5g36BJG57jcv+/ZwLD73Scd6EExdoKhkBBt6khJmXzyA9c/NrzleSteykZMbC8j/eW2DwkSxcLAqitckvXZksKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999791; c=relaxed/simple;
	bh=Ydj+Z+1cn0WqStqIF6lMy1qCSLA8Th69lMVWd5rfERY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=agI+IPN16+mj2S3y8izyYsAw99Yul8xzSZWGma771e8DvVVfEYkvO2gwk15yNnI40lqYBeRR7o12uJ2cmLBF+zp73qfQbpmHPStj7KGaUmhpMlsF3KYLQZqeWbYFCul22uFAnZLVHmHIto1wE5Uh+whAOnr19CVq0DkjXCSKF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Up9ZbkoA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D11F77A00F6;
	Mon, 20 Oct 2025 18:36:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 18:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760999788; x=
	1761086188; bh=OaA31fhO0Mk2O5tNJntGr4vvAQnj5OF5mMtZDb1L75o=; b=U
	p9ZbkoA5ag1XAaL6oy81lbqC9Wnm+HQ9N0tWr3Hyd6bEvZF6PH63MTNeR7jRNp7+
	O0cbV5LvNgxwiKDxvKmKH+Xg9olHjaP07bX9Kw20Nkk14/mErm4Djd0aTjLUIxGP
	CIAQjWOLDeWU3WrnyZSf1VTm+Gz8U19dhcTbk/4P4xoTUB5n49VhDx/T5+nzQMq+
	wKTVYx206Xwcz4OmpgToZ+ScissnCj2Uu+OhaMtT87J3MgHXFzSAG+4S5IV6oSIk
	9UjfyIQTjXAziWe+8G4d7HkoXGkPkwZdeZj5APw9q6u6m6QKt/0X7mUAAI9wgsxL
	0tYPIWd5tqSssR5ldPfDg==
X-ME-Sender: <xms:a7n2aPXuBTaY4cxt5JB_CclEqRtphbHWkZyBS3pm8EEKuwv0ZpPCGg>
    <xme:a7n2aNlTFe5_9jB1sG_tfDNnlz2934AMBhdflgoZn-wBsTb4MasO_rR07C-eE7LWa
    AR8ApMv2EzNnAiW5XrDI8NzcRWhIDY82NQGLLhrFh9rnsMvIQSW0b8>
X-ME-Received: <xmr:a7n2aGMSNpa3LgrzMj5bB2PftHSwNFqbIjYDJUz273jvTOXbvWu__Poctkc5DTfBbrAzHdfm-DR9xLkZPa2QiDjfBdyTqLjrGps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a7n2aNLWQBk2Ien4FDRylxIfMKFVZPufX1ucnN3r_BGMBaurvAYu5Q>
    <xmx:a7n2aI3lrrDpYpst14xmPG_DAx2U1hioUFzozfzepoodIx-MpVpkAw>
    <xmx:a7n2aBXxKKOQwIOCVsROFZhZE2DdfKX17eHwv-ycg0-Ya9NectpUsQ>
    <xmx:a7n2aKPHsa3816dhVWsxALX668MC_dJRm6Jw3lS-3E1GRD5b_mAyeA>
    <xmx:bLn2aGGVP8Oo2mqVGaI7yzSEA8q3_kRD8_JCEQTw4zyMtmKJPL12UdgM>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:36:25 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>
Message-ID: <93055d50d71662261fbcc04488536e7330975954.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1760999284.git.fthain@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 3/5] atomic: Specify alignment for atomic_t and atomic64_t
Date: Tue, 21 Oct 2025 09:28:04 +1100
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


