Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C48473B1F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbhLNCzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:39 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41859 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhLNCz2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:28 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bb012823;
        Tue, 14 Dec 2021 11:54:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bb012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450441;
        bh=EQ0afxQ76LqqjHsFnyzhOLlXVG7xCk9vL5KJdaj0vWU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ha8XVF3AHNb9NVlDtKwxSE1n17wM/tm96ATWaTythyxqTGRGW3+RIj9HfWLYEGOwd
         NvUrGV8lZ50WBP+np6DUo90MrGgmSeubxpjQuzWtOZcVqZeUD1j5q+jBSJcNHtviq4
         KnmA+/B5qOvGd/U/3mGf0OO3z7J/70EiIwFt3RVdme44MuRUUjcom6ubkMK+sUqYxA
         lROzk35AJUxlnAaS2/U6im8sep1LAtC9DvrvqanBIZEZHNjnqJ9dXebMFgc0+r0eyV
         YKOZ4zD+lvLgxPF+m9zNJ/LpkWys+iSZEQpBZ2kVRKwirigJRKDxvm34l/ipx+VTA4
         q++ic5DWMsyIg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 00/11] kbuild: do not quote string values in Makefile
Date:   Tue, 14 Dec 2021 11:53:44 +0900
Message-Id: <20211214025355.1267796-1-masahiroy@kernel.org>
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



Masahiro Yamada (11):
  certs: use $< and $@ to simplify the key generation rule
  certs: unify duplicated cmd_extract_certs and improve the log
  certs: remove unneeded -I$(srctree) option for system_certificates.o
  certs: refactor file cleaning
  certs: remove misleading comments about GCC PR
  kbuild: stop using config_filename in scripts/Makefile.modsign
  certs: simplify $(srctree)/ handling and remove config_filename macro
  kbuild: do not include include/config/auto.conf from shell scripts
  kbuild: do not quote string values in include/config/auto.conf
  certs: move scripts/extract-cert to certs/
  microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}

 MAINTAINERS                                   |  1 -
 Makefile                                      |  6 +-
 arch/arc/Makefile                             |  4 +-
 arch/arc/boot/dts/Makefile                    |  4 +-
 arch/h8300/boot/dts/Makefile                  |  6 +-
 arch/microblaze/Makefile                      |  8 +--
 arch/nds32/boot/dts/Makefile                  |  7 +--
 arch/nios2/boot/dts/Makefile                  |  2 +-
 arch/openrisc/boot/dts/Makefile               |  7 +--
 arch/powerpc/boot/Makefile                    |  2 +-
 arch/riscv/boot/dts/canaan/Makefile           |  4 +-
 arch/sh/boot/dts/Makefile                     |  4 +-
 arch/xtensa/Makefile                          |  2 +-
 arch/xtensa/boot/dts/Makefile                 |  5 +-
 certs/.gitignore                              |  1 +
 certs/Makefile                                | 55 +++++++------------
 {scripts => certs}/extract-cert.c             |  2 +-
 drivers/acpi/Makefile                         |  2 +-
 drivers/base/firmware_loader/builtin/Makefile |  4 +-
 init/Makefile                                 |  2 +-
 net/wireless/Makefile                         |  4 +-
 scripts/.gitignore                            |  1 -
 scripts/Kbuild.include                        | 47 ----------------
 scripts/Makefile                              | 11 +---
 scripts/Makefile.modinst                      |  4 +-
 scripts/gen_autoksyms.sh                      | 11 +---
 scripts/kconfig/confdata.c                    |  2 +-
 scripts/link-vmlinux.sh                       | 47 ++++++++--------
 scripts/remove-stale-files                    |  2 +
 scripts/setlocalversion                       |  9 ++-
 usr/Makefile                                  |  2 +-
 31 files changed, 87 insertions(+), 181 deletions(-)
 rename {scripts => certs}/extract-cert.c (98%)

-- 
2.32.0

