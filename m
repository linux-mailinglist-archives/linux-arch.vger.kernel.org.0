Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87B7D0639
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 03:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbjJTBre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjJTBrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 21:47:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC7119;
        Thu, 19 Oct 2023 18:47:31 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K10pf9005682;
        Fri, 20 Oct 2023 01:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=jXKN6zDkwSfWjvbtXdaBW9VS/SrI5dOi1DOi3RpFO5o=;
 b=pQ7P8GO/+d/nHPTRNH2E3mRyPJ2JHprg1BBREHsmjfHQtFg5s3oHZOYAi8PIvPD50GN/
 I6hOir5BMc7z2QxOjghxlGhDugLDxz9TgV1bIGeDY/FKiN51OTNguiTYQU5PL/9ElX4X
 G8djSHv4YbG5bTWNgGtQrpQek2ZDpPkTI8iOt7BUJV/TTpv3Q0yxZpwaq5aOymHt05RC
 p+xH5LbHr4LhIDuBa4L2pdXoAmmXN7JlbRsa7dGkzy9vyUHumPDgVy3Fx5gX6YXuWFIV
 uRk27w4hiqFO3dlcktHB+kb6olARGeuS6kKjpWA6+FlQWKh5PCqepaNaA3pO4cXYi5Eb /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwmre3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 01:47:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K1lK6m025759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 01:47:20 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 18:47:20 -0700
Date:   Thu, 19 Oct 2023 18:47:18 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arch@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 4230ea146b1e64628f11e44290bb4008e391bc24
Message-ID: <20231020014718.GY3553829@hu-bjorande-lv.qualcomm.com>
References: <202310200707.piSzZcdi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202310200707.piSzZcdi-lkp@intel.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: agxGO6sJGhmccj5iV16laCUoH5mu_EO8
X-Proofpoint-ORIG-GUID: agxGO6sJGhmccj5iV16laCUoH5mu_EO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_01,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=465 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 07:54:25AM +0800, kernel test robot wrote:
[..]
> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml:
> Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:

This (the qcom-pm8xxx.yaml error) is not a false positive, the issue
here is that [1] has not been merged, but the later patch in the same
series which adds a dependency on this file from the mfd binding was
merged.

The patch ([1]) looks good, has been reviewed, and should be ready to be
picked up. Dmitry, or Rob, could you please do so?

[1] https://lore.kernel.org/all/20230827132525.951475-2-dmitry.baryshkov@linaro.org/

Regards,
Bjorn
