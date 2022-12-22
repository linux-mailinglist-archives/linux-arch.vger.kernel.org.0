Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64118653A43
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 02:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiLVBVj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 20:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVBVh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 20:21:37 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E013F79;
        Wed, 21 Dec 2022 17:21:36 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id mn15so327743qvb.13;
        Wed, 21 Dec 2022 17:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vQ+zYR3T/MLmRvx1y4HrhYHCm/YFhPZhfUkcUcESfM=;
        b=l2fa+q+FEd2XVftJdKunAWsH1HG7S8dBsHb+pyQnkCSX1TXkuXti8JKHEfARmsSWRT
         xQebS6MZkDhnAZE1A3MSyIEK1eUPZUe1gprb22RcFQ//PuymRzd8BLNOtFAGp/a61FTx
         57JSoFp9tNTtN1QcKe76hmTtf/9LzGx+KUuDqVsOlyBa3P8Z9dneruz+vGAafZacrKIF
         5D4qdPPjWSMkoveXI7RPaxRIbWKtRPn50A747wMHhLLoo8U+VfMCok3edYL+wnhGBTCJ
         v8NDSlV/3lrChQ+UVwl5AoSSDCCE4tVU9WZAvbYyVr00y/GTw1B5kOj7gmspi/N26quY
         /XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vQ+zYR3T/MLmRvx1y4HrhYHCm/YFhPZhfUkcUcESfM=;
        b=ND/UE2/JXNEUI2dbIlyjr+6uvgO468uX1HSE31ty6dmzK2iEajgB8OSbC9UrYKhY5B
         sFtjxhy6lZ4oxKvEArvHXP0/1b7lc+uL2K5cpzzczLFPLSAWEVTZj4C0OTbe+g/5pngu
         FBX9WligWtHJSHfD4J05anJYiYxNBCt6TULddwWpJU09OergDPLe46Pc/I1p0Lqtto02
         /IkHUklQlQgQ1LVGhmCM2Mk8yVdF4YyLkVbFzHHLQON/ydq/guQ2P/4GgpgDD9L4h7i7
         jEay9HiP6V55/NoGe/1+yY0vkhJK5ymJ8ij2822+6FMpHofo0qJZlJQkyjdLeb03IaHs
         qmQw==
X-Gm-Message-State: AFqh2krEZcDhWY5NtkbyXM/mE6/cesNt2DUZpl1Fyf7nvq3NMpR0WZro
        HVoB95PpGvaL1DrWLC8Ss4s=
X-Google-Smtp-Source: AMrXdXsShUh4L0yNGW8xONTed3Jku8Vj2tplYIwpahvEr5EHAURbNPUd/5CxhDGXUPZFyuLmJTm1qQ==
X-Received: by 2002:a05:6214:1bcd:b0:4c7:595c:993b with SMTP id m13-20020a0562141bcd00b004c7595c993bmr7380408qvc.40.1671672095984;
        Wed, 21 Dec 2022 17:21:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006fc2b672950sm11762886qko.37.2022.12.21.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 17:21:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 53E7F27C0054;
        Wed, 21 Dec 2022 20:21:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Dec 2022 20:21:34 -0500
X-ME-Sender: <xms:HLGjY9HklIzv77_Ct9lMRDUUZb6eQZa3yWh170mrFyW89x0jtHNjOA>
    <xme:HLGjYyVPmxd67lgBprsePVUHyTIbmxYBuswvDpnSE1LaX4Fk0VtZwvRh0xyufIUfo
    Z4CcOSYLSo3jI-gsA>
X-ME-Received: <xmr:HLGjY_JIuJnH4DJCOG6szjiAGggRCSJAEb8Iwik3CXE1nqxc07XdZPwLNC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HLGjYzHn-2QPGDrrRW8mLT94tasGENTscfk3B9t1nA3LK58a-ZZAMw>
    <xmx:HLGjYzU6ZywxNOeGu02VYyDqSSw-TM6buuzedUbIQ3Dz8ouTDzdx1Q>
    <xmx:HLGjY-MCAsYWrrwM_UVYF3caK2jVGszAVuVLkzMGsuXrqP9hm8VU4w>
    <xmx:HrGjY1HNBcK7WC41nwtRf2BlnZ2Rer4p-OxYjeo5j3vOumT9YXfVdghNAUc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Dec 2022 20:21:31 -0500 (EST)
Date:   Wed, 21 Dec 2022 17:21:09 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 00/12] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Message-ID: <Y6OxBW5F/ZF5wocE@boqun-archlinux>
References: <20221219153525.632521981@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219153525.632521981@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Mon, Dec 19, 2022 at 04:35:25PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Since Linus hated on cmpxchg_double(), a few patches to get rid of it, as proposed here:
> 
>   https://lkml.kernel.org/r/Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net
> 
> based on tip/master because Linus' tree is moving a wee bit fast at the moment.
> 
> 0day robot is all green for building, very limited testing on arm64/s390
> for obvious raisins -- I tried to get the asm right, but please, double
> check.
> 

