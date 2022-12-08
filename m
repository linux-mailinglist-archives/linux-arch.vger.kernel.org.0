Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F764704E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLHNAO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 08:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLHNAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 08:00:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6498138B;
        Thu,  8 Dec 2022 05:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC0D61F16;
        Thu,  8 Dec 2022 13:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1772C433D7;
        Thu,  8 Dec 2022 13:00:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.1-final
Date:   Thu,  8 Dec 2022 21:00:07 +0800
Message-Id: <20221208130007.336248-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-3

for you to fetch changes up to 1385313d8bc112760559f06f64708d936b3f2d7c:

  docs/zh_CN: Add LoongArch booting description's translation (2022-12-08 15:03:14 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.1-final

Export smp_send_reschedule() for modules use, fix a huge page entry
update issue, and add documents for booting description.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Export symbol for function smp_send_reschedule()

Huacai Chen (1):
      LoongArch: mm: Fix huge page entry update for virtual machine

Yanteng Si (2):
      docs/LoongArch: Add booting description
      docs/zh_CN: Add LoongArch booting description's translation

 Documentation/loongarch/booting.rst                | 42 +++++++++++++++++++
 Documentation/loongarch/index.rst                  |  1 +
 .../translations/zh_CN/loongarch/booting.rst       | 48 ++++++++++++++++++++++
 .../translations/zh_CN/loongarch/index.rst         |  1 +
 arch/loongarch/include/asm/smp.h                   | 10 -----
 arch/loongarch/kernel/smp.c                        | 11 +++++
 arch/loongarch/mm/tlbex.S                          | 30 +++++++-------
 7 files changed, 119 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/loongarch/booting.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/booting.rst
