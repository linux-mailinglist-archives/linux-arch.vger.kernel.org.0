Return-Path: <linux-arch+bounces-13568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC05B56412
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 02:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765CC17778D
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18531D618A;
	Sun, 14 Sep 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSwjvNXw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2401B6D08;
	Sun, 14 Sep 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811516; cv=none; b=R0PRSE0ttqSgwdxPd7q92M1RiVK46g9SLvd7gR08e3yRGkeMWm0LWRvunTX0KuQQaCWCIQ4/lUM7d4tQ5+52ud6c+4hyU18oIUQ/tpvO7ehK+n6hBXUuaFBgGjBZXvlUZlMYBLHnDQ22kjr3bKDFQxixdzk+C1enJXRkKAazWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811516; c=relaxed/simple;
	bh=ir66o0pXRjHBVjrWNEo5dzT835FcKFxnUCFGo/I526w=;
	h=Message-ID:From:Subject:Date:To:Cc; b=cZIpfwSA9nUUfxZowjqjHXBSN9vZ32hwAMNBvrfJLcjExeeCMLyBjX9cwu8uFAC+/8KbOZ+pjYPO7HS3a0lmdr2rS2reXvwkCbnGQ2BwHsaQUPIjoRhElx1Er6gydhSFk6wob7IZmKNgODbBjS/12/cSEChG6vEgpm3xCAz+osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSwjvNXw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB7757A0089;
	Sat, 13 Sep 2025 20:58:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 13 Sep 2025 20:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757811511; x=1757897911; bh=WKuWOh9Nr25uJ/eG7zP6c69z1t/r
	IXLyvt0ffxnVwpE=; b=XSwjvNXwduL2xTOaS6qWpL4mLjejsjcK8qkQXSUXwhAE
	X7+2bSmJCCJZRxVHAB8yxN/ix4Fh4mIc3aupWJiPGlSTZt/AHYqPojWE4ASCUyRs
	2DaVhBEZZtWjr9SaYgVOFxr87B+Tutv7WVVwTCpyq+0iVz4FKlB+Tzj2a+YPnngU
	pch2XSEMtL/aNhnAZXZrmLPz/XlgkOTdkSCeO7ojStdd2guyisF3fNJZ0gpKgyOT
	W8L6fHYU6hNU/hfehacuQoVuuUFRjVHknLjcnAh7VfvW3QbbXDEPLI2OhD0mujvh
	j2oy6dDlVgHVMBxklBVvVGeDa4lFwJzj6OaUeOx51w==
X-ME-Sender: <xms:NhPGaNEJSurp1ggmjTzZO1Kyi315diw3YvM9OO0HVX4O7oT7DFtoNQ>
    <xme:NhPGaIQV9A1Q4dIvhq5RdXRefS8O8nV4XeVHknNNpkGYMVEvgx0pqISnoe3EeIY3i
    05V1LwDdSDWhQUWvmk>
X-ME-Received: <xmr:NhPGaMRgX--6lnrhS83FsW_KKa_13rZz1BPcrZJt8KzO3vmlj-91iK9oUaPAOaX1pR6VlFPz7egaE157PIiy8AW-u5Gp4oSWqyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkhffufffvveestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhnuceo
    fhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnhephe
    ffudekteffudetvdffffehgedtteekkeefvefgieethfevvddtlefhuddutedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnse
    hlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnh
    gusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NhPGaD1WJmJQW3FnS46ArHNX_jFMVG8t_UrlPj4tdwKHUELJKc4Epw>
    <xmx:NhPGaOzRs68dpLpA2rP4rAMvGzIj8xyt1HbblO3NHgcD7sdc2anlTw>
    <xmx:NhPGaHxMqAVmJKZya9OBoBuq2ThaKZh1xtykFFqFTQ4yZjlq8z46ag>
    <xmx:NhPGaC_sdUVVi5IUAHDKyrGuqcz0_pCVhEogJ4jdrlBgFNy5tqs9xA>
    <xmx:NxPGaIg-_IeEWLXkgiBvmVgIm4DIVxcHySXsvFUwqEOW9w7-z0tGUS1p>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 20:58:27 -0400 (EDT)
Message-ID: <cover.1757810729.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v2 0/3] Align atomic storage
Date: Sun, 14 Sep 2025 10:45:29 +1000
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This series adds the __aligned attribute to atomic_t and atomic64_t.
It also adds a Kconfig option to enable a new runtime warning to help
reveal misaligned atomic accesses on platforms which don't trap that.

Some people might assume scalars are aligned to 4-byte boundaries, while
others might assume natural alignment. Best not to encourage such
assumptions.

Moreover, being that locks are performance sensitive, and being that
atomic operations tend to involve further assumptions, there seems to be
room for improvement here.

Pertinent to this discussion are the section "Memory Efficiency" in
Documentation/RCU/Design/Requirements/Requirements.rst
and the section "GUARANTEES" in Documentation/memory-barriers.txt


Finn Thain (2):
  documentation: Discourage alignment assumptions
  atomic: Specify alignment for atomic_t and atomic64_t

Peter Zijlstra (1):
  atomic: Add alignment check to instrumented atomic operations

 Documentation/core-api/unaligned-memory-access.rst |  7 -------
 include/asm-generic/atomic64.h                     |  2 +-
 include/linux/instrumented.h                       |  4 ++++
 include/linux/types.h                              |  2 +-
 lib/Kconfig.debug                                  | 10 ++++++++++
 5 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.49.1


