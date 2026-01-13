Return-Path: <linux-arch+bounces-15757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10841D16B62
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 06:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D69EA301BCFC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E8359F87;
	Tue, 13 Jan 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVkF3omA"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DB2343C0;
	Tue, 13 Jan 2026 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282680; cv=none; b=au6FPa2818T7diEsa4FSYDbqvH99KhlEvuidKdwyDWWQCiMvgyElRrQ5z6wd1FfyX2uaiOOWCmiT+kqOJLOefMxg7UtQmmEb0bSiYATSk9sTqKZonNeUSt0/5KaMDcbudbnuBhJPjaHstwLEQAEH5IFLqHSqmmLW72bThTVj8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282680; c=relaxed/simple;
	bh=puNEXADyslbCDUE/v5uUZSgeX6mBadwDTQUGSLFJl80=;
	h=Message-ID:From:Subject:Date:To:Cc; b=R01mAg630skoJzIhstX1+y7KNQhgmM0y5c0K8HhXos6Pe2qKw8wu7gD27a8zFsP8F8vRCgAumwRc5gwtFIuoRU6RnFgnaxZUjtLpTeV199Hwm04/TXp9vu0yXk2d7uXfuUh68qtFliAi6MOJ0yjRkOeBItsab114z8/nmZAmpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVkF3omA; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id BE8EF1300343;
	Tue, 13 Jan 2026 00:37:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 13 Jan 2026 00:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1768282676; x=1768289876; bh=SIZTTLX4L6b0H0FhsrLfjIbPTzJy
	CXQADM2Gtk5KlLg=; b=cVkF3omA6kRd1qDwlC/QjBcG/sNoji8l1VMwZh5ITsAj
	IQH6XZmZbiJVGHRbZNI1spqePSMKyrqoDMwwPKT9X9TMQdtXMcjAsyEdPy0ukA+L
	ZDMfLblW0EcIBWBADvSLA/TyX2BJ76a1kqJzcx0V7tJNb+YJgWt26WyVbIZNDovh
	+KfxQIQ8/tQiKcSqZ7RT5cyIeTi3y45MAu/acBvX6U89CV4q8v+CTVDg9HJQiU7y
	GsWTn9e7YKSKZdta713rl4jdQ6gbpZqw0svYrmk0r8Kv7cn5uW0qkBsKgYOlexTe
	z/U9BUOXaf/dlsiRUJjnncK0nDS/gBUsTG2khjBzTQ==
X-ME-Sender: <xms:MdplabFx4HZLJLMziJHDEDG2yjqQPhBzPJXL-QYtHWol7NNEGN-ELQ>
    <xme:MdplafnUsZUQBoeF4TMLPpNBbeOMJ1EI4E5B6pqf71NlUXdjIBACyqf3r5lar53ES
    kQixSPNrmZK3JHIUbpBN6BwF7966HMzXYNKP-5kfaZIR9mRcF-WtWw>
X-ME-Received: <xmr:MdplaVvGJrSgw57AxEir5QXbr8Hf3KarYkVry3b_CgvoDAadbXaqc0rtPWQ1dJj85bqGsM5mKXFgei277sEuAWPiCdT86ugL6OI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffhufffvfevsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    duvedtieevfedvffetudehteeihedtkefhkeeivdelvddtheekteeiueduudefueenucff
    ohhmrghinhepudejrddqnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggp
    rhgtphhtthhopeegvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghriies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    rhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
    dprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhn
    rdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:MdplaWfWDzJqylD0Q-inIpIDSD06wMZgNgisba95LM8ZqH9j-8puIA>
    <xmx:MdplaZapD7buZRwzH-snNYQesF6AwmfpTygoHl_WtRd6-frTzgudew>
    <xmx:MdplabwrPZ6kLZY2A-42jyKbCsUSAnXHPnvAEOkJND4oDJMMrkh70A>
    <xmx:MdplaZuJDr6dR3rUZhQyV3fs-ebQXLUJaLVhJ_WlTWsWT4gY7leaQQ>
    <xmx:NNplaVbhFZWckmFtSGQdtiTPrkO2GI3Doh1qH3ZXcq4wglQsyizSWuJI>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 00:37:46 -0500 (EST)
