Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD7749763
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGFIVH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGFIVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 04:21:06 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A655171A;
        Thu,  6 Jul 2023 01:21:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DE245C007E;
        Thu,  6 Jul 2023 04:21:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 04:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1688631661; x=1688718061; bh=55VJm6qtHlPp+fjYk7l6T/ue2
        9vLnD16rjDAkrZPCsQ=; b=miCAnMlkETGEKIiXQn1XzT5/4isbkBlG74gQNg1KR
        /4YDilL3K5hfcwIMeEDRE0V3Qvsntxu1kxz8iNbk0/LJ/bNahC5uaEK1FF893qkm
        bHXmbL7xtpiwoiLwA8ZA/lEQtDFTwz/BypxWsmT2yRn3PaPHsSfuWIBsgeSAknLe
        oNaYwC3Rlm+I8zojHCaEScHwMkOKyVjV7/w/XLxpCEkW31QcY/R5A76mbiWP/svp
        mbCA0B/a9wEkPhKs7ajBM5MR8dTVwFzH6MP5JvYWcfxw4oNLjHAJcYpy+58amwaA
        4mmznDbyVxLYgJpuvci4ppnoA3bcSJ3LC1hkbDgqfH4zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688631661; x=1688718061; bh=55VJm6qtHlPp+fjYk7l6T/ue29vLnD16rjD
        AkrZPCsQ=; b=pV+kskFaHzqpfS59bdwLgORcyVGSm0aygpOezNUt3cs9gHbazvL
        HZspQrorWeNDExKSXpzk5Nl7ch6mDdi/sqc1xNpXIDiZuYvOSVEaxJ6MOwX71p6z
        ax8lbME3R/dY3I1beJMD1KqYfw1xrf7RxlSkUiUD/eyPt1LXfNTL1Jx32G8Grj2B
        DyMJnozHNgArbdzDr1Bq2Vut2WA/Z3wmNQduML8I2Dn3Uuy8f5gtr9FXNFd86vbg
        VHCa5N3KtSoEp4zku6wlAeR5Hz2+lMxn04EnI7jIWUxSJgpoo6apV3x65KOtuxue
        Q7e6tkR9y5fYxrvjWU0+How9qUFYvLXeZFA==
X-ME-Sender: <xms:bHmmZCwiwxiLK1X9WZoBZcjvpP7VuoNALcRaZ4XDQJYI5wzxjG6RWA>
    <xme:bHmmZOQwT8zk7fMlguW5SrjroqnyVWj4jmikTPLQGfhA_X98fUHTjNAClRfPwgel8
    0UcwgRtu4cHteTk8Qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bHmmZEUBNeWSsnViheE8zbA-w2tm8qHio_afBwMGEyYN3U5SxPfCQg>
    <xmx:bHmmZIj0NH2ZxZSkXD-wiIh6voAZh1r9r88nL5GPvCfgQMGM_BgaTA>
    <xmx:bHmmZEAS4nzeHTWHe7PTeu5zU3yp1tKhiiM2jI47odFhPt7xuU-S1Q>
    <xmx:bXmmZHMnJvvm4kyv8BoCnWwx6g1DybRzT2A9ux0zr92FDeiIYN5ZJg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0BDFB60086; Thu,  6 Jul 2023 04:21:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
Date:   Thu, 06 Jul 2023 10:20:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Subject: [GIT PULL] asm-generic updates for 6.5
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.5

for you to fetch changes up to 4dd595c34c4bb22c16a76206a18c13e4e194335d:

  syscalls: Remove file path comments from headers (2023-06-22 17:10:09 +0200)

----------------------------------------------------------------
asm-generic updates for 6.5

These are cleanups for architecture specific header files:

 - the comments in include/linux/syscalls.h have gone out of sync
   and are really pointless, so these get removed

 - The asm/bitsperlong.h header no longer needs to be architecture
   specific on modern compilers, so use a generic version for newer
   architectures that use new enough userspace compilers

 - A cleanup for virt_to_pfn/virt_to_bus to have proper type
   checking, forcing the use of pointers

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'virt-to-pfn-for-arch-v6.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into asm-generic

Linus Walleij (12):
      fs/proc/kcore.c: Pass a pointer to virt_addr_valid()
      m68k: Pass a pointer to virt_to_pfn() virt_to_page()
      ARC: init: Pass a pointer to virt_to_pfn() in init
      riscv: mm: init: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page() in cifsglob
      netfs: Pass a pointer to virt_to_page()
      xen/netback: Pass (void *) to virt_to_page()
      asm-generic/page.h: Make pfn accessors static inlines
      ARM: mm: Make virt_to_pfn() a static inline
      arm64: memory: Make virt_to_pfn() a static inline
      m68k/mm: Make pfn accessors static inlines

Sohil Mehta (1):
      syscalls: Remove file path comments from headers

