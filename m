Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878A77B716
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjHNKv4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjHNKvi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 06:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A64E4A;
        Mon, 14 Aug 2023 03:51:36 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EAf4mP009955;
        Mon, 14 Aug 2023 10:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=vftLtr5LAHFI92xpUg8GFSsv9vuwW80kYCw601HD+C0=;
 b=Netz9UNEphUGgh0YmaBsorl1cmo+11hE7B6LRR0Zu84cuNC/cpnsNJ6j5rjMsKC6HLsD
 3RfI5eQgYAjVO2fYnn2L0DhZOOrdsWJx8oCoqyexTErc4JwWwwAs13OUdohpYTlEy/jn
 HprQbfw8lJ8pDvCp5RaMQK7lsZnTRNhu0At0ys/BYSXjBCnLKMftLBWGNZw8tCUbjBVj
 eeToYu3jzCClOdsyu8vUYNUtrkyC4kO0mr9HCNMo+iro2AV+EV9awfZuOsdZWAC9ZONu
 oK/xsobLVjfo6qQW0Ucix3SIVOBSFSA/sKvjHA4NQgoC3HuFgng9VxsxCXIpsLma+16p nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfje88fnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:51:13 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EAg6Jg012495;
        Mon, 14 Aug 2023 10:51:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfje88fn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:51:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E99u7W013425;
        Mon, 14 Aug 2023 10:51:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjb2pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:51:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EApAQm44761678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 10:51:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 581C820040;
        Mon, 14 Aug 2023 10:51:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EEC32004B;
        Mon, 14 Aug 2023 10:51:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 14 Aug 2023 10:51:08 +0000 (GMT)
Date:   Mon, 14 Aug 2023 16:21:07 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, npiggin@gmail.com,
        tglx@linutronix.de, rui.zhang@intel.com
Subject: Re: [PATCH v4 08/10] powerpc/pseries: Initialise CPU hotplug
 callbacks earlier
Message-ID: <20230814105107.kvsqhlzvlggjddnw@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <20230705145143.40545-9-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230705145143.40545-9-ldufour@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qgIoR12dooW_zWRqm39eVx2MCCUgizQk
X-Proofpoint-ORIG-GUID: -6onJ4Wk6UnD-kghK4HPpfqVg8QWwTYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

* Laurent Dufour <ldufour@linux.ibm.com> [2023-07-05 16:51:41]:

> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> As part of the generic HOTPLUG_SMT code, there is support for disabling
> secondary SMT threads at boot time, by passing "nosmt" on the kernel
> command line.
> 
> The way that is implemented is the secondary threads are brought partly
> online, and then taken back offline again. That is done to support x86
> CPUs needing certain initialisation done on all threads. However powerpc
> has similar needs, see commit d70a54e2d085 ("powerpc/powernv: Ignore
> smt-enabled on Power8 and later").
> 
> For that to work the powerpc CPU hotplug callbacks need to be registered
> before secondary CPUs are brought online, otherwise __cpu_disable()
> fails due to smp_ops->cpu_disable being NULL.
> 
> So split the basic initialisation into pseries_cpu_hotplug_init() which
> can be called early from setup_arch(). The DLPAR related initialisation
> can still be done later, because it needs to do allocations.
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

-- 
Thanks and Regards
Srikar Dronamraju
