Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112FB3DA656
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhG2O1S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 10:27:18 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:27995 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhG2O1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 10:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1627568835; x=1659104835;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=vwT+DOuMYN89yAYYRZlirHPMkUhH9iWnZONxGbIjejc=;
  b=HVBbJdoOkAoA1Si2R0HXPbV1yjzOKf4b1Cn1p8BjQyKnMzyS6Sy5Awfd
   odoOffFRDecVbHtv2GYVdP2zAyLF5ls22ZezzUVqGyC/QXK5Q2ukC4OSq
   HE4a59ml3Qz3+4f93I4PLioCTMCj5iqww+HUmc69ckMFN95bH5ccrDE86
   8=;
X-IronPort-AV: E=Sophos;i="5.84,278,1620691200"; 
   d="scan'208";a="128801930"
Subject: Re: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 29 Jul 2021 14:27:07 +0000
Received: from EX13D28EUC003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 11343A1C41;
        Thu, 29 Jul 2021 14:27:03 +0000 (UTC)
Received: from uc8bbc9586ea454.ant.amazon.com (10.43.161.153) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 29 Jul 2021 14:26:58 +0000
Date:   Thu, 29 Jul 2021 16:26:54 +0200
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
Message-ID: <20210729142652.GA25242@uc8bbc9586ea454.ant.amazon.com>
References: <20210729133702.11383-1-sidcha@amazon.de>
 <87eebh9qhd.fsf@vitty.brq.redhat.com>
 <20210729140705.wj5tokeq6lkxm2yy@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729140705.wj5tokeq6lkxm2yy@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.43.161.153]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D28EUC003.ant.amazon.com (10.43.164.43)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 02:07:05PM +0000, Wei Liu wrote:
> On Thu, Jul 29, 2021 at 03:52:46PM +0200, Vitaly Kuznetsov wrote:
> > Siddharth Chandrasekaran <sidcha@amazon.de> writes:
> >
> > > According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
> > > should be defined in the order:
> > >
> > >     message_type, reserved, message_flags, payload_size
> > >
> > > but we have it defined in the order:
> > >
> > >     message_type, payload_size, message_flags, reserved
> > >
> > > that is, the payload_size and reserved members swapped.
> >
> > Indeed,
> >
> > typedef struct
> > {
> >       HV_MESSAGE_TYPE MessageType;
> >       UINT16 Reserved;
> >       HV_MESSAGE_FLAGS MessageFlags;
> >       UINT8 PayloadSize;
> >       union
> >       {
> >               UINT64 OriginationId;
> >               HV_PARTITION_ID Sender;
> >               HV_PORT_ID Port;
> >       };
> > } HV_MESSAGE_HEADER;
> 
> Well. I think TLFS is wrong. Let me ask around.

TBH, I hadn't considered that possibility :). I assumed it was a
regression on our side. But I spent some time tracing the history of that
struct all the way back to when it was in staging (in 2009) and now I'm
inclined to believe a later version of TLFS is at fault here.

Based on what we decide in this thread, I will open an issue on the TLFS
GitHub repository.

~ Sid.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



