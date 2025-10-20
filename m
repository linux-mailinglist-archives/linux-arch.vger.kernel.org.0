Return-Path: <linux-arch+bounces-14235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF58BF3F0F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D2618C5F82
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F12F363F;
	Mon, 20 Oct 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjxMXWw6"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E42F39A4;
	Mon, 20 Oct 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999780; cv=none; b=uHSUVSEgARs9SzYSn+KktUFrFhb+6puT4w0ttlqCyods4xcC/u6bGJBbqwBdyGyjq6wiDq+5ATj1seSvfq40dWzjSxlstrp1p5F68QaP7D0fL65nwUjEJszrPZXM1qqUfZlZlH1gsWW56TkfU23ao8hs4+SSw6DZaPVL66xOzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999780; c=relaxed/simple;
	bh=Ds40lvVQ8ct4/JMQM6+DhsSpkMtda2d+9Lt4Ht9DnyM=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=YwvtfJJGL5eiNUECS2fmW8MX5DO1/IfPk1W3InpZT08B2LIG0u9R5qD/1rGQVRU5adH4Ivdwy35kF3YJ0Bs0eg16+5OlJSqryjRP1LuXF5nB2VjovgcqEyoaIkPlAuXKGPlgYav9G2fduym7tzeTtONCaIiDhNDWtRx0UzQlUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjxMXWw6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6DC57A0133;
	Mon, 20 Oct 2025 18:36:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 20 Oct 2025 18:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760999776; x=
	1761086176; bh=sCEkbZKrl8bKnVzNmi1Kw704fMBYVAIdlc+QSCIPujs=; b=b
	jxMXWw6NFgPgWlWIleVc5chc/9HyOBYg4QfUexgH7mW9G7DwDFLUs6WoHP7R8Dtr
	vZ1mpPHNEO32cKKWTGz5KkSxj44VP8A6DpSnDmkPiKfj1Grh3g09d7BRvr6Osl1J
	lMNhboHYycxPoMbgkR62/+qKldWsgONUhK23vIp40NmiInBmAQ3os+OKu0S/ZIjX
	OZ0y+ebfoFVEJ3GZNVg4s6YEVxGyX+UYwOu8WAiJVRQT+SBayG3j8VlW918OCzQ9
	O2KB2EHehfsoBCiQBzNmqFTn6prHdQrPOVziONsj1xuvjC0fFbLRspfC576OYlOD
	RiZHjWcrhJpSw2GuHEedw==
X-ME-Sender: <xms:YLn2aDM5ztU0qc5Qrv8G8OfHLyfrINQ1mU09qaM5riZ30J6aZjZHMg>
    <xme:YLn2aBog_OILZHfR7G52mcosCIVTThdbArql8CjHGP5bMdt9xNuyAO6yG4sMhSpbL
    PQUJfZ1dLRDz0Xxj8Vk0nkWp2k-S_Kw8tlAy6BHOMFVridgc49OPwA>
X-ME-Received: <xmr:YLn2aK5UoBUjWR8kTOscOql0nJ3Hs0QhwcesUDHLnsoAtxRIz-74iy9ry-weE1oh7h5RuizBTBJEYYHg_ncxB2UMpG5r7xySCog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghm
    vghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpd
    hrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnug
    gsrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YLn2aJGpQGZyi2GtNbRJleRIQRoBTk0wG6N6WEWGz0nlM5OsXBC5og>
    <xmx:YLn2aM0A99CJ7CAKjcBJNFLsA2wYpQoVrOf7Ry6Y5wIif-NcSVoqPg>
    <xmx:YLn2aGrE_QT4LWs_mDQqnHgb74JmCxRw-saALwloywQZf7gIS5tcGQ>
    <xmx:YLn2aJNwt_7R44CVe6YKm5RqiyusTz7Ywbj8JqorLwKIFnSTM4Reaw>
    <xmx:YLn2aEXfsXXPFvjs8a7lFi4MnbqpAA6EDe4ZAp50rnLHhJVpsktM2iw3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:36:13 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>,
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
    Helge Deller <deller@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>,
    linux-parisc@vger.kernel.org
Message-ID: <c36756368f0ee942d5a995a603ce290eba06a5b6.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1760999284.git.fthain@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 2/5] parisc: Drop linux/kernel.h include from asm/bug.h
 header
Date: Tue, 21 Oct 2025 09:28:04 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This patch series will add WARN_ON_ONCE() calls to the header file
linux/instrumented.h. That requires including linux/bug.h,
but doing so causes the following compiler error on parisc:

In file included from ./include/linux/atomic/atomic-instrumented.h:17,
                 from ./include/linux/atomic.h:82,
                 from ./arch/parisc/include/asm/bitops.h:13,
                 from ./include/linux/bitops.h:67,
                 from ./include/linux/kernel.h:23,
                 from ./arch/parisc/include/asm/bug.h:5,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/instrumented.h: In function 'instrument_atomic_alignment_check':
./include/linux/instrumented.h:69:9: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
   69 |         WARN_ON_ONCE((unsigned long)v & (size - 1));
      |         ^~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1

The problem is, asm/bug.h indirectly includes atomic-instrumented.h,
which means a new cycle appeared in the graph of #includes. And because
some headers in the cycle can't see all definitions, WARN_ON_ONCE()
appears to be an undeclared function.

This only happens on parisc and it's easy to fix. In the error
message above, linux/kernel.h is included by asm/bug.h. But it's no
longer needed there, so remove it.

The comment about needing BUGFLAG_TAINT seems to be incorrect as of
commit 19d436268dde ("debug: Add _ONCE() logic to report_bug()"). Also,
a comment in linux/kernel.h strongly discourages its use here.

Compile-tested only.
---
 arch/parisc/include/asm/bug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..dbf65623c513 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -2,8 +2,6 @@
 #ifndef _PARISC_BUG_H
 #define _PARISC_BUG_H
 
-#include <linux/kernel.h>	/* for BUGFLAG_TAINT */
-
 /*
  * Tell the user there is some problem.
  * The offending file and line are encoded in the __bug_table section.
-- 
2.49.1


