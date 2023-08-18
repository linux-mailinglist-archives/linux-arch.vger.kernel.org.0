Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C8780542
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 07:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjHRFAV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357956AbjHRFAS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 01:00:18 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FFA3AAB;
        Thu, 17 Aug 2023 22:00:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 68FFC2B00164;
        Fri, 18 Aug 2023 01:00:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 18 Aug 2023 01:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1692334813; x=1692342013; bh=4Hne7fM3xWWmZ3VcZm3RQeJhl
        3MPidqC5AOvp1iIiWo=; b=U7nPHzITmY8Dx2B/MRu9k7dshceM4Lv+Y0UxZeCRN
        VmgsHyIydhtvkbwPA/1QwxuA7AugJ4xoqFUgWXVgqOkVCCWfSFYmpGUpkdnGALRS
        p3hX8zdNFNDmSqMkvxiXWowloHsaC1OImAZbYmHx84ye+MXWS3Hv+QYtvLuaTM+l
        JzrX7up7VDi/IFVh6E3USe8rl8DZ5F2ksGj5xAM3Wwv69coAXdH3iuwFIED2VJs0
        NvydZFk2V4SP3ykPWAIIHrO9AkmNZifijRrC1PA9CVzVwpch0XBzV7h9qeoM6Ny+
        3pphwjWaBdzWGCz0/xwxfSnRls7UFb4+96NyVigXbdScA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692334813; x=1692342013; bh=4Hne7fM3xWWmZ3VcZm3RQeJhl3MPidqC5AO
        vp1iIiWo=; b=qZeTZ0OVd0DZxVfKhKSQ1iCDE4yE3QtvijtvDK5S5AkGbmU1QE5
        +xxFXTvzP6aoWCBvGNhVsr2h8o1bocEYcdgbmtzlwxW73MuMpF4NWHMUeSM8oAfl
        MaAS/3d1wy1PtQpQfkontpQY4Q1hQnN3Dzl33iZbPrhN0GVkAzGCAZYrUgNhy4s3
        nDbIPAVXYoZ1lwCGKDbYLCox5vvT0IWjP2OwClHlzyhZYgEISaNTtd8e+6PD44R3
        vIMUDOAZTm0jkdZozm+MQSD6HbybriyI08xa3otlRg97BS/iEms6NJGCN6R0xOqt
        mew3Iicz5zVR1MdisGxNgHXejWPFVp644RA==
X-ME-Sender: <xms:3freZO_HIXfahjzTG4R5tMPDk26GjXGAbpBKA8RnIXJxNUPIH6O4TQ>
    <xme:3freZOv2TO0QnyMmaes7r3QepCxEoshXfMmIe5_1T5BsF-5E09ahkg05rvTrBGWdf
    rurUsyI-ptlCVoUxLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3freZECcoJFZ_lA5154jiC_ByFNfJRkVdh2WMiWfBL0euvsWVPXPtQ>
    <xmx:3freZGdzpx0CPuCCfXgNJUXEzswglei4GfOflJbpDJv2vAgVdFJpyQ>
    <xmx:3freZDNxMgNvLSHkNwp-Vuo0gt3OEK2q8oSPrQPXkJ7yvHOkDRW1tA>
    <xmx:3freZO038HrUsOBLpGt29YTo_BtcSk8xvz_swuHhbX4LY5QXPFkZyaSGZ20>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28838B60089; Fri, 18 Aug 2023 01:00:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <35766d47-a38d-4096-b602-887cf3a689e1@app.fastmail.com>
Date:   Fri, 18 Aug 2023 07:00:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: [GIT PULL] asm-generic: regression fix for 6.5
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 4dd595c34c4bb22c16a76206a18c13e4e194335d:

  syscalls: Remove file path comments from headers (2023-06-22 17:10:09 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fix-6.5

for you to fetch changes up to 6e8d96909a23c8078ee965bd48bb31cbef2de943:

  asm-generic: partially revert "Unify uapi bitsperlong.h for arm64, riscv and loongarch" (2023-08-17 14:51:20 +0200)

----------------------------------------------------------------
asm-generic: regression fix for 6.5

Just one partial revert for a commit from the merge window
that caused annoying behavior when building old kernels on
arm64 hosts.

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: partially revert "Unify uapi bitsperlong.h for arm64, riscv and loongarch"

 arch/arm64/include/uapi/asm/bitsperlong.h       | 24 ++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/bitsperlong.h       | 14 ++++++++++++++
 tools/arch/arm64/include/uapi/asm/bitsperlong.h | 24 ++++++++++++++++++++++++
 tools/arch/riscv/include/uapi/asm/bitsperlong.h | 14 ++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 arch/arm64/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/riscv/include/uapi/asm/bitsperlong.h
 create mode 100644 tools/arch/arm64/include/uapi/asm/bitsperlong.h
 create mode 100644 tools/arch/riscv/include/uapi/asm/bitsperlong.h
