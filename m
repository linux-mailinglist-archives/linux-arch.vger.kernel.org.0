Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00658109C20
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 11:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKZKQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 05:16:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:40528 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfKZKQ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 05:16:57 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iZXtu-00B9G2-Qu; Tue, 26 Nov 2019 11:16:54 +0100
Message-ID: <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>,
        tavi purdila <tavi.purdila@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        retrage01 <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        pscollins <pscollins@google.com>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        liuyuan <liuyuan@google.com>
Date:   Tue, 26 Nov 2019 11:16:53 +0100
In-Reply-To: <243342257.98153.1574762974057.JavaMail.zimbra@nod.at>
References: <cover.1573179553.git.thehajime@gmail.com>
         <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
         <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
         <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
         <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
         <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
         <243342257.98153.1574762974057.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-11-26 at 11:09 +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > > My point is that UML and LKL should try to do use the same concept/code
> > > regarding virtio. At the end of day both use virtual devices which use
> > > facilities from the host.
> > > If this is really not possible it needs a good explanation.
> > 
> > I think it isn't possible, unless you use vhost-user over a unix domain
> > socket internally to talk between the kernel (virtio_uml) and hypervisor
> > (device) components.
> > 
> > In virtio_uml, the device implementation is assumed to be a separate
> > process with a vhost-user connection. Here in LKL, the virtio device is
> > part of the "hypervisor", i.e. in the same process.
> 
> Exactly, currently UML and LKL solve same things differently, but do we need to?

It's not the same thing though :-)

UML right now doesn't have or support virtio devices in the built-in
hypervisor, what we wanted to use virtio for was explicitly for the
vhost-user devices.

LKL clearly wants to have device implementations in the hypervisor,
perhaps for networking or console etc.? That _might_ be useful since it
makes the device implementation more general, unlike the UML approach
where all devices come with a kernel- and user-side and are special
drivers in the kernel, vs. general virtio drivers.

Now, arguably, since UML has all these already a combined UML/LKL
doesn't actually *need* any virtio devices, since all (or at least most)
of the things that could be covered by virtio today are already covered
by UML devices (block, net, console, random).

I'd probably say then that this can be removed from an initial "minimum
viable product" of LKL, since once merged with UML you get the devices
from that. Later, we could decide that UML devices actually are better
done as virtio, and support something like this.

johannes

