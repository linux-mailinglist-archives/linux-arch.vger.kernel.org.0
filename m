Return-Path: <linux-arch+bounces-8868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EB9BDA3D
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E49A1C22A5A
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611E4A11;
	Wed,  6 Nov 2024 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MXBuRK3M"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764480B;
	Wed,  6 Nov 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852645; cv=none; b=cpdiWxmpOL3IbVHxLk/6+ywpobHWnDlfIC1OiSSYLZbtACg96EtUTfIYkX6yveeoZzuDaJp0z1pgFAs1IUmxTYhFKxDmdTXA5vDG0de31tlW5kFogKeiJ8NjGkq02T2BbCkweudGoqEVCZ9pIrXdm4CF2DGvHFLhy5FXqopIIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852645; c=relaxed/simple;
	bh=G0k7IzF9dLPlR9PDUGCdsLOeHCsgQsAhWQwXJpt41Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGg5f5rNFfdawc4YL4BXYPiH4k+9WnS7J7uFe+xGck35lWSFUM/rc3kRf8kaUvBhGzF83ECPWBhptQmyisEaCgASeZo3T5i692brqnaiUffzcOuddfV2OZdRmnU4O375ttWs1uYLwQV2ZPAFez5amqzPCcvkr1Fel4gmfCsU19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MXBuRK3M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wCXrHMalIEDrFVtUAawVAtx3gdISoe3nHLfr7A9qW8M=; b=MXBuRK3MCxQRrsvHkKyHSKbl9F
	UxoR0sl/b2q67F0JygZBdHMgXuf5Fw22eicfrVYFapz9l2gA7xMs5XrdDTn1s2z+Z6bYa/cLz0fUm
	v36U02GJPeDo9X4bW+XpZ4n2Teo40RD4MrfjfMZJ/uhWqcHLMtz19FqoEa5Mm6RM59oosHz00lC9W
	spFRMAGwf7Zmbb5uf2ynFH4oXw9ZUtFO4O2ESEXyCA/0U+DZtr2YHcUDL5tJmzwqAbUhYrkCyoJ+k
	8/xVkrWPsrQJyEdU3cUqQVE1PFETeiI07LS5EYrO8g84BLZUzGyFdHK3ow9mCZ3npZTYXwypToy1y
	eqjtB5gA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Tq5-00000001Bl1-3Q88;
	Wed, 06 Nov 2024 00:24:01 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com
Cc: masahiroy@kernel.org,
	deller@gmx.de,
	linux-arch@vger.kernel.org,
	live-patching@vger.kernel.org,
	mcgrof@kernel.org,
	kris.van.hees@oracle.com
Subject: [PATCH] tests/module/gen_test_kallsyms.sh: use 0 value for variables
Date: Tue,  5 Nov 2024 16:24:00 -0800
Message-ID: <20241106002401.283517-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Use 0 for the values as we use them for the return value on init
to keep the test modules simple. This fixes a splat reported

do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
do_init_module: loading module anyway...
CPU: 5 UID: 0 PID: 1873 Comm: modprobe Not tainted 6.12.0-rc3+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x80
 do_init_module.cold+0x21/0x26
 init_module_from_file+0x88/0xf0
 idempotent_init_module+0x108/0x300
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f4f3a718839
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff>
RSP: 002b:00007fff97d1a9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b94001ab90 RCX: 00007f4f3a718839
RDX: 0000000000000000 RSI: 000055b910e68a10 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f4f3a7f1b20 R09: 000055b94001c5b0
R10: 0000000000000040 R11: 0000000000000246 R12: 000055b910e68a10
R13: 0000000000040000 R14: 000055b94001ad60 R15: 0000000000000000
 </TASK>
do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
do_init_module: loading module anyway...
CPU: 1 UID: 0 PID: 1884 Comm: modprobe Not tainted 6.12.0-rc3+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x80
 do_init_module.cold+0x21/0x26
 init_module_from_file+0x88/0xf0
 idempotent_init_module+0x108/0x300
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ffaa5d18839

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/tests/module/gen_test_kallsyms.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
index ae5966f1f904..3f2c626350ad 100755
--- a/lib/tests/module/gen_test_kallsyms.sh
+++ b/lib/tests/module/gen_test_kallsyms.sh
@@ -32,7 +32,7 @@ gen_num_syms()
 	PREFIX=$1
 	NUM=$2
 	for i in $(seq 1 $NUM); do
-		printf "int auto_test_%s_%010d = 0xff;\n" $PREFIX $i
+		printf "int auto_test_%s_%010d = 0;\n" $PREFIX $i
 		printf "EXPORT_SYMBOL_GPL(auto_test_%s_%010d);\n" $PREFIX $i
 	done
 	echo
-- 
2.45.2


