Return-Path: <linux-arch+bounces-15447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC05FCC128E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231243025A46
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0412D7386;
	Tue, 16 Dec 2025 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+rvyd1T"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CB1DF261;
	Tue, 16 Dec 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867127; cv=none; b=YZJnX0zFyBM5SPuit2qJR4xzJOlOUWflBHq5c4XHpDRDmjIz5Uw4bXsi8JxU9GvO9S+oNEfoYQiaixlXla9r46gqhuXps4RdB8/lRcHcG/lGZ2M94ZKF5pBcXvVb5sIc/RVP+qNg9fxEiy3VPA5aRc/H1Sf6ViZGQXspYdv5wJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867127; c=relaxed/simple;
	bh=SuCvINbuPVMXqb9QjLD98WOoklSkHkfDpJ3rDwet8XQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JoUP5jo+ghLjN3Q4cML/DAT9wR3HRY9pTA6vptU0v/eYpuI6oL3H31Pyu0qw6uzT/txvC8PHhEH6lT6C94XIlABIhkhzKImRKlxJX/qa/U674FqzHbzRB8wW/LlO2OV7icwJYEH/OSzys3TM3piDu3BdgOjMClFjQiAyCWZgImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+rvyd1T; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id E8A131D00105;
	Tue, 16 Dec 2025 01:38:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 16 Dec 2025 01:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765867116; x=
	1765953516; bh=mcxXvS3cm1F0WmCqE3WMidSQEcc6TanLc8CP39ib5i4=; b=l
	+rvyd1TIBWr7y3uNUW1dqjrjaj577UiCABj6C2hjE+oTIAo35dOQmqUbf+Aj3kcJ
	Iivr/OUuAM83fOTbJYjoJjwaBczygWQ2edkvmLeTN5O0hM3naRT+FhrgaG7j/5DP
	vpEBEWJZA5xkSJ0hPgC3mWbkV2hCp4pn/X356MVI8tyXNbTfYi/Le5iPNwlk8XFx
	+Ru01U22KhLjde9Xbb0RNTyBFTTBvv6u8HGPVn1mwoiRdiQFrRguHN8Q//ppySxp
	V4C5IV5YxZt9ttLK2C3QD5sSBnlIeonaMpDtOxcj0g8LnEA5b6JsM5AqP4cedk27
	Plix2vTxZRzJAeK45rh/g==
X-ME-Sender: <xms:bP5AaSGSd6JlwDUZcqEIjyNiXRBxUD34rV0P73hSD7GlK0LNxblIGA>
    <xme:bP5AaXQlybwhXXI5bgd2sDD532I28mgE639V34CYUpCFIN4jvxM2GxwxRHvhSfMfJ
    h4bFvZ9uGgAx2nntY2FC0c18M--pVUiESzNgOSymSxKEk-t9Ab_4Uc>
X-ME-Received: <xmr:bP5AaUpq-IC4Vv6X1hHTulu3n_uACAqh7cUfj_WbFn3u_z77ZSzQFfd4CaXnhrRywMwyLsMdk3xvEgU7lmYNQBN4QcDZw1dnNZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvefggfdthffhfeevuedugfdtuefgfeettdevkeeigefgudelteeggeeuheegffffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhm
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrhhnugesrg
    hrnhgusgdruggvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepmhgrrh
    hkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bP5AaVrOV7N2BAIlg0s4O8tKXmiTgKpauuol07v8NqESXsk5O9632Q>
    <xmx:bP5Aaf0KiFUDH9E6Z6DSBGnYb-phvoUwfa_T4Zydh4Uk-m0LhczAEA>
    <xmx:bP5AaZgNUSv-f4NPasT7Sapm4Zy2iqFN1rZ_AG9h3BlgUC46MKp3jA>
    <xmx:bP5Aael_yusUIwPsbrTJHhklWSKurKBTLV3D4jb0LPaEhVelqZQN8w>
    <xmx:bP5AaSJjiheOZd2B4-Gzek8fxPTofqQizSNnYm-FdzraX_ZkPCz5a7XE>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 01:38:34 -0500 (EST)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>,
    Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>,
    KP Singh <kpsingh@kernel.org>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    bpf@vger.kernel.org
Message-ID: <4ff540deaf87eb24ba11bbac95bdbea68d22a129.1765866665.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 1/4] bpf: Explicitly align bpf_res_spin_lock
Date: Tue, 16 Dec 2025 17:31:05 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
changes, as it will do on m68k when, in a subsequent patch, the minimum
alignment of the atomic_t member of struct rqspinlock gets increased
from 2 to 4. Drop the BUILD_BUG_ON() as it becomes redundant.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 include/asm-generic/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..eac2dcd31b83 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -28,7 +28,7 @@ struct rqspinlock {
  */
 struct bpf_res_spin_lock {
 	u32 val;
-};
+} __aligned(__alignof__(struct rqspinlock));
 
 struct qspinlock;
 #ifdef CONFIG_QUEUED_SPINLOCKS
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..02f1f671e624 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -692,7 +692,6 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	int ret;
 
 	BUILD_BUG_ON(sizeof(rqspinlock_t) != sizeof(struct bpf_res_spin_lock));
-	BUILD_BUG_ON(__alignof__(rqspinlock_t) != __alignof__(struct bpf_res_spin_lock));
 
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
-- 
2.49.1


