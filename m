Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F61488589
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 20:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiAHTNY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 14:13:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230409AbiAHTNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 14:13:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 208J1dSM028622;
        Sat, 8 Jan 2022 19:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ZtrEmj7RpLT0D2CRHKuWX77vx/C+jmz39Z1GFmH3mLs=;
 b=tHqU1llKYcXRmyJ2hPlZPcDrCzMthnMjQ6FHBCKK/+d2tuoN5POvef0cikqmXgKGkqu8
 gxo3qWCqEWGyizloBiONrA/qTFUYqRqU/Ihxd+iSN1negkudiRNvbw7Sqod3CieychtI
 2LlMdVm+tU0q4Lp3WaLL4k+9DaOpmQkaQbQOfay8tGtvFB/kMPG+266ctHesN8njk6QT
 lbclNazsdI/GTT/7LvlkHLcgnEJF/xxgPOFUZdJHfQA1z9UM7OXf73BqcKZr+I5CqFNl
 NE+I/NrgIJvrAALOxz9nz3zgDWioqKrYIJMpyvyVJsGVeXfAr1jYadDDHBXZXFA3Rnwe DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3df37w1e36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 19:13:13 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 208J4kFu006144;
        Sat, 8 Jan 2022 19:13:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3df37w1e2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 19:13:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 208J7cox001250;
        Sat, 8 Jan 2022 19:13:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vhb012-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 19:13:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 208JD8Ae32506164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jan 2022 19:13:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C87AD11C04A;
        Sat,  8 Jan 2022 19:13:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 646E911C04C;
        Sat,  8 Jan 2022 19:13:08 +0000 (GMT)
Received: from osiris (unknown [9.145.35.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  8 Jan 2022 19:13:08 +0000 (GMT)
Date:   Sat, 8 Jan 2022 20:13:06 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
Message-ID: <YdniQob7w5hTwB1v@osiris>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com>
 <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
 <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iK6vptB3IxazjPD9tBOXzl9b-opgXk7z
X-Proofpoint-ORIG-GUID: 7N4-cUVmsiUdvBVeWxNSY1UpZbWLMSIk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-08_07,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=693
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080145
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 01:47:05PM -0600, Eric W. Biederman wrote:
> Currently I suspect changing wait_event_uninterruptible to
> wait_event_killable, is causing problems.
> 
> Or perhaps there is some reason tasks that have already entered do_exit
> need to have fatal_signal_pending set. (The will have
> fatal_signal_pending set up until they enter get_signal which calls
> do_group_exit which calls do_exit).
> 
> Which is why I am trying to reproduce the reported failure so I can get
> the kernel to tell me what is going on.  If this is not resolved quickly
> I won't send you this change, and I will pull it out of linux-next.

It would have been good if you would have removed this from linux-next
already.

Anyway, now I also had to spend quite some time to bisect why several test
suites just hang with linux-next. It's probably because of holidays that
you didn't get more bug reports.

On s390

- ltp
- elfutils selftests
- seccomp kernel selftests

hang with linux-next.

I bisected the problem to this patch using elfutils selftests:

git clone git://sourceware.org/git/elfutils.git
cd elfutils
autoreconf -fi
./configure --enable-maintainer-mode --disable-debuginfod
make -j $(nproc) > /dev/null
cd tests
make -j $(nproc) check

Note: I actually didn't verify if this also causes ltp+seccomp selftests
      to hang. I just assume it is the case.
