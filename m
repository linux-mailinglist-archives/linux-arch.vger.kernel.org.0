Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A251D7A6F40
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjISXKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjISXJt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:49 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05F122;
        Tue, 19 Sep 2023 16:09:33 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-59bebd5bdadso64418327b3.0;
        Tue, 19 Sep 2023 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164972; x=1695769772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2rIP8yr4Z/tR7qtSq7lABbsZYKpf6sAk4TU1XcMfbs=;
        b=OfehRJ+VskevhNs5ISViFrl4mtSiWdgAkhoZgK3sjFyPytiazj0tKRZuF5eaEQLf9I
         s/cN/rnPAOxHmB1l8/z8V/uDORG/fsUpztSJ0dgwGMmq3gU3Dyc9KfK6KbhBcz7ZifpJ
         WZE6L+urt6TPisGfZjD1h7PK2Z+QFtX/NdSDUCOJqEDsxHu9VNge4wjJmt4T13w3ryv/
         uL29/UEFnlV4aHElXirlWDkNngM1808JqgrfSQ0izK8JTW7P9fyKw1dZrdQciosZ9ngT
         nAPozGiUT+1LECQ73z0KDjHQ5wLBydWdlyzRYnTmBHYUMArVh58lHGuoY+zlq4QLsHuB
         hK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164972; x=1695769772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2rIP8yr4Z/tR7qtSq7lABbsZYKpf6sAk4TU1XcMfbs=;
        b=gbEto3ODi/B+gXCFd1A4TZEkhvuXsMWTNGVrYN/yUiSw8tSgvro2WyGgYQrZzJQ76x
         wA3m1HRoAr/wxXqlBz+hL62UPaM0IMQlIgKEKQIYmL9bNpaakb14Ug8VysCqalrkhnPe
         fw15OrXlalfF3rQ6+fDkTRlKtCvNO/Ixc5TpOBH1/qbOUBxCyIhRdomhKbRv3Jcss0ou
         tLjaNxmHJ8ILRdtr2fMX//WNV3osKwDiSbG8/hlRRZQmCtQYHh8s8AIDzGw6E/9ddOT0
         TXRJCAIS5AyWs2SdeEi4xz0rcVp4b1rxFpAnNlU4wsrqIk8w+xvnSWvpeqobgtLKcv1g
         kpmw==
X-Gm-Message-State: AOJu0Yx3Y4PGR9cFYPHI6cLtZ1Rmyon76G6xPcyMZxy7ecV0LOvnHOyo
        19nmzL2qzZZXRsTQ9Z8V2aZlRP7fp2rh
X-Google-Smtp-Source: AGHT+IEE2Ri9fZWDKXKBXMbI9+9SbxlW7iU1XmgowN/E2j062+16hKUlkNBHSsb1+gXgfWAidBpIZg==
X-Received: by 2002:a0d:df01:0:b0:59c:7d0:ab06 with SMTP id i1-20020a0ddf01000000b0059c07d0ab06mr987766ywe.45.1695164971726;
        Tue, 19 Sep 2023 16:09:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:31 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 5/5] ktest: sys_move_phys_pages ktest
Date:   Tue, 19 Sep 2023 19:09:08 -0400
Message-Id: <20230919230909.530174-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230919230909.530174-1-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement simple ktest that looks up the physical address via
/proc/self/pagemap and migrates the page based on that information.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 tools/testing/selftests/mm/migration.c | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 6908569ef406..67fbae243f94 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -5,6 +5,8 @@
  */
 
 #include "../kselftest_harness.h"
+#include <stdint.h>
+#include <stdio.h>
 #include <strings.h>
 #include <pthread.h>
 #include <numa.h>
@@ -14,11 +16,17 @@
 #include <sys/types.h>
 #include <signal.h>
 #include <time.h>
+#include <unistd.h>
 
 #define TWOMEG (2<<20)
 #define RUNTIME (20)
 
+#define GET_BIT(X, Y) ((X & ((uint64_t)1<<Y)) >> Y)
+#define GET_PFN(X) (X & 0x7FFFFFFFFFFFFFull)
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+#define PAGEMAP_ENTRY 8
+const int __endian_bit = 1;
+#define is_bigendian() ((*(char *)&__endian_bit) == 0)
 
 FIXTURE(migration)
 {
@@ -94,6 +102,47 @@ int migrate(uint64_t *ptr, int n1, int n2)
 	return 0;
 }
 
+
+
+int migrate_phys(uint64_t paddr, int n1, int n2)
+{
+	int ret, tmp;
+	int status = 0;
+	struct timespec ts1, ts2;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
+		return -1;
+
+	while (1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &ts2))
+			return -1;
+
+		if (ts2.tv_sec - ts1.tv_sec >= RUNTIME)
+			return 0;
+
+		/*
+		 * FIXME: move_phys_pages was syscall 454 during RFC.
+		 * Update this when an official syscall number is adopted
+		 * and the libnuma interface is implemented.
+		 */
+		ret = syscall(454, 1, (void **) &paddr, &n2, &status,
+			      MPOL_MF_MOVE_ALL);
+		if (ret) {
+			if (ret > 0)
+				printf("Didn't migrate %d pages\n", ret);
+			else
+				perror("Couldn't migrate pages");
+			return -2;
+		}
+
+		tmp = n2;
+		n2 = n1;
+		n1 = tmp;
+	}
+
+	return 0;
+}
+
 void *access_mem(void *ptr)
 {
 	volatile uint64_t y = 0;
@@ -199,4 +248,56 @@ TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
 		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
 }
 
+/*
+ * Same as the basic migration, but test move_phys_pages.
+ */
+TEST_F_TIMEOUT(migration, phys_addr, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	uint64_t pagemap_val, paddr, file_offset;
+	unsigned char c_buf[PAGEMAP_ENTRY];
+	int i, c, status;
+	FILE *f;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	memset(ptr, 0xde, TWOMEG);
+
+	/* PFN of ptr from /proc/self/pagemap */
+	f = fopen("/proc/self/pagemap", "rb");
+	file_offset = ((uint64_t)ptr) / getpagesize() * PAGEMAP_ENTRY;
+	status = fseek(f, file_offset, SEEK_SET);
+	ASSERT_EQ(status, 0);
+	for (i = 0; i < PAGEMAP_ENTRY; i++) {
+		c = getc(f);
+		ASSERT_NE(c, EOF);
+		/* handle endiand differences */
+		if (is_bigendian())
+			c_buf[i] = c;
+		else
+			c_buf[PAGEMAP_ENTRY - i - 1] = c;
+	}
+	fclose(f);
+
+	for (i = 0; i < PAGEMAP_ENTRY; i++)
+		pagemap_val = (pagemap_val << 8) + c_buf[i];
+
+	ASSERT_TRUE(GET_BIT(pagemap_val, 63));
+	/* This reports a pfn, we need to shift this by page size */
+	paddr = GET_PFN(pagemap_val) << __builtin_ctz(getpagesize());
+
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate_phys(paddr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.39.1

