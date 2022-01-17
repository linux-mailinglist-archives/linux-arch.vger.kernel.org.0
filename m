Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216C49087E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 13:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiAQMQG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 07:16:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239765AbiAQMQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jan 2022 07:16:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20H9vnfq026678;
        Mon, 17 Jan 2022 12:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3a6XeSsdk/gF/5MxcgUQfE5YMHf39nUtcYBoI8X+tZQ=;
 b=fT7WmRMXvktXHp4JBuINW9JapuDmpsVTaPm4kOQeBDYPopHeVUSKAX5PZwdwz3uEmBUf
 JjECpVgthhB6SOUuKBKevThF+FUunjLgaT16HoFxG3QmhX6AEaNagdagFQR2LL/qI/3E
 bK3/V0Mh38Lhm1GeVaMGm41vuTNFLgIbeX/aWBvY4T7Somm250X4fNGNhqp68GVVDLMW
 bymjDPBnWlVUAYq4HQoGS35x7jGaH013kAwMgIniejLrOCf583bXiKWpG5GuoE4MFeBw
 mbKSkkCZwVU7+T24rA73aBjNMNgdNwFFbfoObSn+N7smYJhI6UVLhzbWUCvSxICUjzMB Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn69mk460-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:15:51 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HC1G8c012770;
        Mon, 17 Jan 2022 12:15:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dn69mk45b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:15:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HCD300008145;
        Mon, 17 Jan 2022 12:15:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhj3tf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:15:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCFj4Z41615734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:15:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA4EF4205C;
        Mon, 17 Jan 2022 12:15:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4418342041;
        Mon, 17 Jan 2022 12:15:45 +0000 (GMT)
Received: from osiris (unknown [9.145.81.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Jan 2022 12:15:45 +0000 (GMT)
Date:   Mon, 17 Jan 2022 13:15:43 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
Message-ID: <YeVd7xj2Lwyp4QB1@osiris>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
 <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
 <87tuefwewa.fsf@email.froward.int.ebiederm.org>
 <YeUjVZX764zLm9/K@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeUjVZX764zLm9/K@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xINXz-bmWCwqN2vRiMBHUjzzyNw3PA0R
X-Proofpoint-GUID: k1yIDPKElVbS_MVkl7Z1RwZ35S4nA9_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=573 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Mon, Jan 17, 2022 at 12:05:41AM -0800, Christoph Hellwig wrote:
> On Fri, Jan 07, 2022 at 12:59:33PM -0600, Eric W. Biederman wrote:
> > Assuming it won't be too much longer before the rest of the arches have
> > set_fs/get_fs removed it looks like it makes sense to leave the
> > force_uaccess_begin where it is, and just let force_uaccess_begin be
> > removed when set_fs/get_fs are removed from the tree.
> > 
> > Christoph does it look like the set_fs/get_fs removal work is going
> > to stall indefinitely on some architectures?  If so I think we want to
> > find a way to get kernel threads to run with set_fs(USER_DS) on the
> > stalled architectures.  Otherwise I think we have a real hazard of
> > introducing bugs that will only show up on the stalled architectures.
> 
> I really need help from the arch maintainers to finish the set_fs
> removal.  There have been very few arch maintainers helping with that
> work (arm, arm64, parisc, m68k) in addition to the ones I did because
> I have the test setups and knowledge.  I'll send out another ping,

Just in case you missed it: s390 was converted with commit 87d598634521
("s390/mm: remove set_fs / rework address space handling").
