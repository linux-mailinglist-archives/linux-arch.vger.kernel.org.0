Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8670E30B
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjEWRGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjEWRGP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 13:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF8B5;
        Tue, 23 May 2023 10:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8F862542;
        Tue, 23 May 2023 17:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466B5C433D2;
        Tue, 23 May 2023 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861573;
        bh=O4HzR93cVyWgDZI2VtGL8GGS2znNViXwdOo0oYNScmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S9susCoorlA+c7uqs58+sjbap9DCpSH16D6qnZjnn4qMOmF9hDSX7WFNdJoytkDy+
         TJAOF76W5AoLfrS0i5hCoGI/Dd1rke+vhNX0Nk8gJIVY0WlzZMymoTxgUTZfJl85+R
         KIyTvCf2J4alkJKeJs79j190Xw41NQJpUOQ0yA83g5p7kaFcPFUG4KbCXHat1zRwH5
         nnh9lg91Ok6B44pGoWtSVRf2v4Qw4oA4czgifYOOZ6gzvb/r6dVwCe8j4qycsXvvj9
         neJq4SboSHhxqkNBepoZNv0bgNBgHMVMkc5aFlw1OTddb4KX3ntcqTtic8rQ7HMZPr
         Sip+jFo6uxigg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date:   Wed, 24 May 2023 00:54:58 +0800
Message-Id: <20230523165502.2592-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When trying to run linux with various opensource riscv core on
resource limited FPGA platforms, for example, those FPGAs with less
than 16MB SDRAM, I want to save mem as much as possible. One of the
major technologies is kernel size optimizations, I found that riscv
does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
--gc-sections flag to the linker.

This not only benefits my case on FPGA but also benefits defconfigs.
Here are some notable improvements from enabling this with defconfigs:

nommu_k210_defconfig:
   text    data     bss     dec     hex
1112009  410288   59837 1582134  182436     before
 962838  376656   51285 1390779  1538bb     after

rv32_defconfig:
   text    data     bss     dec     hex
8804455 2816544  290577 11911576 b5c198     before
8692295 2779872  288977 11761144 b375f8     after

defconfig:
   text    data     bss     dec     hex
9438267 3391332  485333 13314932 cb2b74     before
9285914 3350052  483349 13119315 c82f53     after

patch1 and patch2 are clean ups.
patch3 fixes a typo.
patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.

NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
elimination for riscv several months ago, I didn't notice it until
yesterday. Although it missed some preparations and some sections's
keeping, he is the first person to enable this feature for riscv. To
ease merging, this series take his patch into my entire series and
makes patch4 authored by him after getting his ack to reflect
the above fact.

Since v1:
  - collect Reviewed-by, Tested-by tag
  - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag

Jisheng Zhang (3):
  riscv: move options to keep entries sorted
  riscv: vmlinux-xip.lds.S: remove .alternative section
  vmlinux.lds.h: use correct .init.data.* section name

Zhangjin Wu (1):
  riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION

 arch/riscv/Kconfig                  |  13 +-
 arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
 arch/riscv/kernel/vmlinux.lds.S     |   6 +-
 include/asm-generic/vmlinux.lds.h   |   2 +-
 4 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.40.1

