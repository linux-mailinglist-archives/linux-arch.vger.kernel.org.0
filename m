Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BBC616959
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKBQlM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiKBQkx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 12:40:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75FB92DA94;
        Wed,  2 Nov 2022 09:36:08 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2D28E20C28B1;
        Wed,  2 Nov 2022 09:36:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D28E20C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667406968;
        bh=9/88lNAH8ojLEVPtGhn/JbPNn4rjfulEaEKmtJYYGx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LX0pvyot8MtESAsSo095I0p1bpduBwiVFrvZTGV/mCgEQCU+JGX8lNjwMtLCQX/pK
         06z7krYx3xietDrwBVgzkM/v8FFwlBLMxr8exxOPrvjYI/ZscxoqVPT/dbN9mClP7K
         O0F36eGjylj5GJGtzspqUUdCtgeQh63Q0PtzJJxA=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 0/5] Add support running nested Microsoft Hypervisor
Date:   Wed,  2 Nov 2022 16:35:57 +0000
Message-Id: <cover.1667406350.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <https://lore.kernel.org/linux-hyperv/cover.1667394408.git.jinankjain@microsoft.com/T/#t>
References: <https://lore.kernel.org/linux-hyperv/cover.1667394408.git.jinankjain@microsoft.com/T/#t>
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
  mshv: Add support for detecting nested hypervisor
  hv: Setup synic registers in case of nested root partition
  hv: Add an interface to do nested hypercalls
  hv: Enable vmbus driver for nested root partition
  hv, mshv : Change interrupt vector for nested root partition

 arch/x86/include/asm/hyperv-tlfs.h | 17 +++++++-
 arch/x86/include/asm/idtentry.h    |  2 +
 arch/x86/include/asm/irq_vectors.h |  6 +++
 arch/x86/include/asm/mshyperv.h    | 68 ++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/mshyperv.c     | 22 ++++++++++
 arch/x86/kernel/idt.c              |  9 ++++
 drivers/hv/hv.c                    | 18 +++++---
 drivers/hv/vmbus_drv.c             |  5 ++-
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/asm-generic/mshyperv.h     |  1 +
 10 files changed, 137 insertions(+), 12 deletions(-)

-- 
2.25.1

