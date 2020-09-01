Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C479258BC9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIAJgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 05:36:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9082 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgIAJgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 05:36:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0819WopQ152071;
        Tue, 1 Sep 2020 05:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ieUbKRrXXUeTrFPxea2tKHx4x0U86S23DsEANvqZna0=;
 b=nfW1BD90IZ6nv1L25CGs/cMhCnex8TwRpB1E/ny6y8mZDHfWTEY4XfC8VLMGW0DQEnC0
 f0U2avA4C26Ve3eKvKYUrnBrj5Jk9wqICkU8qB+Pm6ZTjNqTTQZ7M4WHCczA5lFUAo5n
 6T68ZjXgJOa/EdzasoLe8yjOpNO3A14P65arOVp3cIR9/cL0tGw9IOoDIiKSYENOwD8P
 PPfgM25kuXuhqc4aCF9fD9OIWUu5btu8txOGFQ7/xJ4aWA4IQidBiXSjOaiqSeaNVKnU
 90c83vDuPsAMgVYDEItznDaDTatcz9vJEMIStKBP1jWzEfpCOw+gNNUvnTplLN+ctK+y NA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339h2yvhtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 05:36:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0819RlIU001400;
        Tue, 1 Sep 2020 09:36:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 337en89yda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 09:36:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0819aLxs11993592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 09:36:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D59911C052;
        Tue,  1 Sep 2020 09:36:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C70511C04C;
        Tue,  1 Sep 2020 09:36:18 +0000 (GMT)
Received: from [9.85.87.174] (unknown [9.85.87.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 09:36:17 +0000 (GMT)
Subject: Re: [PATCH v3 09/13] mm/debug_vm_pgtable/locks: Move non page table
 modifying test together
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-10-aneesh.kumar@linux.ibm.com>
 <d0a0a50c-702b-c63a-edf2-263e4e7bd4a5@arm.com>
 <b6240372-4554-8c17-186a-cdc0b0a9089c@linux.ibm.com>
 <9b75b175-f319-d40e-a95e-b323b3db654a@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <58a5280f-4882-4a36-c52d-15ad879209d6@linux.ibm.com>
Date:   Tue, 1 Sep 2020 15:06:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9b75b175-f319-d40e-a95e-b323b3db654a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=957
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010080
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>>
>>> [   17.080644] ------------[ cut here ]------------
>>> [   17.081342] kernel BUG at mm/pgtable-generic.c:164!
>>> [   17.082091] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>> [   17.082977] Modules linked in:
>>> [   17.083481] CPU: 79 PID: 1 Comm: swapper/0 Tainted: G        W         5.9.0-rc2-00105-g740e72cd6717 #14
>>> [   17.084998] Hardware name: linux,dummy-virt (DT)
>>> [   17.085745] pstate: 60400005 (nZCv daif +PAN -UAO BTYPE=--)
>>> [   17.086645] pc : pgtable_trans_huge_deposit+0x58/0x60
>>> [   17.087462] lr : debug_vm_pgtable+0x4dc/0x8f0
>>> [   17.088168] sp : ffff80001219bcf0
>>> [   17.088710] x29: ffff80001219bcf0 x28: ffff8000114ac000
>>> [   17.089574] x27: ffff8000114ac000 x26: 0020000000000fd3
>>> [   17.090431] x25: 0020000081400fd3 x24: fffffe00175c12c0
>>> [   17.091286] x23: ffff0005df04d1a8 x22: 0000f18d6e035000
>>> [   17.092143] x21: ffff0005dd790000 x20: ffff0005df18e1a8
>>> [   17.093003] x19: ffff0005df04cb80 x18: 0000000000000014
>>> [   17.093859] x17: 00000000b76667d0 x16: 00000000fd4e6611
>>> [   17.094716] x15: 0000000000000001 x14: 0000000000000002
>>> [   17.095572] x13: 000000000055d966 x12: fffffe001755e400
>>> [   17.096429] x11: 0000000000000008 x10: ffff0005fcb6e210
>>> [   17.097292] x9 : ffff0005fcb6e210 x8 : 0020000081590fd3
>>> [   17.098149] x7 : ffff0005dd71e0c0 x6 : ffff0005df18e1a8
>>> [   17.099006] x5 : 0020000081590fd3 x4 : 0020000081590fd3
>>> [   17.099862] x3 : ffff0005df18e1a8 x2 : fffffe00175c12c0
>>> [   17.100718] x1 : fffffe00175c1300 x0 : 0000000000000000
>>> [   17.101583] Call trace:
>>> [   17.101993]  pgtable_trans_huge_deposit+0x58/0x60
>>> [   17.102754]  do_one_initcall+0x74/0x1cc
>>> [   17.103381]  kernel_init_freeable+0x1d0/0x238
>>> [   17.104089]  kernel_init+0x14/0x118
>>> [   17.104658]  ret_from_fork+0x10/0x34
>>> [   17.105251] Code: f9000443 f9000843 f9000822 d65f03c0 (d4210000)
>>> [   17.106303] ---[ end trace e63471e00f8c147f ]---
>>>
>>
>> IIUC, this should happen even without the series right? This is
>>
>>      assert_spin_locked(pmd_lockptr(mm, pmdp));
> 
> Crash does not happen without this series. A previous patch [PATCH v3 08/13]
> added pgtable_trans_huge_deposit/withdraw() in pmd_advanced_tests(). arm64
> does not define __HAVE_ARCH_PGTABLE_DEPOSIT and hence falls back on generic
> pgtable_trans_huge_deposit() which the asserts the lock.
> 


I fixed that by moving the pgtable deposit after adding the pmd locks 
correctly.

mm/debug_vm_pgtable/locks: Move non page table modifying test together
mm/debug_vm_pgtable/locks: Take correct page table lock
mm/debug_vm_pgtable/thp: Use page table depost/withdraw with THP

-aneesh


