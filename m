Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583D6A6696
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCADnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCADnq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE7622DE2
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2023 19:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677642179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x1wMOaAO8hIU9CZgfsi/BGjO2fvLodUUT59H0gz94EA=;
        b=ZM/YV2gbszAja4kwU0Dwuid5/TWE+aJxOGmOHd3cqAMvTE6Aa35cCJTaJ44uTDpoHPkU2C
        TXNMVjX/rBbudyng+SQVJajKSjLyTWQkyMB4kBayTkarrOImVklNgU8GRqotR9QN4wR7xv
        QIT3+GYrG4AGAS6R5h5vBMj88nuhcGo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-5LQ6p9hOO2ybKQKMLIG4Ow-1; Tue, 28 Feb 2023 22:42:56 -0500
X-MC-Unique: 5LQ6p9hOO2ybKQKMLIG4Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C8E63814581;
        Wed,  1 Mar 2023 03:42:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76461C15BAD;
        Wed,  1 Mar 2023 03:42:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way
Date:   Wed,  1 Mar 2023 11:42:30 +0800
Message-Id: <20230301034247.136007-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Motivation and implementation:
==============================
Currently, many architecutres have't taken the standard GENERIC_IOREMAP
way to implement ioremap_prot(), iounmap(), and ioremap_xx(), but make
these functions specifically under each arch's folder. Those cause many
duplicated codes of ioremap() and iounmap().

In this patchset, firstly introduce generic_ioremap_prot() and
generic_iounmap() to extract the generic codes for GENERIC_IOREMAP.
By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
and iounmap() are all visible and available to arch. Arch needs to
provide wrapper functions to override the generic version if there's
arch specific handling in its corresponding ioremap_prot(), ioremap()
or iounmap(). With these changes, duplicated ioremap/iounmap() code uder
ARCH-es are removed, and the equivalent functioality is kept as before.

Background info:
================
1)
The converting more architectures to take GENERIC_IOREMAP way is
suggested by Christoph in below discussion:
https://lore.kernel.org/all/Yp7h0Jv6vpgt6xdZ@infradead.org/T/#u

2)
In the previous v1 to v3, it's basically further action after arm64
has converted to GENERIC_IOREMAP way in below patchset. It's done by
adding hook ioremap_allowed() and iounmap_allowed() in ARCH to add
ARCH specific handling the middle of ioremap_prot() and iounmap().

[PATCH v5 0/6] arm64: Cleanup ioremap() and support ioremap_prot()
https://lore.kernel.org/all/20220607125027.44946-1-wangkefeng.wang@huawei.com/T/#u

Later, during v3 reviewing, Christophe Leroy suggested to introduce
generic_ioremap_prot() and generic_iounmap() to generic codes, and ARCH
can provide wrapper function ioremap_prot(), ioremap() or iounmap() if
needed. Christophe made a RFC patchset as below to specially demonstrate
his idea. This is what v4 and now v5 is doing.

[RFC PATCH 0/8] mm: ioremap: Convert architectures to take GENERIC_IOREMAP way
https://lore.kernel.org/all/cover.1665568707.git.christophe.leroy@csgroup.eu/T/#u

Testing:
========

Old v4 has done below test. In v5, patch 1 is newly added to remove
ARCH_HAS_IOREMAP_xx, and patch 13 ("parisc: mm: Convert to GENERIC_IOREMAP")
is impacted, so I only built related x86_64, m68K, mips64, ppc64le, parisc and
all passed.

------Old v4 testing
- It's running well on arm64, s390x, ppc64le with this patchset applied
  on the latest upstream kernel 6.2-rc8+.
- Cross compiling passed on arc, ia64, parisc, sh, xtensa.
- cross compiling is not tried on hexagon, openrisc and powerpc 32bit
  because:
  - Didn't find cross compiling tools for hexagon, ppc 32bit;
  - there's error with openrisc compiling, while I have no idea how to
    fix it. Please see below pasted log:
    ---------------------------------------------------------------------
    [root@intel-knightslanding-lb-02 linux]# make ARCH=openrisc defconfig
    *** Default configuration is based on 'or1ksim_defconfig'
    #
    # configuration written to .config
    #
    [root@intel-knightslanding-lb-02 linux]# make ARCH=openrisc -j320 CROSS_COMPILE=/usr/bin/openrisc-linux-gnu-
      SYNC    include/config/auto.conf.cmd
      CC      scripts/mod/empty.o
    ./scripts/check-local-export: /usr/bin/openrisc-linux-gnu-nm failed
    make[1]: *** [scripts/Makefile.build:250: scripts/mod/empty.o] Error 1
    make[1]: *** Deleting file 'scripts/mod/empty.o'
    make: *** [Makefile:1275: prepare0] Error 2
    ----------------------------------------------------------------------

History:
=======
v4->v5:
- Ard and Christophe suggested adding a preparation patch to remove
  ARCH_HAS_IOREMAP_xx macros, this is done in newly added patch 1.
- In the current patch 13 ("parisc: mm: Convert to GENERIC_IOREMAP"),
  so we don't need to add ARCH_HAS_IOREMAP_WC.

v3->v4:
- Change to contain arch specific handling in wrapper function
  ioremap(), ioremap_prot() or iounmap() to replace the old hook
  ioremap|iounmap_allowed() hook way for each arch.
