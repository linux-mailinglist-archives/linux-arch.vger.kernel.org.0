Return-Path: <linux-arch+bounces-14233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E58BF3EDF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29E51351B77
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69382F546D;
	Mon, 20 Oct 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8lrsUcd"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97762F5301;
	Mon, 20 Oct 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999758; cv=none; b=U8HnKLloM8hX3cJUvOHHMKi8eLA2FWxufqsLRdyVp3MAn12RUNm4o9ZsljGvu5imVJbFB5hLWWJUZtrgGxws5NZNSPeCpvZIWvKGWyIb/smaArTQ9BT2Ue2OUYBEMkeK86qk5hnxRmR30mO065W8BRc9TgiZNLorgv16pZf0Dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999758; c=relaxed/simple;
	bh=z7VO9YALcMuks9K3N5YvpPrFdoIjEl3cTk4Y51zyFiY=;
	h=Message-ID:From:Subject:Date:To:Cc; b=CrrO+PadM8jhLwYlkSP+ueHg3bh4ur6sOKyxhMknxqYpGQABiQ/GDuKnW9wyEtE3wh3gpJLO8OfGUAeT7qp/EfoAx9aoxwEeHp19wk43Yrcb4KN9AXYTDQmjDRArIN+iVM6Qu3ofWUFjyeolGhIoP+8O9j5dHz3LEUeXa3/6hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8lrsUcd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A5321D0016B;
	Mon, 20 Oct 2025 18:35:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 20 Oct 2025 18:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760999754; x=1761086154; bh=WbKJEdG21clYm0wc8Wne2Sbd+OXB
	PgwJrowUTp5Q/E8=; b=D8lrsUcdgdbChRnbqU8+J4ul97nvFi37TYAhVROEGFGF
	zZ/iyiYLXPekaF2cIeNXWefZ8ao/ga9awnqpPYSsfmiQH4gDo6fMomtfi1CnPyHZ
	o4pBooZ1/PaScmU2vqjn3ghpvzNb4JQGUdoBL3xLmZ5WKgrmipnrGjq4OZg2qYCt
	RgunsNxw2eYDsN1iU6ozWCn+ZbM0JaVK7VViNNUfOSumlksjLatSntCPjpDDgnWD
	l4Vf6Nmn99I1UYfyYMVFs2JSe3iSBVsJ8eMnO+p3Z+tREmv5Q8azMzyVapO91cLb
	R9lPjCoq0bviv8eS7H/i08DES+1/raU/jxCIoa5J1g==
X-ME-Sender: <xms:Sbn2aPFwXyDWB6rBB6_MmTCNsuua4ZSGUBL6YQFAe8bDHVQCWw18Kg>
    <xme:Sbn2aIRbjO1rEYuSkAXZ9X6108oosFsXj09nZMIdm7vCumsLnMs3XDEZLdgZiuQ8c
    j7wJj4uRdwkEW8IdI0Se99wnVoC2_IecFEzNj000NzKAK6fM3nDycM>
X-ME-Received: <xmr:Sbn2aHQrjdceZiUFsqKygDBsNtdBGDxtqV3R9Tu7hA1xaanHJPrXa_igYDgJlI7pNEju3lo4xhDImkgreBhnepmK0xu_xITPLMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffhufffvfevsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    duvedtieevfedvffetudehteeihedtkefhkeeivdelvddtheekteeiueduudefueenucff
    ohhmrghinhepudejrddqnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggp
    rhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrmhgvsh
    drsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgt
    phhtthhopeguvghllhgvrhesghhmgidruggvpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnuges
    rghrnhgusgdruggvpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Sbn2aDeRu2WihSf1EEsDccScZ7aFH2Xos4Uk6YS0MenxQ_4A0z8ogQ>
    <xmx:Sbn2aDfxx3IXMPtbxY-3lJ6xYA5x_i2XNs-Bh6bB_w90LV0VOV690w>
    <xmx:Sbn2aB-6tS8KPC6okonTAsWKEmtMbNrDIIZ_vJwG3L4_9nB8UC-2fA>
    <xmx:Sbn2aLM4y1Y4jCZ2w-yqSgD3WYuyzvi6zPRahZDxwpV-xZzoV3gMKQ>
    <xmx:Srn2aIDyCR_ZROGkcgoSk6sDlJMCCRQSH6uKa3KcBkTKenGfFi_TY_HY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:35:51 -0400 (EDT)
Message-ID: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 0/5] Align atomic storage
Date: Tue, 21 Oct 2025 09:28:04 +1100
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
    Helge Deller <deller@gmx.de>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Andrii Nakryiko <andrii@kernel.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Alexei Starovoitov <ast@kernel.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    bpf@vger.kernel.org,
    Daniel Borkmann <daniel@iogearbox.net>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    linux-parisc@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This series adds the __aligned attribute to atomic_t and atomic64_t
definitions in include/asm-generic.

It also adds Kconfig options to enable a new runtime warning to help
reveal misaligned atomic accesses on platforms which don't trap that.

This patch series is a Request For Comments because the alignment
change is a time/space tradeoff. Its costs and benefits are expected
to vary across platforms and workloads. More measurements are needed.

---

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

Finn Thain (4):
  bpf: Explicitly align bpf_res_spin_lock
  parisc: Drop linux/kernel.h include from asm/bug.h header
  atomic: Specify alignment for atomic_t and atomic64_t
  atomic: Add option for weaker alignment check

Peter Zijlstra (1):
  atomic: Add alignment check to instrumented atomic operations

 arch/parisc/include/asm/bug.h    |  2 --
 include/asm-generic/atomic64.h   |  2 +-
 include/asm-generic/rqspinlock.h |  2 +-
 include/linux/instrumented.h     | 15 +++++++++++++++
 include/linux/types.h            |  2 +-
 kernel/bpf/rqspinlock.c          |  1 -
 lib/Kconfig.debug                | 18 ++++++++++++++++++
 7 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.49.1


