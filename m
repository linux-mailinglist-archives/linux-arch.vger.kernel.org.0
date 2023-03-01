Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65556A66AA
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCADox (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCADod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD030E94
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2023 19:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677642219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b04gx2CEsZva7MKdHssokOo8Q5KwYfP6QKwltziak5c=;
        b=SAMlxEUx0eFel8TWVCwXfbB6792NleAganWiZ7Gj3/K1vE70/zn7dozuF5Cb+8b7MwKa2z
        TonQm/JQY0HgCOPYOG4RzOybZoMt/mSWcki37ETukPjD/abvjRns0J/da3edyIXk8Yr5Po
        6+hlPh4HNlIWLCFsmfvFLxn1ek2hxrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-8Y9zFz3EOyOEh-jq97Zmzw-1; Tue, 28 Feb 2023 22:43:34 -0500
X-MC-Unique: 8Y9zFz3EOyOEh-jq97Zmzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61920811E6E;
        Wed,  1 Mar 2023 03:43:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D76C3C15BAD;
        Wed,  1 Mar 2023 03:43:28 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        willy@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 06/17] mm/ioremap: add slab availability checking in ioremap_prot
Date:   Wed,  1 Mar 2023 11:42:36 +0800
Message-Id: <20230301034247.136007-7-bhe@redhat.com>
In-Reply-To: <20230301034247.136007-1-bhe@redhat.com>
References: <20230301034247.136007-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

Several architectures has done checking if slab if available in
ioremap_prot(). In fact it should be done in generic ioremap_prot()
since on any architecutre, slab allocator must be available before
get_vm_area_caller() and vunmap() are used.

Add the checking into generic_ioremap_prot().

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/ioremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 9f34a8f90b58..2fbe6b9bc50e 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -18,6 +18,10 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr_t last_addr;
 	struct vm_struct *area;
 
+	/* An early platform driver might end up here */
+	if (!slab_is_available())
+		return NULL;
+
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
-- 
2.34.1

