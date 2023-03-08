Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B26B080A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCHNLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 08:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCHNKw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 08:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4591B43
        for <linux-arch@vger.kernel.org>; Wed,  8 Mar 2023 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678280842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uepvc5of9UN+iAXjqvR8mh3Kz3/cFenM5r6Yjs8S6hE=;
        b=T7nQSSWfqVaHP6frStBC/gmpkBua620QR+kN9NXGrxyGIp4evQ186V90kDgfyRcr2Z+NfR
        D2/GB6gZ2b5+J9xoMxRcKWiQH8Bu9QAZsajgVRU6PxsFy5Q7ivibjaqw60VoZQKgZqb4Tg
        1z3vgQcV1BNAne8rOu/7EdjzzR9krPI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-UZNxw_osN4mkAJNTU4up3g-1; Wed, 08 Mar 2023 08:07:18 -0500
X-MC-Unique: UZNxw_osN4mkAJNTU4up3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D503E3806702;
        Wed,  8 Mar 2023 13:07:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A128B2166B26;
        Wed,  8 Mar 2023 13:07:13 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/4] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Wed,  8 Mar 2023 21:07:06 +0800
Message-Id: <20230308130710.368085-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Baoquan He (3):
  mips: add <asm-generic/io.h> including
  arch/*/io.h: remove ioremap_uc in some architectures
  mips: io: remove duplicated codes

 Documentation/driver-api/device-io.rst |   9 +-
 arch/alpha/include/asm/io.h            |   1 -
 arch/hexagon/include/asm/io.h          |   3 -
 arch/m68k/include/asm/kmap.h           |   1 -
 arch/mips/include/asm/io.h             | 112 +++++++++++++++----------
 arch/parisc/include/asm/io.h           |   2 -
 arch/powerpc/include/asm/io.h          |   1 -
 arch/sh/include/asm/io.h               |   2 -
 arch/sparc/include/asm/io_64.h         |   1 -
 drivers/video/fbdev/aty/atyfb_base.c   |   4 +
 10 files changed, 78 insertions(+), 58 deletions(-)

-- 
2.34.1

