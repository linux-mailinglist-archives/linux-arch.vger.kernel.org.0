Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5C7A2429
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjIORC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjIORCg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 13:02:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D519BC
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c09673b006so18924005ad.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694797350; x=1695402150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln+7rHA69/YQ6l7rezPa2HlFS+4ma5eDvscwKBBdEIw=;
        b=ISknroYH8Pez9fMLY0dBDdnB/AAiPDtt3kDdrK9e48FLoWdA/xJ2zaGfPMGpwL3aM+
         TZr/VOErl4qkIHraP4tT05KIvsLm/wPr40uva1sqNDWGMrG+wx9h7TbHkbUgzahu7Js1
         zMOYgJHBCkKwjMvfw1DksM+6YZQ80Ik3dVqcOcYGod/bzm91oBCcnu0JTKDFhLwVRMA8
         qrdXji7Nt8IOiB4B4R5zc3ERkDhZ4zGEP1j70e9vGzofDjeZKYOKxOlP2zf1mfawQUnX
         7xoFmb9tbx1fUOhF7pOsraQuRNd0bBFcEc5D6BWikHLEzQkAGYl40rCEer2aPKsRBrYb
         QBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797350; x=1695402150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln+7rHA69/YQ6l7rezPa2HlFS+4ma5eDvscwKBBdEIw=;
        b=f1o73OAYLuOmVUZOCNQMG/1sGq5z2zMnvW1vA+ORttDYGKLyvsgQTRB5fORx3lQbgc
         4Q6vrAz4XTiShO8sttHFWLfdYob7M96vELufEzKvCDUUL1ybk4WrGpbPrJoI5C3TRW1P
         /oitmUpWhmW6ZtXsXV8SQyZ5pCmy4k9nTmThD2rPpoeb+fwjj4AO4+sRj5cky7NI0EaV
         mTJUB6JPMf1b/OBLJUV5HHo0Qcd78heQ5gKDNHF5i2VvkdTg9Y4z7oXVay+srna1b86B
         GvZ5LGiA41NGpOTGfVC89q4gIhT37DlrbEgYF1wMhvcTk4MNy6wNx1CwWGzHybTmsCRx
         qVnA==
X-Gm-Message-State: AOJu0Yy70CBfiNiNb0ajj/SUHIrHjY3tniiiQD51xGF/rPvKySK2+oUk
        VBtzbk/f47lK1Dq62AXZDDfk0w==
X-Google-Smtp-Source: AGHT+IHW0dFXuQ5J11FZ/mFNf2U7014xBJodgfH0AfGxl53c/+Th0Qz+Am146b6bzYb//uwFGTT5sg==
X-Received: by 2002:a17:902:a40b:b0:1bb:3406:a612 with SMTP id p11-20020a170902a40b00b001bb3406a612mr2116565plq.57.1694797349850;
        Fri, 15 Sep 2023 10:02:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001c44c8d857esm34299plq.120.2023.09.15.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:02:29 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/4] riscv: Add fine-tuned checksum functions
Date:   Fri, 15 Sep 2023 10:01:16 -0700
Message-Id: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyNBGUC/23Q30oFIRAG8Fc5eJ2ho67aVe8REf6rHWLXg56kO
 uy75x6ClvDyG5jfN8yV1FQwVfJwupKSGlbMaw/T3YmE2a1viWLsmQADwQyTNJ8vuOB3eglzCu/
 1Y6HRc6nAGBeAk753LukVP2/m03PPM9ZLLl+3isb36a8G00BrnDJqhVaM+86CeyzYcsU13Ie8k
 B1s8IdYpkYIdCSEOCkTvZbCDxBxRPQIETuiGEQho41aDBB5QDgfIbIjWocALtrUlQGijsjow03
 tl1jlDTjQSqd/yLZtP2bSzwXJAQAA
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking.

Vector support is included in this patch to start a discussion on that,
it can probably be optimized more. The vector patches still need some
work as they rely on GCC vector intrinsics types which cannot work in
the kernel since it requires C vector support rather than just assembler
support. I have tested the vector patches as standalone algorithms in QEMU.

This patch takes heavy use of the Zbb extension using alternatives
patching.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT
and RISCV_CHECKSUM_KUNIT.

I have attempted to make these functions as optimal as possible, but I
have not ran anything on actual riscv hardware. My performance testing
has been limited to inspecting the assembly, running the algorithms on
x86 hardware, and running in QEMU.

ip_fast_csum is a relatively small function so even though it is
possible to read 64 bits at a time on compatible hardware, the
bottleneck becomes the clean up and setup code so loading 32 bits at a
time is actually faster.

---
    
The algorithm proposed to replace the default csum_fold can be seen to
compute the same result by running all 2^32 possible inputs.
    
static inline unsigned int ror32(unsigned int word, unsigned int shift)
{
	return (word >> (shift & 31)) | (word << ((-shift) & 31));
}

unsigned short csum_fold(unsigned int csum)
{
	unsigned int sum = csum;
	sum = (sum & 0xffff) + (sum >> 16);
	sum = (sum & 0xffff) + (sum >> 16);
	return ~sum;
}

unsigned short csum_fold_arc(unsigned int csum)
{
	return ((~csum - ror32(csum, 16)) >> 16);
}

int main()
{
	unsigned int start = 0x0;
	do {
		if (csum_fold(start) != csum_fold_arc(start)) {
			printf("Not the same %u\n", start);
			return -1;
		}
		start += 1;
	} while(start != 0x0);
	printf("The same\n");
	return 0;
}

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
To: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
To: David Laight <David.Laight@aculab.com>
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
To: linux-arch@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Changes in v6:
- Fix accuracy of commit message for csum_fold
- Fix indentation
- Link to v5: https://lore.kernel.org/r/20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com

Changes in v5:
- Drop vector patches
- Check ZBB enabled before doing any ZBB code (Conor)
- Check endianness in IS_ENABLED
- Revert to the simpler non-tree based version of ipv6_csum_magic since
  David pointed out that the tree based version is not better.
- Link to v4: https://lore.kernel.org/r/20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com

Changes in v4:
- Suggestion by David Laight to use an improved checksum used in
  arch/arc.
- Eliminates zero-extension on rv32, but not on rv64.
- Reduces data dependency which should improve execution speed on
  rv32 and rv64
- Still passes CHECKSUM_KUNIT and RISCV_CHECKSUM_KUNIT on rv32 and
  rv64 with and without zbb.
- Link to v3: https://lore.kernel.org/r/20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com

Changes in v3:
- Use riscv_has_extension_likely and has_vector where possible (Conor)
- Reduce ifdefs by using IS_ENABLED where possible (Conor)
- Use kernel_vector_begin in the vector code (Samuel)
- Link to v2: https://lore.kernel.org/r/20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com

Changes in v2:
- After more benchmarking, rework functions to improve performance.
- Remove tests that overlapped with the already existing checksum
  tests and make tests more extensive.
- Use alternatives to activate code with Zbb and vector extensions
- Link to v1: https://lore.kernel.org/r/20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com

---
Charlie Jenkins (4):
      asm-generic: Improve csum_fold
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/include/asm/checksum.h     |  91 ++++++++++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 198 ++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h        |   4 +-
 7 files changed, 655 insertions(+), 3 deletions(-)
---
base-commit: af3c30d33476bc2694b0d699173544b07f7ae7de
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

