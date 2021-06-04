Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93439B7C9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFDLV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhFDLV1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41A8461414;
        Fri,  4 Jun 2021 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805581;
        bh=+xnPy6vKSA4JZpieqy9rOye/hz55CPiRF8qm7EZ7dLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CdBAtHrb/IrZ68ti6U3G95wP6ubSCd4JFz9u2WJ6iln4+xnkM+4Hmoke4VsbLIIPP
         HwtyskbcOBzpDShXl9qvJyx356tdTHZAo3hJDlFypPSwSwiIoO/QZ4I3yFeTee/Oj9
         d2kthGv5HyNcD+Ngidc5IKotNOWjJz6jofFSWdv4PZM2yBCYi9mV4BRdUgYeQ+rdYU
         AGAWp1xaSOjH6HmpLuYGlNFuxrAJXEG0RHwQTIr+/its+Vjq++1toyHGpB2Kp9xDdp
         iqBk4OS2z+7efshnUrZCNq4ahychBeIBC3oQ7qYNd+/9BeMu2Uw6zTGr94oFw8oBVI
         fNTecdt7NY2EQ==
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
Subject: [PATCH v1 0/3] arm64: Enable BTI for the executable as well as the interpreter
Date:   Fri,  4 Jun 2021 12:17:25 +0100
Message-Id: <20210604111728.12052-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; h=from:subject; bh=+xnPy6vKSA4JZpieqy9rOye/hz55CPiRF8qm7EZ7dLQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgugvEP0DyUOyeqjIBzn0tFkh5xzY2HcRp/M4GxMOy 7l9nn6GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYLoLxAAKCRAk1otyXVSH0Dz3B/ 0R1jseSi1DxRO3mtnP3vbBTPEX5UpFMZfI7SC3alRjKEgcMjHQZ+R/rUviWNQUnugrRW9Cc6aXlpMb kNnOMaL41yG2i/j+/VD6tpMCaPTNPLh1ilJF9i3ve5L6VBH9ymsSlL6fj0tQIkMR7iTG1fUq/YQD/b j43T3Wyd1YOfgZeaS8IYVVyiqXxoT0TivYu4CqeKKIg5dTqJNPjJCTqHaKNBYKttEydE1xlsuKXVjs RqzdUEMs9MDbWo6UD6rnf8EJTFo6V3KoC8ZagdCwGqdnC+ZcLyjPYXWnIrtRMlR4TRvvbUYgrf+kAW BodmOA+/cPU157Oy4McKoCvrYWAp7c
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

v2:
 - Add a patch dropping has_interp from arch_adjust_elf_prot()
 - Fix bisection issue with static executables on arm64 in the first
   patch.

Mark Brown (3):
  elf: Allow architectures to parse properties on the main executable
  arm64: Enable BTI for main executable as well as the interpreter
  elf: Remove has_interp property from arch_adjust_elf_prot()

 arch/arm64/include/asm/elf.h | 13 ++++++++++---
 arch/arm64/kernel/process.c  | 20 +++++++-------------
 fs/binfmt_elf.c              | 29 ++++++++++++++++++++---------
 include/linux/elf.h          |  8 +++++---
 4 files changed, 42 insertions(+), 28 deletions(-)


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.20.1

