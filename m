Return-Path: <linux-arch+bounces-15618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5CCEB8A0
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24801300984A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD313126D5;
	Wed, 31 Dec 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wypE0iwm"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD74267B89;
	Wed, 31 Dec 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767169945; cv=none; b=fK3kZcynBPiLJ6OOv7XgqntPgHhGg5lj5H+Xr6GXGGh7qaI/00whu1iXVJczefx9wrVdapsvqcAexidw0iJyn43ylUANKK1H9wETNCxaGC0ci8cJTW5FhL39wM1F7pxC/xKFalvRd3Cf4ZGVko7fHDYmUMiAYtNv+yPgzC9GF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767169945; c=relaxed/simple;
	bh=j7setGtZxKj0GpDffae+KtqWqssWmlZc0B7lMZPOSAI=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=paLTuKBdfrObaIOhrorL7M5xlRYIqYOHHXD7q/FF0rPxfsQ80qZ62BuWNFifTH21FfY8acy6qHSbH+1HUWLtaqQnHngv6p7VeueZEEeq4247u1R5YxApGKuNANrvSNHXzVO6QgsFa1BB2v9T16RaYM77i1VWtFfKu1CJ9+2IupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wypE0iwm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F2E67A008A;
	Wed, 31 Dec 2025 03:32:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 03:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767169942; x=
	1767256342; bh=vBuKVea7vxP3Xqw+0VhXZu0Nuyaahlp6eJXWokICzlg=; b=w
	ypE0iwmRaLxYjHF9ptlWaLGVQ7qc/E6hZPji49twgiSo2Pb4hbVovN2SvLx4MwBH
	BRSvNx9oQYjaYsf8R/nolfANNWqq6WVUR5dDewntajqPn6xdrX1+V/64l4m424or
	L7zRWiMd3jUQWjqBjaCi8e5jAjJdvy2L34iKiAc4Jna99Y7ZSJ6m9gQyPiTPe33a
	btGHqbPNyT2alIICDF22hLN8qKSFKRdA0Tmj6TZv19Ymwkwq3xe/K+7XeVTqNLcp
	8AfneayDDsoZZTfraNTyrqShmuIix2kiYAbpMh3FtGkBxLFcSrNLilcKkDSKDXEZ
	nXOCdQp/E5bqEerHa0sJg==
X-ME-Sender: <xms:lt9UaSK6upfCCqQ3Pqu_dLGScHGQuppu_FvP409tBSib7WB8NZC8Iw>
    <xme:lt9UaU7dP8lGaYrRSKA1KZj95DloGDJy3CO67jRSqXN6hAmF3shfzfZEmtzKIPrrh
    ezdkk6Xou1a-YoKivmc--KtL7uPKu9W3Lj9mJ9GpDwcwgHS7MfJM1lC>
X-ME-Received: <xmr:lt9UaRkekMVDpB3hlVM0A9BsDtPNt1g67zOZRtsDxOzTuoXmZzud85KDUkmt_rw_pCG0Mt4tBiiNagGWZtKTdYKR6nQbFKs6Ip4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefggfehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
    pdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:lt9UaeKfu6I7QtKkYyIQw7KSlgn0msDnq8BCUGabFsTQPvEyfQX1mA>
    <xmx:lt9UaaFmCgoqXt27cMI9sBDOyRr3kSZ4zL15K8l77mlZc8fSXLIlnw>
    <xmx:lt9UaXOYyyEpFsnrorqF5YqmfhhBJI41TcNrUkxm4XbvBDDAanKagQ>
    <xmx:lt9Uac9LhwTUVjiFZqm2tSeYrnwrsa3UKEk3DQ4fupqmtlF6afpwWg>
    <xmx:lt9UaYpPGrCBWtUZktSZOgeIPs0D2bXpSlvp9HqD5bM6HPyOPlyCyZTA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 03:32:21 -0500 (EST)
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
Message-ID: <88df424bfb93bdabe73bf91f5985c5b89f04d123.1767169542.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1767169542.git.fthain@linux-m68k.org>
References: <cover.1767169542.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 2/4] atomic: Specify alignment for atomic_t and atomic64_t
Date: Wed, 31 Dec 2025 19:25:42 +1100
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
Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v5:
 - Added tags from Guo Ren and Arnd Bergmann.

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
index d4437e9c452c..1760e1feeab9 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -180,7 +180,7 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	int __aligned(sizeof(int)) counter;
 } atomic_t;
 
 #define ATOMIC_INIT(i) { (i) }
-- 
2.49.1


