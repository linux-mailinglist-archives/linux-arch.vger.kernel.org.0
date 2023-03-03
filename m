Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096406A9531
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCCK3P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 05:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCCK3O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 05:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF112BF8
        for <linux-arch@vger.kernel.org>; Fri,  3 Mar 2023 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677839311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O2k0Ei/F4zU2Rulh7j3IWkXRZQv/tvq6gI1ZLtPy3Gw=;
        b=MzgKjv5htJgDZmz38hx8wZ9mFjdss4EDKtBJFZKqiqqvx6kSsF6TTjVp9UR2H4OVhUKDAb
        fv+byFdHXYCGAvimGrRtPSosrq8p9epBdZYW4HGLeg7dJjWEm5QPE+8RceMtRZXkK/XXp6
        uqW2NICPqOEQ/8SpDBfFjXWX9/SRtvA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-OfxrwEaEPyGWu_7JaYcaTQ-1; Fri, 03 Mar 2023 05:28:26 -0500
X-MC-Unique: OfxrwEaEPyGWu_7JaYcaTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2064829AA3AC;
        Fri,  3 Mar 2023 10:28:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-150.pek2.redhat.com [10.72.13.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E041DC16900;
        Fri,  3 Mar 2023 10:28:21 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/2] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Fri,  3 Mar 2023 18:28:15 +0800
Message-Id: <20230303102817.212148-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
except of x86 and ia64. They will use the default ioremap_uc definition
in <asm-generic/io.h> which returns NULL. If any arch sees a breakage
caused by the default ioremap_uc(), it can provide a sepcific one for its
own usage. This is done in patch 2.

To get rid of all of them other than x86 and ia64, add asm-generic/io.h
to asm/io.h of mips ARCH. With this adding, we can get rid of the
ioremap_uc() in mips too. Adding asm-generic/io.h is done in patch 1.

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

Baoquan He (2):
  mips: add <asm-generic/io.h> including
  arch/*/io.h: remove ioremap_uc in some architectures

 Documentation/driver-api/device-io.rst | 14 +++--
 arch/alpha/include/asm/io.h            |  1 -
 arch/hexagon/include/asm/io.h          |  3 -
 arch/m68k/include/asm/kmap.h           |  1 -
 arch/mips/include/asm/io.h             | 79 +++++++++++++++++++++++---
 arch/parisc/include/asm/io.h           |  2 -
 arch/powerpc/include/asm/io.h          |  1 -
 arch/sh/include/asm/io.h               |  2 -
 arch/sparc/include/asm/io_64.h         |  1 -
 9 files changed, 79 insertions(+), 25 deletions(-)

-- 
2.34.1

