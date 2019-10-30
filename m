Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B66E9770
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 08:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfJ3H4S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 03:56:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbfJ3H4S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Oct 2019 03:56:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9U7oPHH146048
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 03:56:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vy60jryay-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 03:56:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 30 Oct 2019 07:56:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Oct 2019 07:56:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9U7u7Ri45416546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 07:56:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5DA942042;
        Wed, 30 Oct 2019 07:56:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DCD44203F;
        Wed, 30 Oct 2019 07:56:07 +0000 (GMT)
Received: from funtu.home (unknown [9.145.158.134])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Oct 2019 07:56:07 +0000 (GMT)
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
To:     Richard Henderson <richard.henderson@linaro.org>,
        linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
 <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
 <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Wed, 30 Oct 2019 08:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19103007-0028-0000-0000-000003B10491
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103007-0029-0000-0000-00002473484E
Message-Id: <95aa7fd3-5e80-f11b-3f74-42628f7dfba4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300077
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29.10.19 14:18, Richard Henderson wrote:
> On 10/29/19 8:26 AM, Harald Freudenberger wrote:
>> Fine with me, Thanks, reviewed, build and tested.
>> You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
>> However, will this go into the kernel tree via crypto or s390 subsystem ?
> That's an excellent question.
>
> As an API decision, perhaps going via crypto makes more sense,
> but none of the patches are dependent on one another, so they
> could go through separate architecture trees.
>
> It has been a long time since I have done much kernel work;
> I'm open to suggestions on the subject.
>
>
> r~
Since the change needs to be done in include/linux/random.h
and in parallel with all the arch files in arch/xxx/include/asm/archrandom.h
it should go in one shot. I'd suggest to post the patch series to linux-crypto
and let Herbert Xu handle this.

