Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C14F1241
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbiDDJqa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354620AbiDDJq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 05:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071335DC8
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 02:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DDC7B8075B
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3404C340F3;
        Mon,  4 Apr 2022 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649065471;
        bh=Bz8u+N/aNiqP+D7rbHSQ+B3ZQlGFH3cswzDIh9U3NLg=;
        h=From:To:Cc:Subject:Date:From;
        b=OjBC7XewjXyIBW918AKuOy3QmqtIBNbtCeT2nwb3lAVgG5ZawxzRKMTamDP6mdeeg
         hAk635d064JNq0nehHwDeEoLAY055O6OyoTXWxl7PIqnXV8fviW77C+WQEddPlp+Au
         9xHNi2mchxhTvP+Q9H+9uQSPWTqn/PjUSNJiRAH4aP3zmMVTcuQ5Ep6FHLfmzylrgD
         pd3nFqg/qohbyK1fpkYmNKO3OkMjRyiLmkLW/Bdi+lTtcheQsQ1H97iSyGV3j50e8r
         jQN/tSG+4o3eAoJnR/hVj/csnAMHkzdHznB/rHcZI93hp1Po1Z8EwFGNXlwsStZqST
         p0vcp+DxY7IYA==
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
Subject: [PATCH v12 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Mon,  4 Apr 2022 10:44:23 +0100
Message-Id: <20220404094425.313821-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; h=from:subject; bh=Bz8u+N/aNiqP+D7rbHSQ+B3ZQlGFH3cswzDIh9U3NLg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiSr32Vv3lA0HVPUUqKQDPPx7vJyNXcHWB0mkHG2wA XBGnZFmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYkq99gAKCRAk1otyXVSH0IxqB/ 9OkyhiEqzFkNPcQgv4G0keSQNFepg0Uu+/GZ26uHJCGgvNjrFqHwNuMCYmEWFRiaydppkZBNC1ojD8 qR5BI7phmFadGXM3U6X+2d5OcEtbPgjV39vz5Lxc5cZSz7uHxksZmPqUEmW+RGTf38DAEOfgNh6uWn yAuaaoCxfqDR80aCRY8wHqSm4JVTuaiVURnx+E1TBxndtMg2XyVpb17do/goQOgHf27V9or2F8gUEG gS/fzmgnkfKvkeAYClqrG5k4hMSB+cKpG+Hbc3VbNXeoYuUaHuqJ/SzfyFE7VaR595byRn/w1nZ4e6 98HH22OpfcjM+X/yp0CH9gYPX3StZn
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.30.2

