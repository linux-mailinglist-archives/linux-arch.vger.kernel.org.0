Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88455ABFBC
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiICQXo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiICQXn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 12:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874CD3DBC7;
        Sat,  3 Sep 2022 09:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 330D3B80113;
        Sat,  3 Sep 2022 16:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357BAC433D6;
        Sat,  3 Sep 2022 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662222219;
        bh=VwwOXJImNZSacIylO5PCh0kYdKDhH9SoS9a2my6P4Y4=;
        h=From:To:Cc:Subject:Date:From;
        b=N3TNQZmCWEBrVbWy6swUqBf+C2W/wMtI95XWC8cOmI4MvR5NcTE6h51nWCrIjSlBO
         cmcarQ2uFFwOtZifMPk0GLORkQCmJxK+an5f3aFQR8Xz6wY+I/IezDM0TpKfLzw0hJ
         wJQPenP0cWUS9RaDccXxnVUi2pcRli0rZ4BUzxHZrylvlQngPiJeyyA1LhonssVpDn
         OjymH9H4a1BoHKcdZqh9EBdo5M1Z4eUHm71+/COidRP9+EcdPfXFkCehqa6IXnUlbr
         Vmh7U0EMYSQE51Blweln3ZN7yW74dvqqsgoWAew74j6xsDRbcIj3ziwvSTQdXlmR1c
         7l3d1nifZ2bfQ==
From:   guoren@kernel.org
To:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, shorne@gmail.com,
        guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/3] arch: Cleanup ptrace_disable
Date:   Sat,  3 Sep 2022 12:23:24 -0400
Message-Id: <20220903162328.1952477-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

This series cleanup ptrace_disable() in arch/*. Some architectures
are duplicate clearing SYSCALL TRACE.

Changes in V2:
 - Rebase on linux-6.0-rc3
 - Add Reviewed-by tags.

Guo Ren (3):
  riscv: ptrace: Remove duplicate operation
  openrisc: ptrace: Remove duplicate operation
  arch: ptrace: Cleanup ptrace_disable

 arch/arc/kernel/ptrace.c        |  4 ----
 arch/arm/kernel/ptrace.c        |  8 --------
 arch/microblaze/kernel/ptrace.c |  5 -----
 arch/nios2/kernel/ptrace.c      |  5 -----
 arch/openrisc/kernel/ptrace.c   |  1 -
 arch/riscv/kernel/ptrace.c      |  5 -----
 arch/sparc/kernel/ptrace_32.c   | 10 ----------
 arch/sparc/kernel/ptrace_64.c   | 10 ----------
 kernel/ptrace.c                 |  8 ++++++++
 9 files changed, 8 insertions(+), 48 deletions(-)

-- 
2.36.1

