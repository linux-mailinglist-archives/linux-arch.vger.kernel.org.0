Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33EC688271
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjBBPbh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjBBPbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420A6EDE8;
        Thu,  2 Feb 2023 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W8jT5092DDtlCmrawW/Uxx2BFUdyhIJzihgo65ygdd4=; b=O3BwLZ6BbrBpkX4dSlLTVJddoL
        d+skGCA3LaLD1DjXUjhAZ+YXjWood4lIaETj8WAJCJtuCia+5JPoMriULzyTj05sSSbGGfFURgFzz
        uD8QxDHvTkyu9oqOWL1RbeWVgcL6nddQFkQjJ4QnQ5/nmWe4o+lp5X+xxotmAOSlzmYilLO3E3Xk0
        ANMykPFl0gECdwfo83f9ou7ADvruw1TbUxoxZJvaKSQvsVQMerp6elTDLX0a3tYlZXS6u2n04NOdI
        Zs8Ix4DJGOUZPVkTu/0aNeptCV8+384RejNjk7s8CGcHbikNTJKexF74/3bjQT3gCLRoTujYu6QEQ
        af1EG2rQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbVT-005CFd-1o;
        Thu, 02 Feb 2023 15:28:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F29F53001E5;
        Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7F28623F31FA6; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202145030.223740842@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:30 +0100
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
Subject: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

Since Linus hated on cmpxchg_double(), a few patches to get rid of it, as
proposed here:

  https://lkml.kernel.org/r/Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net


These patches are based on 6.2.0-rc6 + cryptodev-2.6, but also apply to next/master.

Available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/wip-u128

New since v1:

 - rebaed on Eric's ghash cleanups (hence the cryptodev-2.6 dependency)
 - rebased on Heiko's s390/cpum_sf CDSG patch
 - fixed up a bunch of arch code
 - fixed up the inline asm to use 'u128 *' mem argument so the compiler knows
   how wide the modification is.
 - reworked the percpu thing to use union based type-punning instead of
   _Generic() based casts.

---
 Documentation/core-api/this_cpu_ops.rst     |   2 -
 arch/arm64/include/asm/atomic_ll_sc.h       |  56 ++++++-----
 arch/arm64/include/asm/atomic_lse.h         |  39 ++++----
 arch/arm64/include/asm/cmpxchg.h            |  48 +++-------
 arch/arm64/include/asm/percpu.h             |  31 ++++--
 arch/s390/include/asm/cmpxchg.h             |  32 ++-----
 arch/s390/include/asm/cpu_mf.h              |   2 +-
 arch/s390/include/asm/percpu.h              |  35 ++++---
 arch/s390/kernel/perf_cpum_sf.c             |  22 ++---
 arch/x86/include/asm/cmpxchg.h              |  25 -----
 arch/x86/include/asm/cmpxchg_32.h           |   2 +-
 arch/x86/include/asm/cmpxchg_64.h           |  54 ++++++++++-
 arch/x86/include/asm/percpu.h               |  97 +++++++++++--------
 drivers/iommu/amd/amd_iommu_types.h         |   9 +-
 drivers/iommu/amd/iommu.c                   |  10 +-
 drivers/iommu/intel/irq_remapping.c         |   8 +-
 include/asm-generic/percpu.h                |  62 ++----------
 include/crypto/b128ops.h                    |  14 +--
 include/linux/atomic/atomic-arch-fallback.h |  95 ++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  |  88 ++++++++++++++---
 include/linux/dmar.h                        | 125 ++++++++++++------------
 include/linux/percpu-defs.h                 |  46 +++------
 include/linux/slub_def.h                    |  12 ++-
 include/linux/types.h                       |   5 +
 include/uapi/linux/types.h                  |   4 +
 lib/crypto/curve25519-hacl64.c              |   2 -
 lib/crypto/poly1305-donna64.c               |   2 -
 mm/slab.h                                   |  45 ++++++++-
 mm/slub.c                                   | 142 +++++++++++++++++-----------
 scripts/atomic/gen-atomic-fallback.sh       |   4 +-
 scripts/atomic/gen-atomic-instrumented.sh   |  21 ++--
 31 files changed, 645 insertions(+), 494 deletions(-)


