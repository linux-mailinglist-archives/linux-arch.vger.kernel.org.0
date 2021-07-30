Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3175E3DB61C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbhG3JgU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 05:36:20 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:1163 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhG3JgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 05:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1627637775; x=1659173775;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=cP+JhXq5Nalma4gVWY0bx4G6vVp3XZYSMJqhpGkBToc=;
  b=K4gWx3xuRC3u6e1IWMd6ov2gCBbM/JIXwaZWvjVbQTQHkJonXCWpZrP+
   m/bZod786THzGvnNdTguEd7hfePQhHrmIp10CA5T9xS374lPb+YQllFN7
   tlbqDf3iWxROXLmJbdto07yNgS+u4wQ8g20duNVwUqIQQ16TAWQJRr09k
   E=;
X-IronPort-AV: E=Sophos;i="5.84,281,1620691200"; 
   d="scan'208";a="15928374"
Subject: Re: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 30 Jul 2021 09:36:07 +0000
Received: from EX13D28EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id D6F42A2241;
        Fri, 30 Jul 2021 09:36:06 +0000 (UTC)
Received: from u366d62d47e3651.ant.amazon.com (10.43.160.85) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Fri, 30 Jul 2021 09:36:01 +0000
Date:   Fri, 30 Jul 2021 11:35:57 +0200
From:   Siddharth Chandrasekaran <sidcha@amazon.de>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        <linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20210730091649.GA13442@u366d62d47e3651.ant.amazon.com>
References: <20210729133702.11383-1-sidcha@amazon.de>
 <87eebh9qhd.fsf@vitty.brq.redhat.com>
 <20210729140705.wj5tokeq6lkxm2yy@liuwe-devbox-debian-v2>
 <20210729142652.GA25242@uc8bbc9586ea454.ant.amazon.com>
 <20210729165638.f5idr2ag3pdbpd6u@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729165638.f5idr2ag3pdbpd6u@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.43.160.85]
X-ClientProxiedBy: EX13D38UWC001.ant.amazon.com (10.43.162.170) To
 EX13D28EUC003.ant.amazon.com (10.43.164.43)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 04:56:38PM +0000, Wei Liu wrote:
> On Thu, Jul 29, 2021 at 04:26:54PM +0200, Siddharth Chandrasekaran wrote:
> > On Thu, Jul 29, 2021 at 02:07:05PM +0000, Wei Liu wrote:
> > > On Thu, Jul 29, 2021 at 03:52:46PM +0200, Vitaly Kuznetsov wrote:
> > > > Siddharth Chandrasekaran <sidcha@amazon.de> writes:
> > > >
> > > > > According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
> > > > > should be defined in the order:
> > > > >
> > > > >     message_type, reserved, message_flags, payload_size
> > > > >
> > > > > but we have it defined in the order:
> > > > >
> > > > >     message_type, payload_size, message_flags, reserved
> > > > >
> > > > > that is, the payload_size and reserved members swapped.
> > > >
> > > > Indeed,
> > > >
> > > > typedef struct
> > > > {
> > > >       HV_MESSAGE_TYPE MessageType;
> > > >       UINT16 Reserved;
> > > >       HV_MESSAGE_FLAGS MessageFlags;
> > > >       UINT8 PayloadSize;
> > > >       union
> > > >       {
> > > >               UINT64 OriginationId;
> > > >               HV_PARTITION_ID Sender;
> > > >               HV_PORT_ID Port;
> > > >       };
> > > > } HV_MESSAGE_HEADER;
> > >
> > > Well. I think TLFS is wrong. Let me ask around.
> >
> > TBH, I hadn't considered that possibility :). I assumed it was a
> > regression on our side. But I spent some time tracing the history of that
> > struct all the way back to when it was in staging (in 2009) and now I'm
> > inclined to believe a later version of TLFS is at fault here.
> >
> > Based on what we decide in this thread, I will open an issue on the TLFS
> > GitHub repository.
> >
> 
> I have confirmation TLFS is wrong and shall be fixed. Feel free to open
> an issue on GitHub too.

Thanks for the confirmation, I created an issue [1] to track this.

~ Sid.

[1]: https://github.com/MicrosoftDocs/Virtualization-Documentation/issues/1624



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



