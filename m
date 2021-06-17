Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33123AB773
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhFQPaL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 11:30:11 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37548 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhFQPaJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2021 11:30:09 -0400
Received: by mail-ed1-f52.google.com with SMTP id b11so4593420edy.4;
        Thu, 17 Jun 2021 08:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/itsTxOH83bOMIRckT66tyt/S9hpeX8jx9OaBl4TWV0=;
        b=N+iMDiHD7MhP2cIP0oTuCsTqx3ZMDJMAIr9B926LL5+TjwBZPDgZ397UwZujgQEB94
         JGPF9b8htOAvTgfmFDTeVYVNLXI6svACKn5KzxuDRzjR0Gv8+eyEg97KEU9OYMQiFesh
         +UOOx83vI3n5bNyLGu3Paj/muCxhWkfIcAZN9Eg5Unris1QxTUjeKby5JXewbmyusyWz
         kUK/SwOkrrJB4Z+Q+CEG8SyMR7/dqVUAnkKIvdoeg8aPnMWJNZbf/bRrgqPFr5ZkyIN+
         HQvW4qGAZE1lNCdMU1orCvx4XoaUFQ0yZS4tWFgyAaSDJqLl3nsJTZljOenju5tWy6OX
         iT6w==
X-Gm-Message-State: AOAM5321tnnw3jpqAt2UkB+AbKYwLknPM2pSJO7zus2Vim9vtSf8HNJH
        QwAl2so+L4Cg2DqPRD4Ltpc=
X-Google-Smtp-Source: ABdhPJxyh7aN+l7/mCAyGUcuIcJt4RJVaR6/rIZKwCDs8R4EFI26qFf9plfyF1MS+s2K9o3DmCDvAw==
X-Received: by 2002:a05:6402:1216:: with SMTP id c22mr7314917edw.36.1623943677554;
        Thu, 17 Jun 2021 08:27:57 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id g11sm4497850edz.12.2021.06.17.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:27:56 -0700 (PDT)
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
Subject: [PATCH v3 0/3] riscv: optimized mem* functions
Date:   Thu, 17 Jun 2021 17:27:51 +0200
Message-Id: <20210617152754.17960-1-mcroce@linux.microsoft.com>
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

v2 -> v3:
- alias mem* to __mem* and not viceversa
- use __alias instead of a tail call

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
 arch/riscv/lib/memcpy.S         | 108 ----------------------
 arch/riscv/lib/memmove.S        |  64 -------------
 arch/riscv/lib/memset.S         | 113 -----------------------
 arch/riscv/lib/string.c         | 153 ++++++++++++++++++++++++++++++++
 8 files changed, 163 insertions(+), 315 deletions(-)
 delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
 delete mode 100644 arch/riscv/lib/memcpy.S
 delete mode 100644 arch/riscv/lib/memmove.S
 delete mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/string.c

-- 
2.31.1

