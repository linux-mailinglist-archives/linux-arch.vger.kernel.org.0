Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448F77B71A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjHNKxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 06:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjHNKwx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 06:52:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319AD2;
        Mon, 14 Aug 2023 03:52:52 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EARqXt024348;
        Mon, 14 Aug 2023 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=9BZvLnsrLSVKL3+7uPFmpILSTvphDxWhyx3NEzqjphY=;
 b=JF0YMd7HL3l70H6j8RDhwYCOVnaUHSxiGP5fCE9sIvI3hfxCE3w0pb+Iaoon/337mbow
 kSo0k3bZacnkwsk5kZ2ZH2oz9FsvBlTFJQFjyT2m78ZBaNqJuZRWZvSakSlwWudnTmb6
 pVCaFkvYCyCuQ+lwan8Yt8bT5sWKAB83sDZmf6Iv7bxkYv9AlwbE1xemxYP5cKnz2PxY
 /jpHXe1gfzNbLk/H3pDgCfSh7DWx9eXc6onsqsnzWK6bW15QWctcBhkA40+uj0tOc6AF
 Cfqor3X/0T92ZN5RdsATxBrT/mmbPUe9deytFxBG0fc4jXZ0Wm1UtkTcZ84TTUv3BFIG wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfje3rnsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:52:23 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EAMh1g003957;
        Mon, 14 Aug 2023 10:52:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfje3rnry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:52:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E9dbCC001107;
        Mon, 14 Aug 2023 10:52:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxuutg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:52:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EAqKnN21430804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 10:52:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7EC020040;
        Mon, 14 Aug 2023 10:52:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 076A92005A;
        Mon, 14 Aug 2023 10:52:18 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 14 Aug 2023 10:52:17 +0000 (GMT)
Date:   Mon, 14 Aug 2023 16:22:17 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, npiggin@gmail.com,
        tglx@linutronix.de, rui.zhang@intel.com
Subject: Re: [PATCH v4 09/10] powerpc: Add HOTPLUG_SMT support
Message-ID: <20230814105217.m5arvw36tytlda6c@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <20230705145143.40545-10-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230705145143.40545-10-ldufour@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mV3pQ_5WxvfmsXlXb6lCYN2zCVftfmBs
X-Proofpoint-GUID: W7UrWveYQOWFE_sV2-lTumK-ZkPpA_hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=839 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Laurent Dufour <ldufour@linux.ibm.com> [2023-07-05 16:51:42]:

> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Add support for HOTPLUG_SMT, which enables the generic sysfs SMT support
> files in /sys/devices/system/cpu/smt, as well as the "nosmt" boot
> parameter.
> 
> Implement the recently added hooks to allow partial SMT states, allow
> any number of threads per core.
> 
> Tie the config symbol to HOTPLUG_CPU, which enables it on the major
> platforms that support SMT. If there are other platforms that want the
> SMT support that can be tweaked in future.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [ldufour: pass current SMT level to cpu_smt_set_num_threads]
> [ldufour: remove topology_smt_supported]
> [ldufour: remove topology_smt_threads_supported]
> [ldufour: select CONFIG_SMT_NUM_THREADS_DYNAMIC]
> [ldufour: update kernel-parameters.txt]
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
