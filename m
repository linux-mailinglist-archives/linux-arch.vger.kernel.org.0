Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBC5BABC2
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiIPKyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIPKyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 06:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC016D9CE;
        Fri, 16 Sep 2022 03:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1844562AC6;
        Fri, 16 Sep 2022 10:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB30C433C1;
        Fri, 16 Sep 2022 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663324715;
        bh=uKhEvPsni5Ky+cHQE5EHan1X0SKecPDG4FXWXWTdBBE=;
        h=From:To:Cc:Subject:Date:From;
        b=gpiOzyBuh8KhM0CVNudfj9p1EEHI3cNSyca2dVEyTMbW98j4sO5qsXxVywqs0x7C9
         FC2zGpKe1anuOY/3Tf6f1c4DLw3B/qrg+jeVSUVZZjYrpko1HIo77Up6IlM3VhyrNh
         Y1+3m7/cM1mODHsUK0G3WJSSViFGv28XbVsIFvROnhGUEyc9z6V7Y4axLJ4vD77qXW
         D7CVcbLNlWeVfq0AxZx4lAb1x17JbHoWTROSc2Z3jTE5C1vyV+fHr8HaU79bAcqndF
         CB6mJmyEvKs+xLc+kfcw2xWlHqNciT6WYhWcDx8bHbqtZmn+m85B6mW6he17IK7nLK
         Nv3FOx7DklCFQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        rostedt@goodmis.org, andy.chiu@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, jrtc27@jrtc27.com, mingo@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/3] riscv: ftrace: Fixup ftrace detour code
Date:   Fri, 16 Sep 2022 06:38:14 -0400
Message-Id: <20220916103817.9490-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems. The
most horrible bug is preemption panic which found by Andy [1]. I think we
could disable preemption for ftrace first, and Andy could continue the
ftrace preemption work.

@Andy, as Steven said, improving stop_machine mechinism also could prevent
preemption problem, but it would reduce the speed of ftrace_modify. How
do you think about the stop_machine solution, would you give out the
patch for this?

[1]: https://lpc.events/event/16/contributions/1171/

Andy Chiu (1):
  riscv: ftrace: Fixup panic by disabling preemption

Guo Ren (2):
  riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
  riscv: ftrace: Reduce the detour code size to half

 arch/riscv/Kconfig              |  2 +-
 arch/riscv/Makefile             |  6 ++-
 arch/riscv/include/asm/ftrace.h | 46 ++++++++++++++++++-----
 arch/riscv/kernel/ftrace.c      | 65 ++++++++++-----------------------
 arch/riscv/kernel/mcount-dyn.S  | 43 +++++++++-------------
 5 files changed, 78 insertions(+), 84 deletions(-)

-- 
2.36.1

