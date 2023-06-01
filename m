Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C371995D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjFAKSf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFAKSG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 06:18:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58A1FDB;
        Thu,  1 Jun 2023 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G1trJdY7ybtDfb34YzOEZVtQJ+4O7zYES3kMJ7sRdCU=; b=pytfcabSQbAioNogqcJyIjWxkb
        I3OIRz0nPyGAHQCouHiezAZ3WYDnbr+0H5ASElPr4+OfQuPcqSEVXUzQNdmNT0vDCq0lYth70hxc+
        nIxwWeL5rSBkZoelbLSxxySFndCPqg76D3wq86BEGZ1gkD10CrGs9NABCiAJPJkEv81csRGvvoVja
        EaBwzktB36vi1XtuFtdCEjY2KE+yJjTGMIB4mjx3jEx3iBh0aM1LDhfieu9IZABiemcJgKbkPFNuq
        /6ksBvE3iaE68Sn2CQ4733UmzPnTQKsAKE8EvFRBt0Ej6Ani+wvx452hsmvy64dZ4tGLH+6z41/Rs
        43i6i9qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4fJv-008GIu-Pp; Thu, 01 Jun 2023 10:14:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66A3C3002F0;
        Thu,  1 Jun 2023 12:14:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 374AA21484A8B; Thu,  1 Jun 2023 12:14:09 +0200 (CEST)
Date:   Thu, 1 Jun 2023 12:14:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v2 07/12] parisc/percpu: Work around the lack of
 __SIZEOF_INT128__
Message-ID: <20230601101409.GS4253@hirez.programming.kicks-ass.net>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 31, 2023 at 04:21:22PM +0200, Arnd Bergmann wrote:

> It would be nice to have the hack more localized to parisc
> and guarded with a CONFIG_GCC_VERSION check so we can kill
> it off in the future, once we drop either gcc-10 or parisc
> support.

I vote for dropping parisc -- it's the only 64bit arch that doesn't have
sane atomics.

Anyway, the below seems to work -- build tested with GCC-10.1

---
Subject: parisc/percpu: Work around the lack of __SIZEOF_INT128__
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue May 30 22:27:40 CEST 2023

HPPA64 is unique in not providing __SIZEOF_INT128__ across all
supported compilers, specifically it only started doing this with
GCC-11.

Since the per-cpu ops are universally availably, and
this_cpu_{,try_}cmpxchg128() is expected to be available on all 64bit
architectures a wee bodge is in order.

Sadly, while C reverts to memcpy() for assignment of POD types, it does
not revert to memcmp() for for equality. Therefore frob that manually.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/include/asm/percpu.h |   77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

--- /dev/null
+++ b/arch/parisc/include/asm/percpu.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_PARISC_PERCPU_H
+#define _ASM_PARISC_PERCPU_H
+
+#include <linux/types.h>
+
+#if defined(CONFIG_64BIT) && CONFIG_GCC_VERSION < 1100000
+
+/*
+ * GCC prior to 11 does not provide __SIZEOF_INT128__ on HPPA64
+ * as such we need to provide an alternative implementation of
+ * {raw,this}_cpu_{,try_}cmpxchg128().
+ *
+ * This obviously doesn't function as u128 should, but for the purpose
+ * of per-cpu cmpxchg128 it might just do.
+ */
+typedef struct {
+	u64 a, b;
+} u128 __attribute__((aligned(16)));
+
+#define raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
+	typeof(pcp) __val = *__p, __old = *(ovalp);			\
+	bool __ret;							\
+	if (!__builtin_memcmp(&__val, &__old, sizeof(pcp))) {		\
+		*__p = nval;						\
+		__ret = true;						\
+	} else {							\
+		*(ovalp) = __val;					\
+		__ret = false;						\
+	}								\
+	__ret;								\
+})
+
+#define raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)			\
+({									\
+	typeof(pcp) __old = (oval);					\
+	raw_cpu_generic_try_cmpxchg_memcpy(pcp, &__old, nval);		\
+	__old;								\
+})
+
+#define raw_cpu_cmpxchg128(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
+
+#define this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+	bool __ret;							\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval);	\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)		\
+({									\
+	typeof(pcp) __ret;						\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval);	\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define this_cpu_cmpxchg128(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
+
+#endif /* !__SIZEOF_INT128__ */
+
+#include <asm-generic/percpu.h>
+
+#endif /* _ASM_PARISC_PERCPU_H */
