Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A6141627
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jan 2020 06:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgARF5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jan 2020 00:57:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgARF5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Jan 2020 00:57:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00I5qNaF003823;
        Sat, 18 Jan 2020 00:56:47 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qsh08g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jan 2020 00:56:47 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00I5tsZL004365;
        Sat, 18 Jan 2020 05:56:47 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2xksn5h4rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jan 2020 05:56:47 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00I5ukgb52166920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 05:56:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BC2FAC05B;
        Sat, 18 Jan 2020 05:56:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E95A1AC059;
        Sat, 18 Jan 2020 05:56:42 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.2.52])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 18 Jan 2020 05:56:42 +0000 (GMT)
X-Mailer: emacs 27.0.60 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org,
        mpe@ellerman.id.au, davem@davemloft.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 6/9] asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
In-Reply-To: <20200116064531.483522-7-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
 <20200116064531.483522-7-aneesh.kumar@linux.ibm.com>
Date:   Sat, 18 Jan 2020 11:26:40 +0530
Message-ID: <87v9p9mhnr.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-18_01:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=913
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001180043
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> From: Peter Zijlstra <peterz@infradead.org>
>
> Towards a more consistent naming scheme.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

...

> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 18e9fb6fcf1b..c703eb6b7461 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -64,7 +64,7 @@ config SPARC64
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_KRETPROBES
>  	select HAVE_KPROBES
> -	select HAVE_RCU_TABLE_FREE if SMP
> +	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select HAVE_DYNAMIC_FTRACE

This resulted in build failure reported by kbuild test robot. Can we
fold the below change

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c703eb6b7461..02907584be2d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,7 +64,7 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE if SMP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE

We should handle that drop of SMP in a separate patch if needed.

-aneesh
