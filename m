Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BC72FEA3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbjFNM2V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbjFNM2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 08:28:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9611FCE;
        Wed, 14 Jun 2023 05:28:18 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ECF5G7016544;
        Wed, 14 Jun 2023 12:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=27mkrG+QIxGZxwEGRD5WDp5kQPQJX5HPtZZo/lajyus=;
 b=eFxdzo4wOWE2rfjN0Bbi2iUgZB8TO2pTrbpUjyGwqVjZXgTiYNwI+x2cLPzj7XiDmNOu
 xpjBmBkgbGzTvpoazAJh4BVp9+nN7N1QZRROy4hreUg7YeSQy00AgXB6MykgkSL9SW00
 cRlmEtwBxxO94SqZIz1laM5AFWj1BWqKVaLSI7LeaXnAMTa3o9WVcdrhC7vzbKYi3lvb
 BM3vpF61Z2H43kFxo0NZdTT1wu7TRCkkbnr+26wZvrWqKo/hMnxjoOmtAS056ztHq8Sb
 CWh7wqLKkRSrHs4RVlzJt7/fgyqzSYYvjZKej2mb1WGxgxvDd30xzXRo9UygZjWSS3vN OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7dcwrd8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 12:28:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35ECFV10018396;
        Wed, 14 Jun 2023 12:27:59 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7dcwrd4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 12:27:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E2ocsD021295;
        Wed, 14 Jun 2023 12:27:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r4gee2vjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 12:27:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35ECRfWL43385374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 12:27:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F84D2004F;
        Wed, 14 Jun 2023 12:27:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A5320043;
        Wed, 14 Jun 2023 12:27:40 +0000 (GMT)
Received: from [9.179.21.88] (unknown [9.179.21.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 12:27:40 +0000 (GMT)
Message-ID: <bf213e3c-e296-0709-511d-b5c0ee36d9ee@linux.ibm.com>
Date:   Wed, 14 Jun 2023 14:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 3/9] cpu/SMT: Store the current/max number of threads
To:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        linuxppc-dev@lists.ozlabs.org
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-3-mpe@ellerman.id.au> <87fs6z80w5.ffs@tglx>
 <d42e9452-8210-a06a-4c91-6c2f1d038a61@linux.ibm.com> <87sfav5h2z.ffs@tglx>
Content-Language: en-US
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87sfav5h2z.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N_EJRcli3Go9tgypuw3jrv9mtDvzeqIX
X-Proofpoint-ORIG-GUID: xyS2CfNlyOzklVocXvBnFtDPBNmh9FpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_08,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 13/06/2023 20:53:56, Thomas Gleixner wrote:
> On Tue, Jun 13 2023 at 19:16, Laurent Dufour wrote:
>> On 10/06/2023 23:26:18, Thomas Gleixner wrote:
>>> On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
>>>>  #ifdef CONFIG_HOTPLUG_SMT
>>>>  enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
>>>> +static unsigned int cpu_smt_max_threads __ro_after_init;
>>>> +unsigned int cpu_smt_num_threads;
>>>
>>> Why needs this to be global? cpu_smt_control is pointlessly global already.
>>
>> I agree that cpu_smt_*_threads should be static.

I spoke too quickly, cpu_smt_num_threads is used in the powerpc code.

When a new CPU is added it used to decide whether a thread has to be
onlined or not, and there is no way to pass it as argument at this time.
In details, it is used in topology_smt_thread_allowed() called by
dlpar_online_cpu() (see patch "powerpc/pseries: Honour current SMT state
when DLPAR onlining CPUs" at the end of this series).

I think the best option is to keep it global.

>>
>> Howwever, regarding cpu_smt_control, it is used in 2 places in the x86 code:
>>  - arch/x86/power/hibernate.c in arch_resume_nosmt()
>>  - arch/x86/kernel/cpu/bugs.c in spectre_v2_user_select_mitigation()
> 
> Bah. I must have fatfingered the grep then.
> 
>> An accessor function may be introduced to read that value in these 2
>> functions, but I'm wondering if that's really the best option.
>>
>> Unless there is a real need to change this through this series, I think
>> cpu_smt_control can remain global.
> 
> That's fine.
> 
> Thanks,
> 
>         tglx

