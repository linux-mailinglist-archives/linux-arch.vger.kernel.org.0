Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D697A254345
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgH0KOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgH0KOb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A47C061264;
        Thu, 27 Aug 2020 03:14:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g6so2352948pjl.0;
        Thu, 27 Aug 2020 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kJ2fpgSadIOzfLVJTzEgFA08Q4H4dHhYlJOzUg0KTfE=;
        b=DwlM3h0/1TRgy1NN/FHAY3WH3gmxihuRVNnpA39YuyRdwdDBKQhAAElJw+DBI8gzsc
         j0TCwX+em1hMhffXO735vff6d/iqlwOU5f5CAkRnNByQTBqZLAKtkhyNWyqUR1ZWL7hN
         tpKMnn8hUCmvVB8FeayQWQsVOnNoWOvK30c1aOMJU2j9ZesqKY53us4I6f5YS8Ml2nPr
         7+bxRdPIelKiYxqDfJ55U6xlOWaI/30SDhAaK1sGpefrg/IzEuEVW8yX7FfhUCaYsDv2
         NWuavpw55nH6MKPk5K4rtBRxIWA3HYNwNwL7381X6f7w/+n7gOA1dssckeKNfJYXxzRU
         Ayzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kJ2fpgSadIOzfLVJTzEgFA08Q4H4dHhYlJOzUg0KTfE=;
        b=TC7OBrrYzcNMbCf+dEnEjeggIqR4xpsH/IGRTFk3L4IzfiWLJ0jjWSjchzh55WlVjj
         7NlJHNQUHKIESeUTvcnFiALKuaKaqU1fLU/U8qcW66NURdxIwVvdoFXSd06xhlaJSHNh
         WvUC0S8DobpYiBowoLqaDFajrYry5+4v7Tjw8bARTZcOgPIRr9C0xylcDx4YXBxF2Umr
         VO2b3xEZGxjXM8ia6RhOEtebBkcs/h5Y6hxDkzIdlH4OLPkgFe7PvJYhPaZaZkZP707E
         oso8TtFPkTtgxbqqPPRbe9lbWMoouJijm+ip2jKONPVQoJtPdIKgvyJdBfJPzbxJV9oe
         Elcw==
X-Gm-Message-State: AOAM5334eA5Aup27lDAffgh8ANvTucOaAVMq1Bx0u5D+snXi72yAGmDf
        I8CNDPlEM94EC0uqMDJmrlOF15lY3KYDXA==
X-Google-Smtp-Source: ABdhPJzBM9ZQNGhRRwHzq8Ti79sdq6UG69ya/El/b9FpPKWEybqQBzprLwYg82hyCgNwWtzfRwmdLg==
X-Received: by 2002:a17:90a:fa47:: with SMTP id dt7mr10544171pjb.22.1598523271240;
        Thu, 27 Aug 2020 03:14:31 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:30 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/23] clean up the code related to ASSERT()
Date:   Thu, 27 Aug 2020 18:14:05 +0800
Message-Id: <cover.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel has not yet defined ASSERT(). Indeed, BUG() and WARN() are very
clear and can cover most application scenarios. However, some applications
require more debugging information and similar behavior to assert(), which
cannot be directly provided by BUG() and WARN().

Therefore, many modules independently implement ASSERT(), and most of them
are similar, but slightly different, such as:

 #define ASSERT(expr) \
         if(!(expr)) { \
                 printk( "\n" __FILE__ ":%d: Assertion " #expr " failed!\n",__LINE__); \
                 panic(#expr); \
         }

 #define ASSERT(x)                                                       \
 do {                                                                    \
         if (!(x)) {                                                     \
                 printk(KERN_EMERG "assertion failed %s: %d: %s\n",      \
                        __FILE__, __LINE__, #x);                         \
                 BUG();                                                  \
         }                                                               \
 } while (0)

Some implementations are not optimal for instruction prediction, such as
missing unlikely():

 #define assert(expr) \
         if(!(expr)) { \
         printk( "Assertion failed! %s,%s,%s,line=%d\n",\
         #expr,__FILE__,__func__,__LINE__); \
         BUG(); \
         }

Some implementations have too little log content information, such as:

 #define ASSERT(X)                                               \
 do {                                                            \
        if (unlikely(!(X))) {                                   \
                printk(KERN_ERR "\n");                          \
                printk(KERN_ERR "XXX: Assertion failed\n");     \
                BUG();                                          \
        }                                                       \
 } while(0)

As we have seen, This makes the code redundant and inconvenient to
troubleshoot the system. Therefore, perhaps we need to define two
wrappers for BUG() and WARN_ON(), such as ASSERT_FAIL() and
ASSERT_WARN(), provide the implementation of ASSERT(), simplify the
code and facilitate problem analysis.

Maybe I missed some information, but I think there is a need to clean
up the code, maybe in other ways, and more discussion is needed here.
If this approach is reasonable, I will clean up these codes later and
issue related patches.

Chunguang Xu (23):
  include/asm-generic/bug.h: add ASSERT_FAIL() and ASSERT_WARN() wrapper
  ia64: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  KVM: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  fore200e: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  scsi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  rxrpc: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  lib/mpi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  jfs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  cachefiles: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  btrfs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  afs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  rivafb: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  nvidia: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  fbdev/cirrusfb:: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  media/staging: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  sym53c8xx: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  8139too: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  net:hns: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  block/sx8: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  skb: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  ext4: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  rbd: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
  ALSA: asihpi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code

 arch/ia64/hp/common/sba_iommu.c                    |  6 +---
 arch/x86/kvm/ioapic.h                              |  9 +-----
 drivers/atm/fore200e.c                             |  6 +---
 drivers/block/rbd.c                                |  9 +-----
 drivers/block/skd_main.c                           |  8 +-----
 drivers/block/sx8.c                                |  6 +---
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  8 +-----
 drivers/net/ethernet/realtek/8139too.c             |  6 +---
 drivers/scsi/megaraid/mega_common.h                | 10 ++-----
 drivers/scsi/sym53c8xx_2/sym_hipd.h                |  9 +-----
 .../pci/hive_isp_css_include/assert_support.h      |  6 +---
 drivers/video/fbdev/cirrusfb.c                     |  6 +---
 drivers/video/fbdev/nvidia/nvidia.c                |  7 +----
 drivers/video/fbdev/riva/fbdev.c                   |  7 +----
 fs/afs/internal.h                                  |  9 +-----
 fs/btrfs/ctree.h                                   | 12 +-------
 fs/cachefiles/internal.h                           |  9 +-----
 fs/ext4/mballoc.c                                  | 10 +------
 fs/jfs/jfs_debug.h                                 | 13 +--------
 include/asm-generic/bug.h                          | 33 ++++++++++++++++++++++
 lib/mpi/mpi-internal.h                             |  7 +----
 net/rxrpc/ar-internal.h                            |  8 +-----
 sound/pci/asihpi/hpidebug.h                        |  8 +-----
 23 files changed, 56 insertions(+), 156 deletions(-)

-- 
1.8.3.1

