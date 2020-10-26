Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94642991A2
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773096AbgJZQAV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 12:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773093AbgJZQAL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 12:00:11 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5E6217A0;
        Mon, 26 Oct 2020 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728011;
        bh=XWuPlRh2DCn7UpHFESI9Gv4qPkqZxbB6y2h/Lga894Q=;
        h=From:To:Cc:Subject:Date:From;
        b=CChK874F/RvGTfvAA2cFoXUw0eIXV8n8X7wQsqy8vu043S2HAAIhkYyp5IFPbHOnR
         zksMGsGL0TiNPAOO1gK0Z9ctDckYIBPcYE1pTfxkhZfHYIqixZeMmyqbwKOGgLsKjV
         T/PaNnUeFx9VqGawXwJp8JOoZrjEbOpB0BsPac7w=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: fix ffs -Wshadow warning
Date:   Mon, 26 Oct 2020 16:59:59 +0100
Message-Id: <20201026160006.3704027-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wshadow warns about the ffs() definition that has the
same name as the global ffs() built-in:

include/asm-generic/bitops/builtin-ffs.h:13:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]

This is annoying because 'make W=2' warns every time this
header gets included.

Change it to use a #define instead, making callers directly
reference the builtin.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bitops/builtin-ffs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/asm-generic/bitops/builtin-ffs.h b/include/asm-generic/bitops/builtin-ffs.h
index 458c85ebcd15..1dacfdb4247e 100644
--- a/include/asm-generic/bitops/builtin-ffs.h
+++ b/include/asm-generic/bitops/builtin-ffs.h
@@ -10,9 +10,6 @@
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static __always_inline int ffs(int x)
-{
-	return __builtin_ffs(x);
-}
+#define ffs(x) __builtin_ffs(x)
 
 #endif
-- 
2.27.0

