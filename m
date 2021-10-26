Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0629C43AF34
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJZJlR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 05:41:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48648 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhJZJlR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Oct 2021 05:41:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8Tt2u021400;
        Tue, 26 Oct 2021 09:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5OchYLqpnnEkWLBWyeS+I/bGHLZdRbYrebYSuBnZaao=;
 b=nxgIYv02YC7bc8AUu6d2nU0n+t/kqTP73+fSxQQSJNw/d8rMxITaiI8WWShMkpabou94
 iaqIcwXndpFMowYOgsMD4jE3fQjTkOIxJvCRBolgJrb+dpz/Nf/VcFNfwGqscyi/DZnN
 L86uyyilDWeBV6jWvYhWOyY4GZfu4N/+Q0qQcBZQT3G0bA39ppyN8vmCfsiv/uPGdfbw
 BOkiLftG/qTmidGyZkRFkiZOw/a3GwdRCnh/M1sfr4VRnBOXoauFEAPEd7Yt2/rS6D7S
 dr3CLtjzfXTYApHdsuL5BdsV7/gI7C+Q6qt+BiKb27n56NiZ0iwSqsNPqcSne+6HqUvQ bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k87qr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 09:38:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q9YBTR032624;
        Tue, 26 Oct 2021 09:38:51 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k87qqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 09:38:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q9bB93024803;
        Tue, 26 Oct 2021 09:38:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3bx4f5bnhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 09:38:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q9WdaI59310504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 09:32:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ADB5A405E;
        Tue, 26 Oct 2021 09:38:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE160A4055;
        Tue, 26 Oct 2021 09:38:45 +0000 (GMT)
Received: from li-43c5434c-23b8-11b2-a85c-c4958fb47a68.ibm.com (unknown [9.171.51.215])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 09:38:45 +0000 (GMT)
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in
 default_trap_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-11-ebiederm@xmission.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <7c99f791-4a87-ae52-bee7-cb794b0741d2@de.ibm.com>
Date:   Tue, 26 Oct 2021 11:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211020174406.17889-11-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wOnCrEJWusXWZSSGrMyKIp26j2DdWA-4
X-Proofpoint-ORIG-GUID: 3Yl_va_89ctxG_rGJ2F6ZiZfzsDC-bwO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=886 suspectscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260053
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 20.10.21 um 19:43 schrieb Eric W. Biederman:
> Reading the history it is unclear why default_trap_handler calls
> do_exit.  It is not even menthioned in the commit where the change
> happened.  My best guess is that because it is unknown why the
> exception happened it was desired to guarantee the process never
> returned to userspace.
> 
> Using do_exit(SIGSEGV) has the problem that it will only terminate one
> thread of a process, leaving the process in an undefined state.
> 
> Use force_sigsegv(SIGSEGV) instead which effectively has the same
> behavior except that is uses the ordinary signal mechanism and
> terminates all threads of a process and is generally well defined.

Do I get that right, that programs can not block SIGSEGV from force_sigsegv
with a signal handler? Thats how I read the code. If this is true
then

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>   arch/s390/kernel/traps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index bcefc2173de4..51729ea2cf8e 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
>   {
>   	if (user_mode(regs)) {
>   		report_user_fault(regs, SIGSEGV, 0);
> -		do_exit(SIGSEGV);
> +		force_sigsegv(SIGSEGV);
>   	} else
>   		die(regs, "Unknown program exception");
>   }
> 
