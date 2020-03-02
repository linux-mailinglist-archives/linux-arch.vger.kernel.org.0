Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80BB175848
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 11:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCBK0F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 05:26:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgCBK0F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 05:26:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022APDxv006611
        for <linux-arch@vger.kernel.org>; Mon, 2 Mar 2020 05:26:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbejvu0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 05:26:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 2 Mar 2020 10:26:01 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 10:25:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022AOvbP50201060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 10:24:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC194C04E;
        Mon,  2 Mar 2020 10:25:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C14724C050;
        Mon,  2 Mar 2020 10:25:52 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 10:25:52 +0000 (GMT)
Subject: Re: [PATCH v18 00/24] selftests, powerpc, x86: Memory Protection Keys
To:     shuah@kernel.org, skhan@linuxfoundation.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        akpm@linux-foundation.org
References: <cover.1580365432.git.sandipan@linux.ibm.com>
 <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Mon, 2 Mar 2020 15:55:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030210-0020-0000-0000-000003AF7F61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030210-0021-0000-0000-00002207A996
Message-Id: <a86a4a5b-9d44-efed-8bad-a18f108e2746@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_03:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020081
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Shuah,

On 31/01/20 3:21 am, Dave Hansen wrote:
> On 1/29/20 10:36 PM, Sandipan Das wrote:
>> v18:
>> 	(1) Fixed issues with x86 multilib builds based on
>> 	    feedback from Dave.
>> 	(2) Moved patch 2 to the end of the series.
> 
> These (finally) build and run successfully for me on an x86 system with
> protection keys.  Feel free to add my Tested-by, and Acked-by.
> 
> FWIW, I don't think look perfect, but my standards are lower for
> selftests/ than normal kernel code. :)
> 

Any updates on considering this for merging?

- Sandipan

