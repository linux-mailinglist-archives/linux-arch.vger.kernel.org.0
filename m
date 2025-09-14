Return-Path: <linux-arch+bounces-13570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC504B56418
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 02:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F16201047
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74E1D9663;
	Sun, 14 Sep 2025 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+hpi21Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298A1D88A4;
	Sun, 14 Sep 2025 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811560; cv=none; b=EDzXKfDBdIio5tEI8ZJ7yRDLPM7uLmx+mNzqajMNMHwSQqqSrfltFN7JjqVmACxE5W8ZX3kycZ+VAEtnqRr4i33301Q3T8m3xP5Mk9h5ZsQTK6d9pQWLTvCpPjgMO33zCy1wDgFbIELa8zXJOfPAxUqY8rEQr0ZuAW6WIFnxYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811560; c=relaxed/simple;
	bh=iFo1TTId+XZzgMiJwCBx3pFbNkc3ng8NtWxMTnQuqPY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=RDY22C72Fhh2xup2bgV39g6f/wFNN21fCwALnYmeh168sZWcyH8dd4ZBCJqdIsdFG7tU9lXBmEE16xQaO8v3VJFiS2cv9Sifo5qmKvGVF4Qyn3PAoENojaPI7V9Hb1Au1lby87C1C9MKTuUeHnV7x+tPRUefWJoZKVqXS5PT3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+hpi21Z; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F6C47A008A;
	Sat, 13 Sep 2025 20:59:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 13 Sep 2025 20:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757811557; x=
	1757897957; bh=RYITOHoyGB5+x4cCrMn6wf0qMJEfuTNWVxluHPEGLjo=; b=h
	+hpi21Zmpug+UBWd+QPD8aUYZqWY7zMkeEma1lG8HPqP8nfZlDnIB7xbSno1ZXZg
	+voI9L0/UVkkmyLW8iEIC5XCLHJC9TC0My77fbQP6iFLnOpkIgeJAzr6pOhRSMPU
	I9zHFRa7lD4Y6whzR2c8wShFiQ05NWM1W3FlwSlEGaBKamX8UbLREm0stL7HwfEg
	FJzpmurK5oyyUEwCewTP0aTbJMVhGsrgG/X8YApM1C9G9+sbqV3E7HQeEgLmjJPs
	nj8KVLR0MxfVebQjgGoDiO75YjG+XDX12XNdbA29hpNeVi9tvc/gPEft+1BfOoP2
	OWGM3xtbhuViE2yOzM/lQ==
X-ME-Sender: <xms:ZRPGaAKR38X_wx4CGRc13NVyOst82bqhW1roiOKJUV78IgWFJsXTqQ>
    <xme:ZRPGaGgIu9goJqI0ejweXEGr-VaMI2ZqR176DZLnhDcEz_PRDMOewNgET2uGH0MJG
    G1GYAK0sZRKXHGkVrk>
X-ME-Received: <xmr:ZRPGaM8lAL4antQt0LxHpMeATjrVjtDG9wq_RA9OsNH-XB8BqwEMoHpjEMDIPYlx0KCW23XWOXcNqF2x0tRRKvhiZLJujqpYDZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhioh
    hnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruh
    htlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZRPGaLOyScpoKsehpD252w7cAwpNuKHt5oVNjuVBcZs0ID5J4l166w>
    <xmx:ZRPGaADz2-fanRgvcWETnFmGD1PuinfBTn1YUHa8o5b2E-mTRSh_dQ>
    <xmx:ZRPGaPPComZAet9MiH_2q-9vStjOTu3n0AYkgenq-Y-78xEZqbN5tQ>
    <xmx:ZRPGaHc2ZdqQmhBj7eWtaSgcSZKBZO_w13IQQz35WD3HHufcvhNA5A>
    <xmx:ZRPGaKHJM1CRWFlvuyhuavwykNW_4LwVX-QzeLVKzFPJ0HLbVD94cOJb>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 20:59:14 -0400 (EDT)
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
Message-ID: <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1757810729.git.fthain@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Date: Sun, 14 Sep 2025 10:45:29 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Some recent commits incorrectly assumed 4-byte alignment of locks.
That assumption fails on Linux/m68k (and, interestingly, would have
failed on Linux/cris also). Specify the minimum alignment of atomic
variables for fewer surprises and (hopefully) better performance.

Consistent with i386, atomic64_t is not given natural alignment here.

Cc: Lance Yang <lance.yang@linux.dev>
Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
---
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
index 100d24b02e52..7ae82ac17645 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 typedef struct {
-	s64 counter;
+	s64 counter __aligned(sizeof(long));
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..cd5b2b0f4b02 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	int counter __aligned(sizeof(int));
 } atomic_t;
 
 #define ATOMIC_INIT(i) { (i) }
-- 
2.49.1


