Return-Path: <linux-arch+bounces-1320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26459828F8A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 23:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7601F2672A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212073DBA8;
	Tue,  9 Jan 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB46A5Sp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D393C6A4;
	Tue,  9 Jan 2024 22:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA61FC433F1;
	Tue,  9 Jan 2024 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704838610;
	bh=EHvco0VkqOSJGuxdue1TEtXAL00jI8VZrVZxCAuX2+E=;
	h=From:Subject:Date:To:Cc:From;
	b=qB46A5SpFD/NpmrZNfvwVgTddKr4FozL/Nm6NTWqjJuavIDeYbyWj8WbTz/AJAYAd
	 rCq1xH2+lrNbAzymhVqtxXCmJQYKKBtigLbuskx+y07oOM7Fuhn5KtE5lAQldU86ff
	 zsHlTOsJZDWVdq5RMMJKOsWvG0Sf8ZHgtVjZur4CTnnCh2KmHRiE+g9IYh0N3JSxTK
	 HD8CBIbqmmGPG+MOnwgxTifgp44rGjZZFXk0l6vXeduRl6TLk9LScel7oWlPR5uz1g
	 UsvtcwNt/LBd82QaDZxv1VzpZC3HDPVzq86WEch1mZNDSm/ODiPUOVtCeJtXC34hlE
	 7d2vmCHDFTLIQ==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Update LLVM Phabricator and Bugzilla links
Date: Tue, 09 Jan 2024 15:16:28 -0700
Message-Id: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzFnWUC/x3MQQqAIBBA0avErBtQi8CuEi0kpxoyCy0JwrsnL
 d/i/xciBaYIffVCoMSRD18g6wqm1fiFkG0xKKFaIYXG+7TmInQu7ejYbxGtaGZtu1aTJCjdGWj
 m538OY84fszs+Z2MAAAA=
To: akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, patches@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-arch@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, bridge@lists.linux.dev, 
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=nathan@kernel.org;
 h=from:subject:message-id; bh=EHvco0VkqOSJGuxdue1TEtXAL00jI8VZrVZxCAuX2+E=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlzj17YHOFbeqmmzSTv+Yl3Dvc2pO2+wn2gftPWtOlmz
 ZFzErc87ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATcYlj+J+VsOtwv+FtLr6v
 L2ptJLoTJ1xwvPM+afI7W55fz9vnRocyMsxLsi56rXP33S6VMzNvVJ4tXR/xeu4ma9Zvvc8ruWO
 PdPIDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

This series updates all instances of LLVM Phabricator and Bugzilla links
to point to GitHub commits directly and LLVM's Bugzilla to GitHub issue
shortlinks respectively.

I split up the Phabricator patch into BPF selftests and the rest of the
kernel in case the BPF folks want to take it separately from the rest of
the series, there are obviously no dependency issues in that case. The
Bugzilla change was mechanical enough and should have no conflicts.

I am aiming this at Andrew and CC'ing other lists, in case maintainers
want to chime in, but I think this is pretty uncontroversial (famous
last words...).

---
Nathan Chancellor (3):
      selftests/bpf: Update LLVM Phabricator links
      arch and include: Update LLVM Phabricator links
      treewide: Update LLVM Bugzilla links

 arch/arm64/Kconfig                                 |  4 +--
 arch/powerpc/Makefile                              |  4 +--
 arch/powerpc/kvm/book3s_hv_nested.c                |  2 +-
 arch/riscv/Kconfig                                 |  2 +-
 arch/riscv/include/asm/ftrace.h                    |  2 +-
 arch/s390/include/asm/ftrace.h                     |  2 +-
 arch/x86/power/Makefile                            |  2 +-
 crypto/blake2b_generic.c                           |  2 +-
 drivers/firmware/efi/libstub/Makefile              |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  2 +-
 drivers/media/test-drivers/vicodec/codec-fwht.c    |  2 +-
 drivers/regulator/Kconfig                          |  2 +-
 include/asm-generic/vmlinux.lds.h                  |  2 +-
 include/linux/compiler-clang.h                     |  2 +-
 lib/Kconfig.kasan                                  |  2 +-
 lib/raid6/Makefile                                 |  2 +-
 lib/stackinit_kunit.c                              |  2 +-
 mm/slab_common.c                                   |  2 +-
 net/bridge/br_multicast.c                          |  2 +-
 security/Kconfig                                   |  2 +-
 tools/testing/selftests/bpf/README.rst             | 32 +++++++++++-----------
 tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
 .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
 23 files changed, 40 insertions(+), 40 deletions(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240109-update-llvm-links-d03f9d649e1e

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


