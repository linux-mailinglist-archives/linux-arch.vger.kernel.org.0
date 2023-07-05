Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC97483A1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGEL6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGEL6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 07:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208371732;
        Wed,  5 Jul 2023 04:58:50 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Bg82M031939;
        Wed, 5 Jul 2023 11:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mlqW7T2WWtSe4Qrhml1zXvjURCYlhdIQEK4xvx10nPc=;
 b=oIvsG5159Eku/aDHkLs9Io3OnyUue+XUUI3ZW9pUz8E4IrdA7JaQaozpesTjlJfTITs0
 Py34f5r8uxX+L6zMSTKSWiqpd/3atdpX0IwUL8IIJVfPKCMtRXDOJHAChFbq4V6xDFhf
 lPycNDRKZa+yPNB7CHU1Wi0dI/ZwFuvHat6ELPTxg+LwSceXOCub8nUaIgtnafRkVpKv
 UUMB17sCTbUCr36gMDhwNvTcuGCotyKN/KyH1KG8oE7smz2SnNlqgMIx9bHBC3jdtVPd
 ucGh2I49tJ70Ce+acVE7SgfjoMnEmlDmio9V7Rp0CppduxmfHYEg43fuI5CQ028ysoHB EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7vbrd5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:58:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365Bge3o032706;
        Wed, 5 Jul 2023 11:58:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn7vbrd54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:58:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3658lBvo028370;
        Wed, 5 Jul 2023 11:58:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4svkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:58:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365BwUmM24445640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 11:58:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BF3520043;
        Wed,  5 Jul 2023 11:58:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B574E20040;
        Wed,  5 Jul 2023 11:58:29 +0000 (GMT)
Received: from [9.171.79.178] (unknown [9.171.79.178])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 11:58:29 +0000 (GMT)
Message-ID: <b596ffda-01a2-8c88-3977-d85126b329c6@linux.ibm.com>
Date:   Wed, 5 Jul 2023 13:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/9] cpu/SMT: Store the current/max number of threads
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
 <20230629143149.79073-4-ldufour@linux.ibm.com>
 <f7f8726fcab00fa7436867c58eba1032159c4af8.camel@intel.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <f7f8726fcab00fa7436867c58eba1032159c4af8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nMgcbT_ZgRd5DK9uOcan_cIUwDzpLOIq
X-Proofpoint-ORIG-GUID: Zb6IiVDtBqEXccinMMT474GaV4PT7o6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=688
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



Le 05/07/2023 à 05:05, Zhang, Rui a écrit :
> On Thu, 2023-06-29 at 16:31 +0200, Laurent Dufour wrote:
>> From: Michael Ellerman <mpe@ellerman.id.au>
>>
>> Some architectures allows partial SMT states at boot time,
> 
> s/allows/allow.

Thanks Rui !
