Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26FE7DA3AF
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJ0WoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 18:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346748AbjJ0WoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 18:44:02 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B6E1
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:43:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4a25f6390so1692206a34.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698446639; x=1699051439; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQM1G0gFc6Yq3cS/3BYKH2KxVgq2/CZlRQ60FxU2vsY=;
        b=sCEG5s01Hv4lAq1KPrh772zO+ya1hsIN2VvvAT+Y5qQNooZcjcyQPmF9wUxbey+6UU
         zykoX6WqKViSUzw2N0hRfupA59XveXTPpCKjQ71gG/5Xm8IIAGSshNnfDy0JAHTkJ50P
         9vXUnzi/ftFAN+TPdXcFe8ac9ZwOVEhvgtRmz1JFSKHmqsJ3cZhMDsRFa2sn1+8OkpS4
         Tp7F6ImqYcerHQnTIvz876pr9OVm4/6g7xNLLSg3LuOjeFUZqQT5SpARfQZRysgDPjUZ
         xQOxXY4k3q7+27Pufgvi2QxHHYYFuNzbBN2z5ZJ5vRQ2x19UDEsxO5k8WvxbRKYN3iBc
         x3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698446639; x=1699051439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQM1G0gFc6Yq3cS/3BYKH2KxVgq2/CZlRQ60FxU2vsY=;
        b=fsKTGkcpWJs+g4pSyUT+qmmmP92AYCO2HS6oG/opaeEHoG8pZC9qRsAgU4vQ+rRWtf
         cGdV6I01RQwobbRIvrUZu/DeLpYQriqoOVUTJJvi+Iqt+oZiZvJy+Tjau9U4mQKgvlw4
         GMupY13JnbmPag/aRdYX7l2hlWUPx0k6fW1BD5x7sPTSUNQtpNKjYGyiwlk/aNPLhecq
         dUuvZxIwQUhfy5cBHukm5YEj7cRheNPYk5ropk2Pb8x2ipmFu95+zXOjK63ETgv+5g5c
         BFpULR6mNw5FeJS55i+iCjehNEdKpvOzbPmk23F1DmUdt/04XRiAsswjPw/y8KgfyKZZ
         7DfQ==
X-Gm-Message-State: AOJu0YwnPln+xBtawO/QvpF1oX40TPq06FZ/XKwus7/BPHG3WPilxW5p
        zkplKPl41ybn9Y71Ba/BQnQtTQ==
X-Google-Smtp-Source: AGHT+IGpQQnZIUn/lcVZgpnZZWYv9Uyuhdokp0m4XrcCO4pmuDBqfqeQTKdRYnyhX+VCAivhAqsHtw==
X-Received: by 2002:a05:6830:3144:b0:6b9:90db:f6ed with SMTP id c4-20020a056830314400b006b990dbf6edmr4898543ots.11.1698446638944;
        Fri, 27 Oct 2023 15:43:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b006c61c098d38sm448564otk.21.2023.10.27.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:43:58 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 0/5] riscv: Add fine-tuned checksum functions
Date:   Fri, 27 Oct 2023 15:43:50 -0700
Message-Id: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACY9PGUC/23Q3WrDMAwF4Fcpvl6GLf+mV3uPMYYjuYsZTUrcm
 W0l7z6nDBaGLo9An8S5iZKWnIo4Hm5iSTWXPE8thIeDwDFOb6nL1LIACVoGabr5cs3n/J1ecUz
 4Xj7OHQ3KWAghIijR9i5LOuXPu/n80vKYy3Vevu4nqtqmvxo4Rquqk12vvZVqaCzEpyXXueQJH
 3E+iw2s8If00nIINASRnA00eKMHBtF7xHOI3hArgbShnrxmELNDlOIQ0xDvESFSn5rCIHaPcA1
 Xu33S2yFABG99YhC3R9hOXEOUiQ5PTqFTgUH8Huk5xDdEOvQkiciS+4es6/oDPteWuVMCAAA=
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>,
        Conor Dooley <conor.dooley@microchip.com>
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

Relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivosinc.com/

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
To: Xiao Wang <xiao.w.wang@intel.com>
To: Evan Green <evan@rivosinc.com>
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
To: linux-arch@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Changes in v8:
- Speedups of 12% without Zbb and 21% with Zbb when cpu supports fast
  misaligned accesses for do_csum
- Various formatting updates
- Patch now relies on https://lore.kernel.org/lkml/20230920193801.3035093-1-evan@rivosinc.com/
- Link to v7: https://lore.kernel.org/r/20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com

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
Charlie Jenkins (5):
      asm-generic: Improve csum_fold
      riscv: Add static key for misaligned accesses
      riscv: Checksum header
      riscv: Add checksum library
      riscv: Test checksum functions

 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/include/asm/checksum.h     |  92 +++++++++
 arch/riscv/include/asm/cpufeature.h   |   3 +
 arch/riscv/kernel/cpufeature.c        |  30 +++
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   3 +
 arch/riscv/lib/csum.c                 | 339 ++++++++++++++++++++++++++++++++++
 arch/riscv/lib/riscv_checksum_kunit.c | 330 +++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h        |   6 +-
 9 files changed, 832 insertions(+), 3 deletions(-)
---
base-commit: 8d68c506cd34a142331623fd23eb1c4e680e1955
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie

