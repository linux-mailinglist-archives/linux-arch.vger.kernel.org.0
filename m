Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3706ED6A2
	for <lists+linux-arch@lfdr.de>; Mon, 24 Apr 2023 23:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDXVQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Apr 2023 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXVQ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2023 17:16:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A41B3;
        Mon, 24 Apr 2023 14:16:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EDEB15C0194;
        Mon, 24 Apr 2023 17:16:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 17:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682370986; x=1682457386; bh=TdHPh7/T5CgJtnWa9OfzQfXaL
        soGpymfbR8QJC3nNd0=; b=EBalbtpxIqJs/zg5dqzhX3AD0gh9yp7uO1yvONYE9
        FVY5CI4IwFczbNqD6bdMkxfN6dWUiDiks88fOxqmd5cOH7LoxFkSTkfMXfTT6Wvo
        a0HpSi8NR+eXgr1qI8jubfCz4aLCiOtYQDaxmf60bd1Y9jzvOLbj0LkY7f/EjKzz
        H25oHYdz9zyl9gvgGvzEuc/yAZtxsjEo8B2NJ5oyHeKP+xFi+kW5lQtw3VGGWJN4
        KpKswFQbbDVvx0IgfYZUnOOv40hX8ujFnKdR7CzK/kVcB5XZFBO9QPV4XD1uaoV5
        lX+tKBHIxNrCLvKfBnBdGWywnYjgxlKrBSm2mj2Zy1FFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682370986; x=1682457386; bh=TdHPh7/T5CgJtnWa9OfzQfXaLsoGpymfbR8
        QJC3nNd0=; b=JotyfwsAJAvuFapPOEnHL4+94qlUW18uTBY30z1q0jAYoiQnNr6
        cMiwJ/Ojde+FKxAfpAZBCZ/4lvOIEL/Ns/gnDIpEBrC/I0ce3o1JAAxNTYHLQPjq
        w25g9prQQKHJIc5xBdoED0wsqXATDIAOXhn8m9IEyBQd4uKKucSITOwf8X9k6G11
        +GHF5Mdrh8M7z3p7RAFIBfzBZyOV6w2eZdCZ0+DGyyyKP61IWNxBXmqzYEZeo0el
        7ahDMc9QVUtdCk8V1veINuvC10J3vXdw3n7nF/wfcjqulja/6dkWfxXOJga2Hx6l
        3SAz7Xrmfu4dDl7p3k014IUcBQIyJYSmJpA==
X-ME-Sender: <xms:qvFGZIKjg3XB9K73p97UE6dMtL75hWsTZQ4cQNa5YW9ej_bkFd1qsg>
    <xme:qvFGZIKGwQ1VhJfVg-M1VRmZbUI0ILkfpHn1x8scqt7QdnUId-RSck4otpRGPwUvC
    kZ2Wlrg__I61NaDx7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qvFGZItpd23CRjK_MTqzbs4TbynQCfKhPzK56sm3B624RVF4AvxQwQ>
    <xmx:qvFGZFY-sv9mSnk7OLoYRzGr7tEwUpguIpYp4QfZ0QP2kYwUn73tqg>
    <xmx:qvFGZPaScUpOnyWyOek_VURLn1_Z5qIP8IKiG7RIQFhyjDGM005Qdw>
    <xmx:qvFGZLHqKLLAXkx1HnNYDVsvTcnJNOf-vKJ6ruAj93VCu1C7sswkLg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 808FDB60086; Mon, 24 Apr 2023 17:16:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
Date:   Mon, 24 Apr 2023 23:15:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Thomas Huth" <thuth@redhat.com>
Subject: [GIT PULL] asm-generic updates for 6.4
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.4

for you to fetch changes up to 73afb20716e163cdaf662af30d3597aeaacc6a0b:

  Merge branch 'asm-generic-io' into asm-generic (2023-04-05 22:20:00 +0200)

----------------------------------------------------------------
asm-generic updates for 6.4

These are various cleanups, fixing a number of uapi header files to no
longer reference CONFIG_* symbols, and one patch that introduces the
new CONFIG_HAS_IOPORT symbol for architectures that provide working
inb()/outb() macros, as a preparation for adding driver dependencies
on those in the following release.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge branch 'asm-generic-io' into asm-generic

Niklas Schnelle (1):
      Kconfig: introduce HAS_IOPORT option and select it as necessary

Palmer Dabbelt (3):
      Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
      Move ep_take_care_of_epollwakeup() to fs/eventpoll.c
      Move bp_type_idx to include/linux/hw_breakpoint.h

Thomas Huth (2):
      pktcdvd: Remove CONFIG_CDROM_PKTCDVD_WCACHE from uapi header
      scripts: Update the CONFIG_* ignore list in headers_install.sh

 arch/alpha/Kconfig                       |  1 +
 arch/arm/Kconfig                         |  1 +
 arch/arm64/Kconfig                       |  1 +
 arch/ia64/Kconfig                        |  1 +
 arch/loongarch/Kconfig                   |  1 +
 arch/m68k/Kconfig                        |  1 +
 arch/microblaze/Kconfig                  |  1 +
 arch/mips/Kconfig                        |  1 +
 arch/parisc/Kconfig                      |  1 +
 arch/powerpc/Kconfig                     |  1 +
 arch/riscv/Kconfig                       |  1 +
 arch/sh/Kconfig                          |  1 +
 arch/sparc/Kconfig                       |  1 +
 arch/x86/Kconfig                         |  1 +
 drivers/block/pktcdvd.c                  | 13 +++++++++----
 drivers/bus/Kconfig                      |  2 +-
 drivers/parisc/Kconfig                   |  1 +
 fs/eventpoll.c                           | 13 +++++++++++++
 include/linux/hw_breakpoint.h            | 10 ++++++++++
 include/uapi/linux/atmdev.h              |  4 ----
 include/uapi/linux/eventpoll.h           | 12 ------------
 include/uapi/linux/hw_breakpoint.h       | 10 ----------
 include/uapi/linux/pktcdvd.h             | 11 -----------
 lib/Kconfig                              |  4 ++++
 net/atm/svc.c                            |  5 +++++
 scripts/headers_install.sh               |  4 ----
 tools/include/uapi/linux/hw_breakpoint.h | 10 ----------
 27 files changed, 57 insertions(+), 56 deletions(-)
