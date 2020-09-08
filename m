Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC9261797
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgIHRil (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 13:38:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbgIHRiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 13:38:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088HX91w193873;
        Tue, 8 Sep 2020 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zTcPf30MWc1o3sVkuFOlszFjBszv6mbPeKxPdnXhSzU=;
 b=CpOXYrIzNqgah+XmLK3ao2p1ye9+BqkrW/W1vkBKNJnKCOWAruPC38o1UqN5H0fatOAw
 XumWZzfaC1TZGPFsow6W/myGfJbHhaD2OvuzQU0oxh2EDzoXjNHyJvsUt1Te4q4rOnxP
 hoH4fPXZ42JeutQXvPzj1LuseK96o+mcemAbZdpCDekWLg7A2PFNwMito9+ERwk99PLx
 nzqwnuOOTkECp7JT3Dm1gwXmzW5zTGO/Ua5IgYtQHrsvmvB5+rmFFLnzfuN/57SIWYYH
 vzeOQxBeZZr7qbY/CEExQHgWB8KAC0wqCkDbM8R27TiIV4YWSm2aGi/j8+grRA00NWav SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33edqq1kx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:37:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088HYuZt002693;
        Tue, 8 Sep 2020 13:36:58 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33edqq1kvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:36:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088Hauxr003944;
        Tue, 8 Sep 2020 17:36:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 33c2a828a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 17:36:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088Haql029163968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 17:36:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B279352063;
        Tue,  8 Sep 2020 17:36:52 +0000 (GMT)
Received: from thinkpad (unknown [9.171.25.197])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 89AD352050;
        Tue,  8 Sep 2020 17:36:51 +0000 (GMT)
Date:   Tue, 8 Sep 2020 19:36:50 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200908193650.1c1511d0@thinkpad>
In-Reply-To: <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907201256.GC1976319@kernel.org>
        <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_09:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=884 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Sep 2020 07:22:39 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

>=20
>=20
> Le 07/09/2020 =C3=A0 22:12, Mike Rapoport a =C3=A9crit=C2=A0:
> > On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
> >> This is v2 of an RFC previously discussed here:
> >> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@lin=
ux.ibm.com/
> >>
> >> Patch 1 is a fix for a regression in gup_fast on s390, after our conve=
rsion
> >> to common gup_fast code. It will introduce special helper functions
> >> pXd_addr_end_folded(), which have to be used in places where pagetable=
 walk
> >> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
> >>
> >> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_=
end()
> >> themselves by adding an extra pXd value parameter. That was suggested =
by
> >> Jason during v1 discussion, because he is already thinking of some oth=
er
> >> places where he might want to switch to the READ_ONCE logic for pageta=
ble
> >> walks. In general, that would be the cleanest / safest solution, but t=
here
> >> is some impact on other architectures and common code, hence the new a=
nd
> >> greatly enlarged recipient list.
> >>
> >> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
> >> functions instead of #defines, so that we get some type checking for t=
he
> >> new pXd value parameter.
> >>
> >> Not sure about Fixes/stable tags for the generic solution. Only patch 1
> >> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 mig=
ht
> >> still be nice to have in stable, to ease future backports, but I guess
> >> "nice to have" does not really qualify for stable backports.
> >=20
> > I also think that adding pXd parameter to pXd_addr_end() is a cleaner
> > way and with this patch 1 is not really required. I would even merge
> > patches 2 and 3 into a single patch and use only it as the fix.
>=20
> Why not merging patches 2 and 3, but I would keep patch 1 separate but=20
> after the generic changes, so that we first do the generic changes, then=
=20
> we do the specific S390 use of it.

Yes, we thought about that approach too. It would at least allow to
get all into stable, more or less nicely, as prerequisite for the s390
fix.

Two concerns kept us from going that way. For once, it might not be
the nicest way to get it all in stable, and we would not want to risk
further objections due to the imminent and rather scary data corruption
issue that we want to fix asap.

For the same reason, we thought that the generalization part might
need more time and agreement from various people, so that we could at
least get the first patch as short-term solution.

It seems now that the generalization is very well accepted so far,
apart from some apparent issues on arm. Also, merging 2 + 3 and
putting them first seems to be acceptable, so we could do that for
v3, if there are no objections.

Of course, we first need to address the few remaining issues for
arm(32?), which do look quite confusing to me so far. BTW, sorry for
the compile error with patch 3, I guess we did the cross-compile only
for 1 + 2 applied, to see the bloat-o-meter changes. But I guess
patch 3 already proved its usefulness by that :-)
