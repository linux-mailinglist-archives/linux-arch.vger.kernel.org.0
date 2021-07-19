Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2264A3CE689
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbhGSQIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347933AbhGSQGB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 12:06:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04B0861166;
        Mon, 19 Jul 2021 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626713167;
        bh=BuNpEVw0Z7QF7T6Pg1Y4iSPkryr1pnhL0UsAdhxfVKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MBXPEv7c0GX2eb+FcIRSUiE4ipyJFODuf0n8N/RKSemTAvhHtyxd713lOBVXW6cpS
         kGNcMnNsMsEEGjtygw7l29BCGTw+2e9Zovu6Bzq+8j/poNlSenwj87QSJmVs0kIqZP
         Jy2oB4wTRfWfnxDuhgo4bGsiw9GYH95BzdOLLaOuwIW14MdC71olpyBOnKfpvHdGb9
         vE3dFQ7SYZq7K8iQQPzSTOfy6Bwvl1j9rw/sF37Bkh1bfbg7jzTRBM1rldWtCndhfv
         +96eF3kWM6cEyyjXc3ugEZo1lHAj2Rp3ASHw3Y060CrAiEQufA4n3LAk7IB0pWMySH
         s7KPX/QZL5Ouw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 19 Jul 2021 17:45:32 +0100
Message-Id: <20210719164536.19143-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; h=from:subject; bh=BuNpEVw0Z7QF7T6Pg1Y4iSPkryr1pnhL0UsAdhxfVKQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg9awsKt64aeGMJqs+SFgkYb2M102fvMXDFSgSE/pz XyqRHxuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYPWsLAAKCRAk1otyXVSH0Mq7B/ 9LyoRg5d1BWXInbLMROy7vixqHG8dTgSGcnxpFWRikeVZT5UKgZ8V9QItAlMVaEppYaBRw98PfBkDq kQEQWmcgg+Aghu8ifnM1pCArevFtntF3Oa0jgYRVPOXLr9rOteR+1UkQYFSycaTvWrWnD1Epv2BuL8 WDOczzWGZLhkE+oVhpkwKm9sUNtKGZb3N3+Z7HqOGA/mBxAVho58BbGlpQLndfyqljSr3n9xdFac4f 1Megg/C2xlo2/JoyS70SjWDMQhSR02sPRDwwPDyKlR0VEc9tHaylGooFLp8WU7j2Wge+5EQyfOkcpC kJ3SD34oIISkfqQmYV2q1DNVwc3bRV
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


base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
2.20.1

