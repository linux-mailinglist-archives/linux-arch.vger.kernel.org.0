Return-Path: <linux-arch+bounces-13947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD8BC2FEF
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00ED4ED5FE
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1F2550D0;
	Tue,  7 Oct 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABj6y186"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AF255E26;
	Tue,  7 Oct 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881042; cv=none; b=HqVBFkbGRyVrm8bGQnjCIRdyv0Br+EYAwfeBcRzQU0C+nX+XsZmOHVuEfNG2Y4wZDc6oXizmOZ+WB6qxnFFXFnLkvVuoB2oaZXowwUh0SgAJ+UXI8MXdhTdKYHS32Qsn2BR9m7KUgt5y0ArG3/H2veVF+Plpugcf83KdeLoA8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881042; c=relaxed/simple;
	bh=o9lkQbbpBibFWvTNPnvl9IY8JEMBKOvXU3P9W52BYN8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=p3LqmQvzUCcxAtnItPaRefd31FttJoq9IiQtPWvcsUItKU4HsIFbVGVukx7Aj50qxQH4wCVY3I+GlCAggKepqluG21CvPhnSbtNa+cdyIqKSqSg6KEmxYkKsC3EYDu63/9JcbigaC9drMw3l6vbS0jAa4Ck9GA7fSKtpEo1iSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABj6y186; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C8B01D00112;
	Tue,  7 Oct 2025 19:50:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 19:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759881039; x=
	1759967439; bh=deVHNxmHpB/t+ufTPYero2jLsQQUFKf8oNfpE3SPyRM=; b=A
	Bj6y186vePPkbC31PDNQ+ZMcws/90bwULxcYHVuM0LMT2wFqZkFx2jrJk+kAgboo
	3Gfo9YWdBlT02aLCAx0ViCacdpdrpV/Zx3fIAyge/5kCx2RtuR5sMj9jD4RCB9CV
	ksAFY4cpbSZ4ek4+2lfepVj1MfzTbfcDrEggNUKBhM3zeHh5B8BlWcVfLPdu4jRV
	wq3bh1ilU7Ao5VFmT8KBtFZZeycnaXPRIW1uRiQepwxGS5dB+wWSF+WR8HBzk1kZ
	JjOe+q9uToejANPrXzuLP8lictMgrw8cXfrw+q09dJYGbGAZCXVHOponELLU78gY
	9KfL8140vouhvAwHKLUJg==
X-ME-Sender: <xms:TqflaIleFJNlqHj2l2M-j4jYPGZQtS8wOtzsOp7VFdPUo6Wh7T0mcg>
    <xme:TqflaOPUUTMF9-KtoZnuDZIq4d43hSXikFbgjksbX4mNvurclnnVUz9wqFCjlOoFN
    HZEetCyhekoRXFWXFS6tkUJ3FAfmIiQkln4-Md-lOuOQ_MOx7cerg>
X-ME-Received: <xmr:TqflaC64T_f8yAf4YnAW3xC6aD18TCbiXQNqrkN_3RLh1ex1dp_JFjt0r28Z8LLqw0t7Ycw5gXjFq-JnR3Ah3K-N6tdc2xgkQrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhn
    vghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TqflaCZfQADNHX3JTcGuLbBUMCBZiZHltEMTsZEYChGdr16SyUwrRg>
    <xmx:TqflaPex1jSIqytP_nu-IrZfayYxOiYBGFG_xwAWR16D0CimCqJQEg>
    <xmx:TqflaB78q7Jdvx1IROcHo6JUrIYU2HOd8OXUa5chgdEv4qsJ3eRfoA>
    <xmx:TqflaMYvU4EzEIf3VQhNvtS5e3oYgkoJEiLqpWADYBoRS1h6mnQNyQ>
    <xmx:T6flaL524iOTGmMzdOKCgjYNSs-fLDd0gRfPlh41aHawVqTeB0XzC9RG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:50:36 -0400 (EDT)
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
    linux-doc@vger.kernel.org
Message-ID: <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 1/5] documentation: Discourage alignment assumptions
Date: Wed, 08 Oct 2025 09:19:20 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Discourage assumptions that simply don't hold for all Linux ABIs.
Exceptions to the natural alignment rule for scalar types include
long long on i386 and sh.
---
 Documentation/core-api/unaligned-memory-access.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
index 5ceeb80eb539..1390ce2b7291 100644
--- a/Documentation/core-api/unaligned-memory-access.rst
+++ b/Documentation/core-api/unaligned-memory-access.rst
@@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
 When accessing N bytes of memory, the base memory address must be evenly
 divisible by N, i.e. addr % N == 0.
 
-When writing code, assume the target architecture has natural alignment
-requirements.
-
 In reality, only a few architectures require natural alignment on all sizes
 of memory access. However, we must consider ALL supported architectures;
 writing code that satisfies natural alignment requirements is the easiest way
@@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
 to pad structures so that accesses to fields are suitably aligned (assuming
 you do not cast the field to a type of different length).
 
-Similarly, you can also rely on the compiler to align variables and function
-parameters to a naturally aligned scheme, based on the size of the type of
-the variable.
-
 At this point, it should be clear that accessing a single byte (u8 or char)
 will never cause an unaligned access, because all memory addresses are evenly
 divisible by one.
-- 
2.49.1


