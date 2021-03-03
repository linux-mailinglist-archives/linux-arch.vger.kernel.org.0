Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15B32C865
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbhCDAtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:18 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:57126 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577095AbhCCRsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Mar 2021 12:48:07 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 12:48:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1566; q=dns/txt; s=iport;
  t=1614793686; x=1616003286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwSDExt/4yEwWWICTamnjrNRGaKwzVnKFGtN23ZY2jQ=;
  b=QCRRa7IJKmkboQ6L8eCUHhCwrWLyQCErEraRlf3v6sqF73x6Y3ohBw4D
   12hyfJO0jH42m1WsrXVNWqOwRLrg9MxBvc2LBtYhsMdD77SVBYxAeP/5o
   E0Pg4H4/6kjf4LtvCexZ8HqF5/ubGA6+jMq/RC5SXwsELxpw84zcTX8gT
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BKAwCgyD9g/5BdJa1iHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+CK3ZWATkxlh2PehaMOwsBAQENAQEkEAQBAYRNAoF6AiU?=
 =?us-ascii?q?4EwIDAQELAQEFAQEBAgEGBHGFYQ2GRQEFOj8QCxIGLjwNDgYTG4JWgwcPrUV?=
 =?us-ascii?q?0gTSEPwGEX4E+BiKBFo1DJhyBSUKEKz6KMwSCRoE7gnSQS4JLii2be4MGgR+?=
 =?us-ascii?q?IIJJSMRCDJ4pPlVCgEpZgAgQGBQIWgWsjgVczGggbFYMkHzEZDZcihWYgAy8?=
 =?us-ascii?q?4AgYKAQEDCYwTAQE?=
X-IronPort-AV: E=Sophos;i="5.81,220,1610409600"; 
   d="scan'208";a="598970073"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 03 Mar 2021 17:39:14 +0000
Received: from zorba ([10.24.1.194])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 123Hd88Y022034
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Mar 2021 17:39:12 GMT
Date:   Wed, 3 Mar 2021 09:39:08 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/7] Improve boot command line handling
Message-ID: <20210303173908.GG109100@zorba>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <20210302173523.GE109100@zorba>
 <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
X-Outbound-SMTP-Client: 10.24.1.194, [10.24.1.194]
X-Outbound-Node: rcdn-core-8.cisco.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 08:01:01PM -0600, Rob Herring wrote:
> +Will D
> 
> On Tue, Mar 2, 2021 at 11:36 AM Daniel Walker <danielwa@cisco.com> wrote:
> >
> > On Tue, Mar 02, 2021 at 05:25:16PM +0000, Christophe Leroy wrote:
> > > The purpose of this series is to improve and enhance the
> > > handling of kernel boot arguments.
> > >
> > > It is first focussed on powerpc but also extends the capability
> > > for other arches.
> > >
> > > This is based on suggestion from Daniel Walker <danielwa@cisco.com>
> > >
> >
> >
> > I don't see a point in your changes at this time. My changes are much more
> > mature, and you changes don't really make improvements.
> 
> Not really a helpful comment. What we merge here will be from whomever
> is persistent and timely in their efforts. But please, work together
> on a common solution.
> 
> This one meets my requirements of moving the kconfig and code out of
> the arches, supports prepend/append, and is up to date.


Maintainers are capable of merging whatever they want to merge. However, I
wouldn't make hasty choices. The changes I've been submitting have been deployed
on millions of router instances and are more feature rich.

I believe I worked with you on this change, or something like it,

https://lkml.org/lkml/2019/3/19/970

I don't think Christophe has even addressed this. I've converted many
architectures, and Cisco uses my changes on at least 4 different
architecture. With products deployed and tested.

I will resubmit my changes as soon as I can.

Daniel
