Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690A647C445
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhLUQ5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 11:57:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14672 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236459AbhLUQ5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Dec 2021 11:57:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLGJhfB025203;
        Tue, 21 Dec 2021 16:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nspNtTvRFgrrocR08r+32AK/5lxo2m/NNV5yaLOPS8g=;
 b=SSgVim+fUs1YoJ30X+lajJ5qc6wAs11MU0Vek1pjxPwqn7QGir0l1dhW01az5iPYQZ2b
 Ezr1Dvq4QA+aQygEkYeWbJmgoTAc1nMByJMQ8fMI1fuxS2LAWlIwAZmGKNHRzFpJYhhH
 7xQ0fcVHPZI2aUU47x1ZXyZtahIvTEoq1PH+cShmNVWwyCTjsUgE36CPg7VnBTw/QM4e
 41RFJM3deNXlB3I2Sa54Z5f+ecl4nUQsBNxgvlTIKYiySIDVDGqQDKNYrhO3pEoju+2Q
 fv0yNuN9Bs5Uu9CLx0QetxWw0gujtZXUw3uzZVgeH1lTsRjD4hyDQw86cKTiSxy/B44L kw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3g6w3qgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 16:57:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLGqh4b004025;
        Tue, 21 Dec 2021 16:57:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3d179afu7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 16:57:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLGv63F29884770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 16:57:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4EF9A4065;
        Tue, 21 Dec 2021 16:57:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70691A405B;
        Tue, 21 Dec 2021 16:57:06 +0000 (GMT)
Received: from sig-9-145-95-56.uk.ibm.com (unknown [9.145.95.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 16:57:06 +0000 (GMT)
Message-ID: <3b1b7881bbecc25a2d70f54743f1f6a9decbaa45.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     John Garry <john.garry@huawei.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Dec 2021 17:57:06 +0100
In-Reply-To: <3d543c90-383f-647a-5cd4-f7fd4e7246ad@huawei.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
         <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
         <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
         <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
         <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
         <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
         <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
         <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
         <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
         <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
         <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
         <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
         <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
         <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
         <d45ee18a-1faa-9c56-071d-18f5737d225c@huawei.com>
         <11e180449d82e5276586cdaab5e70a1c1b3adb42.camel@linux.ibm.com>
         <3d543c90-383f-647a-5cd4-f7fd4e7246ad@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _33tp7oQ7N0Bps4JSIqF5ZenFLSp0j8M
X-Proofpoint-GUID: _33tp7oQ7N0Bps4JSIqF5ZenFLSp0j8M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210081
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-21 at 16:48 +0000, John Garry wrote:
> On 20/12/2021 09:27, Niklas Schnelle wrote:
> > >   > My feeling is that in this case we want some other dependency, e.g. a
> > >   > new CONFIG_LPC. It should actually be possible to use this driver on
> > >   > any machine with an LPC bus, which would by definition be the primary
> > >   > I/O space, so it should be possible to load it on Arm64.
> > > 
> > > You did suggest HARDCODED_IOPORT earlier in this thread, and the
> > > definition/premise there seemed sensible to me.
> > > 
> > > Anyway it seems practical to make all these changes in a single series,
> > > so need a way forward as Niklas has no such changes for this additional
> > > kconfig option.
> > > 
> > > As a start, may I suggest we at least have Niklas' patch committed to a
> > > dev branch based on -next or latest mainline release for further analysis?
> > > 
> > > Thanks,
> > > John
> > > 
> > > 
> > My plan would be to split the patch up into more manageable pieces as
> > suggested by Arnd plus of course fixes like the missing ARM select. As
> > Arnd suggested I'll split the HAS_IOPORT additions into the initial
> > introduction plus arch selects and then the HAS_IOPORT dependencies per
> > subsytem. I think these per subsystem dependency patches then would be
> > a great place to find drivers which should have a different dependency
> > be it on LPC or a newly introduced HARDCODED_IOPORT. The thing is we
> > can find and check HAS_IOPORT dependencies easily but it's hard to find
> > HARDCODED_IOPORT so I think the lattter should be a refinement of the
> > former. It can of course still go in as a single series. I'll
> > definitely make the next iteration available as a git branch.
> 
> I'll do an audit for what would require HARDCODED_IOPORT to understand 
> the scope while you can continue the work on your current path.
> 
> Thanks,
> john
> 

Sounds good, I'm open to adding such a config option given a clear
enough picture of what drivers it would affect. Meanwhile I've made
some progress splitting things up. I still need to do a bit more
testing and refining of comments before sending an RFC but if you're
curious you can check out the 'has_ioport' branch on my GitHub here:

https://github.com/niklas88/linux.git  (still figuring out if/how I can
get a proper git.kernel.org branch/repository).

Thanks,
Niklas

