Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE76A085A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjBWMPW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 07:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjBWMPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 07:15:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DBE3;
        Thu, 23 Feb 2023 04:15:19 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBrllM031044;
        Thu, 23 Feb 2023 12:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fP9xV6lbjH9d0Me/zzCK1TZbbkYDahLeZPZJbYSqzJg=;
 b=j11osJlhFMpbcNoFcAEqcHR3XdbnHaC0KrVkEPEu2l5fWGAMFhbAcKPlmOgnm64hxjeh
 bqi2M7c3tJAgis1EFipOAhq9GRcMqMgoNhMs8imphlHiUrmQfOiup/YI1hI/sVJxv+GQ
 i5wvWLMSM3aEIx3bVT6Cj4h1Kr2T5wSELedjSt55YUF2MPXvkGTn/cVDIjjXKEFhPttE
 w8n0SzThox9jwO9LD4eCd6CfZy2JBerJuJIntaSC1A9IRxE7gEV2k4gnS97UAyiIN8Ca
 wHsj5Qx9mN9yEuW8jKnLN073OhKzuCR8MjQPHrSrbiZAmTSsEFvzaT1gnmFvFxe7LilG rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx7p00g1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:14:27 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31NBtBG3003887;
        Thu, 23 Feb 2023 12:14:26 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx7p00g0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:14:26 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31N6xENL001655;
        Thu, 23 Feb 2023 12:14:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ntpa65193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:14:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31NCEJb044957978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 12:14:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF4832004B;
        Thu, 23 Feb 2023 12:14:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40BA620040;
        Thu, 23 Feb 2023 12:14:18 +0000 (GMT)
Received: from osiris (unknown [9.152.212.244])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Feb 2023 12:14:18 +0000 (GMT)
Date:   Thu, 23 Feb 2023 13:14:17 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
Message-ID: <Y/dYmcHQXP63ONeL@osiris>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-13-rick.p.edgecombe@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sFRj-Cxjvl2O7RQZgpFdtfpFrv0tJ-hN
X-Proofpoint-GUID: H39IN__vQKd3uO65pvL406ZakvY6b_il
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:04PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pmd_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pmd_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pmd_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pmd_mkwrite_kernel() and switch the kernel users over to it. Have
> pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pmd_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pmd_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
...
> ---
>  arch/s390/include/asm/pgtable.h | 7 ++++++-
>  arch/s390/mm/pageattr.c         | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
