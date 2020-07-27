Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1422F30A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgG0Ovz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 10:51:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbgG0Ovz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 10:51:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CF99BE30548D6D8FEA0;
        Mon, 27 Jul 2020 22:51:52 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.173) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 22:51:43 +0800
Subject: Re: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in
 unmap_stage2_range function
To:     Marc Zyngier <maz@kernel.org>
CC:     <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <steven.price@arm.com>, <mark.rutland@arm.com>,
        <ascull@google.com>, <kvm@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>
References: <20200724134315.805-1-yezhenyu2@huawei.com>
 <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <f74277fd-5af2-c46f-169f-c15a321165cd@huawei.com>
Date:   Mon, 27 Jul 2020 22:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

On 2020/7/26 1:40, Marc Zyngier wrote:
> On 2020-07-24 14:43, Zhenyu Ye wrote:
>> Now in unmap_stage2_range(), we flush tlbs one by one just after the
>> corresponding pages cleared.  However, this may cause some performance
>> problems when the unmap range is very large (such as when the vm
>> migration rollback, this may cause vm downtime too loog).
> 
> You keep resending this patch, but you don't give any numbers
> that would back your assertion.

I have tested the downtime of vm migration rollback on arm64, and found
the downtime could even take up to 7s.  Then I traced the cost of
unmap_stage2_range() and found it could take a maximum of 1.2s.  The
vm configuration is as follows (with high memory pressure, the dirty
rate is about 500MB/s):

  <memory unit='GiB'>192</memory>
  <vcpu placement='static'>48</vcpu>
  <memoryBacking>
    <hugepages>
      <page size='1' unit='GiB' nodeset='0'/>
    </hugepages>
  </memoryBacking>

After this patch applied, the cost of unmap_stage2_range() can reduce to
16ms, and VM downtime can be less than 1s.

The following figure shows a clear comparison:

	      |	vm downtime  |	cost of unmap_stage2_range()
--------------+--------------+----------------------------------
before change |		7s   |		1200 ms
after  change |		1s   |		  16 ms
--------------+--------------+----------------------------------

>> +
>> +    if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
>> +        __tlbi(vmalls12e1is);
> 
> And what is this magic value based on? You don't even mention in the
> commit log that you are taking this shortcut.
> 


If the page num is bigger than 512, flush all tlbs of this vm to avoid
soft lock-ups on large TLB flushing ranges.  Just like what the
flush_tlb_range() does.


Thanks,
Zhenyu

