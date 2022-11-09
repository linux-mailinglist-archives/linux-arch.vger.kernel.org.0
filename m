Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B473622415
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 07:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKIGty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 01:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIGty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 01:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C41741F;
        Tue,  8 Nov 2022 22:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 349B761800;
        Wed,  9 Nov 2022 06:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC145C433D6;
        Wed,  9 Nov 2022 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667976592;
        bh=BIrl1NrFxyHLR1IA71W4GKwpqlpYuXilX7sg5vJPyxM=;
        h=From:To:Cc:Subject:Date:From;
        b=NsCm1DpbXb5kW9klEWByeP+NTouXw3kZn/1gEo3NqKLiYEqIO8y2D+Ol1smVptbSq
         /eupKkTVgnG68dWUT8GwIgeNHpLiPVr73dfEhwW17MCbXKJPPSw6p4qhl/JP3cGTjo
         dqvLwrV478pu2BA0nvjdhWO6SQ8xPag+Or9dzpPg7F70dENFrSloOHritpELHS6q9m
         ox44rCJpa/tMRN9i4DO63bDTMMDNmt0jIOcBjT/dbxxPsd6U+Wx7qjTcMtw4VMZ3FF
         BCCcgs/ycVv1BgFBn3iWIMsDU6b9eS6+nBxehsQgHGk8aMh1Jx5Etk1G6xskdQq334
         wHtULLzBf07xw==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] riscv: stacktrace: A fixup and an optimization
Date:   Wed,  9 Nov 2022 01:49:35 -0500
Message-Id: <20221109064937.3643993-1-guoren@kernel.org>
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

First is a fixup for the return address pointer. The second makes
walk_stackframe could cross the pt_regs frame.

Guo Ren (2):
  riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
  riscv: stacktrace: Make walk_stackframe cross pt_regs frame

 arch/riscv/kernel/entry.S      |  2 +-
 arch/riscv/kernel/stacktrace.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.36.1

