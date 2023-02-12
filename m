Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09869367D
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBLIqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLIqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 03:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5810411;
        Sun, 12 Feb 2023 00:46:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DDC60BA0;
        Sun, 12 Feb 2023 08:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FB0C433EF;
        Sun, 12 Feb 2023 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676191586;
        bh=ah2GfV04TNaeo9p4bKcxyFBZTnmc5HbVuYgTsk1ZZFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MT3LIRf8bJTXYDiK3G1TVA1CKbwwEe0DllUzU7AH1ati2qxAOPPjau6Q9V+1qD712
         9phIFR2qApBCOCf907VbVd1Vzgi8Kkvymd8e38sooTWXCnTAtIO84w+/+6hlc/B6lp
         Vs5cDzwUxMsjjH4ii6tmr6lQu5fAuwTpgoYB+9Li1kyMTuxy7KqTk8M0RXCVTqlXNd
         8MpWrajJGzrj03wUITE461o00r7HJBYuEU1MCW+665ubHQF9TFoiVdlzQjftA9EIyk
         MG5uK31epum7kES7DHzqtYo8SozcgREgID6KFZbc+HSs8IRssKkUVoY0KoNb82sniK
         kpwrKzPXcN5Uw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 0/2] char/agp: consolidate asm/agp.h
Date:   Sun, 12 Feb 2023 10:46:09 +0200
Message-Id: <20230212084611.1311177-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

asm/agp.h is duplicated in several architectures, with x86 being the
only instance that differs from the rest.

Introduce asm-generic/agp.h and use it instead of per-architecture
headers for the most cases.

I believe that asm-generic is the best tree to pick up this patches.

Mike Rapoport (IBM) (2):
  char/agp: consolidate {alloc,free}_gatt_pages()
  char/agp: introduce asm-generic/agp.h

 arch/alpha/include/asm/Kbuild   |  1 +
 arch/alpha/include/asm/agp.h    | 19 -------------------
 arch/ia64/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/agp.h     | 27 ---------------------------
 arch/parisc/include/asm/Kbuild  |  1 +
 arch/parisc/include/asm/agp.h   | 21 ---------------------
 arch/powerpc/include/asm/Kbuild |  1 +
 arch/powerpc/include/asm/agp.h  | 19 -------------------
 arch/sparc/include/asm/Kbuild   |  1 +
 arch/sparc/include/asm/agp.h    | 17 -----------------
 arch/x86/include/asm/agp.h      |  6 ------
 drivers/char/agp/agp.h          |  6 ++++++
 include/asm-generic/agp.h       | 11 +++++++++++
 13 files changed, 22 insertions(+), 109 deletions(-)
 delete mode 100644 arch/alpha/include/asm/agp.h
 delete mode 100644 arch/ia64/include/asm/agp.h
 delete mode 100644 arch/parisc/include/asm/agp.h
 delete mode 100644 arch/powerpc/include/asm/agp.h
 delete mode 100644 arch/sparc/include/asm/agp.h
 create mode 100644 include/asm-generic/agp.h


base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
2.35.1

