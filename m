Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AE14D832
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgA3JUW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 04:20:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgA3JUW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 04:20:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U9GdiP050563
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 04:20:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xueh6yb7g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 04:20:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 09:20:18 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 09:20:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U9KD1815728656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 09:20:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E53A5205F;
        Thu, 30 Jan 2020 09:20:13 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F9B652050;
        Thu, 30 Jan 2020 09:20:10 +0000 (GMT)
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org,
        linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
 <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
 <ca6cfdeb-00f2-d926-e4e1-c1723cc25445@intel.com>
 <26f630e5-1f70-888c-4b43-30e73c9f270c@linux.ibm.com>
Date:   Thu, 30 Jan 2020 14:50:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <26f630e5-1f70-888c-4b43-30e73c9f270c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20013009-0028-0000-0000-000003D5C3C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013009-0029-0000-0000-0000249A11D6
Message-Id: <880326d5-e23c-6724-1c93-7b1d0281dcbd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_02:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300066
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 30/01/20 11:49 am, Sandipan Das wrote:
> Hi Dave,
> 
> On 30/01/20 12:29 am, Dave Hansen wrote:
>> On 1/28/20 1:38 AM, Sandipan Das wrote:
>>> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>>> How have you tested this patch (and the whole series for that matter)?
>>>>
>>> I replaced the second patch with this one and did a build test.
>>> Till v16, I had tested the whole series (build + run) on both a POWER8
>>> system (with 4K and 64K page sizes) and a Skylake SP system but for
>>> x86_64 only.
>>
>> Do you have any idea why I was seeing x86 build errors and you were not?
>>
> 
> There were problems with patch 2 from v17. The fixed patch is what I replied
> with previously in this thread. The test results that I posted were with that
> patch included. Will post out v18 today with the fix.
> 

In patch 2 of v17, the issue was with the target names. Upon adding something
to TEST_GEN_FILES, rules for targets like the following are expected to be
defined.
  <path-to-linux-source>/tools/testing/selftests/vm/protection_keys_32
  <path-to-linux-source>/tools/testing/selftests/vm/protection_keys_64
  <path-to-linux-source>/tools/testing/selftests/vm/protection_keys

But instead, I only defined rules for these.
  protection_keys_32
  protection_keys_64
  protection_keys

Hence the build was failing in these cases:
  $ make -C tools/testing/selftests
  $ make -C tools/testing/selftests/vm
  $ cd tools/testing/selftests/vm
  $ make

But worked in these cases:
  $ make -C tools/testing/selftests/vm protection_keys
  $ cd tools/testing/selftests/vm
  $ make protection_keys

This has been addressed in v18.

- Sandipan

