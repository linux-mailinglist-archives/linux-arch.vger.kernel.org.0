Return-Path: <linux-arch+bounces-11103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC6A6FED7
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F043BB610
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56DC28368F;
	Tue, 25 Mar 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb/eV2Rw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967C257AC7;
	Tue, 25 Mar 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905540; cv=none; b=LiyN/KAaJpya6Z0CXQ849vt7qR6BVNhGS6Q/2LwQTa/Eg806o++jEf/XTiK29/t6+PGsZ5thRK9r2uC/J8909lglcKZIGub5zhycygKwQiuo7NZWmNYg1MlK149JDjhLIdqLWuS8nHgInzpihxN6AuhZh1V9kXBJnFpGCw3uGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905540; c=relaxed/simple;
	bh=sm654hPYjWJMXJD/nEEXxI+s+R28mm6voQq4ZrjJStU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMe7PiSXydF+rGbYnyvinNjlvNVjYHybAfRu9q2marLG7xZlRm+xWmmyndQq06NRj2pGVv0cUdwOH0+Rj8FzzU1A8zaNLkSQPeIfJXc6rzyfJ2aC/yOnhWGiRvEm+GPFqH6a22XH4b4Qz3KqOcGnUYaoFHKrtdvH3jGod7EIyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb/eV2Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2764C4CEE4;
	Tue, 25 Mar 2025 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905540;
	bh=sm654hPYjWJMXJD/nEEXxI+s+R28mm6voQq4ZrjJStU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kb/eV2Rwu3zYNU7Jt3dNKcNXYL8nMRHt5pyAJqK6Q/FHeFvW6XiemJEA3uvEk7fVs
	 3EdHOm9rkT05EzHBa5buxdZyLrstfBsowWufM7HqrOlG+CIUjr96jk/fDQXjnFPt+R
	 dWfnumlqW9XRN8RlSa4I28acYRg721cxluLl8IEARR3ZQbcXBk3NZPefJ2WwhFLcUe
	 OiQ0cG9dLZ0sgksiS+3kI0Gf4fzOMT9Xk2MfF9taYcuO0Y49REu0hLiOZAG6x8XWZ3
	 isLS319gnMj4Vs30saFH4Hmz96Q2P/kZ1dTH5mgBIdyz3rnr7TCbzfvoPIkyCS5b43
	 0M+WNWc7E/U2Q==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 37/43] rv64ilp32_abi: random: Adapt fast_pool struct
Date: Tue, 25 Mar 2025 08:16:18 -0400
Message-Id: <20250325121624.523258-38-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

RV64ILP32 ABI systems have BITS_PER_LONG set to 32, matching
sizeof(compat_ulong_t). Adjust code

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2581186fa61b..0bfbe02ee255 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1015,7 +1015,11 @@ EXPORT_SYMBOL_GPL(unregister_random_vmfork_notifier);
 #endif
 
 struct fast_pool {
+#ifdef CONFIG_64BIT
+	u64 pool[4];
+#else
 	unsigned long pool[4];
+#endif
 	unsigned long last;
 	unsigned int count;
 	struct timer_list mix;
@@ -1040,7 +1044,11 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
  * and therefore this has no security on its own. s represents the
  * four-word SipHash state, while v represents a two-word input.
  */
+#ifdef CONFIG_64BIT
+static void fast_mix(u64 s[4], u64 v1, u64 v2)
+#else
 static void fast_mix(unsigned long s[4], unsigned long v1, unsigned long v2)
+#endif
 {
 	s[3] ^= v1;
 	FASTMIX_PERM(s[0], s[1], s[2], s[3]);
-- 
2.40.1


