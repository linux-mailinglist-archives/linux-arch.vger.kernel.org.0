Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1A34B0329
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiBJCPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:15:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBJCPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:15:32 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:15:34 PST
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D1263D;
        Wed,  9 Feb 2022 18:15:33 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-09.nifty.com with ESMTP id 21A2CPg7025236;
        Thu, 10 Feb 2022 11:12:25 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVGv030193;
        Thu, 10 Feb 2022 11:11:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVGv030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459092;
        bh=RhesRhmCVCx/rBYRE3l+3VDy75d7MnF2gKpJO7C1MhY=;
        h=From:To:Cc:Subject:Date:From;
        b=DbWV5Cym3b8GOZXL9J4z6bghLFew5NZrUMHbU2vkjuoBwpJYbzAb2gqYLfIqmxlDv
         qxm7xHGdb2BmxjtZD+O6P64pVZEVceS8rLJJ2OUoQK1oGk2W7YMZeYCg42VXSD2pr+
         +MiUAe96O8Fq+Ogj3iwSp4DkXZ2GPCrM4Uhmb6ISunoplIh615ECnEM5vy3PiC2Ukt
         40pUXmiYTT5CmIhHjY4wSQroqkb5JxiteHLEgcCzwaR1obdoOKj9XI26yUNpX55Zdw
         0dCg7yrV4O/vXSPyKao2OqAWhRF/u7/Njr3dRVBRmDElOzOZgLd3mzCE59cfmBjXn6
         uEuIfr61FL/VA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/6] Add more export headers to compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:23 +0900
Message-Id: <20220210021129.3386083-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org




Masahiro Yamada (6):
  signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test
    coverage
  shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
  android/binder.h: add linux/android/binder(fs).h to UAPI compile-test
    coverage
  fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
  kexec.h: add linux/kexec.h to UAPI compile-test coverage
  reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test
    coverage

 arch/alpha/include/uapi/asm/signal.h   | 2 +-
 arch/arm/include/uapi/asm/signal.h     | 2 +-
 arch/h8300/include/uapi/asm/signal.h   | 2 +-
 arch/ia64/include/uapi/asm/signal.h    | 2 +-
 arch/m68k/include/uapi/asm/signal.h    | 2 +-
 arch/mips/include/uapi/asm/shmbuf.h    | 7 +++++--
 arch/mips/include/uapi/asm/signal.h    | 2 +-
 arch/parisc/include/uapi/asm/shmbuf.h  | 2 ++
 arch/parisc/include/uapi/asm/signal.h  | 2 +-
 arch/powerpc/include/uapi/asm/shmbuf.h | 5 ++++-
 arch/powerpc/include/uapi/asm/signal.h | 2 +-
 arch/s390/include/uapi/asm/signal.h    | 2 +-
 arch/sparc/include/uapi/asm/shmbuf.h   | 5 ++++-
 arch/sparc/include/uapi/asm/signal.h   | 3 ++-
 arch/x86/include/uapi/asm/shmbuf.h     | 6 +++++-
 arch/x86/include/uapi/asm/signal.h     | 2 +-
 arch/xtensa/include/uapi/asm/shmbuf.h  | 5 ++++-
 arch/xtensa/include/uapi/asm/signal.h  | 2 +-
 include/uapi/asm-generic/shmbuf.h      | 4 +++-
 include/uapi/asm-generic/signal.h      | 2 +-
 include/uapi/linux/android/binder.h    | 4 ++--
 include/uapi/linux/fsmap.h             | 2 +-
 include/uapi/linux/kexec.h             | 4 ++--
 include/uapi/linux/reiserfs_xattr.h    | 2 +-
 usr/include/Makefile                   | 8 --------
 25 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.32.0

