Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E56A6AB6
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCAKXF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 05:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAKXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 05:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B33B0CC
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 02:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677666137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MMRQRl3t6hAKjtY5VRuUkJZdfgn6RD+/9pcPLSeWAJw=;
        b=TZKeqx0F4iEOmlEvt6qRdnlwHaUMfKd8DkWFfhD8xYWgx8crWRROGb3eUgveZKqTvBWGq3
        fBY7nwZ/ooBaigCd9rOPSuqVfS/1umBm3c6C4G55dDVQm1Lb/XMqgefhWn5bRUirs6QvMe
        iwL0TtXn+m2DydkrfKBc3OD1CxfX/DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151--ajzeegeMgyallSEeClPog-1; Wed, 01 Mar 2023 05:22:15 -0500
X-MC-Unique: -ajzeegeMgyallSEeClPog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58311882820;
        Wed,  1 Mar 2023 10:22:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED85D492C14;
        Wed,  1 Mar 2023 10:22:11 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, hch@infradead.org, mcgrof@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Wed,  1 Mar 2023 18:22:06 +0800
Message-Id: <20230301102208.148490-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset tries to remove ioremap_uc() in the current architectures
except of x86 and ia64. They will use the default ioremap_uc definition
in <asm-generic/io.h> which returns NULL.

If any arch sees a breakage caused by the default ioremap_uc(), it can
provide a sepcific one for its own usage.

v1->v2:
  - Update log of patch 2, and document related to ioremap_uc()
    according to Geert's comment.
  - Add Geert's Acked-by.

Baoquan He (2):
  mips: add <asm-generic/io.h> including
  arch/*/io.h: remove ioremap_uc in some architectures

 Documentation/driver-api/device-io.rst | 11 ++++--
 arch/alpha/include/asm/io.h            |  1 -
 arch/hexagon/include/asm/io.h          |  3 --
 arch/m68k/include/asm/kmap.h           |  1 -
 arch/mips/include/asm/io.h             | 47 +++++++++++++++++++++++++-
 arch/mips/include/asm/mmiowb.h         |  2 --
 arch/parisc/include/asm/io.h           |  2 --
 arch/powerpc/include/asm/io.h          |  1 -
 arch/sh/include/asm/io.h               |  2 --
 arch/sparc/include/asm/io_64.h         |  1 -
 10 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.34.1

