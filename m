Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025136F6AFF
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEDMS1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEDMSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 08:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC76190;
        Thu,  4 May 2023 05:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38678633CC;
        Thu,  4 May 2023 12:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5447AC433EF;
        Thu,  4 May 2023 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683202700;
        bh=nGxeARBJkikCTCERlSlzDIaX91rrXwF9UAD1tOJJhxs=;
        h=From:To:Cc:Subject:Date:From;
        b=STXMxlDT5ipVz/GKUn6V9IfBxaM8e7ytBWYJG9QU3X8YqoPzhGVZM7MS5vpHI6aBl
         WvgVLVvtgY4KzgNxiVAVOxnBB5sblr4P4Jk10bzcdjm/zBVu3gO40jTtVk3eBcOzco
         5W48GJcc1p5nA6+yPlgY1/SXHZ3UQgJs7jNC5oFJ3eFmqqx77UaC36hTnrc8GJGdyb
         zfxtVxuHmlOykTFbErpilokpabIlFHGG2CQz3EEzpjt+NAgljfG/JqQpkb8apoMqVx
         NziRyisxp3VU64n85GNhSECBPYuGNKs0oLreyYmkez+l5c8T9dKd5h3vgaH9In14f/
         PAjy2LGIykH5w==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.4
Date:   Thu,  4 May 2023 08:18:15 -0400
Message-Id: <20230504121815.1537054-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.4

for you to fetch changes up to 1f62ed00a56bf01becaccd81bf30f2fcb0322fd2:

  csky: mmu: Prevent spurious page faults (2023-04-13 02:36:14 -0400)

----------------------------------------------------------------
arch/csky patches for 6.4

The pull request we've done:
 - Remove CPU_TLB_SIZE config
 - Prevent spurious page faults

----------------------------------------------------------------
Guo Ren (1):
      csky: mmu: Prevent spurious page faults

Lukas Bulwahn (1):
      csky: remove obsolete config CPU_TLB_SIZE

 arch/csky/Kconfig            | 5 -----
 arch/csky/abiv1/cacheflush.c | 3 +++
 arch/csky/abiv2/cacheflush.c | 3 +++
 3 files changed, 6 insertions(+), 5 deletions(-)
