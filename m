Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB0471CBF
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 20:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhLLTjp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 14:39:45 -0500
Received: from condef-05.nifty.com ([202.248.20.70]:60255 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLTjp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Dec 2021 14:39:45 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-05.nifty.com with ESMTP id 1BCJV20O011775
        for <linux-arch@vger.kernel.org>; Mon, 13 Dec 2021 04:31:02 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BCJTqAk000552;
        Mon, 13 Dec 2021 04:29:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCJTqAk000552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639337393;
        bh=FXw958wyo8ETkKfX7PUkbCcYnUmIcy1cqQ//+4bN/Sg=;
        h=From:To:Cc:Subject:Date:From;
        b=ohvtGUFWSUwc68OTx4V2VSL2Wv0mzlcaItMXt9jwLUaF37y0y5w++Hdivpi6k8cgz
         96UrTLG0976RF4BOZrskI2YFO7GJcwbVMIOsHgqei7Ikn2o774YMePwh7y5izqUokg
         CM7vSOxLPHo1LhvsfCOImQlYbnRzAirsTYvDqDKMXfzrlVhrkH3IyGiTW7fyjG9xbG
         YaGLO2pExbYrar9c6TQUHzJBdUcz1e4kQyoJySslYGnzo0WkOiYsNnKxxv9L+rsN9w
         tWYebiiak+JP/IvuNV2UB/8Zh2bcuwiqEESoUaLYux/i/xNJTvwaoHv/R27ZerMBBS
         TaXme7Ke5Dxuw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/10] kbuild: do not quote string values in Makefile
Date:   Mon, 13 Dec 2021 04:29:31 +0900
Message-Id: <20211212192941.1149247-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This patch refactors the code as outlined in:

  https://lore.kernel.org/linux-kbuild/CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com/

First some patches refactor certs/Makefile. This Makefile is written
in a too complicated way.

I will revert cd8c917a56f20f48748dd43d9ae3caff51d5b987
after this lands in the upstream.



Masahiro Yamada (10):
  certs: use $@ to simplify the key generation rule
  certs: unify duplicated cmd_extract_certs and improve the log
  certs: remove unneeded -I$(srctree) option for system_certificates.o
  certs: refactor file cleaning
  certs: remove misleading comments about GCC PR
  kbuild: stop using config_filename in scripts/Makefile.modsign
  certs: simplify $(srctree)/ handling and remove config_filename macro
  kbuild: do not include include/config/auto.conf from shell scripts
  kbuild: do not quote string values in include/config/auto.conf
  microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}

 Makefile                                      |  6 +--
 arch/arc/Makefile                             |  4 +-
 arch/arc/boot/dts/Makefile                    |  4 +-
 arch/h8300/boot/dts/Makefile                  |  6 +--
 arch/microblaze/Makefile                      |  8 ++--
 arch/nds32/boot/dts/Makefile                  |  7 +--
 arch/nios2/boot/dts/Makefile                  |  2 +-
 arch/openrisc/boot/dts/Makefile               |  7 +--
 arch/powerpc/boot/Makefile                    |  2 +-
 arch/riscv/boot/dts/canaan/Makefile           |  4 +-
 arch/sh/boot/dts/Makefile                     |  4 +-
 arch/xtensa/Makefile                          |  2 +-
 arch/xtensa/boot/dts/Makefile                 |  5 +-
 certs/Makefile                                | 48 ++++++-------------
 drivers/acpi/Makefile                         |  2 +-
 drivers/base/firmware_loader/builtin/Makefile |  4 +-
 init/Makefile                                 |  2 +-
 net/wireless/Makefile                         |  4 +-
 scripts/Kbuild.include                        | 47 ------------------
 scripts/Makefile.modinst                      |  4 +-
 scripts/gen_autoksyms.sh                      |  6 +--
 scripts/kconfig/confdata.c                    |  2 +-
 scripts/link-vmlinux.sh                       | 47 +++++++++---------
 scripts/setlocalversion                       |  9 ++--
 usr/Makefile                                  |  2 +-
 25 files changed, 74 insertions(+), 164 deletions(-)

-- 
2.32.0

