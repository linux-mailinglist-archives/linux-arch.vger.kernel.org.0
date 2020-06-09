Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A21F3C5B
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgFIN1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 09:27:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729538AbgFIN1D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 09:27:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E66F3B3BF6A4142A6804;
        Tue,  9 Jun 2020 21:26:57 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 9 Jun 2020
 21:26:51 +0800
Subject: Re: [RFC PATCH v3 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-3-yezhenyu2@huawei.com> <20200514152840.GC1907@gaia>
 <54468aae-dbb1-66bd-c633-82fc75936206@huawei.com>
Message-ID: <504c7588-97e5-e014-fca0-c5511ae0d256@huawei.com>
Date:   Tue, 9 Jun 2020 21:26:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <54468aae-dbb1-66bd-c633-82fc75936206@huawei.com>
Content-Type: multipart/mixed;
        boundary="------------63F030C8259FBE42240E3096"
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------63F030C8259FBE42240E3096
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit

Hi Catalin,

On 2020/5/18 20:21, Zhenyu Ye wrote:
> I will test the performance of your suggestion and then reply you again
> here.
> 

I have sent the v4 of this series [1], and compared the performance of
these two different implement.  The test code is in the attachment (directly
call the __flush_tlb_range()).

First, I tested the v4 on a machine whose cpus do not support tlb range.
Fortunately, the newly added judgment in loop has very little effect on
performance.  When page nums are 256 (loop 256 times), the impact is less
than 0.5%:

	[page num]	[before change]		[v4 change]
	1		1457			1491
	2		1911			1957
	3		2382			2377
	4		2827			2852
	5		3282			3349
	6		3763			3781
	7		4295			4252
	8		4716			4716
	9		5186			5218
	10		5618			5648
	16		8427			8454
	32		15938			15951
	64		30890			30977
	128		60802			60863
	256		120826			121395
	512		1508			1555

Then I tested them on a FPGA machine whose cpus support the tlb range
feature (this machine is not the same as above).  Below is the test
data when the stride = PTE:

	[page num]	[before change]	[v3 change]	[v4 change]
	1		16051		15094		13524
	2		11366		11270		11146
	3		11582		11536		12171
	4		11694		11199		11101
	5		12138		11506		12267
	6		12290		11214		11105
	7		12400		11448		12002
	8		12837		11225		11097
	9		14791		11529		12140
	10		15461		11218		11087
	16		18233		11192		11094
	32		26983		11224		11079
	64		43840		11237		11092
	128		77754		11247		11098
	256		145514		11223		11089
	512		280932		11197		11111

We can see the v3 and v4 are very similar in this scene, and both
of them performance improved very much compared to current
implementation.  When the page nums are 256, the performance is
improved by more than 10 times.  And the TLBI RANGE instruction
cost less time than classic TLBI in all secenes on this machine,
even if the page num is small. (but this may be different on
different machines)

Everything performs will util now, but I added a new judgment of
stride in the v4:

	if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
	    stride == PAGE_SIZE)
		use tlbi range here...

So when the stride != PTE, then there will use the classic tlbi
instruction and flush the tlbs one by one, where the performance
becomes worse than v3:

	[page num]	[before change]	[v3 change]	[v4 change]
	1		14047		11332		11611
	2		11568		11255		11701
	3		11664		11231		11759
	4		12097		11204		12173
	5		12229		11236		12374
	6		12399		11203		12497
	7		12802		11266		12914
	8		14764		17098		14907
	9		15370		17106		15551
	10		16130		17103		16137
	16		19029		17175		19194
	32		27300		17097		27604
	64		44172		17075		44609
	128		77878		17176		78548
	256		145185		12022		146063
	512		279822		12029		279922

And as we can see, "handle the 2MB with a single classic TLBI"
costs the same time as a single TLBI RANGE instruction.  So should
I remove the judgment of stride and only figure which to use based
on cpucaps in the loop?  But if removes the judgment, the logic
will be the same as v3.(both of them only judge cpucaps)

