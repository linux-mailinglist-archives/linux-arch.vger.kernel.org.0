Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89A618316
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiKCPnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiKCPnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 11:43:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB42E193CD;
        Thu,  3 Nov 2022 08:42:56 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B7AC20C28B1;
        Thu,  3 Nov 2022 08:42:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B7AC20C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667490176;
        bh=dGJbKDoodjUWaGEJKNZ5IgwCUrNdic5vHQv1H8KYTs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BI+Vk9QZfKJnQXILdalmH4LWjzuzADgY8mTQSuBZq5lMJm4/ob3ZOsG/D0kBshqzM
         +MlT4v4n+LCpsazA57rAL3bt7C7pzUc5bNZy2KBu1G+V246y/LCbKNoni9K9wdMxuG
         4AJ45YrvsqIC6eJxPIolzwhjvw+Q1J9bkGUr00AM=
Date:   Thu, 3 Nov 2022 21:12:46 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/5]  Add support running nested Microsoft Hypervisor
Message-ID: <Y2PhdhjE+DGTjzKN@anrayabh-desk>
References: <https://lore.kernel.org/linux-hyperv/cover.1667406350.git.jinankjain@linux.microsoft.com/T/#t>
 <cover.1667480257.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667480257.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 01:04:02PM +0000, Jinank Jain wrote:
> This patch series plans to add support for running nested Microsoft
> Hypervisor. In case of nested Microsoft Hypervisor there are few
> privileged hypercalls which need to go L0 Hypervisor instead of L1
> Hypervisor. This patches series basically identifies such hypercalls and
> replace them with nested hypercalls.

In the future, please include a changelog in your cover letter
explaining what changed in each version of the series.

Anirudh.

> 
> Jinank Jain (5):
>   x86/hyperv: Add support for detecting nested hypervisor
>   Drivers: hv: Setup synic registers in case of nested root partition
>   x86/hyperv: Add an interface to do nested hypercalls
>   Drivers: hv: Enable vmbus driver for nested root partition
>   x86/hyperv: Change interrupt vector for nested root partition
> 
>  arch/x86/include/asm/hyperv-tlfs.h | 17 +++++++-
>  arch/x86/include/asm/idtentry.h    |  2 +
>  arch/x86/include/asm/irq_vectors.h |  6 +++
>  arch/x86/include/asm/mshyperv.h    | 68 ++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/mshyperv.c     | 22 ++++++++++
>  arch/x86/kernel/idt.c              |  9 ++++
>  drivers/hv/hv.c                    | 18 +++++---
>  drivers/hv/hv_common.c             |  7 ++-
>  drivers/hv/vmbus_drv.c             |  5 ++-
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  10 files changed, 141 insertions(+), 14 deletions(-)
> 
> -- 
> 2.25.1
