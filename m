Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817074C6D69
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiB1NIO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 08:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiB1NIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 08:08:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD63C54
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 05:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B4DDB81110
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 13:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434FEC340E7;
        Mon, 28 Feb 2022 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646053644;
        bh=3D39ey04d2tSNbYQJqs5wQw0sel+gm4JWNwn6CjOQDE=;
        h=From:To:Cc:Subject:Date:From;
        b=MMnnNZZ5eyLiSG7wE8SPOb1ibR/3l4ykdObinp/uZfNzmqXIBcBEntj/6SocZrif9
         +Lni1c8SS7RDh8SnVTfR5T+Oz0359Be5evJJgomtdwyjKT0eBJ7EIw7k930zOB1WDb
         t5Ypq9Da3VO5WGKsPkACoINS1pT8qrRoZ3OdT3paNM+4sXsWotlWfEMnJo3r9R5Q+b
         mW7Cs8eRAz4NWAs6BB0kQsjUzL+CmEkO/lnwJLo2ZTF5tboh7ehxt0QcnA7O9HBnMX
         Xanf6kSR2ZvVNhn0aNt6XNqAdpXcVWWZNT6WBsiW4XhGKISNEAWKSuB+ohnEHgwRZh
         SZE1L1B7RK+XQ==
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
Subject: [PATCH v10 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon, 28 Feb 2022 13:06:04 +0000
Message-Id: <20220228130606.1070960-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; h=from:subject; bh=3D39ey04d2tSNbYQJqs5wQw0sel+gm4JWNwn6CjOQDE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiHMi78Ns5UeAT/TGmHQuigmHVKkTD9PzzsXgY1IG5 ZD50ZaGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhzIuwAKCRAk1otyXVSH0IewB/ 0Q7xcFWIflR0OS+UJ9X62BLVivIDZjb9fXEwAcXQ9yjpJjvK0kO/C5eUxUAjrbmWCIf3vYcfqzViBe cjiDZ4ZZ6sRBTT7fdqIthTIm1/FI1vJl/skbbtPgx1gSoWZ1Z3JxRUVxXspBKP8iV0eSa8jzmSEeB3 EdkOm5zAkbl9baqLWPEtz7VtMUGC42/ZaVGhBOVFaq4pX2MuV5pvLH38TKS5n6TDwfDrBXeDO6JtxN df5S+oM9zUStWZcyNW+tmrWm7ytNIaa8jua3lgjlNbNm9+TebxmavpUhSuUN/GdS8cSi2MR3WVIisa R8jp02hcLXFpCsxnidTaAQnwA74Zo/
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/binfmt_elf.c              | 32 +++++++++++++++-------
 include/linux/elf.h          |  4 ++-
 4 files changed, 77 insertions(+), 25 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

