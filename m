Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C6736F38
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjFTOxT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjFTOxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 10:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BDC4
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687272755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=No1ZAzXRenHK6Spay7fCIW5zNaUlPsGtRXWs40EaAkg=;
        b=E+2rvkchJP4KwUh0RKc+LmD1DNImntu3ru3cT3YZM5g2fZ3aCV7k9kvd+E50KUbgLsG/je
        mqY1vpdk/BpDRI4qwDcEWwk2l6U9Sc3GAIoSCf+tLzUuglKT8CTOjfSLFdYZz0rAKoNZNG
        UquCyeAIxvr6KJihM092LKnHoqHv6QQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-9hW9-9gWM06uUSep_ULxGA-1; Tue, 20 Jun 2023 10:52:31 -0400
X-MC-Unique: 9hW9-9gWM06uUSep_ULxGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4169729DD9A3;
        Tue, 20 Jun 2023 14:46:34 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.195.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 863679E9C;
        Tue, 20 Jun 2023 14:46:25 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, peterz@infradead.org,
        ardb@kernel.org, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH v2 0/2] send tlb_remove_table_smp_sync IPI only to necessary CPUs
Date:   Tue, 20 Jun 2023 17:46:16 +0300
Message-Id: <20230620144618.125703-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
indiscriminately, this causes unnecessary work and delays notable in
real-time use-cases and isolated cpus.
By limiting the IPI to only be sent to cpus referencing the effected
mm.
a config to differentiate architectures that support mm_cpumask from
those that don't will allow safe usage of this feature.

changes from -v1:
- Previous version included a patch to only send the IPI to CPU's with
context_tracking in the kernel space, this was removed due to race 
condition concerns.
- for archs that do not maintain mm_cpumask the mask used should be
 cpu_online_mask (Peter Zijlstra).
 
 v1: https://lore.kernel.org/all/20230404134224.137038-1-ypodemsk@redhat.com/

Yair Podemsky (2):
  arch: Introduce ARCH_HAS_CPUMASK_BITS
  mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to MM CPUs

 arch/Kconfig              |  8 ++++++++
 arch/arm/Kconfig          |  1 +
 arch/powerpc/Kconfig      |  1 +
 arch/s390/Kconfig         |  1 +
 arch/sparc/Kconfig        |  1 +
 arch/x86/Kconfig          |  1 +
 include/asm-generic/tlb.h |  4 ++--
 mm/khugepaged.c           |  4 ++--
 mm/mmu_gather.c           | 17 ++++++++++++-----
 9 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.39.3

