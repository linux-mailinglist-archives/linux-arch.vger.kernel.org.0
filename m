Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C367471BF3
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhLLRtL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 12:49:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhLLRtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Dec 2021 12:49:11 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BCHTWOM022620;
        Sun, 12 Dec 2021 17:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9im8bINFr6HEhLEf+QMSkLywF3Qj1B6x6+Mrrb7bbEY=;
 b=N4a2HFKeVVOGIOO9wyIRo12R/aAMpat7vHjtwkv+Vw/p8JftQ90De1Ou0xH7satl8Ni+
 6KV2GHnDb/k4+8YwlTni9IVhZh4SwLquhCuT4g/Gj9qlJMlig48tgxvu+6UlGjIaBTiJ
 /00yDXmTZqHJk4mnB8KKi+DPwSQTNo+rooG5ficg3b8dY1TAym3Ag4zyp0FoFaL5LVWs
 yhgkeYlSUb9PHVStFhvQij9xsik5T5WSmHFYb2G9xNv0I5lkwU64WK5syFa5b9SZRYYj
 mxYqPWOtZcVfMlfh70EygOf5OLIbZESgcs5TepfLjtyyXqWL07uh7o9NBmY9IQkZUvgw Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cwngxr75m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 17:49:05 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BCHkiB5003332;
        Sun, 12 Dec 2021 17:49:04 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cwngxr754-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 17:49:04 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BCHhW3j028899;
        Sun, 12 Dec 2021 17:49:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3cvkm8e9au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 17:49:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BCHmwaL20054298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Dec 2021 17:48:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55EA611C073;
        Sun, 12 Dec 2021 17:48:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E6B11C06E;
        Sun, 12 Dec 2021 17:48:57 +0000 (GMT)
Received: from osiris (unknown [9.145.153.15])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 12 Dec 2021 17:48:57 +0000 (GMT)
Date:   Sun, 12 Dec 2021 18:48:56 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 01/10] exit/s390: Remove dead reference to do_exit from
 copy_thread
Message-ID: <YbY2CDkZbOFRBN0i@osiris>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208202532.16409-1-ebiederm@xmission.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qO-2S9u-J4wCnXBo5p9cuBUOLvh1NgVf
X-Proofpoint-ORIG-GUID: ZiJj0tik5lgEsnkHHuvdFTOduCt6Fxet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-12_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=742 impostorscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112120107
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 08, 2021 at 02:25:23PM -0600, Eric W. Biederman wrote:
> My s390 assembly is not particularly good so I have read the history
> of the reference to do_exit copy_thread and have been able to
> verify that do_exit is not used.
> 
> The general argument is that s390 has been changed to use the generic
> kernel_thread and kernel_execve and the generic versions do not call
> do_exit.  So it is strange to see a do_exit reference sitting there.
> 
> The history of the do_exit reference in s390's version of copy_thread
> seems conclusive that the do_exit reference is something that lingers
> and should have been removed several years ago.
...
> Remove this dead reference to do_exit to make it clear that s390 is
> not doing anything with do_exit in copy_thread.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/s390/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to s390 tree. Just in case you want to apply this to your tree too:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
