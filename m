Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925F748398
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGEL5s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGEL5s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 07:57:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37C1730;
        Wed,  5 Jul 2023 04:57:35 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365BgBo4032039;
        Wed, 5 Jul 2023 11:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9CyLibtCufHi9LQv+5dk80NQ9CpKv/ozyOxKxo25Dcc=;
 b=HakcUKwJTJoq3KAGxVUhWNKZXZlx8wRT3v3aNX0mcejy7of5kuEemJs3/WG1KHkGRvQQ
 1TcauhoqZwZDdZc5nZEcmSjLyh5J/HYUTQNNJEO3t7Re2bEpX3kzqj1A3u7aDlsKthfz
 iO6ZTdUPkqc4j9mB2otrwLtJyc2JuTjRhmN4EC45ECkNqkP6BcKtSAQcX7qnufmIYbeV
 U0tV8SqzAtoIjLsZ2SbJZ3GIkwQIwosehgEIzQ9bhDTtKYn6dEBxBzq6Mm72h3lTDCxn
 tSr9RCQUliKQk2vOR9aIBcUPPOdZxI0Ub4rwDHmD2u27QgnX8DckYG/7lU4hSif7Gmuy LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7vbrbyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:57:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365BgER6032142;
        Wed, 5 Jul 2023 11:57:11 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7vbrbwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:57:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365Bv9T5008757;
        Wed, 5 Jul 2023 11:57:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rjbs51vqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:57:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365Bv6uw24642072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 11:57:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 963872006A;
        Wed,  5 Jul 2023 11:57:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3FBB20076;
        Wed,  5 Jul 2023 11:57:05 +0000 (GMT)
Received: from [9.171.79.178] (unknown [9.171.79.178])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 11:57:05 +0000 (GMT)
Message-ID: <a7b7df27-d49c-a6a7-46a0-47cc1098e644@linux.ibm.com>
Date:   Wed, 5 Jul 2023 13:57:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 6/9] cpu/SMT: Allow enabling partial SMT states via
 sysfs
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     lkp <lkp@intel.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
 <20230629143149.79073-7-ldufour@linux.ibm.com>
 <5801fb9a94c2ce00ca44220be0b1a5bd7f8ff44f.camel@intel.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <5801fb9a94c2ce00ca44220be0b1a5bd7f8ff44f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zH4FnPdZeoo93uwpvPUep2GzdqYTToTy
X-Proofpoint-ORIG-GUID: bNFquvUa8_If2Y-1JRD6wtnNlnOwaAPc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=887
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 05/07/2023 à 05:14, Zhang, Rui a écrit :
> On Thu, 2023-06-29 at 16:31 +0200, Laurent Dufour wrote:
>> @@ -2580,6 +2597,17 @@ static ssize_t control_show(struct device
>> *dev,
>>   {
>>          const char *state = smt_states[cpu_smt_control];
>>   
>> +#ifdef CONFIG_HOTPLUG_SMT
>> +       /*
>> +        * If SMT is enabled but not all threads are enabled then
>> show the
>> +        * number of threads. If all threads are enabled show "on".
>> Otherwise
>> +        * show the state name.
>> +        */
>> +       if (cpu_smt_control == CPU_SMT_ENABLED &&
>> +           cpu_smt_num_threads != cpu_smt_max_threads)
>> +               return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
>> +#endif
>> +
> 
> My understanding is that cpu_smt_control is always set to
> CPU_SMT_NOT_IMPLEMENTED when CONFIG_HOTPLUG_SMT is not set, so this
> ifdef is not necessary, right?

Hi Rui,

Indeed, cpu_smt_control, cpu_smt_num_threads and cpu_smt_max_threads are 
only defined when CONFIG_HOTPLUG_SMT is set. This is the reason for this 
#ifdef block.

This has been reported by the kernel test robot testing v2:
https://lore.kernel.org/oe-kbuild-all/202306282340.Ihqm0fLA-lkp@intel.com

Cheers,
Laurent.
