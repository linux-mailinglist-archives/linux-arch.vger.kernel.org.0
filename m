Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB17026C1
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbjEOIHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjEOIH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:07:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32DE41;
        Mon, 15 May 2023 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qQ97W8DjtNWYNvTOAleOKLKZr+6FI4styhSio5/BDPE=; b=jDA5YrBAqv2XXwX2hyoap3XhWh
        FUFqXWI9xbofaUhrnD/ux504IzigT+5UAWA2nMY5JWOA6Oqia5Te8jXiDxFNK8pNpovPpq5Ipx4Tp
        BoP1Xn/k2yhszEl4J3D1i1ULvw2aVOT2NmbFxiAt/QCeyGGnPAoLUpB5+TENS4VG9T0BTK9qeOYph
        j0IJUDpNmFgbT4b5PUux6ZW+r1nWua3QIgMmTlB8o48//Is03yKfVTJtReG1SFLB/GbnnyxmvNPD4
        42RHsxPs8LP1AfUAk0r3kC5W2n+QFqPC+el6SkJJV5JBjO1M1OFIEMoIuucEObRX9HHJj+weRarpG
        WQ5sFIOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyTDl-00BQN6-1z;
        Mon, 15 May 2023 08:06:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 934F2305ECF;
        Mon, 15 May 2023 10:06:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D82FB202FCEA8; Mon, 15 May 2023 10:06:10 +0200 (CEST)
Message-ID: <20230515080554.657068280@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 09:57:10 +0200
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
Subject: [PATCH v3 11/11] s390/cpum_sf: Convert to cmpxchg128()
References: <20230515075659.118447996@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that there is a cross arch u128 and cmpxchg128(), use those
instead of the custom CDSG helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cpu_mf.h  |    2 +-
 arch/s390/kernel/perf_cpum_sf.c |   16 +++-------------
 2 files changed, 4 insertions(+), 14 deletions(-)

--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -140,7 +140,7 @@ union hws_trailer_header {
 		unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
 		unsigned long long overflow; /* 64 - Overflow Count   */
 	};
-	__uint128_t val;
+	u128 val;
 };
 
 struct hws_trailer_entry {
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1275,16 +1275,6 @@ static void hw_collect_samples(struct pe
 	}
 }
 
-static inline __uint128_t __cdsg(__uint128_t *ptr, __uint128_t old, __uint128_t new)
-{
-	asm volatile(
-		"	cdsg	%[old],%[new],%[ptr]\n"
-		: [old] "+d" (old), [ptr] "+QS" (*ptr)
-		: [new] "d" (new)
-		: "memory", "cc");
-	return old;
-}
-
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1362,7 +1352,7 @@ static void hw_perf_event_update(struct
 			new.f = 0;
 			new.a = 1;
 			new.overflow = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 
 		/* Advance to next sample-data-block */
@@ -1572,7 +1562,7 @@ static bool aux_set_alert(struct aux_buf
 		}
 		new.a = 1;
 		new.overflow = 0;
-		prev.val = __cdsg(&te->header.val, old.val, new.val);
+		prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 	} while (prev.val != old.val);
 	return true;
 }
@@ -1646,7 +1636,7 @@ static bool aux_reset_buffer(struct aux_
 				new.a = 1;
 			else
 				new.a = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 		*overflow += orig_overflow;
 	}


