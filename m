Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B7748389
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGELxv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 07:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGELxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 07:53:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06786A1;
        Wed,  5 Jul 2023 04:53:45 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Bi7Dj021846;
        Wed, 5 Jul 2023 11:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RM6BGoxAB5trXh244t7sn6H8ASPW31lkwjgvtqxQAe4=;
 b=pAqESusDye4cVH05DMf4Kpmp/CC0VTJvxwcjlirvtd31+7M/OodWO7EQofz1CUM1F2pD
 46DpcTZx27Hr+ue/c1eA8Rbs+dpZX7CZD1QwhUqNOzePLJWQ1bDl2rMYcWQ8tikYM5Wo
 xwrNocbA5Cun7n09O3P/jJEut8grM8T1HdNOKfd60XfDHKEmzxyIEzU8viO679v2ffv7
 ikBiVYigTsP0tkRxq8dbO6jbegGH1nPAVxQbfss73pwj6p10SWnpup9g4yqTYMzTHVUE
 SJwa5QkL5fnbI/5c9AJVX0b7rnSHhKP9Udjh08vI5xPFOEpRRRjmm4Nsudo0F88tTidn ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7w6r74v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:53:17 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365BjFjn026313;
        Wed, 5 Jul 2023 11:53:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7w6r74f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:53:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36596LBW030966;
        Wed, 5 Jul 2023 11:53:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbddsve8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:53:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365BrClC42205592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 11:53:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1571820043;
        Wed,  5 Jul 2023 11:53:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB9720040;
        Wed,  5 Jul 2023 11:53:11 +0000 (GMT)
Received: from [9.171.79.178] (unknown [9.171.79.178])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 11:53:11 +0000 (GMT)
Message-ID: <a1276261-353a-f440-bc13-66fd49e08681@linux.ibm.com>
Date:   Wed, 5 Jul 2023 13:53:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/9] Introduce SMT level and add PowerPC support
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
 <44bf8b00c960473e37e35571104b5a1b24673142.camel@intel.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <44bf8b00c960473e37e35571104b5a1b24673142.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N4P2ig7ddIkXcU9iADb77eI_NafRDr1l
X-Proofpoint-GUID: 2jxNtGr7yfx_aCflspM8uTWG1RSqMSor
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 05/07/2023 à 05:04, Zhang, Rui a écrit :
> Hi, Laurent,
> 
> I want to test this patch set and found that it does not apply on top
> of latest usptream git, because of some changes in this merge window,
> so better rebase.

Hi Rui,

Thanks for your interest for this series.
The latest Thomas's changes came into the PowerPC next branch.
I'm working on a rebase.

Cheers,
Laurent.

> thanks,
> rui
> 
> On Thu, 2023-06-29 at 16:31 +0200, Laurent Dufour wrote:
>> I'm taking over the series Michael sent previously [1] which is
>> smartly
>> reviewing the initial series I sent [2].  This series is addressing
>> the
>> comments sent by Thomas and me on the Michael's one.
>>
>> Here is a short introduction to the issue this series is addressing:
>>
>> When a new CPU is added, the kernel is activating all its threads.
>> This
>> leads to weird, but functional, result when adding CPU on a SMT 4
>> system
>> for instance.
>>
>> Here the newly added CPU 1 has 8 threads while the other one has 4
>> threads
>> active (system has been booted with the 'smt-enabled=4' kernel
>> option):
>>
>> ltcden3-lp12:~ # ppc64_cpu --info
>> Core   0:    0*    1*    2*    3*    4     5     6     7
>> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>>
>> This mixed SMT level may confused end users and/or some applications.
>>
>> There is no SMT level recorded in the kernel (common code), neither
>> in user
>> space, as far as I know. Such a level is helpful when adding new CPU
>> or
>> when optimizing the energy efficiency (when reactivating CPUs).
>>
>> When SMP and HOTPLUG_SMT are defined, this series is adding a new SMT
>> level
>> (cpu_smt_num_threads) and few callbacks allowing the architecture
>> code to
>> fine control this value, setting a max and a "at boot" level, and
>> controling whether a thread should be onlined or not.
>>
>> v3:
>>    Fix a build error in the patch 6/9
>> v2:
>>    As Thomas suggested,
>>      Reword some commit's description
>>      Remove topology_smt_supported()
>>      Remove topology_smt_threads_supported()
>>      Introduce CONFIG_SMT_NUM_THREADS_DYNAMIC
>>      Remove switch() in __store_smt_control()
>>    Update kernel-parameters.txt
>>
>> [1]
>> https://lore.kernel.org/linuxppc-dev/20230524155630.794584-1-mpe@ellerman.id.au/
>> [2]
>> https://lore.kernel.org/linuxppc-dev/20230331153905.31698-1-ldufour@linux.ibm.com/
>>
>> Laurent Dufour (1):
>>    cpu/SMT: Remove topology_smt_supported()
>>
>> Michael Ellerman (8):
>>    cpu/SMT: Move SMT prototypes into cpu_smt.h
>>    cpu/SMT: Move smt/control simple exit cases earlier
>>    cpu/SMT: Store the current/max number of threads
>>    cpu/SMT: Create topology_smt_thread_allowed()
>>    cpu/SMT: Allow enabling partial SMT states via sysfs
>>    powerpc/pseries: Initialise CPU hotplug callbacks earlier
>>    powerpc: Add HOTPLUG_SMT support
>>    powerpc/pseries: Honour current SMT state when DLPAR onlining CPUs
>>
>>   .../ABI/testing/sysfs-devices-system-cpu      |   1 +
>>   .../admin-guide/kernel-parameters.txt         |   4 +-
>>   arch/Kconfig                                  |   3 +
>>   arch/powerpc/Kconfig                          |   2 +
>>   arch/powerpc/include/asm/topology.h           |  15 +++
>>   arch/powerpc/kernel/smp.c                     |   8 +-
>>   arch/powerpc/platforms/pseries/hotplug-cpu.c  |  30 +++--
>>   arch/powerpc/platforms/pseries/pseries.h      |   2 +
>>   arch/powerpc/platforms/pseries/setup.c        |   2 +
>>   arch/x86/include/asm/topology.h               |   4 +-
>>   arch/x86/kernel/cpu/bugs.c                    |   3 +-
>>   arch/x86/kernel/smpboot.c                     |   8 --
>>   include/linux/cpu.h                           |  25 +---
>>   include/linux/cpu_smt.h                       |  33 +++++
>>   kernel/cpu.c                                  | 118 ++++++++++++++--
>> --
>>   15 files changed, 187 insertions(+), 71 deletions(-)
>>   create mode 100644 include/linux/cpu_smt.h
>>
> 
