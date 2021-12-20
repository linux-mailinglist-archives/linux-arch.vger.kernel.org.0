Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAA47A6FB
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhLTJ1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 04:27:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229827AbhLTJ1w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Dec 2021 04:27:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BK7jmBa012390;
        Mon, 20 Dec 2021 09:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jBRqccRrq/qpJs4iFewHbHn93HbKdMJkxqO7ZFzulLU=;
 b=RxMPvsL5j/hXCa+nTpOPLNFBCROmIrXPSEKO10FVGwc+nTlLDer90jUFHDgXmdf4eTts
 1we+xHL3jiCzEYk7D+LRq5o6PaWo3E9HFZBAU+Ha4orI/198WK7ZWXIo4hcPJoI8bs3y
 ya94sa/CWht/XHD3eQoEy7qLcBnXYr6bGdS9RGe3O/tSk+Kk/e42iyu3u4K2/q92unCJ
 unUs4Vnj6pUXwO+/5ATJvk++y7P60jLdYVBKtW0PV4D5zAq539i4yUkRprmKZnlvSj0r
 JlYEJ2LzSv9krlwewgW+LEbY30i1nV/S8Hho3Sxv2DbFYr7IFUe281Zib2UvbogsjX9e Tw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d1s1582ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 09:27:45 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BK90qxk001675;
        Mon, 20 Dec 2021 09:27:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3d1799a934-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 09:27:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BK9Reao33882592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 09:27:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB9AA42045;
        Mon, 20 Dec 2021 09:27:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC9C4204B;
        Mon, 20 Dec 2021 09:27:40 +0000 (GMT)
Received: from sig-9-145-145-204.de.ibm.com (unknown [9.145.145.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Dec 2021 09:27:40 +0000 (GMT)
Message-ID: <11e180449d82e5276586cdaab5e70a1c1b3adb42.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     John Garry <john.garry@huawei.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Dec 2021 10:27:39 +0100
In-Reply-To: <d45ee18a-1faa-9c56-071d-18f5737d225c@huawei.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
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
         <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
         <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
         <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
         <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
         <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
         <d45ee18a-1faa-9c56-071d-18f5737d225c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9DCjmHxLglY5b5EcgIVzP1qc0sLrRYjK
X-Proofpoint-ORIG-GUID: 9DCjmHxLglY5b5EcgIVzP1qc0sLrRYjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 mlxlogscore=773 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200053
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-12-17 at 16:30 +0000, John Garry wrote:
> On 17/12/2021 15:55, Arnd Bergmann wrote:
> > > > If you have a better way of finding the affected drivers,
> > >   > that would be great.
> > > 
> > > Assuming arm64 should select HAS_IOPORT, I am talking about f71805f as
> > > an example. According to that patch, this driver additionally depends on
> > > HAS_IOPORT; however I would rather arm64, like powerpc, should not allow
> > > that driver to be built at all.
> > Agreed, I missed these when I looked through the HAS_IOPORT users,
> > that's why I suggested to split up that part of the patch per subsystem
> > so they can be inspected more carefully.
> 
> ok
> 
>  >
>  > My feeling is that in this case we want some other dependency, e.g. a
>  > new CONFIG_LPC. It should actually be possible to use this driver on
>  > any machine with an LPC bus, which would by definition be the primary
>  > I/O space, so it should be possible to load it on Arm64.
> 
> You did suggest HARDCODED_IOPORT earlier in this thread, and the 
> definition/premise there seemed sensible to me.
> 
> Anyway it seems practical to make all these changes in a single series, 
> so need a way forward as Niklas has no such changes for this additional 
> kconfig option.
> 
> As a start, may I suggest we at least have Niklas' patch committed to a 
> dev branch based on -next or latest mainline release for further analysis?
> 
> Thanks,
> John
> 
> 

My plan would be to split the patch up into more manageable pieces as
suggested by Arnd plus of course fixes like the missing ARM select. As
Arnd suggested I'll split the HAS_IOPORT additions into the initial
introduction plus arch selects and then the HAS_IOPORT dependencies per
subsytem. I think these per subsystem dependency patches then would be
a great place to find drivers which should have a different dependency
be it on LPC or a newly introduced HARDCODED_IOPORT. The thing is we
can find and check HAS_IOPORT dependencies easily but it's hard to find
HARDCODED_IOPORT so I think the lattter should be a refinement of the
former. It can of course still go in as a single series. I'll
definitely make the next iteration available as a git branch.

Thanks,
Niklas

