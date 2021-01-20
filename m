Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7630D2FD4FB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbhATQI1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 11:08:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391243AbhATQIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jan 2021 11:08:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KG4Axe123491;
        Wed, 20 Jan 2021 11:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=A1bIFM9NYAheORR+plPg7G3Z9va+nqu/TpLkuMlQioI=;
 b=CPnqeajm81Qy2H6ylARkAEyQroRb7eUr75eeZRdv+lMETb6vY4Zcv/Im1XMV5nS2eBuK
 EFYJdWpo6rZ7bCE86/rK60mLDIPwZ5K/5rkbgZpMCJWAHpKthUPunvn3+UeO5Kttq4t4
 bPR0xH7hexM+cQVorb5TM4LczjHZu8rA1ePrTYldzPiIqC9YifHexP3eFxpjg+OBHZQQ
 d0VgIoaRhdOwyHzRs/smgR7J3NfPCbZ8M/XMJwFKDGmTj+bs5OLPoiIRihV+8GnTw268
 IJ3m1lLmiO0DSfOtA8u+tMX9r8lHriYpUZVQ/STMfyI3mG+P3ARXZGjqxbDQkStX1bdY qg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366nfcd4a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 11:07:16 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KG6ogA007440;
        Wed, 20 Jan 2021 16:07:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3668ny0dsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 16:07:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KG7BgV44892640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 16:07:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 628B7AE06A;
        Wed, 20 Jan 2021 16:07:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15B49AE067;
        Wed, 20 Jan 2021 16:07:11 +0000 (GMT)
Received: from [9.145.21.215] (unknown [9.145.21.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 16:07:11 +0000 (GMT)
Subject: Re: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module gcov
 on UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
Date:   Wed, 20 Jan 2021 17:07:11 +0100
MIME-Version: 1.0
In-Reply-To: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_06:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=895 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200092
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.01.2021 12:18, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On ARCH=um, loading a module doesn't result in its constructors
> getting called, which breaks module gcov since the debugfs files
> are never registered. On the other hand, in-kernel constructors
> have already been called by the dynamic linker, so we can't call
> them again.
> 
> Get out of this conundrum by splitting CONFIG_CONSTRUCTORS into
> CONFIG_CONSTRUCTORS_KERNEL and CONFIG_CONSTRUCTORS_MODULE, both
> of which are enabled by default if CONFIG_CONSTRUCTORS is turned
> on, but CONFIG_CONSTRUCTORS_KERNEL depends on !UML so that it's
> not used on ARCH=um.
> 
> Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
> since we really do want CONSTRUCTORS, just not kernel binary
> ones.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Do you expect other users for these new config symbols? If not it seems
to me that the goal of enabling module constructors for UML could also
be achieved without introducing new config symbols.

For example you could suppress calling any built-in kernel constructors
in case of UML by extending the ifdef in do_ctors() to depend on both
CONFIG_CONSTRUCTORS and !CONFIG_UML (maybe with an explanatory comment).

Of course you'd still need to remove the !UML dependency in
CONFIG_GCOV_KERNEL.

> ---
> Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> from the reset file), and with it we get the files and they work.
> 
> I have no idea which tree this might go through, any suggestions?

So far Andrew Morton was kind enough to pick up gcov-kernel related
changes, so that route might be an option.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
