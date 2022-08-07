Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CEC58BC05
	for <lists+linux-arch@lfdr.de>; Sun,  7 Aug 2022 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiHGR3F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Aug 2022 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGR3E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2022 13:29:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7165C8;
        Sun,  7 Aug 2022 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tMRPcSMjjbccZSrtFDCivTz/DFBFKj1Hj0OrpfCNU18=; b=RsUnPXn+b5CGYQfXWgONPsik0O
        NtaqPRVCaqPMFSeFpsTutpK7KwacMT0+/AP7t6RSuCaly0eDiFpT9fWZ3KtTDCdxVJiRFPUyLXflF
        QvyGdX9xY5S4jCKIGqVuY2O1+v/SQ1pM7xUGTe8Y1DAq5bI4pLa4gxp7ZGQSzFADhKXAuvD+YsPzT
        dsQp3tAAd3MibNz0h20NdZ8yrJv09+l2Pg8K/SFx/jM9Zjne1mnSszY4kMFs7P/Rtc2K3TilXeqYN
        +3c3ttQA2BNe9/hODzpwcTzw4tiBOro/+IRt73cYcZ1ORB/g15on7jnOxtZpwAomfeYhlTCdbt/Ol
        xwED+Sdw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKk5E-00DB4U-MS; Sun, 07 Aug 2022 17:29:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] asm-generic: unistd.h: make 'compat_sys_fadvise64_64' conditional
Date:   Sun,  7 Aug 2022 10:28:54 -0700
Message-Id: <20220807172854.12971-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Don't require 'compat_sys_fadvise64_64' when
__ARCH_WANT_COMPAT_FADVISE64_64 is not set.

Fixes this build error when CONFIG_ADVISE_SYSCALLS is not set:

include/uapi/asm-generic/unistd.h:649:49: error: 'compat_sys_fadvise64_64' undeclared here (not in a function); did you mean 'ksys_fadvise64_64'?
  649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
arch/riscv/kernel/compat_syscall_table.c:12:42: note: in definition of macro '__SYSCALL'
   12 | #define __SYSCALL(nr, call)      [nr] = (call),
include/uapi/asm-generic/unistd.h:649:1: note: in expansion of macro '__SC_COMP'
  649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/uapi/asm-generic/unistd.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -645,8 +645,10 @@ __SC_COMP(__NR_execve, sys_execve, compa
 #define __NR3264_mmap 222
 __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
 /* mm/fadvise.c */
+#ifdef __ARCH_WANT_COMPAT_FADVISE64_64
 #define __NR3264_fadvise64 223
 __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
+#endif
 
 /* mm/, CONFIG_MMU only */
 #ifndef __ARCH_NOMMU
