Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D86328B1
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKUPx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 10:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUPx6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 10:53:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887CCB690;
        Mon, 21 Nov 2022 07:53:55 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8Oovb000814;
        Mon, 21 Nov 2022 15:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iTFbOuUq8jlB7FYKsO2QFbHF7KSE3Y+SOGWHJJHHqfk=;
 b=KxzyqbADG02kEFmBiyRURXOf/c2UXg0Sr7oVX9S88p3EGEoHMKoPmNMYRuUKcuOlVEJN
 JtIxcMn5hQnapCAji9bR4Y+x0uO2KHlJnHRSeCmNwSAWoWY/XN+uQDZ4PGBGtK2ErLVf
 q0XGfoRrOZcoiceFekkI2mx3JYYXaI0zjfi+Tc2GgbMjXfq72yTGngxIb/OkyyF2ASdJ
 CtJ14dbpZKiwJTVj68TgctfraCl78CKyWKBn++93LhU8vl0CaQYazQ2dgwPXE6Ijzd4M
 rhVmyeWnRnnG43ObvQsmoBiusHb1wJR7UlDMhfOmD/lJ4T6Ufy7QlN0sB65f3b09FH0E HQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrf5myqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 15:53:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALFriRc013226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 15:53:44 GMT
Received: from [10.50.44.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 07:53:41 -0800
Message-ID: <9e0cebc4-0ee3-c316-01b3-5131298d70ce@quicinc.com>
Date:   Mon, 21 Nov 2022 21:23:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] asm-generic/io: Add _RET_IP_ to MMIO trace for more
 accurate debug info
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <quic_satyap@quicinc.com>
References: <20221017143450.9161-1-quic_saipraka@quicinc.com>
 <20221024120929.41241e07@gandalf.local.home>
 <2f19ea9c-10e6-d0f7-2fc9-fb0f896bfc64@quicinc.com>
In-Reply-To: <2f19ea9c-10e6-d0f7-2fc9-fb0f896bfc64@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mSf_gyUUoxu3v3oHNGVzsqP78QKun3pf
X-Proofpoint-ORIG-GUID: mSf_gyUUoxu3v3oHNGVzsqP78QKun3pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=608 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 10/26/2022 7:17 PM, Sai Prakash Ranjan wrote:
> Hi Steve,
> 
> On 10/24/2022 9:39 PM, Steven Rostedt wrote:
>> On Mon, 17 Oct 2022 20:04:50 +0530
>> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>>
>>> Due to compiler optimizations like inlining, there are cases where
>>> MMIO traces using _THIS_IP_ for caller information might not be
>>> sufficient to provide accurate debug traces.
>>>
>>> 1) With optimizations (Seen with GCC):
>>>
>>> In this case, _THIS_IP_ works fine and prints the caller information
>>> since it will be inlined into the caller and we get the debug traces
>>> on who made the MMIO access, for ex:
>>>
>>> rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 
>>> addr=0xffff8000087447f4
>>> rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 val=0x0 
>>> addr=0xffff8000087447f4
>>>
>>> 2) Without optimizations (Seen with Clang):
>>>
>>> _THIS_IP_ will not be sufficient in this case as it will print only
>>> the MMIO accessors itself which is of not much use since it is not
>>> inlined as below for example:
>>>
>>> rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
>>> rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 
>>> addr=0xffff8000087447f4
>>>
>>> So in order to handle this second case as well irrespective of the 
>>> compiler
>>> optimizations, add _RET_IP_ to MMIO trace to make it provide more 
>>> accurate
>>> debug information in all these scenarios.
>>>
>>> Before:
>>>
>>> rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
>>> rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 
>>> addr=0xffff8000087447f4
>>>
>>> After:
>>>
>>> rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 
>>> addr=0xffff8000087447f4
>>> rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 
>>> width=32 val=0x0 addr=0xffff8000087447f4
>>>
>>> Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO 
>>> accessors")
>>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> What tree should this go through?
>>
>> -- Steve
> 
> 
> Thanks for the ack, with this I believe Arnd can take it through his 
> tree like last time.
> 


Can we take this patch atleast for 6.2-rc1?

Thanks,
Sai
