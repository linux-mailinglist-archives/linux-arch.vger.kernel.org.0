Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5C58964E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 04:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiHDCzE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiHDCzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 22:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896175FAD8;
        Wed,  3 Aug 2022 19:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F67B617AE;
        Thu,  4 Aug 2022 02:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4694CC433D6;
        Thu,  4 Aug 2022 02:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659581701;
        bh=NAbVm/nXXyhNpdbg8nzJ5becF+EsxM+Ud3RVYm5SLI0=;
        h=From:To:Cc:Subject:Date:From;
        b=egesjTcYbSHr1A3+IjC4NFJF9T/4KsnMSAYDAAAZYRz0mEltVwpwq0tv2nD6eBb5v
         UABfR8Ba0bgrqgi6uK6N/XYONEPLy9ouujpixQB0lTs0W7wAP4fL2Wistj6QKPC/Mx
         Kknlh7/wlbTON79liAx7P9n3eX5Y5vf1xZXe0Gyco7g5PjnXucIHHCX9Qi1ej4vMc6
         FrwPjzC8DbdOmhpWQitk7dkFk4wHYUeFzBPferrbm718fdpgDFPeSwLctVGzbpagc+
         BbMStOs7HzvKaAoyjPyLiLRQ1jg7XIwpJRaMLha2mgSxFgjg0loN+dcgA1oVBSgU0v
         8/56ig6S1KDnA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH V2] uapi: Fixup strace compile error
Date:   Wed,  3 Aug 2022 22:54:48 -0400
Message-Id: <20220804025448.1240780-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Export F_*64 definitions to userspace permanently. "ifndef" usage made it
vailable at all times to the userspace, and this change has actually broken
building strace with the latest kernel headers. There could be some debate
whether having these F_*64 definitions exposed to the user space 64-bit
applications, but it seems that were no harm (as they were exposed already
for quite some time), and they are useful at least for strace for compat
application tracing purposes.

Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h"
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
---
 include/uapi/asm-generic/fcntl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..3a389895328a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -116,13 +116,11 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
-#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
 
 #ifndef F_SETOWN_EX
 #define F_SETOWN_EX	15
-- 
2.36.1

