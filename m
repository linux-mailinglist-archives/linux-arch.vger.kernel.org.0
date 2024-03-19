Return-Path: <linux-arch+bounces-3036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B670880366
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AE41F2246B
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A528DD1;
	Tue, 19 Mar 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJhbVJTi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182C2B9C4;
	Tue, 19 Mar 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869188; cv=none; b=tMs1A6esucphgkSobaCdWzY96SGrhxQEe/nuNJZ9q0iVx52lB6KBQ2d5hSui+4Edf630IQ4COiGLjOCEg7q5wEcL1WiXZ/0rIZ2UV2fygCOopFY0JWLjwwTG9bmH9owQem7fI3uOkX5ZI1txv9eJ2R+wxrfRbYcF2ofrHIcpvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869188; c=relaxed/simple;
	bh=9vsdrHOdvU595S95xdDkff2jQzfQkUKHeLLqhOfOYBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9UPwjwN5FhFmi6yLPD+T19lsHFTBj7XeeUvkd6e+J5Nd03vNzAv6iKtaL6MxSp2bdLqG/GdZNuPsTSlA3pK0+J9xz/j2MUgw7SoJMTG+X+BsmaGJKM28szDGJbEtc6tc7Vl9QZYLI/jTWZl+XXcSQPIJR1BrM6uNJbKIugyllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJhbVJTi; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6e7425a6714so879970b3a.0;
        Tue, 19 Mar 2024 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869186; x=1711473986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mICNFxVbuAWoATTcVLf7/7w/j3oPrAjNRgOFqEMU8tA=;
        b=VJhbVJTi+vb9ithpCZ6RdpkDpxO7aUMTN4nLGM+c3Vwzg1yUEJCKUJRdzNWYk3uchB
         FqZxs/KdjZVHQsw5xRIPlvN3BV+lFFadX1oh89lAMq8uHNBnSYiexAm5Hvu2W6/Fs1QT
         sbI9lugyUakEvw+vY3RtAwRyNwBorLlZFwv5KjQNIJYopw30FNdduAJlrVCEsQNoGIJX
         mSrY1YhmDWas1jkzySdb3A3oNTEv64lnt1L3n3ZDf5loeJ1ogipksQBShMu2KiQ3O9SN
         VpP1eG6yJj0PclsIBsPBeupiEMhPbNfUlAfApNA2rXoEBRE/xoTUf3QHKur8FQ1Ka2Qx
         VPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869186; x=1711473986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mICNFxVbuAWoATTcVLf7/7w/j3oPrAjNRgOFqEMU8tA=;
        b=Sfrhz+FAXU5krhUSBpPm9njrlNQCjWdKz6+XoFTPN0DDomakIWM+/146Du2gltu3L6
         +oaKD37Ge8gd+CcbQdZhKk5XBreq2a8pQCcXxmB5n7alaKY7RhdMnB0Yopzg1jcHtPqp
         9HSYdH1M0I3s9G/u3kBCoW2jTIxQZKKyiN7QKmXTXs/TBaZw4J0qKLTRBlZOZ96AowGg
         eSClxIrhdiJ5BV8uLufAJlBKhUU8q2zTpLqeHzgvvSI/iZm5nkIj7wyez0fYxbbme3k0
         ugorOKI1exrGGH4lVLPw8V8WU4HBTXJKCSpE+tkj7uiJgy+rccPAWhIlk8/705yig46y
         FGaA==
X-Forwarded-Encrypted: i=1; AJvYcCWIGNafoVRFp1CsnZwHezj4fem1B30mNzICC6vNyqz7L5Z4ENzY6heL2PRshiavjmrFHExQvTUinUQm2gCYaQkn6v/UFydWJq7QFS8sqJBsy55acQAYee0jJzUK54laHjBWhXUlm+c1Tcc2pjDsmwPXXhxGA1FkWam1eNlCgFejOmI0TR5dl69PNg==
X-Gm-Message-State: AOJu0Yw+XOmg8fuHaSr4UvDHkjQ/DPS/fWfkjVc/PQH/E1pdPWcJFmng
	xJ/LTSayst9nyr3D19Mko0n0XkAB6BLVsO2cdQkrKPxjjxzb1zA=
X-Google-Smtp-Source: AGHT+IEkv9g+J0IjH2Wlhic/LwJ5mFDbtJLCc/rqi59tk5VwUYFC/wW8XfNIU6Pv1Kca1IuACtmZRQ==
X-Received: by 2002:a05:6a00:99c:b0:6e6:976d:7f53 with SMTP id u28-20020a056a00099c00b006e6976d7f53mr3783163pfg.16.1710869186329;
        Tue, 19 Mar 2024 10:26:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b006e57247f4e5sm10038173pfo.8.2024.03.19.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:26 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	dan.j.williams@intel.com,
	honggyu.kim@sk.com,
	corbet@lwn.net,
	arnd@arndb.de,
	luto@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Date: Tue, 19 Mar 2024 13:26:09 -0400
Message-Id: <20240319172609.332900-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240319172609.332900-1-gregory.price@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement simple ktest that looks up the physical address via
/proc/self/pagemap and migrates the page based on that information.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 tools/testing/selftests/mm/migration.c | 99 ++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 6908569ef406..c005c98dbdc1 100644
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
@@ -94,6 +102,45 @@ int migrate(uint64_t *ptr, int n1, int n2)
 	return 0;
 }
 
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
+		 * FIXME: move_phys_pages was syscall 462 during RFC.
+		 * Update this when an official syscall number is adopted
+		 * and the libnuma interface is implemented.
+		 */
+		ret = syscall(462, 1, (void **) &paddr, &n2, &status,
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
@@ -199,4 +246,56 @@ TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
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


