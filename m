Return-Path: <linux-arch+bounces-4808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B8902A2B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF761F20F0F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE714D9EA;
	Mon, 10 Jun 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ijnhJX3k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05854784;
	Mon, 10 Jun 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052528; cv=none; b=T2D53MYQL+w7aofLoYeU8ie6jmNDKntlPyQ5qH3tLf/rZXeqDGL0FlGaWlyXqPgnUnoAh5sshybp8WwbAb808YXSblZ8ijAM8HRfYTSL/0tWwZ1wwEExTKoV7XsTagK/pZw5NsFCT4qRLmS9LvAQh4HiwfXMtu3py76NfFerBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052528; c=relaxed/simple;
	bh=AxeTD70Xdnmf73ygmURvb2qqMwfuW1qpYQt8rNtFhzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdXhq2xdxoTmrGhvt2F34V/u4XF4TobJNAHzsGSrIaoZYHR0yhzvUOYM58Cwyqa0eenASR/QNMOMS1iRdsmGzyu7AbOiyJEdb38ebQPtwipoF4/U6Ix5Dj/FCarEptZepSqwu0qU04/kYuqsYOYYYzEtMNU77DaMWVcJi8DHtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ijnhJX3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48743C32789;
	Mon, 10 Jun 2024 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052527;
	bh=AxeTD70Xdnmf73ygmURvb2qqMwfuW1qpYQt8rNtFhzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijnhJX3k6ykhDoLXMHH3gTvuCLj8D856jE/hjb4+4CVZsd077UMEAHeeBYoxA7MNu
	 6gVgX6tWfYfvQ4iuKpUERomSR+MkULWmDebnRvSAWDrDIuf0QBvJmtQShosHJJipgt
	 gYo/n7fprCYiVs/jtM6i1XJrxG14F3QwJ56XOj8Y=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/7] vfs: dcache: move hashlen_hash() from callers into d_hash()
Date: Mon, 10 Jun 2024 13:48:15 -0700
Message-ID: <20240610204821.230388-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both __d_lookup_rcu() and __d_lookup_rcu_op_compare() have the full
'name_hash' value of the qstr that they want to look up, and mask it off
to just the low 32-bit hash before calling down to d_hash().

Other callers just load the 32-bit hash and pass it as the argument.

If we move the masking into d_hash() itself, it simplifies the two
callers that currently do the masking, and is a no-op for the other
cases.  It doesn't actually change the generated code since the compiler
will inline d_hash() and see that the end result is the same.

[ Technically, since the parse tree changes, the code generation may not
  be 100% the same, and for me on x86-64, this does result in gcc
  switching the operands around for one 'cmpl' instruction. So not
  necessarily the exact same code generation, but equivalent ]

However, this does encapsulate the 'd_hash()' operation more, and makes
the shift operation in particular be a "shift 32 bits right, return full
word".  Which matches the instruction semantics on both x86-64 and arm64
better, since a 32-bit shift will clear the upper bits.

That makes the next step of introducing a "shift by runtime constant"
more obvious and generates the shift with no extraneous type masking.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/dcache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..8b4382f5c99d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -100,9 +100,9 @@ static unsigned int d_hash_shift __ro_after_init;
 
 static struct hlist_bl_head *dentry_hashtable __ro_after_init;
 
-static inline struct hlist_bl_head *d_hash(unsigned int hash)
+static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-	return dentry_hashtable + (hash >> d_hash_shift);
+	return dentry_hashtable + ((u32)hashlen >> d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -2104,7 +2104,7 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 	unsigned *seqp)
 {
 	u64 hashlen = name->hash_len;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
@@ -2171,7 +2171,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 {
 	u64 hashlen = name->hash_len;
 	const unsigned char *str = name->name;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
-- 
2.45.1.209.gc6f12300df


