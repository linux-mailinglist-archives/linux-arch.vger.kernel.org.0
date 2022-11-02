Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2CE616430
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKBOA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKBOA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 10:00:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2AE65F56;
        Wed,  2 Nov 2022 07:00:23 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8863020B929F;
        Wed,  2 Nov 2022 07:00:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8863020B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667397623;
        bh=QDS071ByWL2Ky/RZhdG/Bn5KPQayXV/7JR1J8Lj5jZE=;
        h=From:To:Cc:Subject:Date:From;
        b=J7LFtD1EtoyIjvkmzKUkJLPgsuUE8hXEXuknMv6ldJ3EM1zD9dK+iCrGe+ShVUvbg
         g2Lbzsv3rs/flrYEjrccSpHfWb3ByAjmjDVM4DyrE06BXMxmP2IypjvfXBVO7+3iLc
         5+hJYP+K1aAbUUmtE9EJQrC7jJIcIxQ2PYbfBXOo=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 0/6] Add support running nested Microsoft Hypervisor
Date:   Wed,  2 Nov 2022 14:00:11 +0000
Message-Id: <cover.1667394408.git.jinankjain@microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@microsoft.com>

This patch series plans to add support for running nested Microsoft
Hypervisor. In case of nested Microsoft Hypervisor there are few
privileged hypercalls which need to go L0 Hypervisor instead of L1
Hypervisor. This patches series basically identifies such hypercalls and
replace them with nested hypercalls.

Jinank Jain (6):
  mshv: Add support for detecting nested hypervisor
  hv: Setup synic registers in case of nested root partition
  hv: Set the correct EOM register in case of nested hypervisor
  hv: Add an interface to do nested hypercalls
  hv: Enable vmbus driver for nested root partition
  hv, mshv : Change interrupt vector for nested root partition

 arch/x86/include/asm/hyperv-tlfs.h | 17 ++++++++-
 arch/x86/include/asm/idtentry.h    |  2 ++
 arch/x86/include/asm/irq_vectors.h |  6 ++++
 arch/x86/include/asm/mshyperv.h    | 42 ++++++++++++++++++++---
 arch/x86/kernel/cpu/mshyperv.c     | 22 ++++++++++++
 arch/x86/kernel/idt.c              |  9 +++++
 drivers/hv/hv.c                    | 55 ++++++++++++++++++------------
 drivers/hv/vmbus_drv.c             |  5 +--
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/asm-generic/mshyperv.h     |  7 +++-
 10 files changed, 137 insertions(+), 29 deletions(-)

-- 
2.25.1

