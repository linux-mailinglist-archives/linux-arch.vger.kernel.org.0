Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812A4F0F3F
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377425AbiDDGWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377415AbiDDGWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:32 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736B37007;
        Sun,  3 Apr 2022 23:20:29 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bj008244;
        Mon, 4 Apr 2022 15:20:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bj008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053202;
        bh=C5Gz1jH1QyoDe74WuUIIOP6eRU56ftuMqQ35MziXx3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Y4GnqtqlaPqaLJIfEV0NMnpXLUmTFbryyHJBMReIrFGr/ikNiCDWwM/8B3Y5mGA6V
         2KgXQTBfwgMVl7DYMjGmX0aHO1mQIHTPn6SlxZ7wXbAtGt28lZfQRlwJLylYZfc8B7
         W/4gzBos/ovahceXo2VlKPpAk4AGrU3qR7TTOQPJyk3lYdUocfKQ6SbzKLoj386BNL
         U8X7ssh2yneidY5e/5PufUch12mTJ4YBwK/Mc8lPgLyAW+ahdtZCF/rOE2+YFbc1mR
         FQ2DM/F6GcvAr45bbWqAWwmbubvINgK2q2l2KVqThhIJCDIykd3fB+0VEmOiiXsBOu
         R4PCnYGG9rdIw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/8] UAPI: make more exported headers self-contained, and put them into test coverage
Date:   Mon,  4 Apr 2022 15:19:40 +0900
Message-Id: <20220404061948.2111820-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Here are more efforts to put more headers to UAPI compile testing
(CONFIG_UAPI_HEADER_TEST).

I am sending this series to Arnd because he has deep knowledge for the
kernel APIs and manages asm-generic pull requests.



Masahiro Yamada (8):
  agpgart.h: do not include <stdlib.h> from exported header
  kbuild: prevent exported headers from including <stdlib.h>,
    <stdbool.h>
  riscv: add linux/bpf_perf_event.h to UAPI compile-test coverage
  mips: add asm/stat.h to UAPI compile-test coverage
  powerpc: add asm/stat.h to UAPI compile-test coverage
  sparc: add asm/stat.h to UAPI compile-test coverage
  posix_types.h: add __kernel_uintptr_t to UAPI posix_types.h
  virtio_ring.h: do not include <stdint.h> from exported header

 arch/h8300/include/uapi/asm/posix_types.h  |  1 +
 arch/mips/include/uapi/asm/stat.h          | 20 ++++++++++----------
 arch/powerpc/include/uapi/asm/stat.h       | 10 +++++-----
 arch/s390/include/uapi/asm/posix_types.h   |  2 ++
 arch/sparc/include/uapi/asm/posix_types.h  |  1 +
 arch/sparc/include/uapi/asm/stat.h         | 12 ++++++------
 arch/xtensa/include/uapi/asm/posix_types.h |  1 +
 include/linux/types.h                      |  2 +-
 include/uapi/asm-generic/posix_types.h     |  2 ++
 include/uapi/linux/agpgart.h               |  9 ++++-----
 include/uapi/linux/virtio_ring.h           |  6 ++----
 tools/arch/h8300/include/asm/bitsperlong.h |  1 +
 usr/dummy-include/stdbool.h                |  7 +++++++
 usr/dummy-include/stdlib.h                 |  7 +++++++
 usr/include/Makefile                       | 12 +-----------
 15 files changed, 51 insertions(+), 42 deletions(-)
 create mode 100644 usr/dummy-include/stdbool.h
 create mode 100644 usr/dummy-include/stdlib.h

-- 
2.32.0

