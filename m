Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23677B71D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHNKyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjHNKxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 06:53:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE151AA;
        Mon, 14 Aug 2023 03:53:53 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EAgH48001988;
        Mon, 14 Aug 2023 10:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=9DatsNlIMKvhIsW6e7G+yhMAXYNXzH4654qKVbEnJ+w=;
 b=d6isXkohe5yHX7KL1mjP0ulC+DmlvyAxJwVechsWenDIRl56/tBieFBizKgrOhitWeQP
 veVqsUQbYimX/gr3ohV2GIZUOxThtsHBPvTBYbSQ4RnADT8xYl0wl0p3tAe39RI7f5ev
 YdSJKXDNla0Ne7EiO9SOAsKzW5JmR207zSIlQwn+XNm1dMgFelCo9MDTWt6lNdZwMxVw
 Zg/M5PwUAMazYrXOSV2KeQv1okR5LyOzdQs8+y5mcTkDlBczNH5Nih7VBOg3gv7+LnhD
 EmsB5Y4dS2B+szI2g8KK7thr0EvDdsnMpD1na3Wc0hPbOPcNZFGcvh9KZDWZiTZChmsv UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfjrar6qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:53:40 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EAgRSw002271;
        Mon, 14 Aug 2023 10:53:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfjrar6pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:53:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E9O5La001124;
        Mon, 14 Aug 2023 10:53:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxuv1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:53:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EArZCW45220104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 10:53:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E5D20040;
        Mon, 14 Aug 2023 10:53:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E983C2004E;
        Mon, 14 Aug 2023 10:53:33 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 14 Aug 2023 10:53:33 +0000 (GMT)
Date:   Mon, 14 Aug 2023 16:23:33 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, npiggin@gmail.com,
        tglx@linutronix.de, rui.zhang@intel.com
Subject: Re: [PATCH v4 10/10] powerpc/pseries: Honour current SMT state when
 DLPAR onlining CPUs
Message-ID: <20230814105333.6ob2wzhfo7dh7rps@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <20230705145143.40545-11-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230705145143.40545-11-ldufour@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CwD7qTG8WZiEiSJK1xK69O_BDeqicsbw
X-Proofpoint-GUID: eF4tFk0fJkdYsn2aTBnF-W0fIbUFVr8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=700 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Laurent Dufour <ldufour@linux.ibm.com> [2023-07-05 16:51:43]:

> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Integrate with the generic SMT support, so that when a CPU is DLPAR
> onlined it is brought up with the correct SMT mode.
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

-- 
Thanks and Regards
Srikar Dronamraju