- Add two patches to convert powerpc to GENERIC_IOREMAP. They are
  picked from above Christophe's RFC patchset, I made some changes
  to make them formal.

v2->v3:
- Rewrite log of all patches to add more details as Christoph suggested.

- Merge the old patch 1 and 2 which adjusts return values and
  parameters of arch_ioremap() into one patch, namely the current
  patch 3. Christoph suggested this.

- Change the return value of arch_iounmap() to bool type since we only
  do arch specific address filtering or address checking, bool value
  can reflect the checking better. This is pointed out by Niklas when
  he reviewed the s390 patch.

- Put hexagon patch at the beginning of patchset since hexagon has the
  same ioremap() and iounmap() as standard ones, no arch_ioremap() and
  arch_iounmap() hooks need be introduced. So the later arch_ioremap
  and arch_iounmap() adjustment are not related in hexagon. Christophe
  suggested this.

- Remove the early ioremap code from openrisc ioremap() firstly since
  openrisc doesn't have early ioremap handling in openrisc arch code.
  This simplifies the later converting to GENERIC_IOREMAP method.
  Christoph and Stafford suggersted this.

- Fix compiling erorrs reported by lkp in parisc and sh patches.
  Adding macro defintions for those port|mem io functions in
  <asm/io.h> to avoid repeated definition in <asm-generic/io.h>.

v1->v2:
- Rename io[re|un]map_allowed() to arch_io[re|un]map() and made
  some minor changes in patch 1~2 as per Alexander and Kefeng's
  suggestions. Accordingly, adjust patches~4~11 because of the renaming
  arch_io[re|un]map().

Baoquan He (14):
  asm-generic/iomap.h: remove ARCH_HAS_IOREMAP_xx macros
  hexagon: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: remove unneeded early ioremap code
  mm: ioremap: allow ARCH to have its own ioremap method definition
  mm/ioremap: add slab availability checking in ioremap_prot
  arc: mm: Convert to GENERIC_IOREMAP
  ia64: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: Convert to GENERIC_IOREMAP
  s390: mm: Convert to GENERIC_IOREMAP
  sh: mm: Convert to GENERIC_IOREMAP
  xtensa: mm: Convert to GENERIC_IOREMAP
  parisc: mm: Convert to GENERIC_IOREMAP
  arm64 : mm: add wrapper function ioremap_prot()
  mm: ioremap: remove unneeded ioremap_allowed and iounmap_allowed

Christophe Leroy (3):
  mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
  mm/ioremap: Consider IOREMAP space in generic ioremap
  powerpc: mm: Convert to GENERIC_IOREMAP

 arch/arc/Kconfig                    |  1 +
 arch/arc/include/asm/io.h           |  7 ++--
 arch/arc/mm/ioremap.c               | 49 ++--------------------
 arch/arm64/include/asm/io.h         |  3 +-
 arch/arm64/mm/ioremap.c             | 10 +++--
 arch/hexagon/Kconfig                |  1 +
 arch/hexagon/include/asm/io.h       |  9 +++-
 arch/hexagon/mm/ioremap.c           | 44 -------------------
 arch/ia64/Kconfig                   |  1 +
 arch/ia64/include/asm/io.h          | 13 +++---
 arch/ia64/mm/ioremap.c              | 41 +++---------------
 arch/loongarch/include/asm/io.h     |  2 -
 arch/m68k/include/asm/io_mm.h       |  2 -
 arch/m68k/include/asm/kmap.h        |  2 -
 arch/mips/include/asm/io.h          |  5 +--
 arch/openrisc/Kconfig               |  1 +
 arch/openrisc/include/asm/io.h      | 11 +++--
 arch/openrisc/mm/ioremap.c          | 58 +------------------------
 arch/parisc/Kconfig                 |  1 +
 arch/parisc/include/asm/io.h        | 15 ++++---
 arch/parisc/mm/ioremap.c            | 62 ++-------------------------
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/io.h       | 17 ++------
 arch/powerpc/mm/ioremap.c           | 26 +-----------
 arch/powerpc/mm/ioremap_32.c        | 19 ++++-----
 arch/powerpc/mm/ioremap_64.c        | 12 +-----
 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/io.h          | 21 ++++++----
 arch/s390/pci/pci.c                 | 57 +++++--------------------
 arch/sh/Kconfig                     |  1 +
 arch/sh/include/asm/io.h            | 65 +++++++++++++++--------------
 arch/sh/include/asm/io_noioport.h   |  7 ++++
 arch/sh/mm/ioremap.c                | 65 +++++------------------------
 arch/x86/include/asm/io.h           |  5 ---
 arch/xtensa/Kconfig                 |  1 +
 arch/xtensa/include/asm/io.h        | 32 ++++++--------
 arch/xtensa/mm/ioremap.c            | 58 +++++++------------------
 drivers/net/ethernet/sfc/io.h       |  2 +-
 drivers/net/ethernet/sfc/siena/io.h |  2 +-
 include/asm-generic/io.h            | 31 +++-----------
 include/asm-generic/iomap.h         |  6 +--
 mm/ioremap.c                        | 41 ++++++++++++------
 42 files changed, 220 insertions(+), 588 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

-- 
2.34.1

