Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A773FFC03
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbhICIcu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 04:32:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234831AbhICIct (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2021 04:32:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18383uBv145986;
        Fri, 3 Sep 2021 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Exm6y1FOu+ZBrK+yh3J6WZQaWOGuziL00C3jiRfFieI=;
 b=Zc5RAxNGHdVf02Wi1czvATyswyK3LyzNfG3uDLlFnSZ/GpBB3AXOIIeiUTuFUWPhx3qO
 UHd3vuSDI6AwH5VuTMk5PFhN8izJhiA1vfr0lO3aSgirFkwEwTuQAOBR7d1Lf/rReuN3
 ls02cdy0VRQ9LWJX3C69TX2cYZZhpUAyODoeqlO8hRACfrHlZMjQe3+yQ6iHTQ3QMJ28
 +lF9jYeYZfNoRGX+98YIur/RXBLCtCJ0DHoJh9sZnvj+uaRtZiSrjeEI8Erbd2h/9eYw
 J+F9cF8bE80J96R7LX6ZYwkfh1CMuVBxknleqYv7KIjG/2Q8vlbCy+geZzj+aIJ+qOBl Ag== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aubde6mex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 04:31:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1838SAYg031431;
        Fri, 3 Sep 2021 08:31:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3au6q757ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 08:31:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1838Ve8d42991930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 08:31:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3951BA4076;
        Fri,  3 Sep 2021 08:31:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF647A404D;
        Fri,  3 Sep 2021 08:31:39 +0000 (GMT)
Received: from sig-9-145-171-221.de.ibm.com (unknown [9.145.171.221])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 08:31:39 +0000 (GMT)
Message-ID: <dd9d9f056a8be2ea62e8497ca5f44707c5623600.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, John Garry <john.garry@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Sep 2021 10:31:39 +0200
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
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NvJMTKo50fBh6rkdhC0LTdUAKiWuDsEy
X-Proofpoint-GUID: NvJMTKo50fBh6rkdhC0LTdUAKiWuDsEy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_02:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030048
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

Sorry for the late reply, this got lost in my inbox. I could spare some
cycles on this but I'm not sure how I can help.

The series you sent after Linus' nacked the previous approach looks
quite broad touching lots of areas I have little experience with. I'd
be willing to test things and look over patches the best I can of
course.

Thanks,
Niklas

