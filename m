Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8B478C15
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhLQNTj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 08:19:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234037AbhLQNTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 08:19:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHCYHV8028266;
        Fri, 17 Dec 2021 13:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WLiJcuOqykjSN0yI/nAUCPPm0ntJ2jHq4zwkOAY7sGA=;
 b=DMeqoNnxsZhompDM6UmoRTTzrLGWaN279GlWVOAHrpRnERIVDxoeGBXl2thQbjmn6SRF
 mcs9HxAKkGJNbD9hSuN1jC0oOibxoOiP0wgx53TbeXob/Oc5dRmggKlMpUmUjUdWWm2f
 jUqpmCbQrVV5lLmpwf6eJmrNSpJrDtxULM+H1kDQjFnPlVUyyyMR3Bem3r0sc7iVg9g7
 IKwS0/TW184JcHVntNGfGfaCR6GMOl6s6mk+dgA2qq4Na0FCmk9pKuLu/JmnPh8i1RJr
 hilxGDwzqX9BDstUUM5I/m673otxUkcKOnqsdGGK1W7xTz9XjM0c8VoL736HQuI9Mxbo pg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d0j1vk26y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 13:19:23 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BHDDaaL015260;
        Fri, 17 Dec 2021 13:19:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3cy77prpyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 13:19:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BHDJI0o29032778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 13:19:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D474A4059;
        Fri, 17 Dec 2021 13:19:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC94A405F;
        Fri, 17 Dec 2021 13:19:18 +0000 (GMT)
Received: from sig-9-145-149-59.de.ibm.com (unknown [9.145.149.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Dec 2021 13:19:17 +0000 (GMT)
Message-ID: <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, John Garry <john.garry@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 14:19:17 +0100
In-Reply-To: <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XpurAU0gZDXe3DKUcbp6l4hEFEGabX0H
X-Proofpoint-ORIG-GUID: XpurAU0gZDXe3DKUcbp6l4hEFEGabX0H
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170076
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-08-10 at 13:33 +0200, Arnd Bergmann wrote:
> On Tue, Aug 10, 2021 at 11:19 AM John Garry <john.garry@huawei.com> wrote:
> > On 04/08/2021 09:52, Arnd Bergmann wrote:
> > 
> > This seems a reasonable approach. Do you have a plan for this work? Or
> > still waiting for the green light?
> 
> I'm rather busy with other work at the moment, so no particular plans
> for any time soon.
> 
> > I have noticed the kernel test robot reporting the following to me,
> > which seems to be the same issue which was addressed in this series
> > originally:
> > 
> > config: s390-randconfig-r032-20210802 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project
> > 4f71f59bf3d9914188a11d0c41bedbb339d36ff5)
> > ...
> > All errors (new ones prefixed by >>):
> > 
> >     In file included from drivers/block/null_blk/main.c:12:
> >     In file included from drivers/block/null_blk/null_blk.h:8:
> >     In file included from include/linux/blkdev.h:25:
> >     In file included from include/linux/scatterlist.h:9:
> >     In file included from arch/s390/include/asm/io.h:75:
> >     include/asm-generic/io.h:464:31: warning: performing pointer
> > arithmetic on a null pointer has undefined behavior
> > [-Wnull-pointer-arithmetic]
> >             val = __raw_readb(PCI_IOBASE + addr);
> > 
> > So I imagine lots of people are seeing these.
> 
> Right, this is the original problem that Niklas was trying to solve.
> 
> If Niklas has time to get this fixed, I can probably find a way to work
> with him on finishing up my proposed patch with the changes you
> suggested.
> 
>        Arnd

Hi Arnd, Hi John,

I've had some time to look into this a bit. As a refreshed starting
point I have rebased Arnd's patch to v5.16-rc5. Since I'm not sure how
to handle authorship and it's very early I haven't sent it as RFC but
it's available as a patch from my GitHub here: 
https://gist.github.com/niklas88/a08fe76bdf9f5798500fccea6583e275

I have incorporated the following findings from this thread already:

- Added HAS_IOPORT to arch Kconfigs
- Added "config LEGACY_PCI" to drivers/pci/Kconfig
- Fixed CONFIG_HAS_IOPORT typo in asm-generic/io.h
- Removed LEGACY_PCI dependency of i2c-i801.
  Which is also used in current gen Intel platforms
  and depends on x86 anyway.

I have tested this on s390 with HAS_IOPORT=n and allyesconfig as well
as running it with defconfig. I've also been using it on my Ryzen 3990X
workstation with LEGACY_PCI=n for a few days. I do get about 60 MiB
fewer modules compared with a similar config of v5.15.8. Hard to say
which other systems might miss things of course.

I have not yet worked on the discussed IOPORT_NATIVE flag. Mostly I'm
wondering two things. For one it feels like that could be a separate
change on top since HAS_IOPORT + LEGACY_PCI is already quite big.
Secondly I'm wondering about good ways of identifying such drivers and
how much this overlaps with the ISA config flag.

I'd of course appreciate feedback. If you agree this is still
worthwhile to persue I'd think the next step would be trying to
refactor this into more manageable patches.

Thanks,
Niklas

