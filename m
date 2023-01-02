Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A5765AD9A
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 08:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjABHNE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 02:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjABHNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 02:13:02 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0EAC21BB;
        Sun,  1 Jan 2023 23:13:01 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3808420FB6C2;
        Sun,  1 Jan 2023 23:12:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3808420FB6C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672643581;
        bh=JHmYiMxUMLjwsWRpltGz5a7sWsZ8QTl2pKremQgo1BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBvcj8L7P8gv2aMynd2B3kKBVlNtI1GCwfx0YiViEoHiZLbIO6hLiU/LSKmqvRUdg
         MeDr8ZQHkwNGFVxpPscpowMlziJuOSHIiX3BPkzYIxIMr+/dG3nhrWLtk7gzebkONJ
         t0lCUQ9DtAy1Sh0JWry/AsBt1BpgE/NlB20qoWWI=
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
Subject: 
Date:   Mon,  2 Jan 2023 07:12:50 +0000
Message-Id: <cover.1672639707.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669788587.git.jinankjain@linux.microsoft.com>
References: <cover.1669788587.git.jinankjain@linux.microsoft.com>
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

Subject: [PATCH v10 0/5] Add support running nested Microsoft Hypervisor

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

[v10]
- Fix de-allocation of SynIC pages as suggested by Michael


 arch/x86/include/asm/hyperv-tlfs.h | 17 +++++-
 arch/x86/include/asm/idtentry.h    |  2 +
 arch/x86/include/asm/irq_vectors.h |  6 +++
 arch/x86/include/asm/mshyperv.h    | 72 +++++++++++++++----------
 arch/x86/kernel/cpu/mshyperv.c     | 87 ++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c              | 10 ++++
 drivers/hv/hv.c                    | 18 ++++---
 drivers/hv/hv_common.c             |  9 ++--
 drivers/hv/vmbus_drv.c             |  5 +-
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/asm-generic/mshyperv.h     |  1 +
 11 files changed, 187 insertions(+), 41 deletions(-)

-- 
2.25.1

