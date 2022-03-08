Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39E4D191B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 14:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiCHNZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 08:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiCHNZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 08:25:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B041996
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 05:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7224AB81806
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 13:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF85C340EB;
        Tue,  8 Mar 2022 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646745871;
        bh=cWHVeZPYv1r1ov1flOwrGDggLr6SS0JvHPeqBo4wpcU=;
        h=From:To:Cc:Subject:Date:From;
        b=I5kdiYwl0guqNlI8bC7ln3DxGIAjrdeDbU+VTrb/DXSw0iuiC1dhZc5gpZ+RNgNo7
         1VsT5y22ck2EKKFhwAXWh32WqrGhWrF4ezUDsZGsbyF5R1thZiZiBDWpZGsMDonkrp
         cU+DNOPyrKhnz28ofYsrTIurz8h0ZqMbpX70oe1D17Wct0FRDHYGMTYg9gkdnjKcaf
         TTATTakJiq7YH3F7oOJmPwEyy6fMlPd5aKt/+8bLcN8sC+WC5bDznlUbYGbi5CFifV
         hMrNYLROwOCW/ALTfpzdVleZiUDSZs8SCE/lXsTcbg8L3/I/drAMMLZTiTR3Sfr/iE
         3BuY/Dmnj5cVg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Tue,  8 Mar 2022 13:22:38 +0000
Message-Id: <20220308132240.1697784-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; h=from:subject; bh=cWHVeZPYv1r1ov1flOwrGDggLr6SS0JvHPeqBo4wpcU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiJ1ibOHou9TOSAIZ7+MPC484wx8xzk8Ug0LvT7Zuc lohXQUaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYidYmwAKCRAk1otyXVSH0DmMB/ 4ueYdiLoK1j8RfnV08DimDkCUOtTYpfo3+vjHdexBaHYHO74sYcNTuzXxHb348Ql3YmFCShAZARHx5 srfldB3c6ez26X5OKKWuKUy3m1TAedkI7zFmWSETcajufRS4RHF00V9IY9nIXssjbCXvblSmI8W8tE Zp69nQ3rhWvjTHv9EjVo5mTwhxIwAcAXq56HOvJ8YSXRUe7h+WBplDLwk8d56ErY6FtgVdYSs0unEX 30QukZbwTd6Xy1IckUfR+ABiHkhOKiKaWYM7otcH2ccFif3iwkSpUgtsOzrIxmpMMu+kDzqVph9Fzi GAp+RATxlofzeigKln2eUz4PFhFUIP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
providing a sysctl which when enabled will cause the kernel to handle
the BTI property for both the interpreter and the main executable.

v11:
 - Ignore extra PT_INTERPs.
v10:
 - Add a sysctl abi.bti_main controlling the new behaviour.
v9:
 - Rebase onto v5.17-rc3.
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

Mark Brown (2):
  elf: Allow architectures to parse properties on the main executable
  arm64: Enable BTI for main executable as well as the interpreter

 arch/arm64/include/asm/elf.h | 14 ++++++++--
 arch/arm64/kernel/process.c  | 52 +++++++++++++++++++++++++++---------
 fs/binfmt_elf.c              | 34 ++++++++++++++++-------
 include/linux/elf.h          |  4 ++-
 4 files changed, 78 insertions(+), 26 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

