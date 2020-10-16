Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD828FCDB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Oct 2020 05:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394140AbgJPD2e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 23:28:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20500 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394121AbgJPD2d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 23:28:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09G32Xr7104134;
        Thu, 15 Oct 2020 23:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Pfl4Q8UgfBozQRqpOnL7CLwyZw3jIbQSuH7T25QWPHE=;
 b=Ow45Rwpj9GbCKLc5v3eokJLP5KU4vJbOfORR1Y8avNUXrJouU2KZrAIuJP2wSIxuMM5A
 um2iRjckka7v6Co3PMCcydvhDKAme7//6VcJjAyTlldbNPaomUocRw1WJTnv9XYOzdPF
 xTshy7ZsABDs1B9BG/JJa0EtIFBPyK0aIUJEq0qgclphxGBSZYnz//xUOq2zEfH5CW9R
 dVgmwy/ag8jufdWhR490ftZpMWRs6z32ajNzBPSX8QCOcQotnOe1LvATh0T4GOTAv1UW
 jYe7S2X6WBpvK0khAv8uZddfwENelSFDcMNV52vYE3Lfcp8XlQ5mhdPisD0eMvMf0AiD 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347386rh02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 23:27:43 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09G3RgmK157704;
        Thu, 15 Oct 2020 23:27:42 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347386rgyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 23:27:42 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09G3CufA009117;
        Fri, 16 Oct 2020 03:27:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3434k7u1cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 03:27:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09G3RbZ526542500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 03:27:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73405AE053;
        Fri, 16 Oct 2020 03:27:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE056AE045;
        Fri, 16 Oct 2020 03:27:31 +0000 (GMT)
Received: from [9.85.72.211] (unknown [9.85.72.211])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Oct 2020 03:27:31 +0000 (GMT)
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-3-leonardo@linux.ibm.com>
 <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
 <20201015144641.GE29778@kitsune.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <3709d0f5-0f92-b003-1d6b-24a61ca2cf1c@linux.ibm.com>
Date:   Fri, 16 Oct 2020 08:57:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015144641.GE29778@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_01:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=876 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160017
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michal,

On 10/15/20 8:16 PM, Michal Suchánek wrote:
> Hello,
> 
> On Thu, Feb 06, 2020 at 12:25:18AM -0300, Leonardo Bras wrote:
>> On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
>>>                  gup_pgd_range(addr, end, gup_flags, pages, &nr);
>>> -               local_irq_enable();
>>> +               end_lockless_pgtbl_walk(IRQS_ENABLED);
>>>                  ret = nr;
>>>          }
>>>   
>>
>> Just noticed IRQS_ENABLED is not available on other archs than ppc64.
>> I will fix this for v7.
> 
> Has threre been v7?
> 
> I cannot find it.
> 
> Thanks
> 
> Michal
> 

https://lore.kernel.org/linuxppc-dev/20200505071729.54912-1-aneesh.kumar@linux.ibm.com

This series should help here.

-aneesh
