Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEF754CD7
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 02:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGPAPR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 20:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGPAPQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 20:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED141212E;
        Sat, 15 Jul 2023 17:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7288760B9B;
        Sun, 16 Jul 2023 00:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B3C433C7;
        Sun, 16 Jul 2023 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689466513;
        bh=X6hTcvtJBK7dd2SCGFkBhw9aiwlqXCXsF5zEG0CNbnw=;
        h=From:To:Cc:Subject:Date:From;
        b=MWdWp6KASNJjzqYRAXOjBuKgG/7fkrdNiXgYlgLalGY9LulRL6o30PkpSSpzv5ybB
         X7ahc6tTYmlLkQzk1n1BmZcAg7P2G1g9+GuC37CWYEoF0AypT9Q4zGs4AM0m49FjeA
         GKoM9xl0UpvfH9vErJLimz5QX53O7h8tvbzxQgqr1im5sgPNqi0CAbc9+Uj37NPUei
         5aEyrHPsLCSQe4PCY4LtjoEinvhwhjeGM9p2+0GWEf80gXmlHPRhMRAN+UzZoSNtpS
         0EZLoN0/jbas70QOBZufRvadwJ085yilH+GIZgCFYXHaGMaYy6t7t8OQ11+y0vJzX1
         EBt2+19XmVoXQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/2] riscv: stack: Fixup independent softirq/irq stack for CONFIG_FRAME_POINTER=n
Date:   Sat, 15 Jul 2023 20:15:04 -0400
Message-Id: <20230716001506.3506041-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The independent softirq/irq stack uses s0 to save & restore sp, but s0
would be corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber
list to fix the problem.

<+0>:     addi    sp,sp,-32
<+2>:     sd      s0,16(sp)
<+4>:     sd      s1,8(sp)
<+6>:     sd      ra,24(sp)
<+8>:     sd      s2,0(sp)
<+10>:    mv      s0,a0		--> compiler allocate s0 for a0 when CONFIG_FRAME_POINTER=n
<+12>:    jal     ra,0xffffffff800bc0ce <irqentry_enter>
<+16>:    ld      a5,56(tp) # 0x38
<+20>:    lui     a4,0x4
<+22>:    mv      s1,a0
<+24>:    xor     a5,a5,sp
<+28>:    bgeu    a5,a4,0xffffffff800bc092 <do_irq+88>
<+32>:    auipc   s2,0x5d
<+36>:    ld      s2,1118(s2) # 0xffffffff801194b8 <irq_stack_ptr>
<+40>:    add     s2,s2,a4
<+42>:    addi    sp,sp,-8
<+44>:    sd      ra,0(sp)
<+46>:    addi    sp,sp,-8
<+48>:    sd      s0,0(sp)
<+50>:    addi    s0,sp,16	--> our code clobber the s0
<+52>:    mv      sp,s2
<+54>:    mv      a0,s0		--> a0 got wrong value for handle_riscv_irq 
<+56>:    jal     ra,0xffffffff800bbb3a <handle_riscv_irq>

Changelog:
V2
 - Fixup compile error with CONFIG_FRAME_POINTER=y
 - FIxup stable@vger.kernel.org tag

Guo Ren (2):
  riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
  riscv: stack: Fixup independent softirq stack for
    CONFIG_FRAME_POINTER=n

 arch/riscv/kernel/irq.c   | 3 +++
 arch/riscv/kernel/traps.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.36.1

