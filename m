Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF126743CF1
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjF3Nlq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3Nlo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 09:41:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CAC1FE8;
        Fri, 30 Jun 2023 06:41:44 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UDdIk3032149;
        Fri, 30 Jun 2023 13:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xwH/eozai20u7sAwuHHlqWlOvsC3TABxXs/tL2Cg9DA=;
 b=VjcJ/37/x89iaOmH+hBIBwAU4D18JtkGmpu1fCBjDBjKWxK/Tim+O1b6wAwP3ol1pAQ6
 UlFQBigpYNqshpbnqEufROSIhoVcIa/ELIpc48a7qnbcgZ5X9iex7Fw+7cMWXcqt5mLO
 u98WMywlo9L18GxbD9XnfRq4HjsHAiR1TtbesZJp4bYyTIrUvAgu3hXOV+zicuUM4FWU
 eK20xoB/eYT3a8ZSTTTNyXU58TzohAYbGTO/hs9jk4UORQenlWxz3arPwr/1jahKvhAz
 ul0ALMKtcvvaYc9qglCqq9YSO3Sp/Ik2+Kwt53trpxISRLESevMtxMhzvyzugGk2MNZq ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhyvggabr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:41:30 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDeYJR005027;
        Fri, 30 Jun 2023 13:41:30 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhyvgga9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:41:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UBai0J007667;
        Fri, 30 Jun 2023 13:41:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr45464a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:41:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35UDfPXP24379926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 13:41:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A262004F;
        Fri, 30 Jun 2023 13:41:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A5D220040;
        Fri, 30 Jun 2023 13:41:24 +0000 (GMT)
Received: from [9.171.36.134] (unknown [9.171.36.134])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jun 2023 13:41:24 +0000 (GMT)
Message-ID: <beda2b05-db6f-54a8-719b-7f4888647791@linux.ibm.com>
Date:   Fri, 30 Jun 2023 15:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/9] Introduce SMT level and add PowerPC support
Content-Language: fr
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch@vger.kernel.org, dave.hansen@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        npiggin@gmail.com, tglx@linutronix.de
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
 <58662E98-81B0-4553-9A75-4CA033720BE3@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <58662E98-81B0-4553-9A75-4CA033720BE3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kxEkzWPYxh7O2TCf2GQC8nQYJyPGRtgF
X-Proofpoint-GUID: FY7QyRFyjNxYcWjk8u6p3xbJ6rrKhpXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 30/06/2023 à 15:32, Sachin Sant a écrit :
> 
> 
>> On 29-Jun-2023, at 8:01 PM, Laurent Dufour <ldufour@linux.ibm.com> wrote:
>>
>> I'm taking over the series Michael sent previously [1] which is smartly
>> reviewing the initial series I sent [2].  This series is addressing the
>> comments sent by Thomas and me on the Michael's one.
>>
>> Here is a short introduction to the issue this series is addressing:
>>
>> When a new CPU is added, the kernel is activating all its threads. This
>> leads to weird, but functional, result when adding CPU on a SMT 4 system
>> for instance.
>>
>> Here the newly added CPU 1 has 8 threads while the other one has 4 threads
>> active (system has been booted with the 'smt-enabled=4' kernel option):
>>
>> ltcden3-lp12:~ # ppc64_cpu --info
>> Core   0:    0*    1*    2*    3*    4     5     6     7
>> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>>
>> This mixed SMT level may confused end users and/or some applications.
>>
>> There is no SMT level recorded in the kernel (common code), neither in user
>> space, as far as I know. Such a level is helpful when adding new CPU or
>> when optimizing the energy efficiency (when reactivating CPUs).
>>
>> When SMP and HOTPLUG_SMT are defined, this series is adding a new SMT level
>> (cpu_smt_num_threads) and few callbacks allowing the architecture code to
>> fine control this value, setting a max and a "at boot" level, and
>> controling whether a thread should be onlined or not.
>>
>> v3:
>>   Fix a build error in the patch 6/9
> 
> Successfully tested the V3 version on a Power10 LPAR. Add/remove of
> processor core worked correctly, preserving the SMT level (on a kernel
> booted with smt-enabled= parameter)
> 
> Laurent (Thanks!) also provided a patch to update the ppc64_cpu &
> lparstat utility. With patched ppc64_cpu utility verified that SMT level
> changed at runtime was preserved across processor core add (on
> a kernel booted without smt-enabled= parameter)
> 
> Based on these test results
> 
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>

Thanks a lot, Sachin!

Once this series is accepted, I'll send the series to update ppc64_cpu.

