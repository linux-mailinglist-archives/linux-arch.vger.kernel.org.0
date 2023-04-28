Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1D6F2109
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbjD1Ws5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjD1Ws4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 18:48:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06526A5;
        Fri, 28 Apr 2023 15:48:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SMmaWK014260;
        Fri, 28 Apr 2023 22:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QF94rjS2z1vD5ApVZ2dn+CkuXnR8dw5vfvE0RTDVXh8=;
 b=H1pJRhNbZIdjGS5iLism4xT9RJTsUV9F16y+GJxd9hFY2592DvqNcmF5iHkAUo8MgJty
 fnr5jkCZCzxQKyPWW8b7l9o2YuXd7JZhshth884JRUArkh2jwPjrUxHNn31hdXp209g6
 yUQIamDK4D+nYGWLZBxb51Jrhuk72MWoJdTvXlMk9qTSuInr+AqyJhbVPXo9Mu2BQqOo
 j/rlX+JqFneDzqBP8w6m5CHhjJ5H7vNq9vk1EbDyLcCht0wTjqaDf4ld+2Cx/VG4xTMW
 jz9Q+B0UjjxopCz94csuXDu5Y2eWyGv+K0wNvYDL9nvt8hKQifilFSn/Hlk9HYSt4mvJ cg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8jun8jnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 22:48:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SMmZx0009857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 22:48:35 GMT
Received: from [10.110.78.181] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 28 Apr
 2023 15:48:34 -0700
Message-ID: <70acccee-22d7-0d35-b943-346a435b9eab@quicinc.com>
Date:   Fri, 28 Apr 2023 15:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Yi-De Wu <yi-de.wu@mediatek.com>
CC:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-4-yi-de.wu@mediatek.com>
 <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <904abf67ec4ba7d37fc1e500e8a2dbd1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6UvFND-TZbp9AA4jPqH0KdgtcDq1-F5h
X-Proofpoint-ORIG-GUID: 6UvFND-TZbp9AA4jPqH0KdgtcDq1-F5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=696 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280190
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

> 
> [...]
> 
>> +/**
>> + * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host 
>> pa),
>> + *                   result is in @pfn
>> + *
>> + * Leverage KVM's gfn_to_pfn_memslot(). Because gfn_to_pfn_memslot() 
>> needs
>> + * kvm_memory_slot as parameter, this function populates necessary 
>> fileds
>> + * for calling gfn_to_pfn_memslot().
>> + *
>> + * Return:
>> + * * 0            - Succeed
>> + * * -EFAULT        - Failed to convert
>> + */
>> +static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64
>> gfn, u64 *pfn)
>> +{
>> +    hfn_t __pfn;
>> +    struct kvm_memory_slot kvm_slot = {0};
>> +
>> +    kvm_slot.base_gfn = memslot->base_gfn;
>> +    kvm_slot.npages = memslot->npages;
>> +    kvm_slot.dirty_bitmap = NULL;
>> +    kvm_slot.userspace_addr = memslot->userspace_addr;
>> +    kvm_slot.flags = memslot->flags;
>> +    kvm_slot.id = memslot->slot_id;
>> +    kvm_slot.as_id = 0;
>> +
>> +    __pfn = gfn_to_pfn_memslot(&kvm_slot, gfn);
> 
> Again, I absolutely oppose this horror. This is internal to KVM,
> and we want to be able to change this without having to mess
> with your own code that we cannot test anyway.
> 
> What if we start using the extra fields that you don't populate
> as they mean nothing to you? Or add a backpointer to the kvm
> structure to do fancy accounting?
> 
> You have your own hypervisor, that's well and good. Since your
> main argument is that it is supposed to be standalone, make it
> *really* standalone and don't use KVM as a prop.


Agreed, same comments were made earlier too. I would prefer that 
GenieZone have its own identify rather than sharing the 
APIs/data-structures here.

---Trilok Soni
