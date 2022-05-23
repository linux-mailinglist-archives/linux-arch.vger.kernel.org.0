Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAA53126A
	for <lists+linux-arch@lfdr.de>; Mon, 23 May 2022 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiEWQD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiEWQD4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 12:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD26211E;
        Mon, 23 May 2022 09:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B196135B;
        Mon, 23 May 2022 16:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469DFC385AA;
        Mon, 23 May 2022 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653321832;
        bh=7zFBXZsHKG5ght880o+3O05xfPLNM7j33LiZO2ke0ok=;
        h=From:To:Cc:Subject:Date:From;
        b=qqO26sjSkuVZ9o7X5vZoYqz9dDKlfUzF54HGUXOfF9H7CLrTq7KfkEz03Taswth/A
         2K+KVBeLOsoam0zjDaKP5qrA1aG7Dq7GReM3X1WZ97mB7tow3ldHxXW/GbcllbzUhk
         QPG7HkuIB20aB2MFXHwkg+l0M7yKOlstZkVLwvqgTrvxB/U/vbJIjE+crL6+QLW2uN
         kw76j4+CQAi4UdCdKKD0bpwrK5voP0uNunOusR0Q17m9gdfmrd6UrypZbu0gJvES8d
         rifp+uFrENG+XX+ZUaL6otlb3sfq6t6QoAWSDx6T8YUcHOttfCYKJfQm0wasxTAyM6
         yJRb2hZpcoFIA==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v5.19-rc1
Date:   Mon, 23 May 2022 12:03:47 -0400
Message-Id: <20220523160347.172358-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.19-rc1

for you to fetch changes up to 64d83f06774668081258bd7f3241267239bb9ab2:

  csky: Move $(core-y) into arch/csky/Kbuild (2022-05-13 15:09:28 +0800)

----------------------------------------------------------------
arch/csky patches for 5.19-rc1

This pull request we've done:
 - Three atomic optimization
 - Memcpy/memcpy_io optimization
 - Some coding conventions for Kbuild, removing the warning

----------------------------------------------------------------
Deyan Wang (1):
      csky: Fix versioncheck warnings

Guo Ren (5):
      csky: patch_text: Fixup last cpu should be master
      csky: optimize memcpy_{from,to}io() and memset_io()
      csky: atomic: Optimize cmpxchg with acquire & release
      csky: atomic: Add custom atomic.h implementation
      csky: atomic: Add conditional atomic operations' optimization

Julia Lawall (1):
      csky: fix typos in comments

Masahiro Yamada (3):
      csky: Remove unused $(dtb-y) from boot/Makefile
      csky: Remove unused core-y for dts
      csky: Move $(core-y) into arch/csky/Kbuild

Matteo Croce (1):
      csky: Add C based string functions

 arch/csky/Kbuild                  |   2 +
 arch/csky/Kconfig                 |   8 +
 arch/csky/Makefile                |   3 -
 arch/csky/abiv1/Makefile          |   2 -
 arch/csky/abiv1/memcpy.S          | 347 --------------------------------------
 arch/csky/abiv1/strksyms.c        |   6 -
 arch/csky/abiv2/Makefile          |   2 +
 arch/csky/abiv2/strksyms.c        |   4 +-
 arch/csky/boot/Makefile           |   1 -
 arch/csky/include/asm/atomic.h    | 237 ++++++++++++++++++++++++++
 arch/csky/include/asm/barrier.h   |  11 +-
 arch/csky/include/asm/cmpxchg.h   |  64 ++++++-
 arch/csky/include/asm/io.h        |  12 +-
 arch/csky/kernel/Makefile         |   2 +-
 arch/csky/kernel/io.c             |  91 ++++++++++
 arch/csky/kernel/module.c         |   2 +-
 arch/csky/kernel/probes/kprobes.c |   2 +-
 arch/csky/kernel/probes/uprobes.c |   2 +-
 arch/csky/kernel/process.c        |   1 -
 arch/csky/lib/Makefile            |   3 +
 arch/csky/lib/string.c            | 134 +++++++++++++++
 arch/csky/mm/dma-mapping.c        |   1 -
 22 files changed, 562 insertions(+), 375 deletions(-)
 delete mode 100644 arch/csky/abiv1/memcpy.S
 delete mode 100644 arch/csky/abiv1/strksyms.c
 create mode 100644 arch/csky/include/asm/atomic.h
 create mode 100644 arch/csky/kernel/io.c
 create mode 100644 arch/csky/lib/string.c