Waiting for your suggestions...

Thanks,
Zhenyu

--------------63F030C8259FBE42240E3096
Content-Type: text/plain; charset="UTF-8"; name="test-tlb-range-perf.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test-tlb-range-perf.c"

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <asm/tlb.h>
#include <linux/time.h>
#include <asm/current.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/mm.h>

#define TESTTIMES 10000

void testRangePerf(void);

static int __init test_init(void)
{
    printk("BEGIN TEST\n");

    testRangePerf();

    printk("END TEST\n");
    return 0;
}


static void __exit test_exit(void)
{
    return;
}

void testRangePerf(void)
{
    int i, j;
    struct timespec64 start, end;
    struct task_struct *ts;
    struct vm_area_struct *vma;

    printk("BEGIN testRangePerf\n");

    ts = current;
    vma = ts->mm->mmap;

    printk("vma->start: %lx, vma->end: %lx, ttl = 0, PAGE_SIZE = 0x%lx\n", vma->vm_start, vma->vm_end, PAGE_SIZE);
    for (i = 1; i <= 10; i++) {
        ktime_get_ts64(&start);
        for (j = 0; j < TESTTIMES; j++) {
            __flush_tlb_range(vma, vma->vm_start, vma->vm_start + PAGE_SIZE * i, PAGE_SIZE, false);
        }
        ktime_get_ts64(&end);
        printk("test __flush_tlb_range with %04d pages, used time: %12lld ns\n", i,
               ((end.tv_sec - start.tv_sec) * 1000000000 + end.tv_nsec - start.tv_nsec) / TESTTIMES);
        msleep(100);
    }

    for (i = 16; i <= 512; i+=i) {
        ktime_get_ts64(&start);
        for (j = 0; j < TESTTIMES; j++) {
            __flush_tlb_range(vma, vma->vm_start, vma->vm_start + PAGE_SIZE * i, PAGE_SIZE, false);
        }
        ktime_get_ts64(&end);
        printk("test __flush_tlb_range with %04d pages, used time: %12lld ns\n", i,
               ((end.tv_sec - start.tv_sec) * 1000000000 + end.tv_nsec - start.tv_nsec) / TESTTIMES);
        msleep(100);
    }

    printk("vma->start: %lx, vma->end: %lx, ttl = 0, PAGE_SIZE = 0x%lx\n", vma->vm_start, vma->vm_end, PMD_SIZE);
    for (i = 1; i <= 10; i++) {
        ktime_get_ts64(&start);
        for (j = 0; j < TESTTIMES; j++) {
            __flush_tlb_range(vma, vma->vm_start, vma->vm_start + PMD_SIZE * i, PMD_SIZE, false);
        }
        ktime_get_ts64(&end);
        printk("test __flush_tlb_range with %04d pages, used time: %12lld ns\n", i,
               ((end.tv_sec - start.tv_sec) * 1000000000 + end.tv_nsec - start.tv_nsec) / TESTTIMES);
        msleep(100);
    }

    for (i = 16; i <= 512; i+=i) {
        ktime_get_ts64(&start);
        for (j = 0; j < TESTTIMES; j++) {
            __flush_tlb_range(vma, vma->vm_start, vma->vm_start + PMD_SIZE * i, PMD_SIZE, false);
        }
        ktime_get_ts64(&end);
        printk("test __flush_tlb_range with %04d pages, used time: %12lld ns\n", i,
               ((end.tv_sec - start.tv_sec) * 1000000000 + end.tv_nsec - start.tv_nsec) / TESTTIMES);
        msleep(100);
    }
}

module_init(test_init)
module_exit(test_exit)

MODULE_LICENSE("Dual BSD/GPL"); 
MODULE_AUTHOR("Eillon");
MODULE_DESCRIPTION("do TTL test");
MODULE_VERSION("1.0");
--------------63F030C8259FBE42240E3096--
