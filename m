Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037BE14BC66
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgA1O4Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 09:56:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgA1O4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jan 2020 09:56:16 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SEoxJY070370
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 09:56:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj72kug5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 09:56:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 28 Jan 2020 14:56:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 14:56:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SEu7Ti47579278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 14:56:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9BE52050;
        Tue, 28 Jan 2020 14:56:07 +0000 (GMT)
Received: from [9.152.212.29] (unknown [9.152.212.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F253D52051;
        Tue, 28 Jan 2020 14:56:06 +0000 (GMT)
Subject: Re: [PATCH v2 10/10] gcov: Remove old GCC 3.4 support
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-11-will@kernel.org>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 28 Jan 2020 15:56:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200123153341.19947-11-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012814-0028-0000-0000-000003D53311
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012814-0029-0000-0000-000024997B2E
Message-Id: <28e3e35c-1a26-5f87-064e-39f8a1fc9105@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=912 impostorscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280118
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23.01.2020 16:33, Will Deacon wrote:
> The kernel requires at least GCC 4.8 in order to build, and so there is
> no need to cater for the pre-4.7 gcov format.
> 
> Remove the obsolete code.
> 
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/gcov/Kconfig   |  24 --
>  kernel/gcov/Makefile  |   3 +-
>  kernel/gcov/gcc_3_4.c | 573 ------------------------------------------
>  3 files changed, 1 insertion(+), 599 deletions(-)
>  delete mode 100644 kernel/gcov/gcc_3_4.c

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Compiles, boots, produces coverage output on a s390 system with a
recent-ish GCC version, so that change is fine by me.

There's a final reference to the gcc_3_4.c file in the gcc_4_7.c header
comment, but its probably not worth the extra effort to adjust that as well.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