Message-ID: <cover.1768281748.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v7 0/4] Align atomic storage
Date: Tue, 13 Jan 2026 16:22:28 +1100
To: Andrew Morton <akpm@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,    Ard Biesheuvel <ardb@kernel.org>,
    Arnd Bergmann <arnd@arndb.de>,    Alexei Starovoitov <ast@kernel.org>,
    Boqun Feng <boqun.feng@gmail.com>,    Borislav Petkov <bp@alien8.de>,
    bpf@vger.kernel.org,    Rich Felker <dalias@libc.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Dave Hansen <dave.hansen@linux.intel.com>,
    Dinh Nguyen <dinguyen@kernel.org>,
    Eduard Zingerman <eddyz87@gmail.com>,    Gary Guo <gary@garyguo.net>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
    Guo Ren <guoren@kernel.org>,    Hao Luo <haoluo@google.com>,
    "H. Peter Anvin" <hpa@zytor.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jiri Olsa <jolsa@kernel.org>,    Jonas Bonn <jonas@southpole.se>,
    KP Singh <kpsingh@kernel.org>,    linux-arch@vger.kernel.org,
    linux-csky@vger.kernel.org,    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,    linux-openrisc@vger.kernel.org,
    linux-sh@vger.kernel.org,    Mark Rutland <mark.rutland@arm.com>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Ingo Molnar <mingo@redhat.com>,    Sasha Levin <sashal@kernel.org>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Stafford Horne <shorne@gmail.com>,    Song Liu <song@kernel.org>,
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
    Thomas Gleixner <tglx@linutronix.de>,
    Yonghong Song <yonghong.song@linux.dev>,
    Yoshinori Sato <ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This series adds the __aligned attribute to atomic_t and atomic64_t
definitions in include/linux and include/asm-generic (respectively)
to get natural alignment of both types on csky, m68k, microblaze,
nios2, openrisc and sh.

This series also adds Kconfig options to enable a new run-time warning
to help reveal misaligned atomic accesses on platforms which don't
trap that.

The performance impact is expected to vary across platforms and workloads.
The measurements I made on m68k show that some workloads run faster and
others slower.

---

Changed since v6
 - Test for __DISABLE_EXPORTS macro instead of __DISABLE_BUG_TABLE macro.

Changed since v5:
 - Added acked-by and revewed-by tags.
 - Added a new macro to inhibit emission of __bug_table section, for the
 benefit of pre-boot code like the EFI stub loader.

Changed since v4:
 - Dropped parisc header file patch as it's been merged already.
 - Submitted as PATCH instead of RFC.

Changed since v3:
 - Rebased on v6.17.
 - New patch to resolve header dependency issue on parisc.
 - Dropped documentation patch.

Changed since v2:
 - Specify natural alignment for atomic64_t.
 - CONFIG_DEBUG_ATOMIC checks for natural alignment again.
 - New patch to add weakened alignment check.
 - New patch for explicit alignment in BPF header.

---

Finn Thain (3):
  bpf: Explicitly align bpf_res_spin_lock
  atomic: Specify alignment for atomic_t and atomic64_t
  atomic: Add option for weaker alignment check

Peter Zijlstra (1):
  atomic: Add alignment check to instrumented atomic operations

 include/asm-generic/atomic64.h   |  2 +-
 include/asm-generic/rqspinlock.h |  2 +-
 include/linux/instrumented.h     | 17 +++++++++++++++++
 include/linux/types.h            |  2 +-
 kernel/bpf/rqspinlock.c          |  1 -
 lib/Kconfig.debug                | 18 ++++++++++++++++++
 6 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.49.1


