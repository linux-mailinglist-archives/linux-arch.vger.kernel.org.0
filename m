Return-Path: <linux-arch+bounces-1174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DC81F0EF
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BBE28403C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E446528;
	Wed, 27 Dec 2023 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eA2cr2Zy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC546522
	for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204520717b3so2986167fac.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703698695; x=1704303495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHAcfAA5kCZ72wDWLqq2p9bQpejC40VxPRIOvgfyeMs=;
        b=eA2cr2ZyXe5LHdAmNEtnv1Bfmn8yhCxX93sKXgC4CGp1y/w0bPfFXQxbHxDA+U9hA0
         pgNazFFiDRYZLY7smC5a9m+Uh6y1bY2coQBf7AjSO6BB29wqmfeL5fiIJUAoex94DndH
         JOyLjIn3V7snD6LXg8Jx4mzvCumVu5BwQNvqObZtYfNY8HtZxp50E/c1OcCkRl0dfi6f
         rFwAFLjcaGKqgbIQY5IAjSgNJh2KdxK24ECR0gWK11s/RHGXKFUz8eK9VNwvHshyT+Jm
         LuYSr96jSFU3G9ByxlW6ltYOCUHPwOpmF6c2uH6qTwYUhn85RfSRd8iOf52iwwaOiUNQ
         VC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703698695; x=1704303495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHAcfAA5kCZ72wDWLqq2p9bQpejC40VxPRIOvgfyeMs=;
        b=rg59AEXkwbYDcY9bEOB679+hbRYJKzQeEDOtvlEGu1bO6Bs6igF1yVALwvpr4jh17+
         w/4ZQYfGeB2rlPDuXpGTBZvEQBUqCBMNkqtqeaxg5UUpyAOizxlkUbbkY8tGVKXBjXMI
         AMCuIsqaHoBTFrcOm+hp5ssEOWkFQ3EOAKBH8kVQbc+QAKWhq0gqZbVi6hz6g8l5sDKQ
         tY+zftqzjkTw568DjMcRIHKXARyDPfEK5BHIrguoYfyt/Hj2GBodNkWN9kFrOPfmGjel
         fMqvtzre0HWBGsw1phUlEmARb80y2dNcadwQgWVy5MRv9zhdTJTnRq2GFbxfrXVS3TeY
         iTjw==
X-Gm-Message-State: AOJu0YzEmGLHpUqpi2839ZQTluyA2uZOsOMSyMw0NlS50JBuh4MXrwaN
	U/vl8gwtELSUsmadhuxIJ+Isk56QfhWJPA==
X-Google-Smtp-Source: AGHT+IHXbRKBQ4pVrbi/7+ChYKSFsG4xbhEERn+M2EAYDEDVluAPiDM1F9z/fux5NMol0w1e64YX/Q==
X-Received: by 2002:a05:6870:56a4:b0:204:5026:c9f5 with SMTP id p36-20020a05687056a400b002045026c9f5mr9652182oao.91.1703698694794;
        Wed, 27 Dec 2023 09:38:14 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id rl15-20020a056871650f00b002049c207104sm1337173oab.27.2023.12.27.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:38:14 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v14 0/5] riscv: Add fine-tuned checksum functions
Date: Wed, 27 Dec 2023 09:37:59 -0800
Message-Id: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdgjGUC/23S3U7EIBAF4FcxvbaGGX4GvPI9jDHAUJeY3W7at
 VE3++7SjXEbM5dMwgcczrmby1TL3D3enbupLHWu46EtwNzfdXkXD2+lr9wGHSrUyivTj8dT3df
 v8pp3Jb/PH/ueExiL3seM0LV9x6kM9fOKPr+09a7Op3H6up6xwDr91dAJ2gK96oMmqyA1FuPTV
 Jdxrof8kMd9t4IL3pCgrIRgQ3JmZz0nMjoJiN4iJCF6RaxC1oYDkxYQs0EAJMQ0hChnjBxKUwT
 EbhEp4cWuNwk2eYxIloqAuC0iZuIaAia6PDjIDryA0BYJEkINUS4TK2a27ATE/yGgUAzWN2Qoi
 UABA3oWkLBBtBhsaEiJCnxxISEGAQF1U9pZYtvac/pogrdEKQUnMrBhQHwRrK2l1pJgzVC0A4m
 51RYQUGTW3hoI0aTo2DkpXtAbBpXIrM2NpK2hAjny/6++XC4/UJYLgvoDAAA=
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 David Laight <david.laight@aculab.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703698692; l=7496;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=b/rJTPKIAQMg3PGom1efR6P9TUmCxlht2gJ8987pQ/s=;
 b=P/b7zFdJEa22N7c2od7nrphYg79jZnTRSVC0iRmQhnFWXaJRa7hcqy0Asu/i/nyg95qHZ1lHl
 s+u3OLSiRi1DBj1Z03XEOuHdySNKXW0rkrUMyAaUe756dFXvv24QG+S
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Each architecture generally implements fine-tuned checksum functions to
leverage the instruction set. This patch adds the main checksum
functions that are used in networking. Tested on QEMU, this series
allows the CHECKSUM_KUNIT tests to complete an average of 50.9% faster.

This patch takes heavy use of the Zbb extension using alternatives
patching.

To test this patch, enable the configs for KUNIT, then CHECKSUM_KUNIT.

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
To: Guo Ren <guoren@kernel.org> 
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
To: linux-arch@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Changes in v14:
- Update misaligned static branch when CPUs are hotplugged (Guo)
- Leave off Evan's reviewed-by on patch 2 since it was completely
  re-written
- Link to v13: https://lore.kernel.org/r/20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com

Changes in v13:
- Move cast from patch 4 to patch 3
- Link to v12: https://lore.kernel.org/r/20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com

Changes in v12:
- Rebase onto 6.7-rc5
- Add performance stats in the cover letter
- Link to v11: https://lore.kernel.org/r/20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com

Changes in v11:
- Extensive modifications to comply to sparse
- Organize include statements (Xiao)
- Add csum_ipv6_magic to commit message (Xiao)
- Remove extraneous len statement (Xiao)
- Add kasan_check_read call (Xiao)
- Improve comment field checksum.h (Xiao)
- Consolidate "buff" and "len" into one parameter "end" (Xiao)
- Link to v10: https://lore.kernel.org/r/20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com

Changes in v10:
- Move tests that were riscv-specific to be arch agnostic (Arnd)
- Link to v9: https://lore.kernel.org/r/20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com

Changes in v9:
- Use ror64 (Xiao)
- Move do_csum and csum_ipv6_magic headers to patch 4 (Xiao)
- Remove word "IP" from checksum headers (Xiao)
- Swap to using ifndef CONFIG_32BIT instead of ifdef CONFIG_64BIT (Xiao)
- Run no alignment code when buff is aligned (Xiao)
- Consolidate two do_csum implementations overlap into do_csum_common
- Link to v8: https://lore.kernel.org/r/20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com

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
      riscv: Add checksum header
      riscv: Add checksum library
      kunit: Add tests for csum_ipv6_magic and ip_fast_csum

 arch/riscv/include/asm/checksum.h   |  93 ++++++++++
 arch/riscv/include/asm/cpufeature.h |   2 +
 arch/riscv/kernel/cpufeature.c      |  89 +++++++++-
 arch/riscv/lib/Makefile             |   1 +
 arch/riscv/lib/csum.c               | 326 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h      |   6 +-
 lib/checksum_kunit.c                | 284 ++++++++++++++++++++++++++++++-
 7 files changed, 793 insertions(+), 8 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie


