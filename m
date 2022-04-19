Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675CF506929
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiDSKyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiDSKyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 06:54:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DCA1DA6A
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 03:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9937561251
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 10:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DCFC385A7;
        Tue, 19 Apr 2022 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650365523;
        bh=Kps/nxXdvPmFXoUlorRs+A7ltjd1wVHQC8NezFMOSIE=;
        h=From:To:Cc:Subject:Date:From;
        b=cJUaGD0gfHALC3Vhq3GC8+GrBlknI/gbREJ1bPrY2fQajjQ+NhUMlvO26h3bobeVz
         FtzRloQyq06Zxvf72SEcZg72R5weY4oJa8e6xEG+1oCgOLS8kLAqvTA+T4I1Wy+Y9i
         gUQxcZiextfbGnMiIzLNiyHcOuINMU8xy9bTy6HK7NABTYaFZE5IRlJVmUxITPHLzM
         11fO0IAlLKYZbUdnuhlK3pXSTPsBatTaI04JuvEIjjqxM/OkJ0pO1KlyzYKmlu5kg9
         bvgMLi+42l9Y6sJpvubhJa6NLqSDgj8Uh/pij2U8/aIXjQJH7YrTReadhmcTHOU4x4
         UDEkLcSrVODEg==
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
Subject: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Tue, 19 Apr 2022 11:51:54 +0100
Message-Id: <20220419105156.347168-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; h=from:subject; bh=Kps/nxXdvPmFXoUlorRs+A7ltjd1wVHQC8NezFMOSIE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpRJcfio29GZoxSti3bpnKc41Y8y84J37Pv6Tfyd ZJzwHuiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6USQAKCRAk1otyXVSH0HFoB/ wJVd2GkOxINUznTSbBRQrTn7aErJQuxDfrnxxIUuz5e4u5Ch2h/G/zyIq736my/GfE619j+hJsCmzO Xl5zl4F6l+WOeobRpHCtOt7gUHdGlXJLQbAWhaEIFzZ2RQZRMc9JJ/YYo6TcZERutsIDdYBXUXfMiX TgooicRZ4bErr3yEcfFUlEFnZVrfec0l9aFLpOSfK2QFQBZs9Hsn+yWyZ31/7oTzVvuHsp2OTYVqsa NRcpH9Wyp2esgbjcw1v/hbwxvddO1K4CKGokpZC6eVLYdobt+hxetNJl8QRzT2BL36IUbi+iQdXGu4 haUUXsU5oBv32Ji2i/lxBRE+JkgARk
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v13:
 - Rebase onto v5.18-rc3.
v12:
 - Rebase onto v5.18-rc1.
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


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.30.2

