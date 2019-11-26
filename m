Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6E109A85
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfKZIua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 26 Nov 2019 03:50:30 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:41160 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfKZIua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 03:50:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CA22D6058361;
        Tue, 26 Nov 2019 09:50:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nmmVOUxEIDAe; Tue, 26 Nov 2019 09:50:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3A2796083137;
        Tue, 26 Nov 2019 09:50:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sAE3L2lO1OQI; Tue, 26 Nov 2019 09:50:26 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 02A406058361;
        Tue, 26 Nov 2019 09:50:25 +0100 (CET)
Date:   Tue, 26 Nov 2019 09:50:25 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>,
        tavi purdila <tavi.purdila@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        retrage01 <retrage01@gmail.com>,
        linux-kernel-library@freelists.org,
        pscollins <pscollins@google.com>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        liuyuan <liuyuan@google.com>
Message-ID: <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
In-Reply-To: <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
References: <cover.1573179553.git.thehajime@gmail.com> <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com> <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com> <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: lkl tools: host lib: virtio devices
Thread-Index: MSw2wTWhPSRSQKoe6IhqCb8SZu2Bxw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "Hajime Tazaki" <thehajime@gmail.com>
> CC: "linux-arch" <linux-arch@vger.kernel.org>, "cem" <cem@freebsd.org>, "tavi purdila" <tavi.purdila@gmail.com>,
> "linux-um" <linux-um@lists.infradead.org>, "retrage01" <retrage01@gmail.com>, linux-kernel-library@freelists.org,
> "pscollins" <pscollins@google.com>, "sigmaepsilon92" <sigmaepsilon92@gmail.com>, "liuyuan" <liuyuan@google.com>
> Gesendet: Dienstag, 26. November 2019 09:43:36
> Betreff: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices

> On Mon, 2019-11-25 at 23:07 +0100, Richard Weinberger wrote:
>> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>> > From: Octavian Purdila <tavi.purdila@gmail.com>
>> > 
>> > Add helpers for implementing host virtio devices. It uses the memory
>> > mapped I/O helpers to interact with the Linux MMIO virtio transport
>> > driver and offers support to setup and add a new virtio device,
>> > dispatch requests from the incoming queues as well as support for
>> > completing requests.
>> > 
>> > All added virtio devices are stored in lkl_virtio_devs as strings, per
>> > the Linux MMIO virtio transport driver command line specification.
>> 
>> Did you checkout arch/um/drivers/virtio_uml.c?
>> Why is this driver needed?
> 
> This isn't really a driver, this is virtio *device-side* code. Our
> virtio_uml is *guest-side* code, and only speaks vhost-user.

Sorry, bad wording from my side. I meant with "driver" a kernel component.
 
> I'm not sure how MMIO devices could possibly work though, does LKL
> intercept MMIO somehow?

My point is that UML and LKL should try to do use the same concept/code
regarding virtio. At the end of day both use virtual devices which use
facilities from the host.
If this is really not possible it needs a good explanation.

Thanks,
//richard
