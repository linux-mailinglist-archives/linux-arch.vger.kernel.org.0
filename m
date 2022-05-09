Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF951F901
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiEIJvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbiEIJk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 05:40:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97905193217;
        Mon,  9 May 2022 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652088970; x=1683624970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/x1ycw0QvCLLhMcVpaUSr9cP6MhaUOF3dS7CsbLTm8=;
  b=OyKHWmdj/pFZhcct06STunaHCeRVGSb4/ct4OhGBMJPy4yjgGAPwTmI9
   Yi5uS8B/6OVOmfuWrWjHpcdFHvZIiw6q2pn9TDsOjP2o4B8+yHDOJcUMw
   F8wilyE3BgMMjqUbaTAxJsXXPF9P8IuEdihYy3LSWehX9x01/TgGl3liu
   DJp3kT9HpIFb0RxhTRIYnstaaGVsJbqA0+ajzYxl3XDDG2WIrt7XhXTW1
   73eGKVwY/dKUwTQF2EwPCYcUdsa8LO8oWZvX/YVpW6CS3od6IoP3VJ2zl
   sT23FjMlme3kGmH1XnJgGP7OnDdEsD4GllAWglWTFpH3ZX3qOd294nCbk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="251040429"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="251040429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:34:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="564969527"
Received: from mfuent2x-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.220.67])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:34:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] termbits.h: Further improvements
Date:   Mon,  9 May 2022 12:34:43 +0300
Message-Id: <20220509093446.6677-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Again, I prefer Greg to take these through his tty tree.

Changes done by this serie:

1) Create termbits-common.h for the most obvious termbits.h intersection.
2) Reformat some lines that remain in termbits.h files.
3) Don't include posix_types.h unnecessarily.

Please do check I got the uapi include things done correctly! That is,
that including using asm-generic/termbits-common.h path is the preferred
approach for a header file that is not supposed to be overridden by the
arch specific header files and that mandatory-y is not required for
termbits-common.h.

Unfortunately I couldn't move also tcflag_t into termbits-common.h due
to the way it is being defined for sparc. However, by the looks of how
the type for tcflag_t is being chosen there, having just unsigned int
might work also for sparc?

Ilpo Järvinen (3):
  termbits.h: create termbits-common.h for identical bits
  termbits.h: Align lines & format
  termbits.h: Remove posix_types.h include

 arch/alpha/include/uapi/asm/termbits.h     | 182 ++++++-----------
 arch/mips/include/uapi/asm/termbits.h      | 209 ++++++++-----------
 arch/parisc/include/uapi/asm/termbits.h    | 131 ++++--------
 arch/powerpc/include/uapi/asm/termbits.h   | 152 +++++---------
 arch/sparc/include/uapi/asm/termbits.h     | 223 ++++++++-------------
 include/uapi/asm-generic/termbits-common.h |  65 ++++++
 include/uapi/asm-generic/termbits.h        | 129 ++++--------
 7 files changed, 418 insertions(+), 673 deletions(-)
 create mode 100644 include/uapi/asm-generic/termbits-common.h

-- 
2.30.2

