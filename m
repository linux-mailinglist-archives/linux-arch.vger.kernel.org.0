Return-Path: <linux-arch+bounces-15446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81935CC128D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB3A30237B3
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594F2609DC;
	Tue, 16 Dec 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XpOQ7fR4"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC16241691;
	Tue, 16 Dec 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867120; cv=none; b=cBcGGw36r3zBZiYiLpEvLPJipV8y0BQg/i1ix7dkfYGdXPQfUGrd3K/+D8YZZGYXaT6AMwjtHfdIpzKwOZg6owIDfLV2MPD+noIYX5ZEiUR6gGhte+U2hxLyj/bFc9kqdikR3m8XoDlyjCqJ/vwkD6gHvqKJaHQqugV0UQ6wEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867120; c=relaxed/simple;
	bh=+m9ugDvP8DldppU+Xne3BpzGk7erpZucQQE5LNo8A2E=;
	h=Message-ID:From:Subject:Date:To:Cc; b=RNU+7FsotGdNSDFaH/+tvbvUbCVkdp+3wUNoMJpNrPIXKhVyOmmUna49Wi0WuRlmqae4/13vUbNZvLKBtDqtRivBzAtjbPycX/Zcht5KCF7jo9kWQ1IuQcY8veQ3ZJ+JAgfn2LdRIeIKrbREFqw1zyoSImy0r+vR5TFvFjOYeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XpOQ7fR4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA7DB7A00FC;
	Tue, 16 Dec 2025 01:38:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Dec 2025 01:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765867105; x=1765953505; bh=9AoWIhfivy4UOmlDhOIXxucmgxZr
	f7I6w7HEi8HnW/4=; b=XpOQ7fR4p5tZHtVqK9hezAwN0iR7Ej3xwfmj6h2wl0PT
	u9MuVU8odNVKLPmTejjbR9tm0tLsMfB2gQR4Y1taeNrLGJ4J9RmtfIa+EN/Ke2kf
	mXVUOLpq287yxZR0HSgr0D3IdsmOTHe75czX6R5lkMHqw6RvbLHuDio2Y0gft2tB
	R1bbXYMr1fDxRH2qSafqByoj2xw4jUxlLvsJON4NynBzSqjLrn4PO67T6a0T5frP
	LTUCD3jDrT1pyDjgL38j5INN4ETiXILU3RLti2Sg9Ka1Ze34q7dzdCf4jyk+fHpw
	KyLi88ojCydxBJ916IRT6r7PHahEgmz9gom0qrq8zA==
X-ME-Sender: <xms:X_5Aaar7URYpNmvxdK7vDqbW6R6P7_oaHf2HJTdnCKikVNCUkPhVyQ>
    <xme:X_5AaahLqfjIcpa1rNTqZg6H4cZP5ZQ9Ok8cEjBLC758rOxuczwaDz9ZT7ajmecQ9
    m46yAMJ73rKxderSDT7kYnFjyEdwqJSNWgtxyLUB5ZsEYztcSf7Cw>
X-ME-Received: <xmr:X_5AaT1jrnOfUKl0vjVSC-UvATqSRSGwo_-LnF1h1avenvg_DZBpj3eb0eHNLF0ckb1WWH-YzxUiQw7KkJKmdHzbv59Zdo0Sh80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkhffufffvveestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhnuceo
    fhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    evtdeiveefvdffteduheetieehtdekhfekiedvledvtdehkeetieeuuddufeeunecuffho
    mhgrihhnpedujedrqdhnvgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghr
    tghpthhtohepfeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghrii
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghr
    nhgusegrrhhnuggsrdguvgdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghssehlih
    gstgdrohhrgh
X-ME-Proxy: <xmx:X_5AaYZXDuSyF6P66w92xvicPXnobpN8Xpw5UGL-SoWpNjcJ6kN9xA>
    <xmx:X_5AaZ4d0tEF2QN-dZ0E5ohtaW8NEzkP2qNW-oNMvzebmpvRD2rBDQ>
    <xmx:X_5AaWIxt82httcCmTeewHLxbx1ppXqQb7IYiWVXXXYLltDHk8pHQg>
    <xmx:X_5AacqnFu4MPU9Ce6YZ9yUpOSrR6jJZL6j6pWyYsLHxyd_SYhYKxg>
    <xmx:Yf5AaboFQo-iNoPfBejvSJoR0jFweEV6XUdV6-NzhTGNDN6TTNAzEWwQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 01:38:21 -0500 (EST)
Message-ID: <cover.1765866665.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 0/4] Align atomic storage
Date: Tue, 16 Dec 2025 17:31:05 +1100
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Andrii Nakryiko <andrii@kernel.org>,    Arnd Bergmann <arnd@arndb.de>,
    Alexei Starovoitov <ast@kernel.org>,
    Boqun Feng <boqun.feng@gmail.com>,    bpf@vger.kernel.org,
    Rich Felker <dalias@libc.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Dinh Nguyen <dinguyen@kernel.org>,
    Eduard Zingerman <eddyz87@gmail.com>,    Gary Guo <gary@garyguo.net>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
    Guo Ren <guoren@kernel.org>,    Hao Luo <haoluo@google.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jiri Olsa <jolsa@kernel.org>,    Jonas Bonn <jonas@southpole.se>,
    KP Singh <kpsingh@kernel.org>,    linux-arch@vger.kernel.org,
    linux-csky@vger.kernel.org,    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,    linux-openrisc@vger.kernel.org,
    linux-sh@vger.kernel.org,    Mark Rutland <mark.rutland@arm.com>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Stafford Horne <shorne@gmail.com>,    Song Liu <song@kernel.org>,
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
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
 include/linux/instrumented.h     | 15 +++++++++++++++
 include/linux/types.h            |  2 +-
 kernel/bpf/rqspinlock.c          |  1 -
 lib/Kconfig.debug                | 18 ++++++++++++++++++
 6 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.49.1

