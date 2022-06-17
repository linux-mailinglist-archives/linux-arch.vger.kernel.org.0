Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4454F96B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382529AbiFQOni (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382853AbiFQOn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91025FF;
        Fri, 17 Jun 2022 07:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898506142F;
        Fri, 17 Jun 2022 14:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E0FC3411B;
        Fri, 17 Jun 2022 14:43:24 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v5.19-rc3
Date:   Fri, 17 Jun 2022 22:44:28 +0800
Message-Id: <20220617144428.569247-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-2

for you to fetch changes up to 03dfb4a3abc4cc497850e6968b59005485592369:

  docs/zh_CN/LoongArch: Fix notes rendering by using reST directives (2022-06-17 22:09:05 +0800)

----------------------------------------------------------------
LoongArch fixes for v5.19-rc3

Add missing ELF_DETAILS in vmlinux.lds.S and fix documents rendering.

----------------------------------------------------------------
Yanteng Si (2):
      docs/LoongArch: Fix notes rendering by using reST directives
      docs/zh_CN/LoongArch: Fix notes rendering by using reST directives

Youling Tang (1):
      LoongArch: vmlinux.lds.S: Add missing ELF_DETAILS

 Documentation/loongarch/introduction.rst           | 15 +++++++++------
 Documentation/loongarch/irq-chip-model.rst         | 22 +++++++++++++---------
 .../translations/zh_CN/loongarch/introduction.rst  | 14 ++++++++------
 .../zh_CN/loongarch/irq-chip-model.rst             | 14 ++++++++------
 arch/loongarch/kernel/vmlinux.lds.S                |  1 +
 5 files changed, 39 insertions(+), 27 deletions(-)
