Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6E13828A
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jan 2020 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgAKQuq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jan 2020 11:50:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730371AbgAKQuq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Jan 2020 11:50:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00BGnqcc024317
        for <linux-arch@vger.kernel.org>; Sat, 11 Jan 2020 11:50:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfb43s81w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 11 Jan 2020 11:50:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Sat, 11 Jan 2020 16:50:44 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 11 Jan 2020 16:50:40 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00BGochb1048904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jan 2020 16:50:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B33EDAE045;
        Sat, 11 Jan 2020 16:50:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4257CAE051;
        Sat, 11 Jan 2020 16:50:35 +0000 (GMT)
Received: from [9.199.42.197] (unknown [9.199.42.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 11 Jan 2020 16:50:34 +0000 (GMT)
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org,
        linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org,
        mingo@redhat.com, bauerman@linux.ibm.com, msuchanek@suse.de,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <87y2ufxlci.fsf@linux.ibm.com>
 <4a35bf48-d191-4e42-ea47-f419895ed876@intel.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Sat, 11 Jan 2020 22:20:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4a35bf48-d191-4e42-ea47-f419895ed876@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011116-0028-0000-0000-000003D0407E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011116-0029-0000-0000-000024945B25
Message-Id: <3a6280fe-6b0f-7e3c-08a9-8186a9c3ea46@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-11_05:2020-01-10,2020-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=828 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001110147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 10/01/20 11:27 pm, Dave Hansen wrote:
> 
> Could you dump these in a git tree, please?  It will make it a wee bit
> easier for me to ship the resulting tree around to a couple different
> systems.
> 

I have pushed a version of this series that uses u64 for all references
to the pkey register irrespective of architecture. This is available at:

https://github.com/sandip4n/linux/tree/pkey-selftests


- Sandipan

