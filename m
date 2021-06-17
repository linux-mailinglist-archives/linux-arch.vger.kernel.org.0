Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3963AA88D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhFQB1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 21:27:25 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:46904 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFQB1V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 21:27:21 -0400
Received: by mail-ej1-f48.google.com with SMTP id he7so6773318ejc.13;
        Wed, 16 Jun 2021 18:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77paSv1vfUnmhsAZFukXy1zk5MAOuc8TBznUAIk9l+0=;
        b=rTCtRMPI08xficmOwe8Fqy7gefLcZ6io9/IjubWAW+63GDBZVXncyevlwLAtEZ/tmC
         1D4YXJB77EuO5aIu2N3xFDeLMS9LQFas1QBDk4v2/unPZ9yMceBkp2oAq0Nl7OxrsDYG
         3qIBMi8Y0uzVZ4rtakL1kC9e2VMDo8Qr+U/5uUzHWERuWtmBaymx0DyAFTMBD7+atFMB
         S5gqHOFOxwT93ZqMqAN9gnOE7qDM3vuk3phvC9Sf8cmR6PyECSW/WuFltdyF/mS4fMWY
         jqNOMLaiU68/GQ+65S6JrVrBfoFBduPhDL4QUGEKD5f1ywWHk3oFdr8CP+qRapLKnRmV
         3ziQ==
X-Gm-Message-State: AOAM533h6khEO3F4z9NGhl/IL4e0H+k/pZoONiOiozuguRRtfwoSm4KB
        PDGsKHqSLr9n9zXzXzqLjrI=
X-Google-Smtp-Source: ABdhPJzIDqhwqbWaknEWaMKhzG/aVdOya/Gu7PhYtIOmdbXoWZZbJ0up5/cW8MXQtJo1WIlrq0OsGQ==
X-Received: by 2002:a17:906:dff2:: with SMTP id lc18mr2364636ejc.371.1623893112431;
        Wed, 16 Jun 2021 18:25:12 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id lu21sm2624721ejb.31.2021.06.16.18.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 18:25:11 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 0/3] riscv: optimized mem* functions
Date:   Thu, 17 Jun 2021 03:25:06 +0200
Message-Id: <20210617012509.34265-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Replace the assembly mem{cpy,move,set} with C equivalent.

Try to access RAM with the largest bit width possible, but without
doing unaligned accesses.

Tested on a BeagleV Starlight with a SiFive U74 core, where the
improvement is noticeable.

v1 -> v2:
- reduce the threshold from 64 to 16 bytes
- fix KASAN build
- optimize memset

Matteo Croce (3):
  riscv: optimized memcpy
  riscv: optimized memmove
  riscv: optimized memset

 arch/riscv/include/asm/string.h |  18 ++--
 arch/riscv/kernel/Makefile      |   1 -
 arch/riscv/kernel/riscv_ksyms.c |  17 ----
 arch/riscv/lib/Makefile         |   4 +-
 arch/riscv/lib/memcpy.S         | 108 ---------------------
 arch/riscv/lib/memmove.S        |  64 -------------
 arch/riscv/lib/memset.S         | 113 ----------------------
 arch/riscv/lib/string.c         | 162 ++++++++++++++++++++++++++++++++
 8 files changed, 172 insertions(+), 315 deletions(-)
 delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
 delete mode 100644 arch/riscv/lib/memcpy.S
 delete mode 100644 arch/riscv/lib/memmove.S
 delete mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/string.c

-- 
2.31.1

