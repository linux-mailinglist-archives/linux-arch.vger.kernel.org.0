Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5B744C18
	for <lists+linux-arch@lfdr.de>; Sun,  2 Jul 2023 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGBDTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Jul 2023 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBDTK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Jul 2023 23:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010501705;
        Sat,  1 Jul 2023 20:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7964960B00;
        Sun,  2 Jul 2023 03:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C4C433C7;
        Sun,  2 Jul 2023 03:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688267948;
        bh=yO9eBNdtOfsDblTPwoN0bflqCrQUZu3bz9XfKKxN6mQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NsrYKUzAEkjzkN8h0ffXrWoRk5tamDYaqSmHcjbpXOajw45H1bQRtwVMgUWPynlPU
         amejgdnyWWkM+J6j3NunadjWgsLdHKjcQ5QgWz6EwPxjADAFFa/M9OAp4Xf+nfbDsY
         h2vBmYySH/tgQwu6KxL/tIepYsWr289VQCwFR1K387IYyQhj0wlGoyEzXt66Zqg2B2
         TkjMBEAESLmUkJByzdhARO6pd7NvI7+NtMbnhThxVE99Y1aXRrsuRBLgIXov8Q9Tbc
         RKajzwxIESOXdEh/H1svmYYLPdSo0yt5+OVKeBekB9HpPFAaQiE100KZ9VQ/uOR7rw
         49Jpt8eTjG3AQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org, guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.5
Date:   Sat,  1 Jul 2023 23:19:04 -0400
Message-Id: <20230702031904.792594-1-guoren@kernel.org>
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

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.5

for you to fetch changes up to dd64621a2a97798d5df40028238a703d4324036b:

  csky: uprobes: Restore thread.trap_no (2023-06-18 08:37:27 -0400)

----------------------------------------------------------------
arch/csky patches for 6.5

The pull request we've done:
 - Correct thread.trap_no restore of uprobe

----------------------------------------------------------------
Tiezhu Yang (1):
      csky: uprobes: Restore thread.trap_no

 arch/csky/kernel/probes/uprobes.c | 3 +++
 1 file changed, 3 insertions(+)
