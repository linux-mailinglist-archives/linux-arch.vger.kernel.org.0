Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F77026B9
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbjEOIHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbjEOIHa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:07:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DF1736;
        Mon, 15 May 2023 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oaAnHSQUa44CIjEzLECo4Bz9k0HVG1DLxoBT0I79NeI=; b=NfkvPcdWsJTjmoEQrA9fvkbzZc
        OLWjr4UU1kWvWf66uviIN6aqUIZ1bU0a8aEQPzT/ji1FUTxQToxV1V2kLh8dentwTx5nRMQ4vbB0i
        gIPkqOaBfpPHRlc4Q9v4DKGIZOs5zR693IMyllbhfUlUJPHFrv0sH5wUWWcgPRBAKgBI1lgDssb4e
        9PWNLgpBVKQLGKCOHMSvDJkLwwQ85cxYADGoR5hXnOpJdsJmtsyLLYpk0hwzrXnE5x14WXOtUXAW9
        mjJQ2i0rMf3kX9KquBpjBy/2GJyEk+TX/LIQwUBEiDSc3Rf/hALuWs5q5Nr/iPhIXqgtRSb4GdE7Z
        shGEbmvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyTDk-003HUQ-Em; Mon, 15 May 2023 08:06:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 079C030003A;
        Mon, 15 May 2023 10:06:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6A6E202F7F66; Mon, 15 May 2023 10:06:10 +0200 (CEST)
Message-ID: <20230515075659.118447996@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 09:56:59 +0200
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
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 00/11] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

I seem to have forgotten to post this series last release; so here goes. I'm
really hoping to merge it and forget about it.


Since Linus hated on cmpxchg_double(), a few patches to get rid of it, as
proposed here:

  https://lkml.kernel.org/r/Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net


These patches are based on 6.4.0-rc2.

Available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/wip-u128

Since v2:

 - reworked this_cpu_cmpxchg() to not implicity do u128 but provide explicit
   this_cpu_cmpxchg128() (arnd)
 - added try_cmpxchg12_local() (per the addition of the try_cmpxchg*_local()
   family of functions)
 - slight cleanup of the SLUB conversion (due to rebase and having to touch it)
 - added a 'cleanup' patch for SLUB, since I was staring at that anyway

Since v1:

 - rebaed on Eric's ghash cleanups (hence the cryptodev-2.6 dependency)
 - rebased on Heiko's s390/cpum_sf CDSG patch
 - fixed up a bunch of arch code
 - fixed up the inline asm to use 'u128 *' mem argument so the compiler knows
   how wide the modification is.
 - reworked the percpu thing to use union based type-punning instead of
   _Generic() based casts.

---
 Documentation/core-api/this_cpu_ops.rst     |   2 -
 arch/arm64/include/asm/atomic_ll_sc.h       |  56 ++++----
 arch/arm64/include/asm/atomic_lse.h         |  39 +++---
 arch/arm64/include/asm/cmpxchg.h            |  48 ++-----
 arch/arm64/include/asm/percpu.h             |  30 +++--
 arch/s390/include/asm/cmpxchg.h             |  32 +----
 arch/s390/include/asm/cpu_mf.h              |   2 +-
 arch/s390/include/asm/percpu.h              |  34 +++--
 arch/s390/kernel/perf_cpum_sf.c             |  16 +--
 arch/x86/include/asm/cmpxchg.h              |  25 ----
 arch/x86/include/asm/cmpxchg_32.h           |   2 +-
 arch/x86/include/asm/cmpxchg_64.h           |  63 ++++++++-
 arch/x86/include/asm/percpu.h               | 100 +++++++++------
 drivers/iommu/amd/amd_iommu_types.h         |   9 +-
 drivers/iommu/amd/iommu.c                   |  10 +-
 drivers/iommu/intel/irq_remapping.c         |   8 +-
 include/asm-generic/percpu.h                |  66 ++--------
 include/crypto/b128ops.h                    |  14 +-
 include/linux/atomic/atomic-arch-fallback.h |  95 +++++++++++++-
 include/linux/atomic/atomic-instrumented.h  |  93 ++++++++++++--
 include/linux/dmar.h                        | 125 +++++++++---------
 include/linux/percpu-defs.h                 |  38 ------
 include/linux/slub_def.h                    |  12 +-
 include/linux/types.h                       |   5 +
 include/uapi/linux/types.h                  |   4 +
 lib/crypto/curve25519-hacl64.c              |   2 -
 lib/crypto/poly1305-donna64.c               |   2 -
 mm/slab.h                                   |  49 ++++++-
 mm/slub.c                                   | 191 ++++++++++++++--------------
 scripts/atomic/gen-atomic-fallback.sh       |   4 +-
 scripts/atomic/gen-atomic-instrumented.sh   |  19 +--
 31 files changed, 667 insertions(+), 528 deletions(-)

