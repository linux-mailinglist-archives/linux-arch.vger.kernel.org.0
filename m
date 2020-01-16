Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53D13D5FB
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 09:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgAPId4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 03:33:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726988AbgAPIdz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 03:33:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G8Vrml024845
        for <linux-arch@vger.kernel.org>; Thu, 16 Jan 2020 03:33:54 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xj5xbb3ru-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 Jan 2020 03:33:54 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 16 Jan 2020 08:33:52 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 08:33:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G8XkE138404580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 08:33:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F830AE051;
        Thu, 16 Jan 2020 08:33:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA152AE056;
        Thu, 16 Jan 2020 08:33:43 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 08:33:43 +0000 (GMT)
Subject: Re: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size
 on powerpc
To:     Michael Ellerman <mpe@ellerman.id.au>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com,
        msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org,
        bauerman@linux.ibm.com
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
 <87h80x9ozr.fsf@mpe.ellerman.id.au>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Thu, 16 Jan 2020 14:03:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <87h80x9ozr.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011608-0016-0000-0000-000002DDC834
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011608-0017-0000-0000-000033405ED1
Message-Id: <375ed2cc-22ea-ddbf-33d3-febed65eefc6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_02:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160072
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On 15/01/20 12:37 pm, Michael Ellerman wrote:
> Sandipan Das <sandipan@linux.ibm.com> writes:
>> Both 4K and 64K pages are supported on powerpc. Parts of
>> the selftest code perform alignment computations based on
>> the PAGE_SIZE macro which is currently hardcoded to 64K
>> for powerpc. This causes some test failures on kernels
>> configured with 4K page size.
>>
>> This problem is solved by determining the correct page
>> size during the build process rather than hardcoding it
>> in the header file.
> 
> Doing it at build time is wrong, the test could be built on a 4K system
> and then run on a 64K system, or vice versa.
> 
> You should just use getpagesize() at runtime.
> 
> cheers
> 

The reason I chose to do it this way was because PAGE_SIZE also determines
the alignment for the function "lots_o_noops_around_write" (which is used
by some of the test cases). Since __attribute__((__aligned__(X))) requires
X to be a constant, I am not sure if there a way around this.

- Sandipan

