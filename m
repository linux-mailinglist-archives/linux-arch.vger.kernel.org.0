Return-Path: <linux-arch+bounces-15450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935ACC12AB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A483065ACE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96E335554;
	Tue, 16 Dec 2025 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a57UIaPi"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0D30F811;
	Tue, 16 Dec 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867161; cv=none; b=gYXghMZckhe3IS9ObdxWgGJ6E+E40/w4sr//Q51LNW4vst3+ofp+pK8uyLXGlIQNFTSa+lKJ2vB7hEIKw6gjfc5W4HhonrvTgjj8nD7jXLAB4r6Om7xIJf9POiA2Fg4WzJijYlSL8zbUD27ZidLfaGTO5E9UKGGMClB+lRrb0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867161; c=relaxed/simple;
	bh=sAGPyROYM86PxLL/FjCxILspgRGOKwASEkqBJkuKc1g=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=QYN1dJdxM7ANplLeMWz/AYWDIn5NUR3gzurrhP9boyF1EAu2R70dl8Q5ODkWKgjtp1iB/5iIW/N31KQUvx1D6MLG3UnajHNCPtkXeyt1mineSKpCyET2OyUl3T9pI5By+EG+8TE1IsYue4u444ZVI+YEb6DSbVBMlCkuCayRa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a57UIaPi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC6127A00CB;
	Tue, 16 Dec 2025 01:39:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 01:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765867147; x=
	1765953547; bh=vezxBcTErgixux4qnf9dl082XeLH8UGEBZdhyNdFB54=; b=a
	57UIaPiS/u+vACMD7PM1Fr3F5p/W8MM6pfartdLtLMsiEawFFVdUaOARQ0Crw9Fh
	VrLhaAucHM9l/Q7LOFDSQGKS33lD2xRxOIms8jDOtFPY6MXiO0hSVizbGfve7A6y
	UQebX9y9WWV6L2SXyyVKOXALSY0Gd/Bie0M36wMA0uHN0bCIeI3Jv381MMNVJ9C8
	/EyXg0VGBnE18jrGyAXfIRHDWdEU7ihE0SAO0J0PfEacP3vnJm5f1EJU2nxN5uHQ
	da8GQQEksXV0qi83E7nDrpAXhGNat0+em8OBUS8H5I7ruifIQZZCrNdrtqVSLnHl
	If3wjOb/1HODUYhSQ7Btg==
X-ME-Sender: <xms:i_5Aafp4dxJwQf_iptz7c_2oS8Y4NQA8TSMDrKRMLMs7UemGzkS6vA>
    <xme:i_5AafqVCV-4kFqjPQu5_clLSVNRoXNMV28-vwhQlkANiwl7Oh_CbDhO-wsrKtBUA
    IHl9DL7lo9UpZhVcM13HkGY2GQw6mfU03yI5AN2ZFID3jISQ1-QtEM>
X-ME-Received: <xmr:i_5AaXDgC7ZwOnUwWPEGzW-sImPH3J3GwPq0yrqO-0BdEmMLpkGUT5ItFWQUImbc8E65WwbKI_hub0HhPYRg1ykaik3vXb2cfxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvefggfdthffhfeevuedugfdtuefgfeettdevkeeigefgudelteeggeeuheegffffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhm
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrhhnugesrg
    hrnhgusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i_5AaVtAZfgeHsEX3dSFTQ6HSsPBeSz-dwAFCkQrgEeNHB6XaJ0tHg>
    <xmx:i_5AaeLqTIIHkXsyoQX2um9TkgdFTnhoWG-qtQJg6t2qqueYUzYz4A>
    <xmx:i_5AaUaUl3wzWHnMXaTQkU7R9sSlLe4Lnlu3Iv1diqlSEZXHSBC7FA>
    <xmx:i_5AaYBJl5dRtadta6gCC_tMMtjCykdgl8R5N1f7YwZTQlpDmYXD2A>
    <xmx:i_5AaWN5SAzabwlldkBrFjGQccHTAik0ww6VD0TbOJym86igLsh5jaXz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 01:39:06 -0500 (EST)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org
Message-ID: <ff38f3d6c7a3e5b8c680013de15540f3ef903522.1765866665.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 4/4] atomic: Add option for weaker alignment check
Date: Tue, 16 Dec 2025 17:31:05 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a new Kconfig symbol to make CONFIG_DEBUG_ATOMIC more useful on
those architectures which do not align dynamic allocations to 8-byte
boundaries. Without this, CONFIG_DEBUG_ATOMIC produces excessive
WARN splats.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v3:
 - Dropped #include <linux/cache.h> to avoid a build failure on arm64.
 - Rewrote Kconfig help text to better describe preferred alignment.
 - Refactored to avoid line-wrapping and duplication.
---
 include/linux/instrumented.h | 17 ++++++++++++++---
 lib/Kconfig.debug            |  8 ++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 402a999a0d6b..ca946c5860be 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -56,6 +56,17 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 	kcsan_check_read_write(v, size);
 }
 
+static __always_inline void instrument_atomic_check_alignment(const volatile void *v, size_t size)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC)) {
+		unsigned int mask = size - 1;
+
+		if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN))
+			mask &= sizeof(struct { long x; } __aligned_largest) - 1;
+		WARN_ON_ONCE((unsigned long)v & mask);
+	}
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  * @v: address of access
@@ -68,7 +79,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -83,7 +94,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -98,7 +109,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d080d23d9a87..60f9deef00fd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1366,6 +1366,14 @@ config DEBUG_ATOMIC
 
 	  This option has potentially significant overhead.
 
+config DEBUG_ATOMIC_LARGEST_ALIGN
+	bool "Check alignment only up to __aligned_largest"
+	depends on DEBUG_ATOMIC
+	help
+	  If you say Y here then the check for natural alignment of
+	  atomic accesses will be constrained to the compiler's largest
+	  alignment for scalar types.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


