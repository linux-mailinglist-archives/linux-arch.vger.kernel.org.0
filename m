Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1F40DDFC
	for <lists+linux-arch@lfdr.de>; Thu, 16 Sep 2021 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhIPPbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 11:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238967AbhIPPby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Sep 2021 11:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FD9D6121F;
        Thu, 16 Sep 2021 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631806234;
        bh=FpfW2dml9iwXK4/Wly3stSwGR4U67dk+Puq8J5H2csI=;
        h=From:To:Cc:Subject:Date:From;
        b=Pe3pTO4Uq7d7p1QjzRj/6voHn6sV5U78GUPyj6n+Ocbe5j5XVAOrPpBs/In3ZzN9g
         3QR1jhM5qgUY/yVUFIzgRLPKkt5uf6ILqo63tq8yAF/o1Ft1IjnEK+fIWaB6NoOojc
         JewF5rjH8FTtSYEtThXHqzKmDojldgouG2X+geIbq2zuc1LUjNqUNTTuMq3MJBZmd7
         w3U7ewjokAORDbPwOR73VbG1rzAbnDX0DEaH4XOL6BbW3k42/qCK+JkkoTn0Ek0SFq
         +U2qeoPxwuNGF1sGFIijmsx/VgHVU9VTrVlhzI7JonSHFI4lDHvzFsNcZZtLn0cL7i
         RTJkQfhhnhlew==
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
Subject: [PATCH v6 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Thu, 16 Sep 2021 16:28:17 +0100
Message-Id: <20210916152821.1153-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; h=from:subject; bh=FpfW2dml9iwXK4/Wly3stSwGR4U67dk+Puq8J5H2csI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ2KREZKgPv/EBvhKPZFFrjL0WsWLYD7CC1vAsC9i PARhInOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNikQAKCRAk1otyXVSH0P/1B/ 0cCj/YTkZ+DVhsjUTyg8TLY5ptwj+JU6OAT83cPtOtYWX2g0NWFIa/SZWmIgIIjniBzyaBulr/74fw RHfTK57MNOQkeXBg+c9aKnfKDGwcPdlll8J6iAHW/FDyEGVpHh8nANsQAKjSzhPm6t2SZca3suGdSH vue978zca/IX2R/L009gybaG+3x2s1PPej3mOak1e5Q4rzF5IoACW6loM1b9Q3smpGJuCH4cXRUmtA 4W1PFvc1lyyOx+HtSP/I/lX+QJXrSorx6PqdXYw/Xbz1540uW4D1SHKRNTSTzUXwnjMGIr5Vu28A/d eUT9a/QpSYKAy3qt5qYjnkY+PclYfq
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


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.20.1

