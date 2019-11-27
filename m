Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5810B14A
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2019 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK0O2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 27 Nov 2019 09:28:41 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35472 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0O2l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 09:28:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7443F6058360;
        Wed, 27 Nov 2019 15:28:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TlatcLpTclcL; Wed, 27 Nov 2019 15:28:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1FEB8605A912;
        Wed, 27 Nov 2019 15:28:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FvQWTClmKLzL; Wed, 27 Nov 2019 15:28:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E98146058360;
        Wed, 27 Nov 2019 15:28:37 +0100 (CET)
Date:   Wed, 27 Nov 2019 15:28:37 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     tavi purdila <tavi.purdila@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>,
        linux-um <linux-um@lists.infradead.org>,
        retrage01 <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        pscollins <pscollins@google.com>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        liuyuan <liuyuan@google.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <48783237.99334.1574864917843.JavaMail.zimbra@nod.at>
In-Reply-To: <m2wobmq7v8.wl-thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com> <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at> <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net> <243342257.98153.1574762974057.JavaMail.zimbra@nod.at> <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net> <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com> <293078386.98317.1574784295793.JavaMail.zimbra@nod.at> <m2wobmq7v8.wl-thehajime@gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: lkl tools: host lib: virtio devices
Thread-Index: vsG9rMhagKP3M5YFcBzxoH42Dsol8w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
>> Can you please point out a little further why UML's net or block drivers
>> are not usable for LKL?
> 
> I think we can do it (but need to check).
> 
> LKL may use UML's drivers, and UML can also use LKL's devices/drivers
> (as my 36/37 and 37/37 patches do, though the patches has no careful
> consideration on IRQ handling).

Of course. So please don't get me wrong, I don't want LKL to become
UML. I hope that UML can also benefit from LKL.

Thanks,
//richard
