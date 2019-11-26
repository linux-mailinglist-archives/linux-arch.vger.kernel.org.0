Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3815109A5D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 09:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKZInq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 03:43:46 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:39184 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKZInp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 03:43:45 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iZWRg-00AxG9-G8; Tue, 26 Nov 2019 09:43:40 +0100
Message-ID: <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Hajime Tazaki <thehajime@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Conrad Meyer <cem@freebsd.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org,
        Patrick Collins <pscollins@google.com>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Yuan Liu <liuyuan@google.com>
Date:   Tue, 26 Nov 2019 09:43:36 +0100
In-Reply-To: <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
         <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
         <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-11-25 at 23:07 +0100, Richard Weinberger wrote:
> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> > 
> > Add helpers for implementing host virtio devices. It uses the memory
> > mapped I/O helpers to interact with the Linux MMIO virtio transport
> > driver and offers support to setup and add a new virtio device,
> > dispatch requests from the incoming queues as well as support for
> > completing requests.
> > 
> > All added virtio devices are stored in lkl_virtio_devs as strings, per
> > the Linux MMIO virtio transport driver command line specification.
> 
> Did you checkout arch/um/drivers/virtio_uml.c?
> Why is this driver needed?

This isn't really a driver, this is virtio *device-side* code. Our
virtio_uml is *guest-side* code, and only speaks vhost-user.

I'm not sure how MMIO devices could possibly work though, does LKL
intercept MMIO somehow?

johannes


