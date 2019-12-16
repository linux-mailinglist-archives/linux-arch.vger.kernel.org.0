Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8612076A
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfLPNl2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 08:41:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbfLPNl2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Dec 2019 08:41:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGDcUlr076139;
        Mon, 16 Dec 2019 08:40:40 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe8aaw6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 08:40:40 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBGDcdLa077440;
        Mon, 16 Dec 2019 08:40:40 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe8aaw5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 08:40:39 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBGDeW0l014885;
        Mon, 16 Dec 2019 13:40:38 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2wvqc689y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 13:40:38 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGDebSg43385342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 13:40:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCF2B28058;
        Mon, 16 Dec 2019 13:40:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF8028059;
        Mon, 16 Dec 2019 13:40:32 +0000 (GMT)
Received: from [9.199.36.91] (unknown [9.199.36.91])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Dec 2019 13:40:31 +0000 (GMT)
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
To:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org> <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
Date:   Mon, 16 Dec 2019 19:10:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216132004.GO2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_05:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160122
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/16/19 6:50 PM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 06:43:53PM +0530, Aneesh Kumar K.V wrote:
>> On 12/16/19 6:07 PM, Peter Zijlstra wrote:
> 
>>> I'm confused, are you saing you're happy to have PowerPC eat the extra
>>> TLB invalidates? I thought you cared about PPC performance :-)
>>>
>>>
>>
>> Instead can we do
>>
>> static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>> {
>> #ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>> 	 * Invalidate page-table caches used by hardware walkers. Then we still
>> 	 * need to RCU-sched wait while freeing the pages because software
>> 	 * walkers can still be in-flight.
>> 	 */
>> 	tlb_flush_mmu_tlbonly(tlb);
>> #endif
>> }
> 
> How does that not break ARM/ARM64/s390 and x86 ?
> 

Hmm I missed that usage of RCU_TABLE_NO_INVALIDATE.

Ok I guess we need to revert this change that went upstream this merge 
window then

commit 52162ec784fa05f3a4b1d8e84421279998be3773
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Thu Oct 24 13:28:00 2019 +0530

     powerpc/mm/book3s64/radix: Use freed_tables instead of need_flush_all



I will review the change closely.

-aneesh
