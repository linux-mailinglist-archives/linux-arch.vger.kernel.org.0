Return-Path: <linux-arch+bounces-15759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59361D16B86
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 06:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4A3303F7C2
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729F35BDBD;
	Tue, 13 Jan 2026 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByJH5Iks"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5A2C235D;
	Tue, 13 Jan 2026 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282705; cv=none; b=shg62/AD+fwstuqeEuxv4eRrz33crhwdM3DFiO2oulN7+MVn6FfzDrAo3sLS4YPG7B91ThtP961cvU8vPN0fUYu6F1so5XS7y6So+oePfN2GL+SrTA2LsWZzbKdTc3iGli87643Xh0lW+VwLwy6mgiZu3z3+RglCBr2UwgVZSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282705; c=relaxed/simple;
	bh=TVBYg+2G0DLr0zMyrc3vdOsG1553YTGNnc2V942V/Bw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=mVyu03FPbDLB9VZ9MaJ9G3bsWfHlCUxNbD0vJlMhoAy2H9Wl3LDwIzFGYANl24Us8bW6Gs6BFW2y0Su+BITePePVZ75PEI1VvMwKcxGcGmhrabvjJU8nLhpPtB5GSZl3HWP79HFnOTPywxyzPz682y2Fk311y707BSCX3ugsWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByJH5Iks; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66C077A0095;
	Tue, 13 Jan 2026 00:38:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 00:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768282701; x=
	1768369101; bh=CsktC8xD5EhNAbS2AjeT72YR6CfdK+yufEdKYFi5oBo=; b=B
	yJH5Iksp+s2dl2BeWNT3+0GXbL4pFiKVsqQIuA5LP7MZcGQPzrzLzVVOY/gd3jB7
	DmdH4tLHsdFYTg3Y0O6peSyDn0ebLh8xGPCX+ho0WzIBPgL65IsYmgyqitQUURwH
	/UHfYmmrpcfb2An26uoJHQRjteEsb7QbKXjia2ULzcAq+AADrr7AzXwqZYBAbIOm
	HQB8KFZzG5l6WyzfjbB/74WUFrmGduqob7rlQ7/kPkK5xe4itM5h2ZQWE92+225X
	8KzYvdr9wJZC9pFsglfdGzZL++P//5GUy5cWPxPl10jcySHCK5IOyUMMp5ZamB82
	/XkQWKFU71TrkZn2cCRPQ==
X-ME-Sender: <xms:TNplaYOFuJ72KZUAG0ulz69EqOhU01dAjDDulhURWBqgEavESR064w>
    <xme:TNplaT1-mQ3vIbDaNNosfmD80vpyZxnzgwPd1_Pdjeyfy1b91N4HD89JLAsVwDbpE
    xjM-6PFjLcLNb5ALX8QCrw_h9Tc0KJNEns1CtSG0QkxtQWrmZGFKc13>
X-ME-Received: <xmr:TNplac2eLVCFtcNAlMuXVlC6MZKm-2jTkjB1GhueunvBTiO7O973ouH9yxL8PLOJeHZPq4n3eN8zZIQoX6ToHNFOL9cGFfE93us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:TNplaSybt1dc4nXV8Pbz5hJaaI8SMS2x8qghwV2UQMV2q-pu-gVOpg>
    <xmx:TNplafnybh97IHBbMMTouPbWixNMjTiIASA_c-HPv6qmXBSyPkRX8Q>
    <xmx:TNplaWxxP8odMBWvLSqZxW2SvHAKMPYI5uK1dXnEAxhjl_p0wenkZg>
    <xmx:TNplaeKSN53fJ2BOOKvOOf481cgZ2jZN9sTnx-K27QucyPiSoQ1ZaA>
    <xmx:TdplaRTwYJPXw5r5bc3N6CnGoFRLJjc99VVeZSkMC3liyzQ6EZTDbsGR>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 00:38:19 -0500 (EST)
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
Message-ID: <a76bc24a4e7c1d8112d7d5fa8d14e4b694a0e90c.1768281748.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1768281748.git.fthain@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v7 2/4] atomic: Specify alignment for atomic_t and atomic64_t
Date: Tue, 13 Jan 2026 16:22:28 +1100
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

See also, commit bbf2a330d92c ("x86: atomic64: The atomic64_t data type
should be 8 bytes aligned on 32-bit too").

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


