Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1A1416C3
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jan 2020 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgARJZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jan 2020 04:25:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbgARJZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Jan 2020 04:25:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00I9CZB7011370
        for <linux-arch@vger.kernel.org>; Sat, 18 Jan 2020 04:25:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkw7gjn13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 18 Jan 2020 04:25:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Sat, 18 Jan 2020 09:25:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 18 Jan 2020 09:24:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00I9OvJG37879856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 09:24:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DE1AE04D;
        Sat, 18 Jan 2020 09:24:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FCDAE045;
        Sat, 18 Jan 2020 09:24:52 +0000 (GMT)
Received: from [9.199.37.218] (unknown [9.199.37.218])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Jan 2020 09:24:52 +0000 (GMT)
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org,
        linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1579265066.git.sandipan@linux.ibm.com>
 <3a14815c-b9cb-f5a5-630a-0bfb25356429@intel.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Sat, 18 Jan 2020 14:54:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3a14815c-b9cb-f5a5-630a-0bfb25356429@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011809-0016-0000-0000-000002DE80B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011809-0017-0000-0000-000033411FB0
Message-Id: <88abbb6b-8e07-43e5-231f-0e54edcad3f7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-18_02:2020-01-16,2020-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=959 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001180074
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 17/01/20 11:32 pm, Dave Hansen wrote:
> I also tested the series.  The 64-bit binary works fine.  But,
> 
> This is failing to build the x86 selftests:
> 
> make: *** No rule to make target 'protection_keys.c', needed by
> '/home/daveh/linux/tools/testing/selftests/x86/protection_keys_32'.  Stop.
> 
> I think you just forgot to remove the binary from the x86 Makefile.
> 
> Which reminds me: This removes the 32-bit binary.  x86 32-bit binaries
> exercise different paths than the 64-bit ones, so we like to have both.
>  Although it isn't *essential* it would really be nice to keep the
> 32-bit binary.
> 

Oops. Let me fix that. Thanks for testing this.

- Sandipan

