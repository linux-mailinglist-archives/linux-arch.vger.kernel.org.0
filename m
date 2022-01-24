Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1649830C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiAXPHu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 10:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiAXPHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 10:07:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A988BC06173B
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 07:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0B16CE1181
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 15:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A3EC340E7;
        Mon, 24 Jan 2022 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036864;
        bh=WMgkeOdQ6YbZ5GIkHNwSa0O95o1TyPQ6kQHHyVZD1lU=;
        h=From:To:Cc:Subject:Date:From;
        b=TlGZvebEBrnY2HnGbom+psgbPGZoslqE4dMEz3mtx3QCcVnxAEiT3dD3FIG89VR6C
         i0lf789i07iWKSMMfd3iTCLpzXqRTolwk+ZdeWbpw/u45nJeVx6GJFTaTKIa+6YB8A
         NU4nSv+VrTufD1nMCsbFzlV3cLxyQnNafVvBEyElUf97BfEAWcRf4Nz8T1pmWPOSCU
         74QVMsCx2Iy64BMABWbP4o2ZD/zqf2IgsETf0FEewNSmCEBede5QynE121FnteV9XR
         mucU27vVX+r+2/YzzK6duajfL0JQVZ/30SAAmHWRr3DQbogdQ8569s9bFMCgVBrNMB
         fmBoEeunceisA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 24 Jan 2022 15:07:00 +0000
Message-Id: <20220124150704.2559523-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; h=from:subject; bh=WMgkeOdQ6YbZ5GIkHNwSa0O95o1TyPQ6kQHHyVZD1lU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sCR+KQD4owTwEsFkgOrRjSCjH9/v7lBfvVL4+HB BHEQ46qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7AkQAKCRAk1otyXVSH0DsIB/ 4+6HTMMlaFtfwcaVnhkNLMyJiRyeTKZijSz6WgTwp/XNuXivIqEWrH1xDUKwpYduwfk2r5G9JBNQk/ 7kMvM2Cjr7PJCTSzCsWoM9v8bbfM5lj9l3VIh3pF7BUDulEuMX9Xn8KJPZH6DzpcQDqfDPkThograk 7IVvp8Ra8da4ZseUKVrBgoBU0VBg4tllFHbchZzwTGJUku+FCz3v0JqBnEKWZxNnvym0pGDF1nTqXd 0sXEvN3ys6dgD2TrVAeP9w4j8FNuexV5SqCAjmavCxfm9x9WwC9RTJJVMuSJm1MrFrusz4ZFxTE0C8 kGfR/hmIzxKXtQz7DylOgXVODstqlP
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

v8:
 - Rebase onto v5.17-rc1.
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


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.30.2

