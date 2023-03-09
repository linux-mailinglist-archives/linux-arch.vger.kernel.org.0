Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC16B2CF4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCISgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCISgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 13:36:17 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7E3CF2F91;
        Thu,  9 Mar 2023 10:36:15 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D26E2057639;
        Thu,  9 Mar 2023 10:36:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D26E2057639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678386975;
        bh=FlNVFu0pWbOavHBL0eHfwtfKDC01SJK6EPHbEZafCVk=;
        h=From:To:Subject:Date:From;
        b=CvZQ68eikF9rJVDAvQ0dmsuusCGIcERvcZg4pU4Ss3TPpw01CQs3fXpZwl7TNdW47
         vMi04Qz4Gmy4aTyDqxAMwWrzpSOUjiHBHVrLB6RKQH2oEYQESqHXzVqDgfJ/08/1jX
         UUIA0EuxPSzil0Trn6BdZbot6inohNzgQ3iiXdYE=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 0/2] Hyper-V VTL support
Date:   Thu,  9 Mar 2023 10:35:55 -0800
Message-Id: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
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

[V2]
 - Remove the code for reserve 1 IRQ.
 - boot_cpu_has -> cpu_feature_enabled.
 - Improved commit message for 0002 patch.
 - Improved Kconfig flag description for HYPERV_VTL.
 - Removed hv_result as a wrapper around hv_do_hypercall().
 - The value of output[0] copied to a local variable before returning.


Saurabh Sengar (2):
  x86/init: Make get/set_rtc_noop() public
  x86/hyperv: VTL support for Hyper-V

 arch/x86/Kconfig                   |  24 +++
 arch/x86/hyperv/Makefile           |   1 +
 arch/x86/hyperv/hv_vtl.c           | 227 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  75 ++++++++++
 arch/x86/include/asm/mshyperv.h    |  14 ++
 arch/x86/include/asm/x86_init.h    |   2 +
 arch/x86/kernel/cpu/mshyperv.c     |   6 +-
 arch/x86/kernel/x86_init.c         |   4 +-
 include/asm-generic/hyperv-tlfs.h  |   4 +
 9 files changed, 350 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_vtl.c

-- 
2.34.1

