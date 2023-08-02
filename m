Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFB76C780
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHBHxh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjHBHxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 03:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE73AA7;
        Wed,  2 Aug 2023 00:51:00 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3727efrU023604;
        Wed, 2 Aug 2023 07:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WUG9XLUVxLD7YIOS1nqOLP6cSeDLTC0hGYP99dM8eH0=;
 b=bM5ub1zz1WkYeipfcRZrFYrWldGUj2gfIAAKnMOEOACR5ozS4+lO+fWTth6HVudw4u8/
 eCi6uTohMkcnFfIEORufE4EG04WbZaLgky2xu6RY8UlvqpTrDLsI0Hop9SvyIvMGLaIE
 a3kKq43chLqb6Y/XkmK7h4Ah9XVmC4wkE0yO6OIK3WW0kfO/kf6x8W2PeNql4lUBurBs
 rru86ne+R8yAeH0RRZ4xfR8ZhU7UbGRiZ2UoQgbhDytfBOp6+6Q5C5ds6rZ2t9Oa82na
 3XPFxNHBvpK2S5IaH+1nkDi87xqguPKWUU5qzgqKSv4XqLOiaA4QyY+PITG1VDW+Linr YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7jtbgb28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 07:50:47 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3727okDX028336;
        Wed, 2 Aug 2023 07:50:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7jtbgb1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 07:50:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3725lVkV017127;
        Wed, 2 Aug 2023 07:50:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fajt96q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 07:50:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3727ogS439584194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 07:50:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF9B20043;
        Wed,  2 Aug 2023 07:50:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53D6E20040;
        Wed,  2 Aug 2023 07:50:42 +0000 (GMT)
Received: from osiris (unknown [9.152.212.233])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Aug 2023 07:50:42 +0000 (GMT)
Date:   Wed, 2 Aug 2023 09:50:41 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
Message-ID: <20230802075041.6227-A-hca@linux.ibm.com>
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
 <847747a8-b773-4b7b-8c14-b8ef4ba7c022@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847747a8-b773-4b7b-8c14-b8ef4ba7c022@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mHE9DXdOLlfh0U8erF_iRnnf87LWW2mN
X-Proofpoint-ORIG-GUID: nV5PTDj8_7vOlCsetG4JPZrIcfMJb1U7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=579 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 02, 2023 at 07:59:48AM +0200, Arnd Bergmann wrote:
> On Wed, Aug 2, 2023, at 03:07, Linus Torvalds wrote:
> > On Tue, 1 Aug 2023 at 15:22, <ndesaulniers@google.com> wrote:
> 
> > Who ends up being affected by this? Powerpc does its own
> > word-at-a-time thing because the big-endian case is nasty and you can
> > do better with special instructions that they have.
> 
> powerpc needs the same patch though.
> 
> > Who else is even BE any more? Some old 32-bit arm setup?
> >
> > I think the patch is fine, but I guess I'd like to know that people
> > who are affected actually don't see any code generation changes (or
> > possibly see improvements from not turning it into a bool until later)
> 
> s390 is the main one here, maintainers added to Cc.

The generated code on s390 is identical with and without the patch
using gcc 13.2.
So this looks fine from my point of view.
