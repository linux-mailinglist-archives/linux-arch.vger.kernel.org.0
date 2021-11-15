Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62860450840
	for <lists+linux-arch@lfdr.de>; Mon, 15 Nov 2021 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhKOPaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Nov 2021 10:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhKOPaT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D61DC60EB2;
        Mon, 15 Nov 2021 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990043;
        bh=y2gJEptAy9Et9KNJ+WgWMubC2Cf2DYOaQGtmMK574eM=;
        h=From:To:Cc:Subject:Date:From;
        b=TbProUbFBzA2fjGLUytNroOvYITHBxaGsm0vnvbYeko4K5HqffeM06txdZvJ6nuE7
         +kJrV01X7B3NleLEsk/tQmee7gZnrk5yJmGVEofmhjF5M4IHx1W2aXZ/tsuBmyIUcu
         SJwJcq5ysl8iJlDVOdyFZnRPDpn+2O69xWcuQoikgL0ckZnjVOfy0bSAij7FOJG03d
         ZuKdRfnccZwZ1g8BfyIDxZ5Y07bWV80ry7xrWJ4VIpjBOU1j6XCI9WjIeWtAlt0/3m
         H4zfLXeILrQU5W9Wd4zXNRCF+cBvLbDrluHzquVTDiFaSEtL7bMqRWIsyLIR6ULf1l
         acOtba72xZsVw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 15 Nov 2021 15:27:10 +0000
Message-Id: <20211115152714.3205552-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; h=from:subject; bh=y2gJEptAy9Et9KNJ+WgWMubC2Cf2DYOaQGtmMK574eM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknxLTDDzIIYxy+ulyMSW7G9JFvtTRLsXNuPUPEwl 4lYp3TqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8SwAKCRAk1otyXVSH0F+rB/ 9Ui/dB66NxvOi8g/beOGNPDLFGwrLIyaBV8Ro1VoGi8dU9mcRWkTNhiYEFk2h70oDW8Ss3RIqeq9hm j2ZOIk/yXtfqbpVXIc3qIdznwiwqvlxCiNC9CWHBk9PnjZmn0f5di2+RHyVliiJCUVOir55WC8TMv2 aoEWxAuMzOwQgfeDIs7ai3pM7J7goBNFWEQo8l6pKSvu+RVOt8x/O0AecknD/4Hy9YTWuHfrfFPig8 ZCK/PZRfCM3nbOYRjDCi7W+ThbG4HRNnRmuiK6pofKVnFBf3UoUmPiVfv4q1FPPgfmUbfZQQIcmwJo SkngK8Mq1B6BOWkV9NU+1KBosJwLMm
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Deployments of BTI on arm64 have run into issues interacting with
systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
linked executables the kernel will only handle architecture specific
properties like BTI for the interpreter, the expectation is that the
interpreter will then handle any properties on the main executable.
For BTI this means remapping the executable segments PROT_EXEC |
PROT_BTI.

This interacts poorly with MemoryDenyWriteExecute since that is
implemented using a seccomp filter which prevents setting PROT_EXEC on
already mapped memory and lacks the context to be able to detect that
memory is already mapped with PROT_EXEC.  This series resolves this by
handling the BTI property for both the interpreter and the main
executable.

This does mean that we may get more code with BTI enabled if running on
a system without BTI support in the dynamic linker, this is expected to
be a safe configuration and testing seems to confirm that. It also
reduces the flexibility userspace has to disable BTI but it is expected
that for cases where there are problems which require BTI to be disabled
it is more likely that it will need to be disabled on a system level.

v7:
 - Rebase onto v5.16-rc1.
v6:
 - Rebase onto v5.15-rc1.
v5:
 - Rebase onto v5.14-rc2.
 - Tweak changelog on patch 1.
 - Use the helper for interpreter/executable flag in elf.h as well.
v4:
 - Rebase onto v5.14-rc1.
v3:
 - Fix passing of properties for parsing by the main executable.
 - Drop has_interp from arch_parse_elf_property().
 - Coding style tweaks.
v2:
 - Add a patch dropping has_interp from arch_adjust_elf_prot()
 - Fix bisection issue with static executables on arm64 in the first
   patch.

Mark Brown (4):
  elf: Allow architectures to parse properties on the main executable
  arm64: Enable BTI for main executable as well as the interpreter
  elf: Remove has_interp property from arch_adjust_elf_prot()
  elf: Remove has_interp property from arch_parse_elf_property()

 arch/arm64/include/asm/elf.h | 14 ++++++++++++--
 arch/arm64/kernel/process.c  | 16 +++-------------
 fs/binfmt_elf.c              | 29 ++++++++++++++++++++---------
 include/linux/elf.h          |  8 +++++---
 4 files changed, 40 insertions(+), 27 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.30.2