I added some test cases for cmpxcgh128 APIs, and found two issues. I
will reply separately in the patches. The test cases themselves are at
the end, let me know if you want to me to send a proper patch.

Regards,
Boqun

------------------------------------------------------------>8
Subject: [PATCH] atomic: Add test cases for cmpxchg128 family

Besides for 32bit and 64bit cmpxchg, we only test via atomic_cmpxchg_*
APIs, add tests via cmpxchg* APIs while we are at it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/atomic64_test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..7f79d0704ba8 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -76,12 +76,19 @@ do {								\
 	BUG_ON(atomic##bit##_read(&v) != expect);		\
 } while (0)
 
+#define TEST_ARGS_PLAIN(_, op, init, ret, expect, args...)	\
+do {								\
+	__WRITE_ONCE(n, init);					\
+	BUG_ON(op(&n, ##args) != ret);				\
+	BUG_ON(__READ_ONCE(n) != expect);			\
+} while (0)
+
 #define XCHG_FAMILY_TEST(bit, init, new)				\
 do {									\
 	FAMILY_TEST(TEST_ARGS, bit, xchg, init, init, new, new);	\
 } while (0)
 
-#define CMPXCHG_FAMILY_TEST(bit, init, new, wrong)			\
+#define ATOMIC_CMPXCHG_FAMILY_TEST(bit, init, new, wrong)		\
 do {									\
 	FAMILY_TEST(TEST_ARGS, bit, cmpxchg, 				\
 			init, init, new, init, new);			\
@@ -89,6 +96,14 @@ do {									\
 			init, init, init, wrong, new);			\
 } while (0)
 
+#define CMPXCHG_FAMILY_TEST(bit, init, new, wrong)			\
+do {									\
+	FAMILY_TEST(TEST_ARGS_PLAIN, _, cmpxchg##bit, 			\
+			init, init, new, init, new);			\
+	FAMILY_TEST(TEST_ARGS_PLAIN, _, cmpxchg##bit,			\
+			init, init, init, wrong, new);			\
+} while (0)
+
 #define INC_RETURN_FAMILY_TEST(bit, i)			\
 do {							\
 	FAMILY_TEST(TEST_ARGS, bit, inc_return,		\
@@ -109,6 +124,7 @@ static __init void test_atomic(void)
 	int one = 1;
 
 	atomic_t v;
+	int n;
 	int r;
 
 	TEST(, add, +=, onestwos);
@@ -139,6 +155,7 @@ static __init void test_atomic(void)
 	DEC_RETURN_FAMILY_TEST(, v0);
 
 	XCHG_FAMILY_TEST(, v0, v1);
+	ATOMIC_CMPXCHG_FAMILY_TEST(, v0, v1, onestwos);
 	CMPXCHG_FAMILY_TEST(, v0, v1, onestwos);
 
 }
@@ -155,6 +172,7 @@ static __init void test_atomic64(void)
 	int r_int;
 
 	atomic64_t v = ATOMIC64_INIT(v0);
+	long long n = 0;
 	long long r = v0;
 	BUG_ON(v.counter != r);
 
@@ -201,6 +219,7 @@ static __init void test_atomic64(void)
 	DEC_RETURN_FAMILY_TEST(64, v0);
 
 	XCHG_FAMILY_TEST(64, v0, v1);
+	ATOMIC_CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
 	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
 
 	INIT(v0);
@@ -245,10 +264,30 @@ static __init void test_atomic64(void)
 	BUG_ON(!r_int);
 }
 
+#ifdef system_has_cmpxchg128
+static __init void test_atomic128(void)
+{
+	long long v0 = 0xaaa31337c001d00dLL;
+	long long v1 = 0xdeadbeefdeafcafeLL;
+	long long v2 = 0xfaceabadf00df001LL;
+	long long v3 = 0x8000000000000000LL;
+
+	s128 init = ((s128)v0 << 64) + v1;
+	s128 new = ((s128)v1 << 64) + v0;
+	s128 wrong = ((s128)v2 << 64) + v3;
+	s128 n = 1;
+
+	CMPXCHG_FAMILY_TEST(128, init, new, wrong);
+}
+#else
+static __init void test_atomic128(void) {}
+#endif
+
 static __init int test_atomics_init(void)
 {
 	test_atomic();
 	test_atomic64();
+	test_atomic128();
 
 #ifdef CONFIG_X86
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
-- 
2.38.1

