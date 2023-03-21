Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF46C31A2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 13:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCUMZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCUMZg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 08:25:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5533A32E59;
        Tue, 21 Mar 2023 05:25:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1EE1424;
        Tue, 21 Mar 2023 05:26:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAF203F71E;
        Tue, 21 Mar 2023 05:25:28 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: [PATCH v2 2/4] lib: test clear_user()
Date:   Tue, 21 Mar 2023 12:25:12 +0000
Message-Id: <20230321122514.1743889-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321122514.1743889-1-mark.rutland@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The clear_user() function follows the same conventions as
copy_{to,from}_user(), and presumably has identical requirements on the
return value. Test it in the same way.

I've given this a spin on a few architectures using the KUnit QEMU
harness, and it looks like most get *something* wrong, or I've
misunderstood and clear_user() doesn't have the same requirements as
copy_{to,from}_user()). From those initial runs:

* arm, arm64, i386, riscv, x86_64  don't ensure that at least 1 byte is
  zeroed when a partial zeroing is possible, e.g.

  | too few bytes consumed (offset=4095, size=2, ret=2)
  | too few bytes consumed (offset=4093, size=4, ret=4)
  | too few bytes consumed (offset=4089, size=8, ret=8)

* s390 reports that some bytes have been zeroed even when they haven't,
  e.g.

  | zeroed bytes incorrect (dst_page[4031+64]=0xca, offset=4031, size=66, ret=1

* sparc passses all tests

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org
---
 lib/usercopy_kunit.c | 89 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
index 45983952cc079..1ec0d5bbc179a 100644
--- a/lib/usercopy_kunit.c
+++ b/lib/usercopy_kunit.c
@@ -155,6 +155,11 @@ static void usercopy_test_exit(struct kunit *test)
 	usercopy_env_free(env);
 }
 
+static char buf_zero(int offset)
+{
+	return 0;
+}
+
 static char buf_pattern(int offset)
 {
 	return offset & 0xff;
@@ -230,6 +235,7 @@ static void assert_size_valid(struct kunit *test,
 
 static void assert_src_valid(struct kunit *test,
 			     const struct usercopy_params *params,
+			     char (*buf_expected)(int),
 			     const char *src, long src_offset,
 			     unsigned long ret)
 {
@@ -240,9 +246,10 @@ static void assert_src_valid(struct kunit *test,
 	 * A usercopy MUST NOT modify the source buffer.
 	 */
 	for (int i = 0; i < PAGE_SIZE; i++) {
+		char expected = buf_expected(i);
 		char val = src[i];
 
-		if (val == buf_pattern(i))
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -253,6 +260,7 @@ static void assert_src_valid(struct kunit *test,
 
 static void assert_dst_valid(struct kunit *test,
 			     const struct usercopy_params *params,
+			     char (*buf_expected)(int),
 			     const char *dst, long dst_offset,
 			     unsigned long ret)
 {
@@ -263,9 +271,10 @@ static void assert_dst_valid(struct kunit *test,
 	 * A usercopy MUST NOT modify any bytes before the destination buffer.
 	 */
 	for (int i = 0; i < dst_offset; i++) {
+		char expected = buf_expected(i);
 		char val = dst[i];
 
-		if (val == 0)
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -278,9 +287,10 @@ static void assert_dst_valid(struct kunit *test,
 	 * buffer.
 	 */
 	for (int i = dst_offset + size - ret; i < PAGE_SIZE; i++) {
+		char expected = buf_expected(i);
 		char val = dst[i];
 
-		if (val == 0)
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -316,6 +326,29 @@ static void assert_copy_valid(struct kunit *test,
 	}
 }
 
+static void assert_clear_valid(struct kunit *test,
+			       const struct usercopy_params *params,
+			       const char *dst, long dst_offset,
+			       unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	/*
+	 * Have we actually zeroed the bytes we expected to?
+	 */
+	for (int i = 0; i < params->size - ret; i++) {
+		char dst_val = dst[dst_offset + i];
+
+		if (dst_val == 0)
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"zeroed bytes incorrect (dst_page[%ld+%d]=0x%x, offset=%ld, size=%lu, ret=%lu",
+			dst_offset, i, dst_val,
+			offset, size, ret);
+	}
+}
 static unsigned long do_copy_to_user(const struct usercopy_env *env,
 				     const struct usercopy_params *params)
 {
@@ -344,6 +377,19 @@ static unsigned long do_copy_from_user(const struct usercopy_env *env,
 	return ret;
 }
 
+static unsigned long do_clear_user(const struct usercopy_env *env,
+				   const struct usercopy_params *params)
+{
+	void __user *uptr = (void __user *)UBUF_ADDR_BASE + params->offset;
+	unsigned long ret;
+
+	kthread_use_mm(env->mm);
+	ret = clear_user(uptr, params->size);
+	kthread_unuse_mm(env->mm);
+
+	return ret;
+}
+
 /*
  * Generate the size and offset combinations to test.
  *
@@ -378,8 +424,10 @@ static void test_copy_to_user(struct kunit *test)
 		ret = do_copy_to_user(env, &params);
 
 		assert_size_valid(test, &params, ret);
-		assert_src_valid(test, &params, env->kbuf, 0, ret);
-		assert_dst_valid(test, &params, env->ubuf, params.offset, ret);
+		assert_src_valid(test, &params, buf_pattern,
+				 env->kbuf, 0, ret);
+		assert_dst_valid(test, &params, buf_zero,
+				 env->ubuf, params.offset, ret);
 		assert_copy_valid(test, &params,
 				  env->ubuf, params.offset,
 				  env->kbuf, 0,
@@ -404,8 +452,10 @@ static void test_copy_from_user(struct kunit *test)
 		ret = do_copy_from_user(env, &params);
 
 		assert_size_valid(test, &params, ret);
-		assert_src_valid(test, &params, env->ubuf, params.offset, ret);
-		assert_dst_valid(test, &params, env->kbuf, 0, ret);
+		assert_src_valid(test, &params, buf_pattern,
+				 env->ubuf, params.offset, ret);
+		assert_dst_valid(test, &params, buf_zero,
+				 env->kbuf, 0, ret);
 		assert_copy_valid(test, &params,
 				  env->kbuf, 0,
 				  env->ubuf, params.offset,
@@ -413,9 +463,34 @@ static void test_copy_from_user(struct kunit *test)
 	}
 }
 
+static void test_clear_user(struct kunit *test)
+{
+	const struct usercopy_env *env = test->priv;
+
+	for_each_size_offset(size, offset) {
+		const struct usercopy_params params = {
+			.size = size,
+			.offset = offset,
+		};
+		unsigned long ret;
+
+		buf_init_pattern(env->ubuf);
+
+		ret = do_clear_user(env, &params);
+
+		assert_size_valid(test, &params, ret);
+		assert_dst_valid(test, &params, buf_pattern,
+				 env->ubuf, params.offset, ret);
+		assert_clear_valid(test, &params,
+				   env->ubuf, params.offset,
+				   ret);
+	}
+}
+
 static struct kunit_case usercopy_cases[] = {
 	KUNIT_CASE(test_copy_to_user),
 	KUNIT_CASE(test_copy_from_user),
+	KUNIT_CASE(test_clear_user),
 	{ /* sentinel */ }
 };
 
-- 
2.30.2

