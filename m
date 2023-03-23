Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B16C72F4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCWWUG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCWWUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:20:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63320D3F;
        Thu, 23 Mar 2023 15:20:02 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 670CE60A;
        Thu, 23 Mar 2023 22:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 670CE60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679610002; bh=uJ3G9x9Oc+8gANJ7IStVIIXmDT9uCREH515n9V/IsQI=;
        h=From:To:Cc:Subject:Date:From;
        b=TFj34R/CSPOrMPhLbV673AOSIIXwpBK2m3pJWW7qh9ZjGUyUKvRF4BtECRPGm2+a1
         q0v0AewLZfCa1qiPTA5N6DKG9aqtlfgAGKQJ6HMt8AfjymrYiyFS59SNzDaZsGQrDS
         s/bIGI7tJinLprk0wJs+lAeuJZAvI5wadaVlmSbXYvQ8IAaNMNPYESd0TV7lYRwTNU
         FVd2B/mV+WjpGHnk6xEoPlxCdHGW+oZ3cz8TORdVAkCbRiqphrfayy1waTunA2wviL
         J22BYFJQhIzJ8EHHyfDUj24vs58HIrDWfodFNRQ3mTJ//cqhdTBqhQchBEjR3SaHZr
         x+HcR5ammNF7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/6] Documentation: arch reorg (continued)
Date:   Thu, 23 Mar 2023 16:19:42 -0600
Message-Id: <20230323221948.352154-1-corbet@lwn.net>
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

Jonathan Corbet (6):
  docs: zh_CN: create the architecture-specific top-level directory
  docs: move xtensa documentation under Documentation/arch/
  docs: move sparc documentation under Documentation/arch/
  docs: move superh documentation under Documentation/arch/
  docs: move openrisc documentation under Documentation/arch/
  docs: move nios2 documentation under Documentation/arch/

 Documentation/arch/index.rst                           | 10 +++++-----
 Documentation/{ => arch}/nios2/features.rst            |  0
 Documentation/{ => arch}/nios2/index.rst               |  0
 Documentation/{ => arch}/nios2/nios2.rst               |  0
 Documentation/{ => arch}/openrisc/features.rst         |  0
 Documentation/{ => arch}/openrisc/index.rst            |  0
 Documentation/{ => arch}/openrisc/openrisc_port.rst    |  0
 Documentation/{ => arch}/openrisc/todo.rst             |  0
 Documentation/{ => arch}/sh/booting.rst                |  0
 Documentation/{ => arch}/sh/features.rst               |  0
 Documentation/{ => arch}/sh/index.rst                  |  0
 Documentation/{ => arch}/sh/new-machine.rst            |  0
 Documentation/{ => arch}/sh/register-banks.rst         |  0
 Documentation/{ => arch}/sparc/adi.rst                 |  0
 Documentation/{ => arch}/sparc/console.rst             |  0
 Documentation/{ => arch}/sparc/features.rst            |  0
 Documentation/{ => arch}/sparc/index.rst               |  0
 Documentation/{ => arch}/sparc/oradax/dax-hv-api.txt   |  0
 Documentation/{ => arch}/sparc/oradax/oracle-dax.rst   |  0
 Documentation/{ => arch}/xtensa/atomctl.rst            |  0
 Documentation/{ => arch}/xtensa/booting.rst            |  0
 Documentation/{ => arch}/xtensa/features.rst           |  0
 Documentation/{ => arch}/xtensa/index.rst              |  0
 Documentation/{ => arch}/xtensa/mmu.rst                |  0
 .../translations/zh_CN/{arch.rst => arch/index.rst}    | 10 +++++-----
 .../translations/zh_CN/{ => arch}/openrisc/index.rst   |  4 ++--
 .../zh_CN/{ => arch}/openrisc/openrisc_port.rst        |  4 ++--
 .../translations/zh_CN/{ => arch}/openrisc/todo.rst    |  4 ++--
 Documentation/translations/zh_CN/index.rst             |  2 +-
 MAINTAINERS                                            |  4 ++--
 arch/sh/Kconfig.cpu                                    |  2 +-
 arch/xtensa/include/asm/initialize_mmu.h               |  2 +-
 drivers/sbus/char/oradax.c                             |  2 +-
 33 files changed, 22 insertions(+), 22 deletions(-)
 rename Documentation/{ => arch}/nios2/features.rst (100%)
 rename Documentation/{ => arch}/nios2/index.rst (100%)
 rename Documentation/{ => arch}/nios2/nios2.rst (100%)
 rename Documentation/{ => arch}/openrisc/features.rst (100%)
 rename Documentation/{ => arch}/openrisc/index.rst (100%)
 rename Documentation/{ => arch}/openrisc/openrisc_port.rst (100%)
 rename Documentation/{ => arch}/openrisc/todo.rst (100%)
 rename Documentation/{ => arch}/sh/booting.rst (100%)
 rename Documentation/{ => arch}/sh/features.rst (100%)
 rename Documentation/{ => arch}/sh/index.rst (100%)
 rename Documentation/{ => arch}/sh/new-machine.rst (100%)
 rename Documentation/{ => arch}/sh/register-banks.rst (100%)
 rename Documentation/{ => arch}/sparc/adi.rst (100%)
 rename Documentation/{ => arch}/sparc/console.rst (100%)
 rename Documentation/{ => arch}/sparc/features.rst (100%)
 rename Documentation/{ => arch}/sparc/index.rst (100%)
 rename Documentation/{ => arch}/sparc/oradax/dax-hv-api.txt (100%)
 rename Documentation/{ => arch}/sparc/oradax/oracle-dax.rst (100%)
 rename Documentation/{ => arch}/xtensa/atomctl.rst (100%)
 rename Documentation/{ => arch}/xtensa/booting.rst (100%)
 rename Documentation/{ => arch}/xtensa/features.rst (100%)
 rename Documentation/{ => arch}/xtensa/index.rst (100%)
 rename Documentation/{ => arch}/xtensa/mmu.rst (100%)
 rename Documentation/translations/zh_CN/{arch.rst => arch/index.rst} (77%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst (88%)

-- 
2.39.2

