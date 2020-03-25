Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35197192DF8
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCYQQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 12:16:01 -0400
Received: from foss.arm.com ([217.140.110.172]:50516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbgCYQQB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Mar 2020 12:16:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826631FB;
        Wed, 25 Mar 2020 09:16:00 -0700 (PDT)
Received: from [172.16.1.108] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDEA3F52E;
        Wed, 25 Mar 2020 09:15:56 -0700 (PDT)
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de,
        rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com,
        tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com,
        steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
From:   James Morse <james.morse@arm.com>
Openpgp: preference=signencrypt
Message-ID: <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
Date:   Wed, 25 Mar 2020 16:15:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200324134534.1570-1-yezhenyu2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Zhenyu,

On 3/24/20 1:45 PM, Zhenyu Ye wrote:
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.  This series provide support for this feature. 
> 
> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> which detect the TTL feature and add __tlbi_level interface.

How does this interact with THP?
(I don't see anything on that in the series.)

With THP, there is no one answer to the size of mapping in a VMA.
This is a problem because the arm-arm has in "Translation table level
hints" in D5.10.2 of DDI0487E.a:
| If an incorrect value for the entry being invalidated by the
| instruction is specified in the TTL field, then no entries are
| required by the architecture to be invalidated from the TLB.

If we get it wrong, not TLB maintenance occurs!

Unless THP leaves its fingerprints on the vma, I think you can only do
this for VMA types that THP can't mess with. (see
transparent_hugepage_enabled())


Thanks,

James
