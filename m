Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AF6C0E17
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 11:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCTKEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 06:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCTKE3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 06:04:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26981F742;
        Mon, 20 Mar 2023 03:03:54 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BA19820FAACE;
        Mon, 20 Mar 2023 03:03:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA19820FAACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679306622;
        bh=FtXfq6t14W8wRg84Ahg76WKseeVUXWFLWJc0iPV2wLA=;
        h=From:To:Subject:Date:From;
        b=eXTfTuo+P9FkVD43Ja9RyMHLIz/xN7jrFeKaO5VYBEVXYQwPsv65XW5bwLTdeunrD
         RLKdwK/k/Roawysa1ZUEEDO0gG8mRc54Q6/64sMXveZcq/K1WY//9GItZQ7ZJ52yNZ
         VpZGll6djnxfpv1416Co7IH5q23/scL2DMJQs7Os=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 0/5] Hyper-V VTL support
Date:   Mon, 20 Mar 2023 03:03:33 -0700
Message-Id: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URI_TRY_3LD,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series introduces support for Virtual Trust Level (VTL)
in Hyper-V systems. It provide a foundation for the implementation
of Hyper-V VSM support in the Linux kernel, providing a secure
platform for the development and deployment of applications.

Virtual Secure Mode (VSM) is a critical aspect of the security
infrastructure in Hyper-V systems. It provides a set of hypervisor
capabilities and enlightenments that enable the creation and
management of new security boundaries within operating system
software. The VSM achieves and maintains isolation through Virtual
Trust Levels, which are hierarchical, with higher levels being more
privileged than lower levels. Please refer to this link for further
information: https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

This patch series adds the initialization of the x86 platform for VTL
systems. This also adds the VTL early bootup code for initializing
and bringing up secondary cpus to targeted VTL context. In VTL, AP
has to start directly in the 64-bit mode, bypassing the usual
16-bit -> 32-bit -> 64-bit mode transition sequence that occurs after
waking up an AP with SIPI whose vector points to the 16-bit AP
startup trampoline code.

Currently only VTL level supprted is '2'. This patch series is tested
extensively on VTL2 systems.

[V3]
 - Break in to 5 patches
 - hv_init_vp_context_t -> hv_init_vp_context
 - HYPERV_VTL -> HYPERV_VTL_MODE
 - Modify description of HYPERV_VTL_MODE
 - VTL 0 and VTL 2 -> VTL0 and VTL2
 - Remove casting for this_cpu_ptr pointer

[V2]
 - Remove the code for reserve 1 IRQ.
 - boot_cpu_has -> cpu_feature_enabled.
 - Improved commit message for 0002 patch.
 - Improved Kconfig flag description for HYPERV_VTL.
 - Removed hv_result as a wrapper around hv_do_hypercall().
 - The value of output[0] copied to a local variable before returning.

Saurabh Sengar (5):
  x86/init: Make get/set_rtc_noop() public
  x86/hyperv: Add VTL specific structs and hypercalls
  x86/hyperv: Make hv_get_nmi_reason public
  x86/hyperv: VTL support for Hyper-V
  x86/Kconfig: Add HYPERV_VTL_MODE

 arch/x86/Kconfig                   |  24 +++
 arch/x86/hyperv/Makefile           |   1 +
 arch/x86/hyperv/hv_vtl.c           | 227 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  75 ++++++++++
 arch/x86/include/asm/mshyperv.h    |  15 ++
 arch/x86/include/asm/x86_init.h    |   2 +
 arch/x86/kernel/cpu/mshyperv.c     |   6 +-
 arch/x86/kernel/x86_init.c         |   4 +-
 include/asm-generic/hyperv-tlfs.h  |   4 +
 9 files changed, 351 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_vtl.c

-- 
2.34.1

