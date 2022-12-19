Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D1865072D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 05:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLSE3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Dec 2022 23:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiLSE27 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Dec 2022 23:28:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A32BF68;
        Sun, 18 Dec 2022 20:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6B4AB80D27;
        Mon, 19 Dec 2022 04:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7358DC433EF;
        Mon, 19 Dec 2022 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671423986;
        bh=hRycLOTdsoI0Dl/XQOcXlNVZnTaSLloe3NHNpvNTRgo=;
        h=From:To:Cc:Subject:Date:From;
        b=Oft5A7jUfir39CQjGSuN6VD5SuM0J18M9RnuI35aL7lqt6mu9cKKSo+qdouJVLx2X
         aVm8L1oBf2XiMQi/KKIoUj9rgkQlvBO1lJCcLM/9XohaheYVSog2/pIuFyayYg1aAg
         to1yZFvmH0H8BQs009eu13ks3MM/gT2sb2Oeq7Ohe+8mUrUV2IlqsBR2xCnfU/H4Vm
         9Z3CTbhxmhFQWqDl6yopLSRqhBhm7L2NzQTvNYQQm6qenBxVfvQ2Kr3UqcFBdiP44M
         ngPNDzY1Nut8gWnSKSsHbJt/A6yF9IqUPtvq2CS+V5a0LUPQkubKCmm4DlFsAXNBQV
         MNl/bjZThHLTA==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.2-rc1
Date:   Sun, 18 Dec 2022 23:26:22 -0500
Message-Id: <20221219042622.2621881-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.2-rc1

for you to fetch changes up to 7e2004906fb52257772be0ef262fba2d5eb1653b:

  Revert "csky: Add support for restartable sequence" (2022-11-11 04:59:28 -0500)

----------------------------------------------------------------
arch/csky patches for 6.2-rc1

The pull request we've done:
 - Revert rseq
 - Add current_stack_pointer support
 - Typo fixup

----------------------------------------------------------------
Colin Ian King (1):
      csky: Kconfig: Fix spelling mistake "Meory" -> "Memory"

Mathieu Desnoyers (2):
      Revert "csky: Fixup CONFIG_DEBUG_RSEQ"
      Revert "csky: Add support for restartable sequence"

Tong Tiangen (1):
      csky: add arch support current_stack_pointer

 arch/csky/Kconfig                 |  4 ++--
 arch/csky/include/asm/processor.h |  2 ++
 arch/csky/kernel/entry.S          | 11 +----------
 arch/csky/kernel/signal.c         |  2 --
 arch/csky/kernel/stacktrace.c     |  6 ++----
 5 files changed, 7 insertions(+), 18 deletions(-)
