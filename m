Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C1510951
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354289AbiDZTzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354278AbiDZTzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 15:55:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D76B09C;
        Tue, 26 Apr 2022 12:51:54 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QJkQTs009986;
        Tue, 26 Apr 2022 19:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=T7bjvQ3BcrN7Z6h9Fc26vG+y3bdOGAaPUHj4pY8LJ6g=;
 b=QeOf0hyzkXYEwHLGJeMuxaoU0I2z5QQl1+8yQ4GSOYpEz5DjVDEJ5fb5ZOnyoQYxtAE3
 PCCpMW+rY0ABr25y3jvM5Ui4chmZPzyrlHB23ylD2cFNe1RQEniJQsxu5MP7u4U9L7HU
 ooxYy1CtyntH96ekCadJEhrl3bMjIOLx79gQwSU3sZxh0NlNLyY6XLIsM/7liWm9LM0g
 p5oASzZjl7hA3sw7QYuw/sVTffwcdD5mCLVPGSjBSIc/fNoDWnI+kliGBCbNh0YwpZGX
 UKjnrIE19mrpMvNv2iTk6D3YobHaKqSKQKGzZxv/81fycEyJDdApP7p/udYx7z0LVpia Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpq6e82kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:51:27 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QJm8dW021744;
        Tue, 26 Apr 2022 19:51:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpq6e82kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:51:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QJo8mP006577;
        Tue, 26 Apr 2022 19:51:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938vvdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 19:51:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QJcJDq48038304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 19:38:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D2111C050;
        Tue, 26 Apr 2022 19:51:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F97E11C04C;
        Tue, 26 Apr 2022 19:51:20 +0000 (GMT)
Received: from osiris (unknown [9.145.34.143])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 19:51:20 +0000 (GMT)
Date:   Tue, 26 Apr 2022 21:51:18 +0200
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
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Message-ID: <YmhNNrLW+tM2gnZB@osiris>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com>
 <Ymgtb2dSNYz7DBqx@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymgtb2dSNYz7DBqx@zn.tnic>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q9gEbp0-esGpLxC7emUANKdeJL4GNy7u
X-Proofpoint-ORIG-GUID: ikyLc1vizVQ4dnq38vPU_YoCIQAl4_o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_06,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=648
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204260123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 07:35:43PM +0200, Borislav Petkov wrote:
> On Tue, Apr 26, 2022 at 03:40:21PM +0200, Juergen Gross wrote:
> >  /* protected virtualization */
> >  static void pv_init(void)
> >  {
> >  	if (!is_prot_virt_guest())
> >  		return;
> >  
> > +	platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> 
> Kinda long-ish for my taste. I'll probably call it:
> 
> 	platform_set()
> 
> as it is implicit that it sets a feature bit.

...and platform_clear(), instead of platform_reset_feature() please.

> In any case, yeah, looks ok at a quick glance. It would obviously need
> for more people to look at it and say whether it makes sense to them and
> whether that's fine to have in generic code but so far, the experience
> with cc_platform_* says that it seems to work ok in generic code.

We _could_ convert s390's machine flags to this mechanism. Those flags
are historically per-cpu, but if I'm not mistaken none of them is
performance critical anymore, and those who are could/should probably
transformed to jump labels or alternatives anyway.
