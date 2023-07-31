Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A01769554
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGaL4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGaL4D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 07:56:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881FBE68;
        Mon, 31 Jul 2023 04:55:59 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VBdaI6022016;
        Mon, 31 Jul 2023 11:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qHBp4S0vXvjXdtL9T2yqLOyzOu6JR+RCmAuqtz3oATI=;
 b=PRL2Py6acpx6CEWblmiyaSymSgQTSspw5jTVmUoT/zaNCgUT34P/T+pVy9UT+M4jFq1d
 LcIJqj84lO1cS2kmZCwGkj3ZO0GH6VRpISKyR0vgJ2i1A3R3cN0ni5JM0MfkyhGFUAIj
 3K1Bj9wrOzVnlC15vzu9+YiOuOUWWPejvduUN+o0EMeIxgYubz2WIXC2W6z+dznXbJaB
 IEf7NDwVOsnA9RuTVnksVqbItvLZ2XvSOjo+Oyn5JhFeQsAsRZ7I5DWIWQeymii+paUo
 CmZp6aiHlk5LHyoKCwEH6nooWwwWCDfKVHmz3q7WUJlyAqJRb6snSOtSEpKENsi480+3 +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6bj11mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:55:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VBeaa3026148;
        Mon, 31 Jul 2023 11:55:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6bj11msy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:55:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36VB8GSU015538;
        Mon, 31 Jul 2023 11:55:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3mjt2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:55:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36VBtSqK23528166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 11:55:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2BEB20043;
        Mon, 31 Jul 2023 11:55:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676AB20040;
        Mon, 31 Jul 2023 11:55:28 +0000 (GMT)
Received: from [9.144.146.219] (unknown [9.144.146.219])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jul 2023 11:55:28 +0000 (GMT)
Message-ID: <c2ac9fce-8967-6b5a-8cc3-ff5de5150a09@linux.ibm.com>
Date:   Mon, 31 Jul 2023 13:55:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
To:     Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        rui.zhang@intel.com
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <87tttoqxft.ffs@tglx>
Content-Language: en-US
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87tttoqxft.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -WSL2ggfwRiYmP9_bsW-zeZdPnGYqxSI
X-Proofpoint-GUID: 3GAGWt4nw0RLj7-HH_Q5bFHD7idPBBwp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310104
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 28/07/2023 à 09:58, Thomas Gleixner a écrit :
> Laurent, Michael!
> 
> On Wed, Jul 05 2023 at 16:51, Laurent Dufour wrote:
>> I'm taking over the series Michael sent previously [1] which is smartly
>> reviewing the initial series I sent [2].  This series is addressing the
>> comments sent by Thomas and me on the Michael's one.
> 
> Thanks for getting this into shape.
> 
> I've merged it into:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
> 
> and tagged it at patch 7 for consumption into the powerpc tree, so the
> powerpc specific changes can be applied there on top:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-for-ppc-23-07-28

Thanks Thomas!
