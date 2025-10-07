Return-Path: <linux-arch+bounces-13946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507DBC2FE3
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0465219A3A51
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EC221DAE;
	Tue,  7 Oct 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tH93gk6S"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3023F42D;
	Tue,  7 Oct 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881031; cv=none; b=HoXZcUAFtx6H3fM2I3Cg1i4GGLv0wRA1Yq8Ws0mcZUt3iLMtit+jW3NXXrVuvFLDZ2QfEn5moMkTkyl7hIi4iTy2iKrkL1UMnlyI6urcB5GAxohjfjYPK6cO5woa1DrON9B/Zr5SzJOtLmu153bJwxGaJdSI6PlqM9+t01KuBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881031; c=relaxed/simple;
	bh=lyl+Zp+wRGNGv5PQZ4By4Y0d+218NRT+TpI7ZmiPWMo=;
	h=Message-ID:From:Subject:Date:To:Cc; b=JuZtQrGdvHlfAa/VG2j9/mu8mMRqp4Ro/+6EOI/hXr7hUmavlpFApD8nCejSolf5p3O9BqzLf8ZdIB3lsatysZrNHuMxGFlsj3jLvl4dij4yBkt07wKjivVUcjyuHdVXgWy9Sv3Cl323gcKCeFgCz1IhSN5eirIOJwvaCE4Kzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tH93gk6S; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 018191D0019A;
	Tue,  7 Oct 2025 19:50:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 19:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759881026; x=1759967426; bh=cP/vkgZvwLgEDU6kBJJxJkqQv+9W
	OYr9EfQhPjX+cK8=; b=tH93gk6S7kZVQ9b92s/Kh+6oSVT5Ngwa35FFDjogn3Ld
	za3HNeU2/I2lHN7IKrsFBq33WPzEsOn9Bg/XV+EEzUr1n3BroM3GO1Yd8CLc13l+
	BaMIaS3jCPgWNletAiVVg5N1lH3mrzJrbeEUSMGN+AMYiWP9B1K/b9sRXgM0oD8L
	f9aE/2ZBv2dYU46t1ZgC2yEbOViAII+hUDFGC4Ehwmg3mlck8giTGiR4mHzsoBWi
	+BKKqLqzlVwOR/ndq9L9A59CKI0OEyuazf/WiXusupGiekDkhJHbgg1TxAp63tZQ
	0JA9G1CCZY3vMgCrLf/eFFR7IVFKmbIiffwSasMNSg==
X-ME-Sender: <xms:QaflaFABHI_Bgxv1ZD66coBdY0UlFjzA6KedAJspYfeaM8gRM0FmfQ>
    <xme:QaflaEkmi5X0RG3FZqjr4njWzc6RQTFQEUNoRiC3FYjlkbDxfiqUgn_EWbE8hXfS6
    UguVFpLy6UFZM1Bck5sZrV0beyTx82GYjpOUAmD3JqfM3Pkkrb4Sto>
X-ME-Received: <xmr:QaflaDi4eICCMxI1hpbCHtsM88-sPWkZWDlN3_Iwh3RZk_KAnI-qL7t3Y1hAOKYQVlJxP3x1jxw7BTA7swXWpiAxLb1R1-KlCAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffhufffvfevsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehffdukeetffdutedvffffheegtdetkeekfeevgfeitefhvedvtdelhfduudettdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedviedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihho
    ghgvrghrsghogidrnhgvthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrh
    hnugesrghrnhgusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QaflaNcFY9-d34JW1bnQGOT83yHqbltIOgwc1klMCWogRDh0o6OHrw>
    <xmx:QaflaDBi7QbyJKVh3iqdeo45-irPxVwP3nuJ_W4RKk1Sw39bClhzvA>
    <xmx:QaflaB6HzseO8OzGIEbbn5wPhC6UNe1i6XEHu6pF4XJylCJL61SpnA>
    <xmx:QaflaAzUwF4lcix5M2nzUVIaKUbwkjveWPk15iWMTZ-0tQb7PuDydw>
    <xmx:QqflaGvrZdCtK2ZIIySVfdt7xk5JOwwAFW-nTiIPISwhsmP-COEvLl8X>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:50:22 -0400 (EDT)
Message-ID: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 0/5] Align atomic storage
Date: Wed, 08 Oct 2025 09:19:20 +1100
To: Andrii Nakryiko <andrii@kernel.org>,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    bpf@vger.kernel.org,
    Jonathan Corbet <corbet@lwn.net>,
    Eduard Zingerman <eddyz87@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Hao Luo <haoluo@google.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jiri Olsa <jolsa@kernel.org>,
    KP Singh <kpsingh@kernel.org>,
    Lance Yang <lance.yang@linux.dev>,
    linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This series adds the __aligned attribute to atomic_t and atomic64_t
definitions in include/asm-generic.

It also adds Kconfig options to enable a new runtime warning to help
reveal misaligned atomic accesses on platforms which don't trap that.

Some people might assume scalars are aligned to 4-byte boundaries, while
others might assume natural alignment. Best not to encourage such
assumptions in the documentation.

Moreover, being that locks are performance sensitive, and being that
atomic operations tend to involve further assumptions, there seems to be
room for improvement here.

Pertinent to this discussion are the section "Memory Efficiency" in
Documentation/RCU/Design/Requirements/Requirements.rst
and the section "GUARANTEES" in Documentation/memory-barriers.txt

---
Changed since v2:
 - Specify natural alignment for atomic64_t.
 - CONFIG_DEBUG_ATOMIC checks for natural alignment again.
 - New patch to add weakened alignment check.
 - New patch for explicit alignment in BFP header.

---

Finn Thain (4):
  documentation: Discourage alignment assumptions
  bpf: Explicitly align bpf_res_spin_lock
  atomic: Specify alignment for atomic_t and atomic64_t
  atomic: Add option for weaker alignment check

Peter Zijlstra (1):
  atomic: Add alignment check to instrumented atomic operations

 .../core-api/unaligned-memory-access.rst      |  7 -------
 include/asm-generic/atomic64.h                |  2 +-
 include/asm-generic/rqspinlock.h              |  2 +-
 include/linux/instrumented.h                  | 12 ++++++++++++
 include/linux/types.h                         |  2 +-
 kernel/bpf/rqspinlock.c                       |  1 -
 lib/Kconfig.debug                             | 19 +++++++++++++++++++
 7 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.49.1


