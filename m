Return-Path: <linux-arch+bounces-1304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3E827BB9
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 00:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5541A284B3C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 23:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F056479;
	Mon,  8 Jan 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HCCe0DHr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411F5645E
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204e52f0617so1555054fac.1
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2024 15:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704758247; x=1705363047; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ame9l2qcp8W3BLOjm08r1uJEq7CAYl28JAJ9F06Kn3g=;
        b=HCCe0DHr9CuWwyRf59Otr3LUg2S9Ld/NIuYBSbAsRTkpPIzaDjgBp7hFTVsclAuzYd
         sgnNQvsKttNs+ntx+TBmpuY1Wvp5C8t8P3lgzIe1fDCzZTmmsfepZ76xEhMhptg8G4ur
         fVlY5Cp1EFje0qVi8VtO5411HE44S8fQZCJA40x2w4zqxqLg6jtsYyaPNw7AxKETJoiF
         1BukIkR8BDrIlFSmK+RO4KISh7Ah+GPduRmxglnNp1dR7RgzAdsLi3/n9X2EoFIX/ssp
         e39kRb8lqb43uytmqsr+evYVBBKiX2koqzd7jnBIbjl/5wiSFhvTOY4IQ1LE2VDsTYBh
         m6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758247; x=1705363047;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ame9l2qcp8W3BLOjm08r1uJEq7CAYl28JAJ9F06Kn3g=;
        b=HzR3bPSnjvFrLx9h5DfHAC9yyfADA+klH3I+pdie05rnfvBG7jspXBHqS9LleCsIC+
         45XoOt/HJnvMyFYq1JW5HaKCN/uYrEUGBmn2doGPKL0r7ueljj15VE8C8zYtX6mc48st
         UgnxtbQArShrjvYG0v7Ts494hpF+K9zq8I/ObjlzGlKuomSSpk8V/w2UH+smbARaZqwG
         WjOZCNqcdr8l8zC8V49lXwOWN/usbv6kgPglaipTpR+u1weaVh746Msn7IwgOOjP2K8Q
         OD+sePexDJUvLgnPPC6x8AzAPWuYbdDXWsc/8Fw+CoBgKI4WRqu8M1CvAI3AvZZs2q4m
         vo4w==
X-Gm-Message-State: AOJu0YzV9SZaWwKwlR/qL6QZE71Lt7h+aGtgXupkSN2T1r2sdMyp7zVN
	wiz0XHpUidUzbMEeoWhAhIHAkf9d2QKvvA==
X-Google-Smtp-Source: AGHT+IHi1J1WRRNoADpp6L+dL8gC+r3BOYLwTzvE8u2A0Tr6D1I0AC6w3V6M787ebgrmj06JKkab2w==
X-Received: by 2002:a05:6870:8891:b0:205:e4da:bfbc with SMTP id m17-20020a056870889100b00205e4dabfbcmr235809oam.3.1704758247045;
        Mon, 08 Jan 2024 15:57:27 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ti5-20020a056871890500b002043b415eaasm206961oab.29.2024.01.08.15.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:57:26 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v15 0/5] riscv: Add fine-tuned checksum functions
Date: Mon, 08 Jan 2024 15:57:01 -0800
Message-Id: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6LnGUC/23S207EIBAG4FcxvbaGGQ4DXvkexhhgqEvMbk2rj
 Yfsu0uNcUmcS0j4YH7+r2EtSy3rcHv1NSxlq2udT20B9vpqyId4eipj5bYxoEKtvDLj/PJaj/W
 zPOZDyc/r23HkBMai9zEjDO3cy1Km+v6D3j+09aGur/Py8XPHBvvur4ZO0DYY1Rg0WQWpsRjvl
 rrNaz3lmzwfhx3c8IIEZSUEG5IzO+s5kdFJQHSPkIToHbEKWRsOTFpATIcASIhpCFHOGDmUpgi
 I7REp4c3uLwk2eYxIloqAuB4RM3ENARNdnhxkB15AqEeChFBDlMvEipktOwHxfwgoFIP1DZlKI
 lDAgJ4FJHSIFoMNDSlRgS8uJMQgIKAuSrtLbFsbZ4wmeEuUUnAiAx0D4kSwt5ZaS4I1U9EOJOZ
 SW0BAkdl7ayBEk6Jj56R4QXcMKpHZmxtJW0MFcmTpq8H0jDzU3l3miY1X4Oy/15zP52/50o9+Q
 QQAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704758245; l=7699;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4EOYBtqtiIKNjQ7RGmnLjHPQtqeJgMfF//Og2/cODXU=;
 b=q9E7KeVhJRkPDLBeP/iIZ0JM/sa3wIV9aol2J4ZRCyNROlbB3nkMrs3dcs0aJpsnVmuUjX0dx
 zvdM7oAD4dxCoaOsWukXzsKokeEk9a8acfXb8JaIRt/Upp12wNEofF0
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
Changes in v15:
- Create modify_unaligned_access_branches to consolidate duplicate code
  (Evan)
- Link to v14: https://lore.kernel.org/r/20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com

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
 arch/riscv/kernel/cpufeature.c      |  90 +++++++++-
 arch/riscv/lib/Makefile             |   1 +
 arch/riscv/lib/csum.c               | 326 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h      |   6 +-
 lib/checksum_kunit.c                | 284 ++++++++++++++++++++++++++++++-
 7 files changed, 795 insertions(+), 7 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20230804-optimize_checksum-db145288ac21
-- 
- Charlie


