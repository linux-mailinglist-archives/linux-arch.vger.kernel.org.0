Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CE51F8BF
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiEIJv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiEIJjz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 05:39:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7618C06D;
        Mon,  9 May 2022 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652088961; x=1683624961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JULdTGBTfThIZcRLutbTwErm+tkVZJR7XHUyFQtfHus=;
  b=I7KHiNxYzLnjnhp3L39e9Rbks2p6eiKRG0gNap7+/972wyozBhr4qQ8y
   6qWauqHGCyGpHCWgKWTBLwShlMv4+cgw0S0Z+9cGu9GFV3Xrme6jlolVG
   yHnz05zCDkXweBZHjra0Qsuu4KbyQ/LFPDhpqpKRvK68n4YEjEkW3DQDc
   1WgjnEyqbSWNA1LH8Dnn/U/X+ecH/XtzEKBGZjmsnLwiUl/c7NPSqc7Yr
   dZUpfsanIZj208oiX+uHDuJkZdRalHwKhXzzEGgBTVgI6+IWfu5aFLaiC
   zEJcv7opiKNPSnQLE3QZxEwd0rN3U7m06aIR7++fh/60Sq9vUVOrYxjpB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="249533352"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249533352"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:35:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="564969629"
Received: from mfuent2x-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.220.67])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:35:14 -0700
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
Subject: [PATCH 3/3] termbits.h: Remove posix_types.h include
Date:   Mon,  9 May 2022 12:34:46 +0300
Message-Id: <20220509093446.6677-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509093446.6677-1-ilpo.jarvinen@linux.intel.com>
References: <20220509093446.6677-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nothing in termbits seems to require anything from linux/posix_types.h.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/alpha/include/uapi/asm/termbits.h  | 2 --
 arch/mips/include/uapi/asm/termbits.h   | 2 --
 arch/parisc/include/uapi/asm/termbits.h | 2 --
 arch/sparc/include/uapi/asm/termbits.h  | 2 --
 include/uapi/asm-generic/termbits.h     | 2 --
 5 files changed, 10 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 735e9ffe2795..f1290b22072b 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -2,8 +2,6 @@
 #ifndef _ALPHA_TERMBITS_H
 #define _ALPHA_TERMBITS_H
 
-#include <linux/posix_types.h>
-
 #include <asm-generic/termbits-common.h>
 
 typedef unsigned int	tcflag_t;
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index 8fa3e79d4f94..1eb60903d6f0 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -11,8 +11,6 @@
 #ifndef _ASM_TERMBITS_H
 #define _ASM_TERMBITS_H
 
-#include <linux/posix_types.h>
-
 #include <asm-generic/termbits-common.h>
 
 typedef unsigned int	tcflag_t;
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index d72c5ebf3a3a..3a8938d26fb4 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -2,8 +2,6 @@
 #ifndef __ARCH_PARISC_TERMBITS_H__
 #define __ARCH_PARISC_TERMBITS_H__
 
-#include <linux/posix_types.h>
-
 #include <asm-generic/termbits-common.h>
 
 typedef unsigned int	tcflag_t;
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index cfcc4e07ce51..4321322701fc 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -2,8 +2,6 @@
 #ifndef _UAPI_SPARC_TERMBITS_H
 #define _UAPI_SPARC_TERMBITS_H
 
-#include <linux/posix_types.h>
-
 #include <asm-generic/termbits-common.h>
 
 #if defined(__sparc__) && defined(__arch64__)
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index c92179563289..890ef29053e2 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_GENERIC_TERMBITS_H
 #define __ASM_GENERIC_TERMBITS_H
 
-#include <linux/posix_types.h>
-
 #include <asm-generic/termbits-common.h>
 
 typedef unsigned int	tcflag_t;
-- 
2.30.2

