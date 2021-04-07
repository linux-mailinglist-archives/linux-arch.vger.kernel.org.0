Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C7356BEB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhDGMQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 08:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37276 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234542AbhDGMQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 08:16:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137C3gEp173757;
        Wed, 7 Apr 2021 08:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Lxj40dpOv+iFXbAWfhTZRnR8s3LKVpG47j3P4TYD2qI=;
 b=hA46bv2ba54miGjwjf3xLKOB/OmN3p0nA7k/KDPqoUogpjCVTwBnfU0CWJXxq0FJQ0rz
 wDpME3/Hl4YRW8Fp3L91X7sC4W4Fm/ZTnMYJ60/La80JlZi9pO6WfNw2C69DnSb+P2y7
 VEYUYRTwdf7e9mh9SEZl6LwzX1PEZW1wts24KTmqiUb6bzVXthsjQdrgsK4NgfZDMxKo
 RSoyGcDIuiLkNTwbOoPPAh1oy+mVowBpjzbHwK5DmKVysUIJfPyP2cVxTU8UXRjS635r
 L/SEmf9TqUQ3tEmEJJ+YR3d0OSNZi2B4hdpVr/+PuDdjenGTLacSev+v5ihloP2zcJ03 EQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpg7yyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 08:15:46 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137C7NEb023814;
        Wed, 7 Apr 2021 12:15:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 37rvbw0ca7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 12:15:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137CFfGL53412214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 12:15:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2F1AE05A;
        Wed,  7 Apr 2021 12:15:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2918AE057;
        Wed,  7 Apr 2021 12:15:40 +0000 (GMT)
Received: from osiris (unknown [9.171.27.208])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Apr 2021 12:15:40 +0000 (GMT)
Date:   Wed, 7 Apr 2021 14:15:39 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 17/20] kbuild: s390: use common install script
Message-ID: <YG2iawVO+fit6N5T@osiris>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-18-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-18-gregkh@linuxfoundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pajna-vBjbwYhzfCxdFTnEuZTPVBAVFh
X-Proofpoint-GUID: Pajna-vBjbwYhzfCxdFTnEuZTPVBAVFh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=636 priorityscore=1501 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:16AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for s390, no changes
> needed.  So call that instead and delete the s390-only install script.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/boot/Makefile   |  2 +-
>  arch/s390/boot/install.sh | 30 ------------------------------
>  2 files changed, 1 insertion(+), 31 deletions(-)
>  delete mode 100644 arch/s390/boot/install.sh

Acked-by: Heiko Carstens <hca@linux.ibm.com>
