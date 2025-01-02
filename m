Return-Path: <linux-arch+bounces-9556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D39FFE8E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC21E1883A52
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95161B87C3;
	Thu,  2 Jan 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="C0n+W3pE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpNOhL57"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729661B652B;
	Thu,  2 Jan 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842883; cv=none; b=jRAKIbpMhrzuCoqpi3kuQHbuE5f+yEiJrUJATPOK6c9MaR8YXyKyi3Ot5e+7666ywwXAKvcPaM9nr1gbwT10xYvrIwEn7882NZv7ICAvl2yxRlU/tfMNt3TDsarzgmAkKtgDJjlaA80ug9UwDrZBerNswazYD3tSZ2C9F/ng5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842883; c=relaxed/simple;
	bh=iGbFf7yE310Qf5wE69W+rLuaNjrCNo9z7+lX5168IoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R9nBN2w28KsYg64lzetHr0G0eMJpvOdSnRAZFUPnHA8H8o5OM7BIJY5ejMExjnIUPkmtvLTFDDG3+gBSB8BD4+L3cD72daZ4uFNH2sGtoblzyx3cEfjL+FQozDGfLZ4VIKfJE4D7H4l6b7OHCgTIE6bbbGp4CfszhSQ+hfw/Gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=C0n+W3pE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gpNOhL57; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A85F1140194;
	Thu,  2 Jan 2025 13:34:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jan 2025 13:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1735842879; x=1735929279; bh=+O
	ikN0pu5xQBs+6DiwtjQm0qzeBit393eT2AAuNyaWI=; b=C0n+W3pEUvrqomIA+Z
	+YqjWo2+NLv1E0NqFCfUuHyoI8cZ10kffHdk3O9dJn7oiu8lGjoUriwVu5osuY1t
	Kk9Vb+EqGsqTGso4x8G26dexed74/KNpMbJD2uF/jNaFVz+vjESkSWfvz5IDBDg0
	NPDFlMvgFE1NbzO25uRyMdDyL7Qw9t4pPqh10GxMnG18IeAX0nHUtG7+xFAe5kac
	8pJAl++K5AaglGclxX7Oo4vVaUUbFWKIGIXG6Fdy8ktFdAXws8VMBiEQBQ2oiX35
	M0YwxoTaH4LUMG4gNJiEJZnFbQibWrDtx4h8z5M4dkQV8ObMV7a0eZrKfL3+8Ci4
	Qz8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735842879; x=1735929279; bh=+OikN0pu5xQBs+6DiwtjQm0qzeBi
	t393eT2AAuNyaWI=; b=gpNOhL57Gbjt774epwINdza8jWODx/Ii25B+8gRfqcGe
	nTryj5QCt3FFWOnbHdz7LyfUqjSqAIPg2FYS13KOkyCftM9AR4GZZ/jNPT34Ko94
	Vjou/NKuKaLegy/7rNVy015zWr3xb9WK1/TKhvcnhpHAGLM04OOUgLJ0Yr4UGGmv
	7yH66BjYrGjB2r145p/bjNq79mKM8w6XiWblHyLFqEKhhDn6UVDrlNnfze81rqZc
	A6ZlMr+RNO7Cioa3HAiKaSjwgglw5kdapKPMIAUX7STPDmD59hdeA+mtha9zcNpV
	GvttXQk8F/HZwaEbf3EXO/azOuKv++4SL5ncNJeQMA==
X-ME-Sender: <xms:P9x2Z4cFVubdTh1KR7VgtJPsLKlKhYaQ6plw9ZVbm7yhi7raPa6i4A>
    <xme:P9x2Z6PAAc6mMEUfJyUtKcS1WK1wivuq-hNHnAiX_lPLs14ez8gvTKc0OEyuTsSvC
    X6_IWayNhw1qt-z43E>
X-ME-Received: <xmr:P9x2Z5jPdTFRK5Uw5S5w8ycDe8rChdasthmFHsVz0IvoR4TbW4KVWULI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhmqeenucggtffrrghtthgvrhhnpeetteeukeejfeetueeiueelveegfeef
    kedtledtkeehleegvefhheetjeeltdfhjeenucffohhmrghinhepthhsihhnghhhuhgrrd
    gvughurdgtnhdpghhithhhuhgsrdgtohhmpdhgihhtvggvrdgtohhmnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghngh
    esfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtoheptghh
    vghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnh
    gusgdruggvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:P9x2Z99fr1xsaPZYkZR6-J21XDO2WZesVILvZltZApGE05wd2RZTrw>
    <xmx:P9x2Z0vwpQaPmqJucmGIJb2d1mjnn24QdX4Bs2UUPDiJD7ULS4roTQ>
    <xmx:P9x2Z0FOlfoqjlo1F0r_9O2jsYx2T657XG7vIrzvIwd-tdMxwLpxRQ>
    <xmx:P9x2ZzNJasqbzzWQinWE_Usc6upkrSeTeBgBiUDe3u_jilpllXSljQ>
    <xmx:P9x2Z5-5OK5EGcgPRDZpHekYgbTts8KoMNv_Iq-cb0duWGXIxFdbVju9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 13:34:37 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Date: Thu, 02 Jan 2025 18:34:33 +0000
