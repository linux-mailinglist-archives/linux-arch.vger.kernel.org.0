Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A17117F15
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLJErX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 23:47:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLJErX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 23:47:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so1502857pln.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Dec 2019 20:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8tQSVFZXpglTzCwnCQJ/H8jDbSquTv0j0/ujEPlW6k=;
        b=Q5ohWjCIeOzukO5LCkWh2UDZUjzpG6Dg+k5QibSsNEXqnEUsNI3eOHJLFy8voZYt1D
         zWAwzTdpWafUiM/2V3jWWisOZsqR4bWCl+3Si1gmC/LlI61VQXqM8pt6m9UAyMGHCMQR
         a4aAP4oUxg9Iibn2yn+JTh0K/J6050DPkyO3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8tQSVFZXpglTzCwnCQJ/H8jDbSquTv0j0/ujEPlW6k=;
        b=k9VbP2CVmxQzJCtJRbglCyiozSCcXmi12OMkq3a+zp8C7/I8MevxGWDtv1aQraoDVz
         Bf1cFogkzjZ/0TPgXVNAA+2GA1MfQQ0tSSs8vP7OpRwuWqN/qDTzH6lIo5ODnYfaXVAf
         Xr4/eitM0OmQnB4nnjb4HEv4x0yd8dxEFmcApK93Ge2RjmT2tRj5ZXuhVw7MM+jD2aBp
         M3iShOZD4qSD/Hs19KrKxUPqE+KO+4GP85TPC9fqjgipSG/uUPWEn7RAQdIJ0yzQP6th
         9gxQK7Qna19xd1QrfoCSJgDK+6QRbojjxGHfsCc1hZu+Lx/he6CILZLlilqb5te352lV
         MRcA==
X-Gm-Message-State: APjAAAXA+5KZBLDCBLdqLeM5oDXn7BHq+sqDAESNekPMtG5Ta9WMCLpS
        YzxeasJYfCm3uun6QxplrknynA==
X-Google-Smtp-Source: APXvYqzZzlhFQwpykUHNZoV4iqQbstcouL0rgALlQzDURKcSExHxCCWi3YgmjP5uPHJuX5j1JCnLyA==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr30957647plq.234.1575953242726;
        Mon, 09 Dec 2019 20:47:22 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-e460-0b66-7007-c654.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e460:b66:7007:c654])
        by smtp.gmail.com with ESMTPSA id e16sm1159270pgk.77.2019.12.09.20.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 20:47:21 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/4] KASAN for powerpc64 radix, plus generic mm change
Date:   Tue, 10 Dec 2019 15:47:10 +1100
Message-Id: <20191210044714.27265-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

The big change from v1 is the introduction of tree-wide(ish)
MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
approach, which was for the arch to override the page table array
definitions with their own. (And I squashed the annoying intermittent
crash!)

Apart from that there's just a lot of cleanup. Christophe, I've
addressed most of what you asked for and I will reply to your v1
emails to clarify what remains unchanged.

Regards,
Daniel

Daniel Axtens (4):
  mm: define MAX_PTRS_PER_{PTE,PMD,PUD}
  kasan: use MAX_PTRS_PER_* for early shadow
  kasan: Document support on 32-bit powerpc
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   7 +-
 Documentation/powerpc/kasan.txt               | 112 ++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   3 +
 arch/powerpc/Kconfig                          |   3 +
 arch/powerpc/Kconfig.debug                    |  21 ++++
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 ++
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  20 +++-
 arch/powerpc/kernel/process.c                 |   8 ++
 arch/powerpc/kernel/prom.c                    |  59 ++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  67 +++++++++++
 arch/s390/include/asm/pgtable.h               |   3 +
 arch/x86/include/asm/pgtable_types.h          |   5 +
 arch/xtensa/include/asm/pgtable.h             |   1 +
 include/asm-generic/pgtable-nop4d-hack.h      |   9 +-
 include/asm-generic/pgtable-nopmd.h           |   9 +-
 include/asm-generic/pgtable-nopud.h           |   9 +-
 include/linux/kasan.h                         |   6 +-
 mm/kasan/init.c                               |   6 +-
 23 files changed, 353 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.20.1

