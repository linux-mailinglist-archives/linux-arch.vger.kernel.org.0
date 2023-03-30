Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03486D0F78
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjC3T4S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjC3T4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 15:56:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C310410;
        Thu, 30 Mar 2023 12:56:15 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 71726736;
        Thu, 30 Mar 2023 19:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71726736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680206174; bh=N2IjKygEUNSWzbk9HGHBaTn8tSmphhsRZ+T4HZU7T4A=;
        h=From:To:Cc:Subject:Date:From;
        b=N11ThEoftHzgDZyRRy5XaAhIHIoygIt2DNi+uBUBvEOZ5WzS+vBamxM40IepJXu/i
         BiLjVd7oPPEdBTNF+QrwK0vNnHx3vvYr/maxB8tDl6/SrGsIlF8VDMyUIG8h5Me0xI
         FSiNcVornnTwjM1ruKphnudluEC6zRhf0Arl7BuAA8wp9NteXex3GfNQ9xQje/DgOY
         YynTvlX09YGyjwFPRQg0QBx8BqH8MFTT3AgWx6yK1KoyKaJlYYZuSb5wHSusH7uz6z
         Ypu/kjz8ZEToj0Re5j257032pIFzCw2JZMDU0D0fu3XwPKt6PB5gMkAXYtyLPnnThf
         qNjOzA+ndZd9Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/4] docs: move yet more architecture docs
Date:   Thu, 30 Mar 2023 13:56:00 -0600
Message-Id: <20230330195604.269346-1-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series builds on top of the documentation reorganization posted at

    https://lore.kernel.org/lkml/20230315211523.108836-1-corbet@lwn.net/

it adds several more architectures (the relatively inactive ones) to the
new arch/ directory.  This series goes on top of the previous one.

The cover letter from that series provides the motivation for this work:

    The top-level Documentation/ directory, despite the efforts of the last
    few years, is still a mess; there is too much stuff there, making it
    harder to find anything.  We do not organize our source directories
    that way, and for good reasons.

Jonathan Corbet (4):
  docs: Move arc architecture docs under Documentation/arch/
  docs: move ia64 architecture docs under Documentation/arch/
  docs: move parisc documentation under Documentation/arch/
  docs: move m68k architecture documentation under Documentation/arch/

 Documentation/admin-guide/kernel-parameters.rst           | 2 +-
 Documentation/{ => arch}/arc/arc.rst                      | 0
 Documentation/{ => arch}/arc/features.rst                 | 0
 Documentation/{ => arch}/arc/index.rst                    | 0
 Documentation/{ => arch}/ia64/aliasing.rst                | 0
 Documentation/{ => arch}/ia64/efirtc.rst                  | 0
 Documentation/{ => arch}/ia64/err_inject.rst              | 0
 Documentation/{ => arch}/ia64/features.rst                | 0
 Documentation/{ => arch}/ia64/fsys.rst                    | 0
 Documentation/{ => arch}/ia64/ia64.rst                    | 0
 Documentation/{ => arch}/ia64/index.rst                   | 0
 Documentation/{ => arch}/ia64/irq-redir.rst               | 0
 Documentation/{ => arch}/ia64/mca.rst                     | 0
 Documentation/{ => arch}/ia64/serial.rst                  | 0
 Documentation/arch/index.rst                              | 8 ++++----
 Documentation/{ => arch}/m68k/buddha-driver.rst           | 0
 Documentation/{ => arch}/m68k/features.rst                | 0
 Documentation/{ => arch}/m68k/index.rst                   | 0
 Documentation/{ => arch}/m68k/kernel-options.rst          | 0
 Documentation/{ => arch}/parisc/debugging.rst             | 0
 Documentation/{ => arch}/parisc/features.rst              | 0
 Documentation/{ => arch}/parisc/index.rst                 | 0
 Documentation/{ => arch}/parisc/registers.rst             | 0
 Documentation/translations/zh_CN/arch/index.rst           | 2 +-
 .../translations/zh_CN/{ => arch}/parisc/debugging.rst    | 4 ++--
 .../translations/zh_CN/{ => arch}/parisc/index.rst        | 4 ++--
 .../translations/zh_CN/{ => arch}/parisc/registers.rst    | 4 ++--
 MAINTAINERS                                               | 6 +++---
 arch/ia64/kernel/efi.c                                    | 2 +-
 arch/ia64/kernel/fsys.S                                   | 2 +-
 arch/ia64/mm/ioremap.c                                    | 2 +-
 arch/ia64/pci/pci.c                                       | 2 +-
 arch/m68k/Kconfig.machine                                 | 4 ++--
 33 files changed, 21 insertions(+), 21 deletions(-)
 rename Documentation/{ => arch}/arc/arc.rst (100%)
 rename Documentation/{ => arch}/arc/features.rst (100%)
 rename Documentation/{ => arch}/arc/index.rst (100%)
 rename Documentation/{ => arch}/ia64/aliasing.rst (100%)
 rename Documentation/{ => arch}/ia64/efirtc.rst (100%)
 rename Documentation/{ => arch}/ia64/err_inject.rst (100%)
 rename Documentation/{ => arch}/ia64/features.rst (100%)
 rename Documentation/{ => arch}/ia64/fsys.rst (100%)
 rename Documentation/{ => arch}/ia64/ia64.rst (100%)
 rename Documentation/{ => arch}/ia64/index.rst (100%)
 rename Documentation/{ => arch}/ia64/irq-redir.rst (100%)
 rename Documentation/{ => arch}/ia64/mca.rst (100%)
 rename Documentation/{ => arch}/ia64/serial.rst (100%)
 rename Documentation/{ => arch}/m68k/buddha-driver.rst (100%)
 rename Documentation/{ => arch}/m68k/features.rst (100%)
 rename Documentation/{ => arch}/m68k/index.rst (100%)
 rename Documentation/{ => arch}/m68k/kernel-options.rst (100%)
 rename Documentation/{ => arch}/parisc/debugging.rst (100%)
 rename Documentation/{ => arch}/parisc/features.rst (100%)
 rename Documentation/{ => arch}/parisc/index.rst (100%)
 rename Documentation/{ => arch}/parisc/registers.rst (100%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/debugging.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/registers.rst (98%)

-- 
2.39.2

