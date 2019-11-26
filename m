Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71905109C71
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfKZKmN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 05:42:13 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33650 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfKZKmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 05:42:13 -0500
Received: by mail-il1-f196.google.com with SMTP id y16so9648437iln.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 02:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rN6hX6UIjkl8mKnhvYVMUGoWOFAsS2VHV71TXTPM2vo=;
        b=Zk004bV+gDdINhUAPo/QYLfqW8JAsP0+o2D+/aIIaFG9bRG3iLBdg6TWVDbCMV/4x0
         SdM04MKuXZvvxo+nnW6EO3avMym/FHAshOgWXjKqEEcmHwvo3+SaiZXEin9vSTvfSkpC
         RrU0BJruUC9ngDYhLQfORzXUuEyUr3CVxPJGXoekNujKvpu1g359r+90WNFCC7hra+SD
         HPGoTv6e2WuzqI5f8DlE3nUAph/RKxsZ6hm8cnxWvQrDxsvlxj87Cu0Q7TWPdxMI4vKa
         QwbPrqM5uXyqYeXpaPWV+8GMMhpiSAIsNlJqlzSuNUZW9cfz8N1rOc88SsseRuzzWOrY
         Bydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rN6hX6UIjkl8mKnhvYVMUGoWOFAsS2VHV71TXTPM2vo=;
        b=GsovoKSqlQUVplJNiD1eG9HIkS1sVBL58E9vloOTlyy8ZyRXKTL0DLOOni08jGVrjR
         ESnrdbaGbElBaRcFfBWieoqgvYPbr4zBik3kfmsyDdZsfSvPHpVm93jZuCUzh+XnBHK9
         lhdnQCADLXmmXmLUZd7Drnea2lyu4BGSP2QZb9GrKk+oCK3Cpj5jQFQdeYy6dQVOA57u
         i0XNI/bJe/oBn5O7FYZANLvRsFzF9WT7eU0E/bkei7Geowq9NCkECMje0JmNCE1nQ3wv
         EGsCMw4h1BHmwgju929uHQ03mWJP/cvzd/QsZ6WrcefVgVDK/MUE9Lra8wMBtslH5w5j
         sbCA==
X-Gm-Message-State: APjAAAXYbT2pXiYr2LVcHtKSGBvcbkRysov8yYWHc/O0msXVk6pA2EPM
        xblL5t7zMgFnJyvnL9n1hKqS87Wc7o4tYp2ARL4=
X-Google-Smtp-Source: APXvYqyQya69iSRzRbLuF1WUpS4hv5vVxVYiP+KmiRMWUXYyArus5JFA4f+UsqIrqPibXeBwsCj6xubh/MocwJCtCXA=
X-Received: by 2002:a92:8108:: with SMTP id e8mr37510102ild.209.1574764932547;
 Tue, 26 Nov 2019 02:42:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
 <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
 <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
 <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at> <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
 <243342257.98153.1574762974057.JavaMail.zimbra@nod.at> <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net>
In-Reply-To: <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Tue, 26 Nov 2019 12:42:01 +0200
Message-ID: <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Richard Weinberger <richard@nod.at>,
        Hajime Tazaki <thehajime@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>,
        linux-um <linux-um@lists.infradead.org>,
        retrage01 <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        pscollins <pscollins@google.com>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        liuyuan <liuyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 26, 2019 at 12:16 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2019-11-26 at 11:09 +0100, Richard Weinberger wrote:
> > ----- Urspr=C3=BCngliche Mail -----
> > > > My point is that UML and LKL should try to do use the same concept/=
code
> > > > regarding virtio. At the end of day both use virtual devices which =
use
> > > > facilities from the host.
> > > > If this is really not possible it needs a good explanation.
> > >
> > > I think it isn't possible, unless you use vhost-user over a unix doma=
in
> > > socket internally to talk between the kernel (virtio_uml) and hypervi=
sor
> > > (device) components.
> > >
> > > In virtio_uml, the device implementation is assumed to be a separate
> > > process with a vhost-user connection. Here in LKL, the virtio device =
is
> > > part of the "hypervisor", i.e. in the same process.
> >
> > Exactly, currently UML and LKL solve same things differently, but do we=
 need to?
>
> It's not the same thing though :-)
>
> UML right now doesn't have or support virtio devices in the built-in
> hypervisor, what we wanted to use virtio for was explicitly for the
> vhost-user devices.
>
> LKL clearly wants to have device implementations in the hypervisor,
> perhaps for networking or console etc.? That _might_ be useful since it
> makes the device implementation more general, unlike the UML approach
> where all devices come with a kernel- and user-side and are special
> drivers in the kernel, vs. general virtio drivers.
>

That is correct. Initially we used the same UML model, with dedicated
drivers for LKL, and later switched to using the built-in virtio
drivers (so far for network and block devices).

> Now, arguably, since UML has all these already a combined UML/LKL
> doesn't actually *need* any virtio devices, since all (or at least most)
> of the things that could be covered by virtio today are already covered
> by UML devices (block, net, console, random).
>
> I'd probably say then that this can be removed from an initial "minimum
> viable product" of LKL, since once merged with UML you get the devices
> from that. Later, we could decide that UML devices actually are better
> done as virtio, and support something like this.
>

I agree, I think it make sense to drop these since the problem of
dedicated vs generic / virtio drivers are orthogonal with regard to
UML and LKL unification and can later be worked on.
