Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208664C3D1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 07:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiLNGdN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 01:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiLNGdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 01:33:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7711D66C;
        Tue, 13 Dec 2022 22:33:10 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4585B20B8768;
        Tue, 13 Dec 2022 22:33:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4585B20B8768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670999590;
        bh=FdaBi9/UQGf58YdgIgm2T4j7hu0zNGTVpigliN7T3i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6dHAnLbwUkjs/eiq7E52J+K2L1QTd6SDIA182EE03p/YhKBNoOv9DtSYl/DM0J71
         eozeLtZq1pT7U+UGEsOtgUC41rzmh5Yj+oNGEXcJIlGHtywpGLcU/Wsl2fwYliw/Na
         gDjqM+bNza2sNHio/S9XtgYkgWAFlKPb9u0ffotY=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: [PATCH v9 0/5] Add support running nested Microsoft Hypervisor
Date:   Wed, 14 Dec 2022 06:32:59 +0000
Message-Id: <cover.1670749201.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667406350.git.jinankjain@linux.microsoft.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series plans to add support for running nested Microsoft
Hypervisor. In case of nested Microsoft Hypervisor there are few
privileged hypercalls which need to go L0 Hypervisor instead of L1
Hypervisor. This patches series basically identifies such hypercalls and
replace them with nested hypercalls.

Jinank Jain (5):
  x86/hyperv: Add support for detecting nested hypervisor
  Drivers: hv: Setup synic registers in case of nested root partition
  x86/hyperv: Add an interface to do nested hypercalls
  Drivers: hv: Enable vmbus driver for nested root partition
  x86/hyperv: Change interrupt vector for nested root partition

[v4]
- Fix ARM64 compilation

[v5]
- Fix comments from Michael Kelly

[v6]
- Send the correct patches from the right folder

[v7]
- Fix linker issues for CONFIG_HYPERV=n pointed out by Michael
- Fix comments from Nuno: created two separate functions for fetching
  nested vs non-nested registers.

[v8]
- Refactor as per the recommendation from Michael Kelly

[v9]
- Address comments from Michael and Nuno.

 arch/x86/include/asm/hyperv-tlfs.h | 17 +++++-
 arch/x86/include/asm/idtentry.h    |  2 +
 arch/x86/include/asm/irq_vectors.h |  6 +++
 arch/x86/include/asm/mshyperv.h    | 72 +++++++++++++++----------
 arch/x86/kernel/cpu/mshyperv.c     | 87 ++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c              | 10 ++++
 drivers/hv/hv.c                    | 19 +++++--
 drivers/hv/hv_common.c             |  9 ++--
 drivers/hv/vmbus_drv.c             |  5 +-
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/asm-generic/mshyperv.h     |  1 +
 11 files changed, 190 insertions(+), 39 deletions(-)

-- 
2.25.1

