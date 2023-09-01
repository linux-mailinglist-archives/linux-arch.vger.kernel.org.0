Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BF7902F9
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbjIAUwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjIAUwV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 16:52:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5C1B1;
        Fri,  1 Sep 2023 13:52:19 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381KoM5I013874;
        Fri, 1 Sep 2023 20:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=YATKeppYVdmosy4MOHbVQ0Q9N+F6cqQTc7UhdQG11lA=;
 b=Z/zre60c/P6Z1gstV2ByzpyumGUuTExj61W6vBhzcx75Llc0+N6EWpVBQqX07eKs49aK
 jQDp5Me7qgXpz74GLG6JYiGt5kAFHy2gC6tf6DyyzvF5Rqv0t23uIp36m6McIa5CQ5c9
 u7bFAv9kytTHNY/hXVKLtctWhu2PqfEjLusiP+QXlO44SUSoIyxXzINa4XMC59HrK4cR
 TKL18ISW3ENFhZ4aRjzFbHbmtLJ1FL7TfLg9k4xKDuxdiSsIgqmRRUsrORJz/FiRdlaB
 nEuWhDGb+CiYLepVMFbrqeu6jfpzSenmjShVmEXmQbd+SgpBp70QmMTAcOSHLCuMkEaR mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunwg1rcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:51:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381KdPxc013171;
        Fri, 1 Sep 2023 20:51:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunwg1rc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:51:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381K3eZO009907;
        Fri, 1 Sep 2023 20:51:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7m7mba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 20:51:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381Kpmlk20775538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 20:51:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A2022004B;
        Fri,  1 Sep 2023 20:51:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6073820040;
        Fri,  1 Sep 2023 20:51:47 +0000 (GMT)
Received: from osiris (unknown [9.171.55.36])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Sep 2023 20:51:47 +0000 (GMT)
Date:   Fri, 1 Sep 2023 22:51:45 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     aleksandr.mikhalitsyn@canonical.com, arnd@arndb.de,
        bluca@debian.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, keescook@chromium.org,
        kuba@kernel.org, ldv@strace.io, leon@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
Message-ID: <20230901205145.10640-A-hca@linux.ibm.com>
References: <20230901200517.8742-A-hca@linux.ibm.com>
 <20230901203322.56399-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901203322.56399-1-kuniyu@amazon.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jNQc6YDsC8RZryLJ2nJ5hWKUhYmf97hv
X-Proofpoint-ORIG-GUID: luZecLbiaJAq-lVfBHI4pxkmJh25vlml
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=902 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 01, 2023 at 01:33:22PM -0700, Kuniyuki Iwashima wrote:
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Fri, 1 Sep 2023 22:05:17 +0200
> > On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wrote:
> > > +	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
> > > +	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
> > > +		msg->msg_flags |= MSG_CTRUNC;
> > > +		return;
> > > +	}
> > 
> > This does not work for compat tasks since the size of struct cmsghdr (aka
> > struct compat_cmsghdr) is differently. If the check from put_cmsg() is
> > open-coded here, then also a different check for compat tasks needs to be
> > added.
> > 
> > Discovered this because I was wondering why strace compat tests fail; it
> > seems because of this.
> > 
> > See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c
> > 
> > For compat tasks recvmsg() returns with msg_flags=MSG_CTRUNC since the
> > above code expects a larger buffer than is necessary.
> 
> Can you test this ?

Works for me.

Tested-by: Heiko Carstens <hca@linux.ibm.com>
