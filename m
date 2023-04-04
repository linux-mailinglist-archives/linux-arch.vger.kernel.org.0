Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04B6D6388
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjDDNnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjDDNnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 09:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60CC468D
        for <linux-arch@vger.kernel.org>; Tue,  4 Apr 2023 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680615775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eOn+GooQef0PZGSR4LECkucKGIH5iRWxz3Wp3EiY8Go=;
        b=Q4A1PZMH/3oWU8Y0Vqw0Y+aFINdfkLgQH1AbhBRs8BO71OVwa2nScDgG6Ea6MHSzerMwWd
        92qTPq/kCT5YW2NUP3ec4+DAUkycxageMHg32hGpr+ELYJBYXMRVPgpf9YIxxYbTliNJ7v
        CvvPy1ox6VpqUTXVx3uFeW6fb+fK1sw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-5BjHu8A0ORC4zh0ZPovsnQ-1; Tue, 04 Apr 2023 09:42:50 -0400
X-MC-Unique: 5BjHu8A0ORC4zh0ZPovsnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0B332A59564;
        Tue,  4 Apr 2023 13:42:48 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41AAB2166B29;
        Tue,  4 Apr 2023 13:42:40 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        frederic@kernel.org, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com
Cc:     ypodemsk@redhat.com, alougovs@redhat.com
Subject: [PATCH 0/3] send tlb_remove_table_smp_sync IPI only to necessary CPUs
Date:   Tue,  4 Apr 2023 16:42:21 +0300
Message-Id: <20230404134224.137038-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
indiscriminately, this causes unnecessary work and delays notable in
real-time use-cases and isolated cpus.
By limiting the IPI to only be sent to cpus referencing the effected
mm and in kernel mode latency is improved.
a config to differentiate architectures that support mm_cpumask from
those that don't will allow safe usage of this feature.

Yair Podemsky (3):
  arch: Introduce ARCH_HAS_CPUMASK_BITS
  mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to MM CPUs
  mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to CPUs in
    kernel mode

-- 
2.31.1

