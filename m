Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B7637223
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 07:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXGBp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 01:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXGBo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 01:01:44 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC6F3C6D1D;
        Wed, 23 Nov 2022 22:01:43 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 07F7320B6C40;
        Wed, 23 Nov 2022 22:01:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07F7320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669269703;
        bh=tzhuwFycoebVcWHMrROkyA4tNeUrjJRxO2O9LjBLL/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tO4LkNEd0fbiZuhAb4Mq31XvGZG0XXL+EfRHrghgNTWZyWb3Gw0vlZzMu1v5mJkYl
         etwLU1+1p/bnAVGaO1WUXtpSO3XmxaX8J7vsNM7c2/u8bbvA2USXQVQ3mlSpMv49lA
         l7tXuSJU3CIPSmaHC6rIGZOQmogLgHCpXO6BbL8k=
Subject: Re: [PATCH v5 0/5] Add support running nested Microsoft Hypervisor
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
References: <cover.1667394408.git.jinankjain@microsoft.com>
 <cover.1669007822.git.jinankjain@linux.microsoft.com>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Message-ID: <1f96d38f-adc0-8233-bb95-4937d196ac8d@linux.microsoft.com>
Date:   Thu, 24 Nov 2022 11:31:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <cover.1669007822.git.jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Please ignore the v5 patch series I posted the wrong set of patches.

Regards,

Jinank

On 11/24/2022 11:23 AM, Jinank Jain wrote:
> This patch series plans to add support for running nested Microsoft
> Hypervisor. In case of nested Microsoft Hypervisor there are few
> privileged hypercalls which need to go L0 Hypervisor instead of L1
> Hypervisor. This patches series basically identifies such hypercalls and
> replace them with nested hypercalls.
>
> Jinank Jain (5):
>    x86/hyperv: Add support for detecting nested hypervisor
>    Drivers: hv: Setup synic registers in case of nested root partition
>    x86/hyperv: Add an interface to do nested hypercalls
>    Drivers: hv: Enable vmbus driver for nested root partition
>    x86/hyperv: Change interrupt vector for nested root partition
>
> [v4]
> - Fix ARM64 compilation
>
> [v5]
> - Fix comments from Michael Kelly
>
>   arch/arm64/hyperv/mshyperv.c       |  6 +++
>   arch/x86/include/asm/hyperv-tlfs.h | 17 ++++++-
>   arch/x86/include/asm/idtentry.h    |  2 +
>   arch/x86/include/asm/irq_vectors.h |  6 +++
>   arch/x86/include/asm/mshyperv.h    | 68 ++++++++++++++++------------
>   arch/x86/kernel/cpu/mshyperv.c     | 71 ++++++++++++++++++++++++++++++
>   arch/x86/kernel/idt.c              |  9 ++++
>   drivers/hv/hv.c                    | 18 +++++---
>   drivers/hv/hv_common.c             |  7 ++-
>   drivers/hv/vmbus_drv.c             |  5 ++-
>   include/asm-generic/hyperv-tlfs.h  |  1 +
>   include/asm-generic/mshyperv.h     |  1 +
>   12 files changed, 173 insertions(+), 38 deletions(-)
>
