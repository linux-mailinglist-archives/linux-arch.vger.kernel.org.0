Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3C149F93
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 09:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgA0INs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 03:13:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727754AbgA0INs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 03:13:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8AIAM103565
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 03:13:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrg61rffy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 03:13:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 27 Jan 2020 08:13:44 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 08:13:39 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00R8CkLr25690530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:12:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B1511C05C;
        Mon, 27 Jan 2020 08:13:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B31411C070;
        Mon, 27 Jan 2020 08:13:35 +0000 (GMT)
Received: from [9.124.35.62] (unknown [9.124.35.62])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 08:13:35 +0000 (GMT)
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
To:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
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
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Mon, 27 Jan 2020 13:43:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127081134.GI14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012708-0028-0000-0000-000003D4B1D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012708-0029-0000-0000-00002498F4BC
Message-Id: <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=545
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270070
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/27/20 1:41 PM, Peter Zijlstra wrote:
> On Sun, Jan 26, 2020 at 07:52:05AM -0800, Guenter Roeck wrote:
>> On Thu, Dec 12, 2019 at 10:32:05AM +0100, Peter Zijlstra wrote:
>>> As described in the comment, the correct order for freeing pages is:
>>>
>>>   1) unhook page
>>>   2) TLB invalidate page
>>>   3) free page
>>>
>>> This order equally applies to page directories.
>>>
>>> Currently there are two correct options:
>>>
>>>   - use tlb_remove_page(), when all page directores are full pages and
>>>     there are no futher contraints placed by things like software
>>>     walkers (HAVE_FAST_GUP).
>>>
>>>   - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
>>>     architecture does not do IPI based TLB invalidate and has
>>>     HAVE_FAST_GUP (or software TLB fill).
>>>
>>> This however leaves architectures that don't have page based
>>> directories but don't need RCU in a bind. For those, provide
>>> MMU_GATHER_TABLE_FREE, which provides the independent batching for
>>> directories without the additional RCU freeing.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>
>> Various sparc64 builds (allnoconfig, tinyconfig, as well as builds
>> with SMP disabled):
>>
>> mm/mmu_gather.c: In function '__tlb_remove_table_free':
>> mm/mmu_gather.c:101:3: error: implicit declaration of function '__tlb_remove_table'; did you mean 'tlb_remove_table'?
> 
> Thanks; I'll respin these patches against Aneesh' pile and make sure to
> look into this when I do so.
> 
> 

I did send a change to fix that. it is to drop !SMP change in the patch

https://lore.kernel.org/linux-mm/87v9p9mhnr.fsf@linux.ibm.com


-aneesh

