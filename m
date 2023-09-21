Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACD7A9F43
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjIUUUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjIUUTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9517CE72
        for <linux-arch@vger.kernel.org>; Thu, 21 Sep 2023 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J82jcaw/+kiBJ2FfMU0engZd+GV+Xpg+5yRwfEtk5KM=;
        b=SXku282kZ3Y9jPux7Vy+0JCZcDrsH9shJlv9jdw7Dod/8QvQ+lSnUR3jenIw/dPaqrXf2e
        qTWhzqAZEB/FipGyGn5DGBgbUFu4h+1YrVPZj4w/nkTdLuZ3RBDqgjr4imH5jvDAmRFXV0
        +2fZeJB8fRMG7QlBD5uPSDgt0Yg3qAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-KY3ntw-DNRuE8xoylOxPWA-1; Thu, 21 Sep 2023 07:04:34 -0400
X-MC-Unique: KY3ntw-DNRuE8xoylOxPWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DF13803B5D;
        Thu, 21 Sep 2023 11:04:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91D9A2156702;
        Thu, 21 Sep 2023 11:04:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, arnd@arndb.de, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        deller@gmx.de, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/4] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Thu, 21 Sep 2023 19:04:20 +0800
Message-ID: <20230921110424.215592-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset tries to remove ioremap_uc() in the current architectures
except of x86 and ia64. They will use the default ioremap_uc version
in <asm-generic/io.h> which returns NULL. Anyone who wants to add new
invocation of ioremap_uc(), please consider using ioremap() instead or
adding a new ARCH specific ioremap_uc(), or refer to the callsite
in drivers/video/fbdev/aty/atyfb_base.c.

This change won't cuase breakage to the current kernel because in the
only ioremap_uc callsite, an adjustment is made to eliminate impact in
patch 1 of this series.

To get rid of all of them other than x86 and ia64, add asm-generic/io.h
to asm/io.h of mips ARCH. With this adding, we can get rid of the
ioremap_uc() in mips too. This is done in patch 2. And a followup patch
4 is added to remove duplicated code according to Arnd's suggestion.

Test:
=====
Except of Jiaxun's efficient testing on patch 2/4, I also did cross compiling
of this series on mips64, building passed.

History:
=======
v4->v5:
  - In v4, Thomas reported that adding <asm-generic/io.h> including into
    mips always cause crash on his malta qemu. Finally, Jiaxun stood up to
    take over the patch 2/4 and make it work. This patchset collects
    Jiaxun's patch v5 and add Arnd's tag. Thanks to Jiaxun.
  - Meanwhile, the old patch 4/4 need be adjusted because Jiaxun has done
    some removal of duplicated codes in <asm/io.h>.
  - Add reviewers' tags from v4.
v3->v4:
  - Add patch 1 to adjust code in the only ioremap_uc() callsite so that
    later removing ioremap_uc() won't cause breakage.
  - Update log and document writing in patch 3.
  - Add followup patch 4 to clean up duplicated code in asm/io.h of MIPS.
v2->v3:
  - In patch 1, move those macro definition of functio near its function
    declaration according to Arnd's suggestion. And remove the unneeded
    change in asm/mmiowb.h introduced in old version.
  - In patch 2, clean up and rewrite the messy document related to
    ioremap_uc() in Documentation/driver-api/device-io.rst.
v1->v2:
  - Update log of patch 2, and document related to ioremap_uc()
    according to Geert's comment.
  - Add Geert's Acked-by.

Arnd Bergmann (1):
  video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Baoquan He (2):
  arch/*/io.h: remove ioremap_uc in some architectures
  mips: io: remove duplicated codes

Jiaxun Yang (1):
  mips: add <asm-generic/io.h> including

 Documentation/driver-api/device-io.rst |   9 +-
 arch/alpha/include/asm/io.h            |   1 -
 arch/hexagon/include/asm/io.h          |   3 -
 arch/m68k/include/asm/kmap.h           |   1 -
 arch/mips/include/asm/io.h             | 123 +++++++++++++++----------
 arch/mips/include/asm/mmiowb.h         |   4 +-
 arch/mips/include/asm/smp-ops.h        |   2 -
 arch/mips/include/asm/smp.h            |   4 +-
 arch/mips/kernel/setup.c               |   1 +
 arch/mips/pci/pci-ip27.c               |   3 +
 arch/parisc/include/asm/io.h           |   2 -
 arch/powerpc/include/asm/io.h          |   1 -
 arch/sh/include/asm/io.h               |   2 -
 arch/sparc/include/asm/io_64.h         |   1 -
 drivers/video/fbdev/aty/atyfb_base.c   |   4 +
 15 files changed, 88 insertions(+), 73 deletions(-)

-- 
2.41.0

