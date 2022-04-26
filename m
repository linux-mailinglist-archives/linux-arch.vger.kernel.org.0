Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE264510956
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiDZT5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiDZT5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 15:57:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5A7486A;
        Tue, 26 Apr 2022 12:54:22 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QJIDm8013637;
        Tue, 26 Apr 2022 19:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uIQwJX508dFGTPPox0kxzyjch6Vz1M0Kw+Ufz6SrqTo=;
 b=WmjPjE02A2glZ3GEypJCv1I3nyS5NenxU1DsecPWagOiGlHB+isLhG4iS8LhRXe60h7m
 GzwiRmclQrYSianmOrGwTGfTBvAyUcSoidmYvJjBnb2DpNhuqfc4bww0fGS3lNngH1by
 0mj+od80f4KkyqFHO/V3P+6w2853Vo75Kw2AGBVcwNSP6+RrLMKtGteOEADl6c8SIk4n
 SZBx14UACa/I4KqhWtDzcPenr7u3OGrPWtQ7DKcGQm/s5oGgajGW1Hn76K/G8Xhht8LM
 o8Ktx1MudAQoNOSnLUKK36qhB7uARe/zj5WQDZyJJ4Id0bGud307+MvAy1YCklZsMwxF OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj07ydjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:53:51 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QJGflV028203;
        Tue, 26 Apr 2022 19:53:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj07ydhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:53:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QJqlWI008177;
        Tue, 26 Apr 2022 19:53:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938vvfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:53:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QJrivJ31195588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 19:53:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A23E54C04A;
        Tue, 26 Apr 2022 19:53:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB5DD4C040;
        Tue, 26 Apr 2022 19:53:43 +0000 (GMT)
Received: from osiris (unknown [9.145.34.143])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 19:53:43 +0000 (GMT)
Date:   Tue, 26 Apr 2022 21:53:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
Message-ID: <YmhNxnHMe/of4rDD@osiris>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com>
 <YmgsYvWQchxub8cW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmgsYvWQchxub8cW@zn.tnic>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e5Ttc1-K1zi3D9kbUbAUZB-rSO9nhubA
X-Proofpoint-ORIG-GUID: 22ZVrN89OB26N_EjwFeeJmS59Kwfcbpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 07:31:14PM +0200, Borislav Petkov wrote:
> On Tue, Apr 26, 2022 at 03:40:20PM +0200, Juergen Gross wrote:
> > diff --git a/kernel/platform-feature.c b/kernel/platform-feature.c
> > new file mode 100644
> > index 000000000000..2d52f8442cd5
> > --- /dev/null
> > +++ b/kernel/platform-feature.c
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/cache.h>
> > +#include <linux/platform-feature.h>
> > +
> > +unsigned long __read_mostly platform_features[PLATFORM_FEAT_ARRAY_SZ];
> 
> Probably __ro_after_init.
> 
> > +EXPORT_SYMBOL_GPL(platform_features);
> 
> You probably should make that thing static and use only accessors to
> modify it in case you wanna change the underlying data structure in the
> future.

That would add another indirection, which at least I think is not
necessary, and would make it less likely that this infrastructure is
used.
