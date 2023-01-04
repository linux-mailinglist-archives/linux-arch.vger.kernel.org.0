Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C965D21B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 13:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjADMJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 07:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjADMJE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 07:09:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863E395E5;
        Wed,  4 Jan 2023 04:08:38 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304BtmSd028031;
        Wed, 4 Jan 2023 12:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/+3E/6uhsEsNbfIBZNDg4Dna6IRh//Qo5TUvYFVbCpg=;
 b=YL4jVarSnbznELObLfvzbVJAtLCdJ+CnXERogsYv6t6gXI9AbLzDexZP0VmKKlPtMv3Y
 F/o8WaDs5GXt5rjOtRrvfyDpZqtKajHVMJ4NVJSZIfkN0M3DFxs0AYoxydUYGjchqWMl
 YVyUZe6ClxG4NftHN3bhiY67g24szI57CkIMRdNAiyk0rJE3EIZKTlZnRd8FjK3ctb7o
 AlTlvSFBMBQZPAzMaGTfyfl69UQt+leadNGD1GZBoqnpc6/pgwJN+aquf+3SsSZMqfdA
 mDAgEwNPnw8WCWPVyOvYh4in0q0GSXSWDhbHGg/nt2sJMfwxKFN3bL7fHJKNHDXKNk2a 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw90xr9e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:07:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304Buk4D030736;
        Wed, 4 Jan 2023 12:07:45 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw90xr9dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:07:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303NahKZ001913;
        Wed, 4 Jan 2023 12:07:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d8nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:07:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 304C7dgf45810066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 12:07:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D4E520040;
        Wed,  4 Jan 2023 12:07:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5C620049;
        Wed,  4 Jan 2023 12:07:37 +0000 (GMT)
Received: from osiris (unknown [9.179.28.126])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jan 2023 12:07:37 +0000 (GMT)
Date:   Wed, 4 Jan 2023 13:07:35 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
Message-ID: <Y7VsB8Zl4dZIC8c+@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris>
 <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4DtMKKso1esxB3_JoeRNn4u6YiaeZ5eJ
X-Proofpoint-GUID: 3IAXim3b6DGqV8HT2j5Nmx0Y_NddguSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=744
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 11:08:29AM -0800, Linus Torvalds wrote:
> On Tue, Jan 3, 2023 at 9:17 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 04:35:36PM +0100, Peter Zijlstra wrote:
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/slub_def.h |   12 ++-
> > >  mm/slab.h                |   41 +++++++++++--
> > >  mm/slub.c                |  146 ++++++++++++++++++++++++++++-------------------
> > >  3 files changed, 135 insertions(+), 64 deletions(-)
> >
> > Does this actually work? Just wondering since I end up with an instant
> > list corruption on s390. Might be endianness related, but I can't see
> > anything obvious at a first glance.
...
> the right thing for a 128-bit value. And I have to admit that all
> those games with __pcpu_cast_128() make no sense to me. Why isn't it
> just using "u128" everywhere without any odd _Generic() games?

That would have been my question as well, but the good thing is that
you pointed me to the percpu patch - Initially didn't expect any s390
specific code in there, but that is where the bug is.
I'll reply to that patch.
