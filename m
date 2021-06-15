Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8193A7465
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 04:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFOCvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 22:51:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42659 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhFOCvh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 22:51:37 -0400
Received: by mail-ed1-f52.google.com with SMTP id i13so49074951edb.9;
        Mon, 14 Jun 2021 19:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQa/CyUV3AEwC/LA7ChZSvZVCCa5fmmDbkR0hhf+KY0=;
        b=mmp9q+AafLl6aPmANPZJ49tFCwEFf5ixTu5cI3fytISRdeqVetdQ/jjSzbl/0us0Py
         r6I/Mn41qMg21wxc3Z/g8AauibBhTjAwJMKl0UiSstoXt+uocQncVRyND9vTcvqn/lft
         NTnq0p5rkUvIpk3ZdIhgcTjQB6wgFcveOQbb74TnJtavMwUIfYAvsuzl5gCSeXXE/f+P
         2jFhjftOVoefrMi3zDolfDLU9RCDxMMN7ychppUHpbulOV/96TDTxJzNRc8F/9pROJb6
         12Nl7rzGKwAyErB9gkcx8L6oy+9Sirf4Dflrk/tAbpRvTdUi/TG4W6dz7b7CQN6Z+vzY
         0CvQ==
X-Gm-Message-State: AOAM5331zK0slZm6n7I4GOrJ4kWsNTsORoVhBaAuJOi/nMpNDr6MxEAP
        BGsSq/GP6FYidvLOaFTxJ5C9KWYgBStpMg==
X-Google-Smtp-Source: ABdhPJyIWHb5QFeN5xkFSB8wE3IB4UlFXlAqqFnvUJIA5oeI15EtAWJUgoa8IlEkAJToCofdLzwVJw==
X-Received: by 2002:a17:906:264c:: with SMTP id i12mr18194532ejc.101.1623724776230;
        Mon, 14 Jun 2021 19:39:36 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id cn25sm834966edb.69.2021.06.14.19.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 19:39:35 -0700 (PDT)
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
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 0/3] riscv: optimized mem* functions
Date:   Tue, 15 Jun 2021 04:38:09 +0200
Message-Id: <20210615023812.50885-1-mcroce@linux.microsoft.com>
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

