Return-Path: <linux-arch+bounces-15616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AACEB87D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E935A300C768
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750C2189BB0;
	Wed, 31 Dec 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5n9Lbs4"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CD246768;
	Wed, 31 Dec 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767169926; cv=none; b=MdBlNSpxxlZZ4YI+JYm1I6/Pgz+/tNSxSCtYV7/bvJM2GjAEtWQ9oQnQGpDZBaqKM02nICWA7OmSkBvtlGBEbiAYC7kJFTMyJ5iVW0yd6nr6wZfVJZs9nssMYzVIhRwcShLgytg/SM48qFsxS2UOVXAT+I+2AdWILf0t2AJHzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767169926; c=relaxed/simple;
	bh=7DcCyNAxIOrE8PfdIo71cf+hyldla10OgBJkDOcbRtQ=;
	h=Message-ID:From:Subject:Date:To:Cc; b=s+ZFFarG607jQffIzkfhk+SNmmFj1b/PBzWvQ9yN67cXoN1O250fN/tn0FyFeCStK4DwMgzQdukur4+VXCsVBK2IkbWrXG2WxBTuBYlzWsLgVCprMRshnm8OWRRLPB877WsaPn+6yTBxTiOK2CR6q0ffLJjKns9lyYIWQlvuHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5n9Lbs4; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 76BBE13000B8;
	Wed, 31 Dec 2025 03:32:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 03:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767169921; x=1767177121; bh=Lb2eWdiKdYUIGHuGDDbo7kxfILv0
	pg03yvKu0vOb+CE=; b=J5n9Lbs4zQ75be3RA51MEYLNsx/D6J6wHE9mjE4Rt+Qf
	15YQS4LRZ1UBtJuj9+PDhm9Im1kyDJOqAwCZ5PcNufD2WbNmN4XKLgfHwPtTGj7s
	jgcL1YphW7FW2JHHjwFz5FXtqz4n2SfuXMAmKzIn5Y08IXkvjBs+DDGcspip5Zci
	cZOmQvmXeCH7j+s5HD3OubVT2LyDYVtPcEcE7uTQKrFsIydtuoj0wuO3ubwwuc75
	/Gbmctq8XdZFrKXpe2IMDda+gJAFYzAbD8xaC8KyIVfS1NjssIF7jKDvrjgpKwSd
	SNRRbSEmluMxhkw8NP1kxqbLfWWhTAYVLGfsVwKj3A==
X-ME-Sender: <xms:fd9UaeiRyKe6EAsts2vuraIWpAGpXYF6S0-ab29iEfg7uIWZsD1jkg>
    <xme:fd9Uab2fCrjO4ugtginziqp8h-lz0CMGt13DuAQ1828yc4hQNJ1Ml-AzEZAwbR_9d
    H_-IiI1UP3mRr9WfBOkp6bX4eLNpAZCkwEvgC4oB9Bk8hKG22PNcsU>
X-ME-Received: <xmr:fd9UaaRW79jsdBtsY1cm8DSOV-NMfoSsF4LSUaTK1lpZOJKtJ14gh1ADzUrbroBSux_Or8KN6wb-zvcO4UoNBdavy_nO4W2C-u0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkhffufffvveestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhnuceo
    fhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    evtdeiveefvdffteduheetieehtdekhfekiedvledvtdehkeetieeuuddufeeunecuffho
    mhgrihhnpedujedrqdhnvgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghr
    tghpthhtohepgeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghr
    uggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpd
    hrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdr
    fhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
X-ME-Proxy: <xmx:fd9UaValjqnDrsAQZyzs-n4h9vaQLYxBBEFAH518d7YwUZVtZhwY7A>
    <xmx:fd9Uaf5eZ4_XVFMc3_Z0pxzB8lW2sV9GCiONli5I5Py9efDA1Rg0-Q>
    <xmx:fd9UaeuA0xIpFY3NulbznfmXRFsySF9OzbhkbNhUMkBgnjiGEBaN_g>
    <xmx:fd9UaR4DSIAE_aLXWohDbPAmv_HVG0l-QieXD8fgUiUIz_pVBIMZvg>
    <xmx:gd9UaSAy4Z2KnDeHIMQ8JvSZv23grHngVf6siI2XZGpH97_SQThrlfqY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 03:31:56 -0500 (EST)
Message-ID: <cover.1767169542.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 0/4] Align atomic storage
Date: Wed, 31 Dec 2025 19:25:42 +1100
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
    linux-csky@vger.kernel.org,    linux-efi@vger.kernel.org,
    linux-kernel@vger.kernel.org,    linux-m68k@lists.linux-m68k.org,
    linux-openrisc@vger.kernel.org,    linux-sh@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Ingo Molnar <mingo@redhat.com>,    Sasha Levin <sashal@kernel.org>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Stafford Horne <shorne@gmail.com>,    Song Liu <song@kernel.org>,
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
    Thomas Gleixner <tglx@linutronix.de>,    x86@kernel.org,
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

 arch/x86/boot/compressed/Makefile     |  1 +
 drivers/firmware/efi/libstub/Makefile |  1 +
 include/asm-generic/atomic64.h        |  2 +-
 include/asm-generic/rqspinlock.h      |  2 +-
 include/linux/instrumented.h          | 17 +++++++++++++++++
 include/linux/types.h                 |  2 +-
 kernel/bpf/rqspinlock.c               |  1 -
 lib/Kconfig.debug                     | 18 ++++++++++++++++++
 8 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.49.1