Tiezhu Yang (2):
      asm-generic: Unify uapi bitsperlong.h for arm64, riscv and loongarch
      tools arch: Remove uapi bitsperlong.h of hexagon and microblaze

 arch/arc/mm/init.c                                 |   2 +-
 arch/arm/common/sharpsl_param.c                    |   2 +-
 arch/arm/include/asm/delay.h                       |   2 +-
 arch/arm/include/asm/io.h                          |   2 +-
 arch/arm/include/asm/memory.h                      |  17 ++-
 arch/arm/include/asm/page.h                        |   4 +-
 arch/arm/include/asm/pgtable.h                     |   2 +-
 arch/arm/include/asm/proc-fns.h                    |   2 -
 arch/arm/include/asm/sparsemem.h                   |   2 +-
 arch/arm/include/asm/uaccess-asm.h                 |   2 +-
 arch/arm/include/asm/uaccess.h                     |   2 +-
 arch/arm/kernel/asm-offsets.c                      |   2 +-
 arch/arm/kernel/entry-armv.S                       |   2 +-
 arch/arm/kernel/entry-common.S                     |   2 +-
 arch/arm/kernel/entry-v7m.S                        |   2 +-
 arch/arm/kernel/head-nommu.S                       |   3 +-
 arch/arm/kernel/head.S                             |   2 +-
 arch/arm/kernel/hibernate.c                        |   2 +-
 arch/arm/kernel/suspend.c                          |   2 +-
 arch/arm/kernel/tcm.c                              |   2 +-
 arch/arm/kernel/vmlinux-xip.lds.S                  |   3 +-
 arch/arm/kernel/vmlinux.lds.S                      |   3 +-
 arch/arm/mach-berlin/platsmp.c                     |   2 +-
 arch/arm/mach-keystone/keystone.c                  |   2 +-
 arch/arm/mach-omap2/sleep33xx.S                    |   2 +-
 arch/arm/mach-omap2/sleep43xx.S                    |   2 +-
 arch/arm/mach-omap2/sleep44xx.S                    |   2 +-
 arch/arm/mach-pxa/gumstix.c                        |   2 +-
 arch/arm/mach-rockchip/sleep.S                     |   2 +-
 arch/arm/mach-sa1100/pm.c                          |   2 +-
 arch/arm/mach-shmobile/headsmp-scu.S               |   2 +-
 arch/arm/mach-shmobile/headsmp.S                   |   2 +-
 arch/arm/mach-socfpga/headsmp.S                    |   2 +-
 arch/arm/mach-spear/spear.h                        |   2 +-
 arch/arm/mm/cache-fa.S                             |   1 -
 arch/arm/mm/cache-v4wb.S                           |   1 -
 arch/arm/mm/dma-mapping.c                          |   2 +-
 arch/arm/mm/dump.c                                 |   2 +-
 arch/arm/mm/init.c                                 |   2 +-
 arch/arm/mm/kasan_init.c                           |   1 -
 arch/arm/mm/mmu.c                                  |   2 +-
 arch/arm/mm/physaddr.c                             |   2 +-
 arch/arm/mm/pmsa-v8.c                              |   2 +-
 arch/arm/mm/proc-v7.S                              |   2 +-
 arch/arm/mm/proc-v7m.S                             |   2 +-
 arch/arm/mm/pv-fixup-asm.S                         |   2 +-
 arch/arm64/include/asm/memory.h                    |   9 +-
 arch/arm64/include/uapi/asm/bitsperlong.h          |  24 ----
 arch/loongarch/include/uapi/asm/bitsperlong.h      |   9 --
 arch/m68k/include/asm/mcf_pgtable.h                |   3 +-
 arch/m68k/include/asm/page_mm.h                    |  11 +-
 arch/m68k/include/asm/page_no.h                    |  11 +-
 arch/m68k/include/asm/sun3_pgtable.h               |   4 +-
 arch/m68k/mm/mcfmmu.c                              |   3 +-
 arch/m68k/mm/motorola.c                            |   4 +-
 arch/m68k/mm/sun3mmu.c                             |   2 +-
 arch/m68k/sun3/dvma.c                              |   2 +-
 arch/m68k/sun3x/dvma.c                             |   2 +-
 arch/riscv/include/uapi/asm/bitsperlong.h          |  14 ---
 arch/riscv/mm/init.c                               |   4 +-
 drivers/memory/ti-emif-sram-pm.S                   |   2 +-
 drivers/net/xen-netback/netback.c                  |   2 +-
 fs/netfs/iterator.c                                |   2 +-
 fs/proc/kcore.c                                    |   2 +-
 fs/smb/client/cifsglob.h                           |   2 +-
 fs/smb/client/smbdirect.c                          |   2 +-
 include/asm-generic/page.h                         |  12 +-
 include/linux/compat.h                             |  82 ++----------
 include/linux/syscalls.h                           | 140 +++------------------
 include/uapi/asm-generic/bitsperlong.h             |  13 +-
 include/uapi/asm-generic/unistd.h                  | 129 +++++--------------
 kernel/sys_ni.c                                    | 110 +---------------
 tools/arch/arm64/include/uapi/asm/bitsperlong.h    |  24 ----
 tools/arch/hexagon/include/uapi/asm/bitsperlong.h  |  27 ----
 .../arch/loongarch/include/uapi/asm/bitsperlong.h  |   9 --
 .../arch/microblaze/include/uapi/asm/bitsperlong.h |   2 -
 tools/arch/riscv/include/uapi/asm/bitsperlong.h    |  14 ---
 tools/include/uapi/asm-generic/bitsperlong.h       |  14 ++-
 tools/include/uapi/asm-generic/unistd.h            | 129 +++++--------------
 tools/include/uapi/asm/bitsperlong.h               |   6 -
 80 files changed, 218 insertions(+), 716 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/loongarch/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/riscv/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/arm64/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/hexagon/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/microblaze/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/riscv/include/uapi/asm/bitsperlong.h
