Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE69478CD1
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhLQNwT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 08:52:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233098AbhLQNwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 08:52:18 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHCJZRM028935;
        Fri, 17 Dec 2021 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MU0lvh52JOY+YJGKGYPMMV3/Q3MlmYPk+I+BMaPIekU=;
 b=tiocDKEbTd2sMsTVHMmrqaVez1ZB9BJqJH/ClndA+HiYXS3yNtUkE+xPEnrhiJuC54kN
 VkuI+qiuVkhonqE7XADZYHy0Ed/vtBO0xuIyj1/r+CyDO5t5XLoQZqiXRegZtAdOcM7p
 EuxEtN1tD2QfwzQ1LD7fXSCS7f22kmhR/GS45mfHp8+qGll7E+g2/XfXX2QDFYVL71zS
 irn/+f6JK4caLde9srGO4pb1nN50m0U4cLK+kazNjh9PNBnT2Y0VxlXzY+FE+4zlYhhA
 1zzcpvd3ZZQHeDZuXT/cJrKrROLBD5OP+mYMs3zhKjoc5NhnMhjif4HYKQy7S4FEtnRN Eg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d0tf5hvkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 13:52:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BHDRWBN009104;
        Fri, 17 Dec 2021 13:52:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3cy77prybm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 13:52:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BHDi3B246924234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 13:44:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5E3AA405C;
        Fri, 17 Dec 2021 13:52:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36131A4064;
        Fri, 17 Dec 2021 13:52:06 +0000 (GMT)
Received: from sig-9-145-149-59.de.ibm.com (unknown [9.145.149.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Dec 2021 13:52:06 +0000 (GMT)
Message-ID: <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 14:52:05 +0100
In-Reply-To: <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
         <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
         <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
         <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
         <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
         <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
         <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
         <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
         <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
         <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
         <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
         <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
         <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
         <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vxxUh-g2XOOGqzQm6SSRL4mo12jMPP-Y
X-Proofpoint-ORIG-GUID: vxxUh-g2XOOGqzQm6SSRL4mo12jMPP-Y
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_05,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170078
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-12-17 at 14:32 +0100, Arnd Bergmann wrote:
> On Fri, Dec 17, 2021 at 2:19 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > I've had some time to look into this a bit. As a refreshed starting
> > point I have rebased Arnd's patch to v5.16-rc5. Since I'm not sure how
> > to handle authorship and it's very early I haven't sent it as RFC but
> > it's available as a patch from my GitHub here:
> > https://gist.github.com/niklas88/a08fe76bdf9f5798500fccea6583e275
> > 
> > I have incorporated the following findings from this thread already:
> > 
> > - Added HAS_IOPORT to arch Kconfigs
> > - Added "config LEGACY_PCI" to drivers/pci/Kconfig
> > - Fixed CONFIG_HAS_IOPORT typo in asm-generic/io.h
> > - Removed LEGACY_PCI dependency of i2c-i801.
> >   Which is also used in current gen Intel platforms
> >   and depends on x86 anyway.
> > 
> > I have tested this on s390 with HAS_IOPORT=n and allyesconfig as well
> > as running it with defconfig. I've also been using it on my Ryzen 3990X
> > workstation with LEGACY_PCI=n for a few days. I do get about 60 MiB
> > fewer modules compared with a similar config of v5.15.8. Hard to say
> > which other systems might miss things of course.
> > 
> > I have not yet worked on the discussed IOPORT_NATIVE flag. Mostly I'm
> > wondering two things. For one it feels like that could be a separate
> > change on top since HAS_IOPORT + LEGACY_PCI is already quite big.
> > Secondly I'm wondering about good ways of identifying such drivers and
> > how much this overlaps with the ISA config flag.
> > 
> > I'd of course appreciate feedback. If you agree this is still
> > worthwhile to persue I'd think the next step would be trying to
> > refactor this into more manageable patches.
> 
> Thanks a lot for restarting this work! I think this all looks reasonable
> (a lot was my original patch anyway, so of course I think that ;)), but
> it would be good to split it up into multiple patches.

Yes definitely.

> 
> The CONFIG_LEGACY_PCI should take care of a lot of it, and I
> think that can be a single patch. I'd expand the Kconfig description
> to explain that this also covers PCIe devices that use the legacy
> I/O space even if they do not have a PCIe-to-PCI bridge in them.
> 
> The introduction of CONFIG_HAS_IOPORT, plus selecting it from
> the respective architectures makes sense as another patch, but
> I would make that separate from the #ifdef and 'depends on'
> changes to individual subsystems or drivers, as they are
> better reviewed separately.
> 
>         Arnd

Sounds like a plan. How should I mark authorship in the split up
patches. I definitely still see you as the main author to all of this
but of course I'll have to do quite a bit of editing and you shouldn't
get blamed for any mistakes I make. So not sure how to handle Sign-off-
bys and git's author property.

