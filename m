Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9F6D5B64
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjDDJBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjDDJBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 05:01:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E1710EA;
        Tue,  4 Apr 2023 02:01:09 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5CFFE210DD92;
        Tue,  4 Apr 2023 02:01:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CFFE210DD92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680598869;
        bh=ZJSNDxHuoCpxuFP6EwKcvSgo1VZVW6Qhmfhsxpz/kw8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qEkczgNLHrbA3o4tZ+Z2OJTojDuZCgYBbC4JUHLVLlm9IEDH/xDJaOOiAFH5w/7uA
         8RKrcuhqYvQcMR/0bSt3NtXGYOuggo2pdnvscFehVu8M8zkwZNGGolVa66zPHtnram
         OllAPOZgFB2eTgPPFoaMwU52Xbi4uBfhLqcTRxlk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: [PATCH v4 4/5] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
Date:   Tue,  4 Apr 2023 02:01:03 -0700
Message-Id: <1680598864-16981-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add HYPERV_VTL_MODE Kconfig flag for VTL mode.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/Kconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..511f2e012c59 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -13,6 +13,30 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_VTL_MODE
+	bool "Enable Linux to boot in VTL context"
+	depends on X86_64 && HYPERV
+	default n
+	help
+	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
+	  enlightenments offered to host and guest partitions which enables
+	  the creation and management of new security boundaries within
+	  operating system software.
+
+	  VSM achieves and maintains isolation through Virtual Trust Levels
+	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
+	  being more privileged than lower levels. VTL0 is the least privileged
+	  level, and currently only other level supported is VTL2.
+
+	  Select this option to build a Linux kernel to run at a VTL other than
+	  the normal VTL0, which currently is only VTL2.  This option
+	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  secondary CPUs directly into 64-bit context as required for VTLs other
+	  than 0.  A kernel built with this option must run at VTL2, and will
+	  not run as a normal guest.
+
+	  If unsure, say N
+
 config HYPERV_TIMER
 	def_bool HYPERV && X86
 
-- 
2.34.1

