Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148057CD049
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQXPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Oct 2023 19:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjJQXPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Oct 2023 19:15:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B9FD;
        Tue, 17 Oct 2023 16:15:08 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HNCFuV016883;
        Tue, 17 Oct 2023 23:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6l8K+zlwEhLLX214l6vpRGzDWkRe5WLN3fGIjut9A8k=;
 b=NxGosvxCFLdIKyADacPqMj7Z/2VpAKnwwhDdYrnPVODOBVPQnIbzuCQMrj0zrkssDZ0j
 skYZz3R//lYOaS/Ah93/RzFRGJJeGBRH4fGC4wBii/aZBacmDKJgao88FMfAYNwbCIvv
 vYwp/CELiopI2PEPFYRJ+IxnOkdWexc4ZTBhpmN9dylQ8l1ADwqXmv8cQL/nRT0/xGEJ
 dIkMT+CRet9pOfpPaboNg3KHeSZVvIT6GdjgcLWgQffsepquWLPa3a6P2HRJ+e4Ffoxz
 tuD/pkeqCCclrpT9zt9Sdmf7m40fw7R+ua33UKkAHX8mVX7G765OLhZCVu54FLlwriCk Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt3qv033b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:14:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HND8OV020148;
        Tue, 17 Oct 2023 23:14:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt3qv0330-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:14:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMNbud027130;
        Tue, 17 Oct 2023 23:14:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkc8de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:14:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HNEsLL22217252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 23:14:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B15D15804B;
        Tue, 17 Oct 2023 23:14:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D750A58055;
        Tue, 17 Oct 2023 23:14:53 +0000 (GMT)
Received: from [9.61.148.54] (unknown [9.61.148.54])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 23:14:53 +0000 (GMT)
Message-ID: <4294d9ae-3f5e-4f81-b586-2c134d21896a@linux.ibm.com>
Date:   Tue, 17 Oct 2023 18:14:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PING][PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Language: en-US
From:   Peter Bergner <bergner@linux.ibm.com>
To:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
References: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
In-Reply-To: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nN4KjNZj50rO6_LqZkRXygqLOQCFnOq1
X-Proofpoint-GUID: lLwL3FQnW5CClXBEbUZX8rWUOQs8gJGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CCing linux-kernel for more exposure.

PING.  I'm waiting on a reply from anyone on the kernel side of things
to see whether they have an issue with reserving values for AT_HWCAP3
and AT_HWCAP4.  

I'll note reviews from the GLIBC camp did not have an issue with the below patch.

Thanks.

Peter


On 9/26/23 5:02 PM, Peter Bergner wrote:
> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
> access by our __builtin_cpu_supports built-in function.  The TCB space for
> the HWCAP entries - which are created in pairs - is an ABI extension, so
> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
> problematical, given distro unwillingness to apply ABI modifying patches
> to distro point releases.  Define AT_HWCAP3 and AT_HWCAP4 in the generic
> uapi header so they can be used in GLIBC to reserve space in the powerpc
> TCB for their future use.
> 
> I scanned both the Linux and GLIBC source codes looking for unused AT_*
> values and 29 and 30 did not seem to be used, so they are what I went
> with.  If anyone sees a problem with using those specific values, I'm
> amenable to using other values, just let me know what would be better.
> 
> Peter
> 
> 
> Signed-off-by: Peter Bergner <bergner@linux.ibm.com>
> ---
>  include/uapi/linux/auxvec.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index 6991c4b8ab18..cc61cb9b3e9a 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -32,6 +32,8 @@
>  #define AT_HWCAP2 26	/* extension of AT_HWCAP */
>  #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
>  #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
> +#define AT_HWCAP3 29	/* extension of AT_HWCAP */
> +#define AT_HWCAP4 30	/* extension of AT_HWCAP */
>  
>  #define AT_EXECFN  31	/* filename of program */
>  

