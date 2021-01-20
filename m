Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9872FD586
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391418AbhATQWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 11:22:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403915AbhATQVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jan 2021 11:21:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KG4BAk123542;
        Wed, 20 Jan 2021 11:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CMe63OiaCb4tvijzumx1OkCOvIyJLoNXyCnrUNu6Er0=;
 b=BlH54lqV6clnWudq2Uc+frXAl7UnK1Daxu3zd0jJF258Cqj1GCyLgyZFyYHnpFybKNZY
 zxchJ3x2ldUSb3qj5S9pMLmbJ6hx8gOT/A4XhW4KAiE8aaJVe1Tn/FkYg1qaUBHXDM9g
 cCln2M5i5TsZWFPOCH/GsBk/tR/ovkCmRDoDlGAaiLyhAkhp56Yco+GxI3kHHCa++oJz
 O25iQiiu3G4FSzsdSrrSk+de1mVQBM5H8lAFgTkmIwRTM2F7ktFWdewHTEICMx9Su3+4
 s10wiFg+YuVq5YffQQFZrju0X+pvz3IeVzSlCA/HizDgFL8/YvhNnGHa7Pu9X/r3RGbw 5g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366nfcdhpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 11:20:30 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KGGbfj003917;
        Wed, 20 Jan 2021 16:20:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3668nwru19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 16:20:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KGKJOc35979530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 16:20:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1789AE059;
        Wed, 20 Jan 2021 16:20:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1DEAE056;
        Wed, 20 Jan 2021 16:20:25 +0000 (GMT)
Received: from [9.145.21.215] (unknown [9.145.21.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 16:20:25 +0000 (GMT)
Subject: Re: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module gcov
 on UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
 <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
 <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <1232adfb-cbe8-5cfc-88bc-b8913d6a39c6@linux.ibm.com>
Date:   Wed, 20 Jan 2021 17:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_06:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=547 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200092
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20.01.2021 17:09, Johannes Berg wrote:
> On Wed, 2021-01-20 at 17:07 +0100, Peter Oberparleiter wrote:
> 
>> Do you expect other users for these new config symbols? 
> 
> Probably not.
> 
>> If not it seems
>> to me that the goal of enabling module constructors for UML could also
>> be achieved without introducing new config symbols.
> 
> Yeah, true.
> 
>> For example you could suppress calling any built-in kernel constructors
>> in case of UML by extending the ifdef in do_ctors() to depend on both
>> CONFIG_CONSTRUCTORS and !CONFIG_UML (maybe with an explanatory comment).
>>
>> Of course you'd still need to remove the !UML dependency in
>> CONFIG_GCOV_KERNEL.
> 
> Right.
> 
> I can post a separate patch and we can see which one looks nicer?

Sounds good!


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
