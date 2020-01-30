Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F235114D65B
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 07:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgA3GTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 01:19:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgA3GTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:19:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6DlAV021062
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:19:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xuagnmdjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:19:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:19:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 06:19:31 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U6Ibsg42795398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 06:18:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D5B4AE055;
        Thu, 30 Jan 2020 06:19:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54B0CAE045;
        Thu, 30 Jan 2020 06:19:27 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 06:19:27 +0000 (GMT)
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
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
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Thu, 30 Jan 2020 11:49:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca6cfdeb-00f2-d926-e4e1-c1723cc25445@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20013006-0016-0000-0000-000002E1F204
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013006-0017-0000-0000-00003344BAD8
Message-Id: <26f630e5-1f70-888c-4b43-30e73c9f270c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_01:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300041
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 30/01/20 12:29 am, Dave Hansen wrote:
> On 1/28/20 1:38 AM, Sandipan Das wrote:
>> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>> How have you tested this patch (and the whole series for that matter)?
>>>
>> I replaced the second patch with this one and did a build test.
>> Till v16, I had tested the whole series (build + run) on both a POWER8
>> system (with 4K and 64K page sizes) and a Skylake SP system but for
>> x86_64 only.
> 
> Do you have any idea why I was seeing x86 build errors and you were not?
> 

There were problems with patch 2 from v17. The fixed patch is what I replied
with previously in this thread. The test results that I posted were with that
patch included. Will post out v18 today with the fix.

- Sandipan

