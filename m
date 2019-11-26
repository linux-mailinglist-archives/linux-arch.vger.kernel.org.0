Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D910A1AF
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 17:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfKZQCR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 26 Nov 2019 11:02:17 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47246 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfKZQCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 11:02:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C138760A073C;
        Tue, 26 Nov 2019 17:02:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f34gkYDE1roQ; Tue, 26 Nov 2019 17:02:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C5044607BD95;
        Tue, 26 Nov 2019 17:02:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X44XAjAkgYcv; Tue, 26 Nov 2019 17:02:12 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7FC1062EBCAB;
        Tue, 26 Nov 2019 17:02:12 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:02:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        pscollins <pscollins@google.com>, levex <levex@linux.com>,
        mattator <mattator@gmail.com>, cem <cem@freebsd.org>,
        tavi purdila <tavi.purdila@gmail.com>,
        staal1978 <staal1978@gmail.com>, motomuman <motomuman@gmail.com>,
        jiangshanlai <jiangshanlai@gmail.com>,
        retrage01 <retrage01@gmail.com>, petrosagg <petrosagg@gmail.com>,
        liuyuan <liuyuan@google.com>, xiaoj <xiaoj@google.com>,
        mark <mark@stillwell.me>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        phh <phh@phh.me>, sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        luca dariz <luca.dariz@gmail.com>,
        edisonmcastro <edisonmcastro@hotmail.com>
Message-ID: <907430042.98310.1574784132348.JavaMail.zimbra@nod.at>
In-Reply-To: <m2v9r6iux5.wl-thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com> <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com> <CAFLxGvw+w+xmput3xMjKPXPn4hj9opbo+gtV6896hhzDUzQNiA@mail.gmail.com> <m2v9r6iux5.wl-thehajime@gmail.com>
Subject: Re: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel
 library
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: architecture skeleton for Linux kernel library
Thread-Index: lvbtPMSot5jWCgVHtFQyj94K0JHInQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Hajime Tazaki" <thehajime@gmail.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-arch" <linux-arch@vger.kernel.org>, "pscollins"
> <pscollins@google.com>, "levex" <levex@linux.com>, "mattator" <mattator@gmail.com>, "cem" <cem@freebsd.org>, "tavi
> purdila" <tavi.purdila@gmail.com>, "staal1978" <staal1978@gmail.com>, "motomuman" <motomuman@gmail.com>, "jiangshanlai"
> <jiangshanlai@gmail.com>, "retrage01" <retrage01@gmail.com>, "petrosagg" <petrosagg@gmail.com>, "liuyuan"
> <liuyuan@google.com>, "xiaoj" <xiaoj@google.com>, "mark" <mark@stillwell.me>, "linux-kernel-library"
> <linux-kernel-library@freelists.org>, "phh" <phh@phh.me>, "sigmaepsilon92" <sigmaepsilon92@gmail.com>, "luca dariz"
> <luca.dariz@gmail.com>, "edisonmcastro" <edisonmcastro@hotmail.com>
> Gesendet: Dienstag, 26. November 2019 15:17:26
> Betreff: Re: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel library

> On Tue, 26 Nov 2019 07:00:33 +0900,
> Richard Weinberger wrote:
>> 
> (snip)
>> >
>> > Signed-off-by: Andreas Abel <aabel@google.com>
>> > Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
>> > Signed-off-by: Edison M. Castro <edisonmcastro@hotmail.com>
>> > Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
>> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
>> > Signed-off-by: Jens Staal <staal1978@gmail.com>
>> > Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
>> > Signed-off-by: Levente Kurusa <levex@linux.com>
>> > Signed-off-by: Luca Dariz <luca.dariz@gmail.com>
>> > Signed-off-by: Mark Stillwell <mark@stillwell.me>
>> > Signed-off-by: Matthieu Coudron <mattator@gmail.com>
>> > Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
>> > Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
>> > Signed-off-by: Patrick Collins <pscollins@google.com>
>> > Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
>> > Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
>> > Signed-off-by: Xiao Jia <xiaoj@google.com>
>> > Signed-off-by: Yuan Liu <liuyuan@google.com>
>> > Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
>> 
>> Can we please have this chain cleaned up?
>> Please see process/submitting-patches.rst.
> 
> Do you mean "this chain" by the long list of Signed-off-by lines, or
> something else ?

The long list is rather unusual.
 
> We were trying to put all of contributors on the list.  I was failed to
> interpret process/submitting-patches.rst on which part is not appropriate.

If every contributor is also a Co-Author. Okay. But having such a long
list of authors is still a little odd.

Thanks,
//richard
