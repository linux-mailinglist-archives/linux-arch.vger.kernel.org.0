Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D67181B4
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjEaN21 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEaN2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DFC126;
        Wed, 31 May 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wcJJV24VbYlY1PWzzae048ORvkrTfGMOvTB+4LRdIko=; b=ZCaN9EKWJgEkcuGgxM/ADbx94M
        G03dV6vMZ01SeuX4XeUD/ST9pnnkWJlhFyUn36PeSTx4HwZLOaV1Un1/UIQdwmGQcFJy5ke1y1ph0
        4gI+sbIacF5Qi2XhKT65K6WXemSMLSlsiRy1sMyJNOgV1Tn8vRmRMUZmDLnUwZq+cghRKjKS3YSq2
        nov0q53CxHjOQ380s4gPZqDiXzc10/7e5vnGZl2HdRLxV+I+eL6nN6JB7wWpO5iWlxdh7Qc4sUzGU
        t/I0z4d02H+1QiGZjucBz1TMMe0a61V9LL4YUcCfUju21PcwS5g76pVkW0OKG7aSE+R6CkRgnDmL/
        hrab2zKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LrG-007IIj-33; Wed, 31 May 2023 13:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03CEF30074B;
        Wed, 31 May 2023 15:27:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7798E243B69E6; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531130833.635651916@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org
Subject: [PATCH 00/12] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

After much breaking of things, find here the improved version.

Since v3:

 - unbreak everything that does *NOT* have cmpxchg128()

   Notably this_cpu_cmpxchg_double() is used unconditionally by SLUB
   which means that this_cpu_try_cmpxchg128() needs to be unconditionally
   available on all 64bit architectures.

 - fixed up x86/x86_64 cmpxchg{8,16}b emulation for this_cpu_cmpxchg{64,128}()

 - introduce {raw,this}_cpu_try_cmpxchg*()

 - add fallback for !__SIZEOF_INT128__ 64bit architectures

   Sadly there are supported 64bit architecture/compiler combinations that do
   not have __SIZEOF_INT128__, specifically it was found that HPPA64 only added
   this with GCC-11.

   this is yuck, and ideally we'd simply raise compiler requirements, but this
   'works'.

My plan is to re-add this to tip/locking/core and thus -next later this week.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

---
 Documentation/core-api/this_cpu_ops.rst     |   2 -
 arch/arm64/include/asm/atomic_ll_sc.h       |  56 +++---
 arch/arm64/include/asm/atomic_lse.h         |  39 ++---
 arch/arm64/include/asm/cmpxchg.h            |  48 ++----
 arch/arm64/include/asm/percpu.h             |  30 ++--
 arch/s390/include/asm/cmpxchg.h             |  32 +---
 arch/s390/include/asm/cpu_mf.h              |   2 +-
 arch/s390/include/asm/percpu.h              |  34 ++--
 arch/s390/kernel/perf_cpum_sf.c             |  16 +-
 arch/x86/include/asm/cmpxchg.h              |  25 ---
 arch/x86/include/asm/cmpxchg_32.h           |   2 +-
 arch/x86/include/asm/cmpxchg_64.h           |  63 ++++++-
 arch/x86/include/asm/percpu.h               | 102 ++++++-----
 arch/x86/lib/Makefile                       |   3 +-
 arch/x86/lib/cmpxchg16b_emu.S               |  43 +++--
 arch/x86/lib/cmpxchg8b_emu.S                |  67 ++++++--
 drivers/iommu/amd/amd_iommu_types.h         |   9 +-
 drivers/iommu/amd/iommu.c                   |  10 +-
 drivers/iommu/intel/irq_remapping.c         |   8 +-
 include/asm-generic/percpu.h                | 257 ++++++++++++++++++++++------
 include/crypto/b128ops.h                    |  14 +-
 include/linux/atomic/atomic-arch-fallback.h |  95 +++++++++-
 include/linux/atomic/atomic-instrumented.h  |  93 ++++++++--
 include/linux/dmar.h                        | 125 +++++++-------
 include/linux/percpu-defs.h                 |  45 ++---
 include/linux/slub_def.h                    |  12 +-
 include/linux/types.h                       |  12 ++
 include/uapi/linux/types.h                  |   4 +
 lib/crypto/curve25519-hacl64.c              |   2 -
 lib/crypto/poly1305-donna64.c               |   2 -
 mm/slab.h                                   |  53 +++++-
 mm/slub.c                                   | 139 +++++++++------
 scripts/atomic/gen-atomic-fallback.sh       |   4 +-
 scripts/atomic/gen-atomic-instrumented.sh   |  19 +-
 34 files changed, 952 insertions(+), 515 deletions(-)

