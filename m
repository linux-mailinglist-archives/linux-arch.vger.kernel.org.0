Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C625896F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIAHlg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:41:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgIAHlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:41:35 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0817WNaH125544;
        Tue, 1 Sep 2020 03:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h3419/CEwU26a+0SHFDvKwjc5uwrFx2HmXp4BB3PFtw=;
 b=h7dmGQy1iJCXPBvlTCmpgTw5WSKuIIZR1svzyiP/1aui2jbjQHM9AxTmV/96ZYKAF4HL
 yGYh7Kgyg1ns7FLiu+Wh1/UzwCYT1fq9SJkVWzUg/Fpp0r8FuX3DNQ7/jY+qf9EuXK8S
 YneqVbYvODVnaSuPILEBrP5bQkhfdAS7Cs+nZSg/mqPMYQt75dBBzo6ePeW3BiW1Rw54
 qpEZFSBuFAMjCOCxyfD7UtrM5NZgtSs9JcnnxmGLzUFd7fOkUodwfUFMthRvcddBje0g
 eRkdFMX+MDN4mwVyjs0uwBlWaDt8WuYgQutzVVqR7jKVbFT6FC4AAvtSHw7kSju4VUre 5A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339hy60796-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 03:40:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0817bLDr016300;
        Tue, 1 Sep 2020 07:40:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8b41s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 07:40:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0817eH4d12648802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 07:40:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 588AC11C04A;
        Tue,  1 Sep 2020 07:40:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 104EC11C04C;
        Tue,  1 Sep 2020 07:40:14 +0000 (GMT)
Received: from [9.85.87.174] (unknown [9.85.87.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 07:40:13 +0000 (GMT)
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
 <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
 <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <2fb4ac88-d417-2bdd-3c56-a816c356636a@linux.ibm.com>
Date:   Tue, 1 Sep 2020 13:10:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=859
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010060
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 12:20 PM, Christophe Leroy wrote:
> 
> 
> Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
>> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>>
>>>
>>>
>>> There is a checkpatch.pl warning here.
>>>
>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 
>>> chars per line)
>>> #7:
>>> Architectures like ppc64 use deposited page table while updating the 
>>> huge pte
>>>
>>> total: 0 errors, 1 warnings, 40 lines checked
>>>
>>
>> I will ignore all these, because they are not really important IMHO.
>>
> 
> When doing a git log in a 80 chars terminal window, having wrapping 
> lines is not really convenient. It should be easy to avoid it.
> 

We have been ignoring that for a long time  isn't it?

For example ppc64 checkpatch already had
--max-line-length=90


There was also recent discussion whether 80 character limit is valid any 
more. But I do keep it restricted to 80 character where ever it is 
easy/make sense.

-aneesh

