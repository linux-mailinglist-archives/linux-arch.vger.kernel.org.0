Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9B12106C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfLPRBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 12:01:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfLPRBB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Dec 2019 12:01:01 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGGvZEl093370;
        Mon, 16 Dec 2019 12:00:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe3nkqm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 12:00:14 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBGGwAin095696;
        Mon, 16 Dec 2019 12:00:13 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe3nkqk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 12:00:13 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBGGssAc028256;
        Mon, 16 Dec 2019 17:00:11 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 2wvqc5vskm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 17:00:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGH0Bpp38469964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 17:00:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 366EA124052;
        Mon, 16 Dec 2019 17:00:11 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A973A124060;
        Mon, 16 Dec 2019 17:00:05 +0000 (GMT)
Received: from [9.199.36.169] (unknown [9.199.36.169])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Dec 2019 17:00:05 +0000 (GMT)
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
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
 <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
 <33ed03aa-a34c-3a81-0f83-20c3e8d4eff7@linux.ibm.com>
 <20191216145041.GG2827@hirez.programming.kicks-ass.net>
 <20191216151419.GL2871@hirez.programming.kicks-ass.net>
 <20191216153047.GM2871@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <c4edc550-b510-2521-d703-be324de68436@linux.ibm.com>
Date:   Mon, 16 Dec 2019 22:30:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216153047.GM2871@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_06:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=2 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/16/19 9:00 PM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 04:14:19PM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 16, 2019 at 03:50:41PM +0100, Peter Zijlstra wrote:
>>> On Mon, Dec 16, 2019 at 07:24:24PM +0530, Aneesh Kumar K.V wrote:
>>>
>>>> So __p*_free_tlb() routines on ppc64 just mark that we need a page walk
>>>> cache flush and the actual flush in done in tlb_flush_mmu.
>>>
>>> Not quite, your __p*_free_tlb() goes to pgtable_free_tlb() which call
>>> tlb_remove_table().
>>>
>>>> As per
>>>>
>>>> d86564a2f085b79ec046a5cba90188e61235280 (mm/tlb, x86/mm: Support
>>>> invalidating TLB caches for RCU_TABLE_FREE ) that is not sufficient?
>>>
>>> 96bc9567cbe1 ("asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE")
>>>
>>> And no. Since you have TABLE_NO_INVALIDATE set, tlb_remove_table() will
>>> not TLBI when it fails to allocate a batch page, which is an error for
>>> PPC-Radix.
>>>
>>> There is also no TLBI when the batch page is full and the RCU callback
>>> happens, which is also a bug on PPC-Radix.
>>
>> It seems to me you need something like this here patch, all you need to
>> add is a suitable definition of tlb_needs_table_invalidate() for Power.
> 
> I'm thinking this:
> 
> #define tlb_needs_table_invalidate()	radix_enabled()
> 
> should work for you. When you have Radix you need that TLBI, if you have
> Hash you don't.
> 

yes. I was doing something similar with #ifdef around 
tlb_table_invalidate(). I will take your approach rather than an arch 
override of tlb_table_invalidate()

-aneesh
