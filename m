Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8F6C78EB
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCXHgn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 03:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXHgm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 03:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A340C0;
        Fri, 24 Mar 2023 00:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524E56296F;
        Fri, 24 Mar 2023 07:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC356C433D2;
        Fri, 24 Mar 2023 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679643400;
        bh=BBS9cSTname+Z1/k6YNt/nmdj4wvYmKElUY7I0mcqBI=;
        h=From:To:Cc:Subject:Date:From;
        b=rDQrw1PN087BeT3VrGtecrJalaSgojkdpf8sH9ycPAcc0VFY6USfYCuXf+HzgvtnY
         ZBKrIykAz+2aq/t8xLXZCtuXq9cyOQ5KRfH6pwn+9h633cZ19+Kegx48iGbQvPX2a/
         rPUaVZ0+3vvBrOat7/3QV/XC+xOkLSjUwBrLH3uPGL43Q0zkskOYaj0XMx439stJcp
         8NfnYd9S7Haxb5Kni2pjf3swk6A8VWJysCTx5ktEE1jbEKPdukR2n65lkpzX1PZYe4
         pH7foapRz5RZa4b16jkHjNxWpRB+XNZypEGbI8+wqD/xgA5hQ2ucUf4furLV82OnoD
         RI4dApSC69dsQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        esyr@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3] uapi: Fixup strace compile error
Date:   Fri, 24 Mar 2023 03:36:30 -0400
Message-Id: <20230324073630.161034-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Here is the compile error log:
../../../src/xlat/fcntlcmds.h:54:7: error: ‘F_GETLK64’ undeclared here
(not in a function); did you mean ‘F_GETLK’?
   54 |  XLAT(F_GETLK64),
      |       ^~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }
      |                                                      ^~~
../../../src/xlat/fcntlcmds.h:57:7: error: ‘F_SETLK64’ undeclared here
(not in a function); did you mean ‘F_SETLK’?
   57 |  XLAT(F_SETLK64),
      |       ^~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }
      |                                                      ^~~
../../../src/xlat/fcntlcmds.h:60:7: error: ‘F_SETLKW64’ undeclared here
(not in a function); did you mean ‘F_SETLKW’?
   60 |  XLAT(F_SETLKW64),
      |       ^~~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }

Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h"
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
---
Changelog
v3:
 - Add error log

v2:
https://lore.kernel.org/lkml/20220804025448.1240780-1-guoren@kernel.org/
 - Optimize commit log

v1:
https://lore.kernel.org/lkml/20220613013051.1741434-1-guoren@kernel.org/
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

