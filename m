Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06D7A6ACF
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjISSpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:45:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9269E
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:44:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565e54cb93aso3526341a12.3
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695149098; x=1695753898; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uA2AKw5TRuWkTphPeTSud1oyV6iHPUIlWEjGcPkhvI=;
        b=ygcczdBodNaTKVzFwxIcsmZsm1h02TlyGNKHsPyRLUKTfpRRw0LKq3G3WWPB7KJ5aG
         EKHqgQXGn0N8Lo32ezKoUW73t8ByxUHUVLlKUEU3eW2CPBUZv6zsqSq2/EPUJUJYvB70
         grs+X7erBCW+Cc6Wb3e6383TSUhG8Qk4tmhE4j0vpeYxBdDvKORXYw+SDRHF9Y08Rp7q
         +aCdpI20832Fwu5Os+ktUxRzn5MOJ1QoB0MaKxQD9ceknlDM9gQXneLV5yNcTAO6eDf9
         q20HnVHmdCnBXgvxrhpR2KoOhl0m4s55Jj+RXt77zARrH19jonj2mIFKxjONNEE8sc38
         Y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149098; x=1695753898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uA2AKw5TRuWkTphPeTSud1oyV6iHPUIlWEjGcPkhvI=;
        b=L7mB+NH0plYfMakeXh3jtuYUCFatVBH5xmoNFbHFAktOu4l8i1tIxuCovd1BfYaES4
         Viuzdo2QTmMLOpg4Mg8HDFb2KhaOXpNpia/26WVvwqmISJTtTJfWsq9IJc5v7xnc97Jc
         F5TxlwCWyt7NNKvUIkLpSFJvXH+vJRDy+qAZpLHDPDhgL09dyaIIiAZUxm4at+v5fumf
         hv7Aew3zjJFC+cZo9/Rau9129kj8cXQghyDV2J0/Jw2n6Qb0B9KMr+M4Yu1QgY0+DM5n
         ymIWA5XoTsZDey4YrdJ+ErJ/uW1YO1VRu1JPPa9tV9cvSdfwJyUylNsb8XEOEGyX7uh5
         lpjQ==
X-Gm-Message-State: AOJu0YwmDTqpK5MpEkjID6b2Fu3GMeGLJ/JCSxpq6MmswYW58de8icES
        Zsfva8zozIA1EW5hYKU1cEpjrDkarWG4GrcVchY=
X-Google-Smtp-Source: AGHT+IHQse60GH+RLIRvJ6EeiBAwEVE5yYVcnEb1+9ssEr7AXWIByI8HcDuGdJ6V4rNHibbFVK8OGQ==
X-Received: by 2002:a17:90a:e2ce:b0:26b:5ba4:4948 with SMTP id fr14-20020a17090ae2ce00b0026b5ba44948mr534507pjb.12.1695149098229;
        Tue, 19 Sep 2023 11:44:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0026309d57724sm3876846pjz.39.2023.09.19.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:44:57 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 0/4] riscv: Add fine-tuned checksum functions
Date:   Tue, 19 Sep 2023 11:44:29 -0700
Message-Id: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3sCWUC/23QTWrDMBAF4KsEresijf6z6j1KKNJIqUWxFaxEt
 A2+e+VQqClavoH5Znh3UuKSYiHHw50ssaaS8tyCfjoQHN38HocUWiZAgVNDxZAv1zSl7/iGY8S
 PcpuG4JmQYIxDYKTtXZZ4Tp8P8/XU8pjKNS9fjxOVbdNfDVRHq2ygg+VaUuYbC+5lSTWXNOMz5
 olsYIU/xFLZQ6AhiEFJE7wW3HcQvkd0D+EbIikELoINmncQsUMY6yGiIVojggs2NqWDyD3Sa7j
 K7RMrvQEHWurYQdQe6XaiGsKEU3hWDBUz/5B1XX8A5VvcmA4CAAA=
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes in v7:
- Included linux/bitops.h in asm-generic/checksum.h to use ror (Conor)
- Optimized loop in do_csum (David)
- Used ror instead of shifting (David)
- Unfortunately had to reintroduce ifdefs because gcc is not smart
  enough to not throw warnings on code that will never execute
- Use ifdef instead of IS_ENABLED on __LITTLE_ENDIAN because IS_ENABLED
  does not work on that
- Only optimize for zbb when alternatives is enabled in do_csum
- Link to v6: https://lore.kernel.org/r/20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com

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
 arch/riscv/lib/csum.c                 | 217 ++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h        |   6 +-
 7 files changed, 676 insertions(+), 3 deletions(-)
---
base-commit: da5f5b0f1b813dafe9ce81b70fed01b0d103d556
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

