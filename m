Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B23700D11
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjELQfB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjELQfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 12:35:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9705E1BF2;
        Fri, 12 May 2023 09:34:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFq5EG018240;
        Fri, 12 May 2023 16:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9WU0F0MVcux5FDfZibYYwUshorLv1fpr3rzhFkYzNIc=;
 b=O9B69os5SZA5qhp167TQ5XWT88Oq8SDYSMWCuRs6UGYTBfBoF0z3KDif0pKinr4JBjZV
 DRt1STuNVlA6L4JQBog1iGdV1mbkKbfQDXXhWcpAX9DAJMZVne60azJiWKYPNaHBL9SJ
 Vre4xVNDOVQyxI4K303Ihp2UFIooGB9CEmgedys0FOFj4udFdfUzBX1WP3JBucQhrdk6
 oDsFzL/0wf4QydTbBfMQiEqjjJhWBnb78xt/U5ntlkXMBykuY5f8gxDBWqrEn/Ew1Wlc
 grwu5MTkrjnPWa771bpwoCWEbm40qqt7W0DBlzcWHdfCthB366HgMgsESY9a7ggrJYps og== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhrdsg3hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:34:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CGYeRD018537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:34:40 GMT
Received: from [10.110.80.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 09:34:39 -0700
Message-ID: <169ecb01-0ab6-93d7-7350-0c551b69e7ae@quicinc.com>
Date:   Fri, 12 May 2023 09:34:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
To:     =?UTF-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        =?UTF-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-3-yi-de.wu@mediatek.com>
 <168269352006.3076.11433928748883862569.robh@kernel.org>
 <c0b590711516f5bb0e9db688685e09a8e73abd5e.camel@mediatek.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <c0b590711516f5bb0e9db688685e09a8e73abd5e.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PHlsf2qDKrQvOQgX44F-Xv2J-6oVnwUP
X-Proofpoint-GUID: PHlsf2qDKrQvOQgX44F-Xv2J-6oVnwUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120138
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/11/2023 11:42 PM, Yi-De Wu (吳一德) wrote:
> On Fri, 2023-04-28 at 09:52 -0500, Rob Herring wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>> 
>> 
>> On Fri, 28 Apr 2023 18:36:17 +0800, Yi-De Wu wrote:
>> > From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>> > 
>> > Add documentation for GenieZone(gzvm) node. This node informs gzvm
>> > driver to start probing if geniezone hypervisor is available and
>> > able to do virtual machine operations.
>> > 
>> > Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
>> > Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
>> > ---
>> >  .../hypervisor/mediatek,geniezone-hyp.yaml    | 31
>> > +++++++++++++++++++
>> >  MAINTAINERS                                   |  1 +
>> >  2 files changed, 32 insertions(+)
>> >  create mode 100644
>> > Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-
>> > hyp.yaml
>> > 
>> 
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m
>> dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>> 
>> yamllint warnings/errors:
>> 
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-
>> hyp.yaml: $id: relative path/filename doesn't match actual path or
>> filename
>>         expected: 
>> https://urldefense.com/v3/__http://devicetree.org/schemas/hypervisor/mediatek,geniezone-hyp.yaml*__;Iw!!CTRNKA9wMg0ARbw!joIOXbICM7UGvy3XBEJvfzSKO7s61efB87_NX5cqpUqpu5ot5cuzw50A8-8ledZT9_7ifsB2sKzxSD0$
>> 
>> doc reference errors (make refcheckdocs):
>> 
>> See 
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230428103622.18291-3-yi-de.wu@mediatek.com
>> 
>> The base for the series is generally the latest rc1. A different
>> dependency
>> should be noted in *this* patch.
>> 
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up
>> to
>> date:
>> 
>> pip3 install dtschema --upgrade
>> 
>> Please check and re-submit after running the above command yourself.
>> Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up
>> checking
>> your schema. However, it must be unset to test all examples with your
>> schema.
>> 
> 
> Noted, we've run the yaml check and we are going to re-submit the
> latest version in v3.
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

Do you want us to reply w/ such a big confidentiality notice?

