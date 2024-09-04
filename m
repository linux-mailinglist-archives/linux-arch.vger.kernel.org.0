Return-Path: <linux-arch+bounces-7006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1696BF10
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00D928BD45
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7031D9335;
	Wed,  4 Sep 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdlBtfHZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D81EEE4
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457853; cv=none; b=j1raX6KxlIidE5+21V0o8wgu/nrlyxuWVS/wtsaK67ryeX3UFn1OQkLECIrtJHYh7ZK/KlKDMxiPXo9Zk1m63zDhxFQKvhpwilHm5CNYz8ikqdPRnt+OH8ox8tElMEpt2F8tOYNYpgPjvi6SvHcaLGv+/ddEA5k2Q4fYkq+tOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457853; c=relaxed/simple;
	bh=uWrtz3g6TxgzckFRZ4YDiY+UV6EL+/VQKjQ9NqC5RB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEg3mcFMbqZkDIwO20pMKQ7L+jKLmi7vDr8Yn8qZ5Zm2L7FAycxuPHzk7JL7E7cIqKS5C4GH9RsgRawdLs/nMH9zBRT7I/xtNJ0l+Y9meNAb2CNrBIrmhxUvpwaQ+EK7992vkd50qeQGmWtzXZ/XiTcSzNbUgQxWulvGqusBRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdlBtfHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEl6UcNWySWixJDtk3OBM+nYtD0bKQYmS/w9a5H5Rf8=;
	b=OdlBtfHZPteX/Y82e9OtZ6mD4rFZkrMjavnXMpJtPj9tboHSyc05Qt5sF1rZAkdoNG6klN
	qyZlLDtJEBWeTbtc1h/BNRf+Sh58KJaC0IO8hIMm8ENiFSd0SBv4gGnM9rwuztoLKqpjzi
	QSeeaBkI7i94FZxzRKLUupY7S/NhDGY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-e_9B40lyMieiF8Az2Ti6rw-1; Wed,
 04 Sep 2024 09:50:45 -0400
X-MC-Unique: e_9B40lyMieiF8Az2Ti6rw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E44A1953945;
	Wed,  4 Sep 2024 13:50:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A77E300019A;
	Wed,  4 Sep 2024 13:50:37 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] um: kunit: resolve missing prototypes warning
Date: Wed,  4 Sep 2024 15:50:19 +0200
Message-ID: <20240904135019.200756-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While building for KUnit with default settings, the build is generating
the following compilation warnings.

```
$ make ARCH=um O=.kunit --jobs=16
../lib/iomap.c:156:5: warning: no previous prototype for
‘ioread64_lo_hi’ [-Wmissing-prototypes]
  156 | u64 ioread64_lo_hi(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~
[...]
```

The warning happens because the prototypes are defined in
`asm-generic/iomap.h` only when `readq` and `writeq` are defined.
For UM, those function get some default definitions but are currently
defined _after_ the prototypes for `ioread64*`/`iowrite64*` functions.
Moving the inclusion of `asm-generic/iomap.h` fixes it.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..0b02c8e38f20 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -13,10 +13,6 @@
 #include <linux/types.h>
 #include <linux/instruction_pointer.h>
 
-#ifdef CONFIG_GENERIC_IOMAP
-#include <asm-generic/iomap.h>
-#endif
-
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
@@ -295,6 +291,10 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_GENERIC_IOMAP
+#include <asm-generic/iomap.h>
+#endif
+
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
  * are not guaranteed to provide ordering against spinlocks or memory

base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
-- 
2.46.0


