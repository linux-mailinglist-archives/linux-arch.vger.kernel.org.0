Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741E83A71F3
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNWfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 18:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFNWfI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C120611CE;
        Mon, 14 Jun 2021 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623709984;
        bh=1kttxY5HjwWN86k+EJQoe+g9QsvSoz0LeKgZ0xCI6qc=;
        h=From:To:Cc:Subject:Date:From;
        b=AdFG1sq8HMXV2ZTKKp6R25/GSxMTmILuJliaSeS0vXJ9k62bkhVpyse8fsk9z3CUX
         z+BbzJi1whsha2sn7Gy70wyU6Fqj1B+U8s6GU3M4Acj/5ZiX/zBpez/QHbIHwCgnjd
         I5houeQ3Cy7ypxvXUThwRlm1qmRcnxPMuW/5VSRJIKk9207Qqj6Al8oDHqCBdpnM0S
         /RuK1R2qkt4wZTZ1tzds9vBFIunQXcgl/wzTGEQ6jCgdFNpZ8Mp5xqIQOTC3+K/QtZ
         R0OcjOYemg5tjgvodhDYdGsYTJ3rkucvk/aPx3H822A4j8rdAFYWJn4aeSI3Qr7xU+
         gse5kA0bFa3zw==
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
Subject: [PATCH v3 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 14 Jun 2021 23:32:10 +0100
Message-Id: <20210614223214.39011-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; h=from:subject; bh=1kttxY5HjwWN86k+EJQoe+g9QsvSoz0LeKgZ0xCI6qc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgx9jpTlJ5MnJRp0eC3EbCH14AgQ9moJeH2EhyUxrd WkurP8OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYMfY6QAKCRAk1otyXVSH0L8/B/ 9DF+/o4D85EdoAaFyMTYzLFlyr5QHFDQS0uVicMa+psnlUjGgc8+Dc5MGjrSjh5lQIWgdPJF8FhKYj 2Wiu1QEYji3e+cARAhr6honQGf+mBtevppJc17CpxJs0Id2Q0jBOH0FoREIOGoKphCGTbsS4otXOWh 8L5YFxYvjUGmEUbBID6wgz0sbeRdtCFmlTthdZCdGiMI6g5hY9OTraKZ/TVTg2IdxJUEnEzJQ8ObLW EzaUkw4BJu5jKu8KRaxBCoopD5fUvUTm9HnK/iK5TTMYoRYPjlZsB+FGmK6P5ow4bOFFxgHeUeWHqk +r7lFtHCCM0inhENJ4cZc+sfWpv2Zc
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


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.20.1

