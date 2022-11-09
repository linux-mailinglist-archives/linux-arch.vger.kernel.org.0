Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B0622417
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKIGuE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 01:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKIGuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 01:50:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6717590;
        Tue,  8 Nov 2022 22:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10D9618CA;
        Wed,  9 Nov 2022 06:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A875C43470;
        Wed,  9 Nov 2022 06:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667976601;
        bh=DwVEaVj4L6g3T9BDJpJF+Y6rdkgMq0eaBMuAtX/lkSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeF4RhteKOWuXuKRiJsMMup1NYGJlKSOB0M8riRuaSJ9l1KjDZexIIra2gr/DeioW
         GveugXwtOp3eOgr7ELI9Jc9G5moMoT+lxavZb9T8sWa2OVnUF4o2oY6IJQTrS44yF9
         REsxjvMBCeR+uE7W376P2ZdV4oPA3QmzQD9bIEbsM6WRHwSRjxjHt0TK9c3RYzEO+D
         /CZGS2NRO+SymjGNQQa4fhJ2bvzxpGc8EzZCaEl8h78oHyNw035IpqefXPX+SDSFg8
         FJvjvPA+scgY++BQiHeEWG+U9i2K33uHnrQcgIFVx9AEZWtDlmAkS7Uy5sFzxj38qP
         24Le0jfL2r1sA==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, Alan Kao <alankao@andestech.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 1/2] riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
Date:   Wed,  9 Nov 2022 01:49:36 -0500
Message-Id: <20221109064937.3643993-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221109064937.3643993-1-guoren@kernel.org>
References: <20221109064937.3643993-1-guoren@kernel.org>
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

The 'retp' is a pointer to the return address on the stack, so we
must pass the current return address pointer as the 'retp'
argument to ftrace_push_return_trace(). Not parent function's
return address on the stack.

Fixes: b785ec129bd9 ("riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 08d11a53f39e..bcfe9eb55f80 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -58,7 +58,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		} else {
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
-						   (unsigned long *)(fp - 8));
+						   &frame->ra);
 		}
 
 	}
-- 
2.36.1

