Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5789A3C5BCD
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGLMAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 08:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234610AbhGLL7n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 07:59:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 101F4610E6;
        Mon, 12 Jul 2021 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626091015;
        bh=Sd2Kflgdz6EMyz+IER+5JzuAgUbhmPO5bzvIfgOgrKw=;
        h=From:To:Cc:Subject:Date:From;
        b=EChe/NWCf4LREkd+I/n8uuEYbnOydGa5UWD52J3JnJfbX8XK+IYqsemoJDMAb8FQu
         NYuQ+AweDPvTDCNLCxGQMP10dbLt1MRFgvnVLwO4oGSTP1SziEZelAuGmD8uxoO+JX
         srR/jf2yHM4umjsKRV767jH/du0c1nUDSh8BzbZX7qnZdXzJftHLnJzbzUaQklJJMq
         uL6SADRC07nKCq727l7m4yUxcqxuvsz9qSvwGaheTaMe1NKqfLG8gSiyLW1ms+vmCD
         XoEcvo+2/hrIVgy+FIhn7m5mru4lTZbpwoPSpcv6OmVxP95UbDth+mRZCAvdEBJqWB
         ucUmeVw2fOj8w==
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
Subject: [PATCH v4 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 12 Jul 2021 12:52:55 +0100
Message-Id: <20210712115259.29547-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; h=from:subject; bh=Sd2Kflgdz6EMyz+IER+5JzuAgUbhmPO5bzvIfgOgrKw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg7C0WNg8bmv+mBPkYNk6JpHqVu8oqetE1VzSQ69yb 1HyLTy6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYOwtFgAKCRAk1otyXVSH0JE2B/ 99C7G14IqugPmhEaxUpEuLmGFstEDOw65O6hug9yU2a8cMWwMxV6XHN/PMvrflGeRWwqelO3LkCdon arJFvsRSWaenG+agFSXLbNY+g56aJ6MY3a21DmAyu1Lsj/6d+wPnvwIaetbDAZigjdhXBeUO0UIa7c 7fmqq+eg9foi7H7pOXXlMKcR6WNJJMRkO2OmCpN4JPa/UEd28wGe+nPzn6A5bViFoo9hoyRQz6AdGv PLHLmMpB1FRiREpjh/g5w67dFs0ACEeV8R7GY1al9cq1czoPwbqYm0qVS8MsGb84OkSj1Zi0GuC3pD 0HpAVBD994eQaXm/IUi+gmiFo/kDlm
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

 arch/arm64/include/asm/elf.h | 13 ++++++++++---
 arch/arm64/kernel/process.c  | 23 +++++++++++------------
 fs/binfmt_elf.c              | 33 ++++++++++++++++++++++++---------
 include/linux/elf.h          |  8 +++++---
 4 files changed, 50 insertions(+), 27 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.20.1