Message-Id: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADncdmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwMj3ZxEYyPd0sSCTF0LY0vTVAvjRJNUCwsloPqCotS0zAqwWdGxtbU
 A5BmBy1sAAAA=
X-Change-ID: 20250102-la32-uapi-8395e83a4e88
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3723;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=iGbFf7yE310Qf5wE69W+rLuaNjrCNo9z7+lX5168IoA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSyO3alDU+Ej6dZ371w5EDp8jWPoqt+Krn2xU1gSPdV3
 ywjP3VnRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzE8BUjw99a65yXy10fMj5d
 LffpjfjqHXPUZwQsSIsOe6cZPD9UMYGR4UXbivkRqva8K9dKFK2IbtlZfvhwYFy2qLPa5h1v5zB
 eZAAA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

This series defines the UAPI for LoongArch32, marking my initial step
towards upstreaming support for the architecture. Once the UAPI is
ratified, we can proceed to scrutinise various kernel components to
enable 32-bit support while simultaneously addressing user-space porting.

Why am I upstreaming LoongArch32?
================================
Although 32-bit systems are experiencing declining adoption in general
computing, LoongArch32 remains highly relevant within specific niches.
Beyond embedded applications, several vendors are actively developing
application-level LoongArch32 processors. Loongson, for example, has
released two open-source reference hardware implementations: openLA500
and openLA1000 [6].

The architecture also holds considerable educational value, having been
integrated into China's national computer architecture curricula and
embedded systems courses. Additionally, the National Student Computer
System Capability Challenge (NSCSCC) [1] features LoongArch32 CPUs, where
hundreds of students design Linux-capable hardware implementations and
compete on performance. This initiative has resulted in several exciting
high-performance LoongArch32 cores, including LainCore[2], Wired[3],
NOP-Core[4], NagiCore[5]....

From an upstream perspective, we will largely reuse the infrastructure
already established for LoongArch64, ensuring that the maintenance burden
remains minimal.

Porting Status
==============
The LoongArch32 port has been available downstream for some time, with
various system components hosted on Loongson's Gitee[6]. However, these
components utilise an older downstream ABI and fall short of upstream
quality.

On the upstream front, LLVM-19 now includes experimental support for
LoongArch32 (ILP32 ABI) under the loongarch32* triple, and efforts are
underway to enable GNU toolchain support. My upstream-ready kernel port
and musl libc port can successfully boot into a minimal Buildroot
environment and execute test cases on QEMU virt machine with clang
toolchain.

Thank you for reading. I look forward to your comments and feedback.

[1]: https://www.tsinghua.edu.cn/en/info/1245/13802.htm
[2]: https://github.com/LainChip/LainCore
[3]: https://github.com/gmlayer0/wired
[4]: https://github.com/NOP-Processor/NOP-Core
[5]: https://github.com/MrAMS/NagiCore
[6]: https://gitee.com/loongson-edu

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      loongarch: Wire up 32 bit syscalls
      loongarch: Introduce sys_loongarch_flush_icache syscall
      loongarch: vdso: Introduce __vdso_flush_icache function

 arch/loongarch/include/asm/Kbuild          |  1 +
 arch/loongarch/include/asm/cacheflush.h    |  6 ++++
 arch/loongarch/include/asm/syscall.h       |  2 ++
 arch/loongarch/include/asm/vdso/vdso.h     | 10 ++++++
 arch/loongarch/include/asm/vdso/vsyscall.h |  1 +
 arch/loongarch/include/uapi/asm/Kbuild     |  1 +
 arch/loongarch/include/uapi/asm/unistd.h   |  6 ++++
 arch/loongarch/kernel/Makefile.syscalls    |  3 +-
 arch/loongarch/kernel/syscall.c            | 49 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/vdso.c               |  2 ++
 arch/loongarch/mm/cache.c                  |  3 ++
 arch/loongarch/vdso/Makefile               |  2 +-
 arch/loongarch/vdso/flush_icache.c         | 50 ++++++++++++++++++++++++++++++
 arch/loongarch/vdso/vdso.lds.S             |  5 +++
 scripts/syscall.tbl                        |  2 ++
 15 files changed, 140 insertions(+), 3 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20250102-la32-uapi-8395e83a4e88

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


