Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0783DA981
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhG2Q4r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 12:56:47 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:44613 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhG2Q4q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 12:56:46 -0400
Received: by mail-wm1-f46.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so4502160wmd.3;
        Thu, 29 Jul 2021 09:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAOr1eTi2QbZFnOFfALjz4TbmFhPPA7Bn3lPJeG08eE=;
        b=GgwafQx4+gpsLxU4D8qPW85iEahhD+KpsZPorEOogzi3tiBGJ0WZ0FuSY38Gx5Vls+
         qXdveLl4FvUSPyNnb6j56g6wAhEpLHPcvzNyr/nA5X93jrSIys4aQeh3m18REcJE1gEh
         1/qddAObi+E+XhWHxB6LojxG8rMFx9ZWbqjYlWxVl0rGT0IipI8XA3W0rEswTXhl5hX/
         9iLRQu6FjmjyDcyq408KKkNOcbthwjp1AKAwyuRYK0WU1OkHdWfKlQiztSeZm440oCpk
         tdCNtBgMhlbxcBxXUBD2EcsElNzmSIcPJyGDg7f4z1aPvxMI4hTWalKqJ8suqdwFdoq8
         59CA==
X-Gm-Message-State: AOAM532ZWU1Kz7CNsBfiMs4c8WeTDGh+M8kOQPU+YLr53oEAtkkmiwsr
        csksqtsbVQHLBHi5qbDbdy0=
X-Google-Smtp-Source: ABdhPJyfCfq044i2vz5ul0cBAcnLD2W5dYBIRUnQdt4zr5u4bLe7WSQpPLQIvGhwXP2+rJ3hRrPI9Q==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr15030397wmc.160.1627577800978;
        Thu, 29 Jul 2021 09:56:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p22sm8806377wmq.44.2021.07.29.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:56:40 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
Message-ID: <20210729165638.f5idr2ag3pdbpd6u@liuwe-devbox-debian-v2>
References: <20210729133702.11383-1-sidcha@amazon.de>
 <87eebh9qhd.fsf@vitty.brq.redhat.com>
 <20210729140705.wj5tokeq6lkxm2yy@liuwe-devbox-debian-v2>
 <20210729142652.GA25242@uc8bbc9586ea454.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729142652.GA25242@uc8bbc9586ea454.ant.amazon.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 04:26:54PM +0200, Siddharth Chandrasekaran wrote:
> On Thu, Jul 29, 2021 at 02:07:05PM +0000, Wei Liu wrote:
> > On Thu, Jul 29, 2021 at 03:52:46PM +0200, Vitaly Kuznetsov wrote:
> > > Siddharth Chandrasekaran <sidcha@amazon.de> writes:
> > >
> > > > According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
> > > > should be defined in the order:
> > > >
> > > >     message_type, reserved, message_flags, payload_size
> > > >
> > > > but we have it defined in the order:
> > > >
> > > >     message_type, payload_size, message_flags, reserved
> > > >
> > > > that is, the payload_size and reserved members swapped.
> > >
> > > Indeed,
> > >
> > > typedef struct
> > > {
> > >       HV_MESSAGE_TYPE MessageType;
> > >       UINT16 Reserved;
> > >       HV_MESSAGE_FLAGS MessageFlags;
> > >       UINT8 PayloadSize;
> > >       union
> > >       {
> > >               UINT64 OriginationId;
> > >               HV_PARTITION_ID Sender;
> > >               HV_PORT_ID Port;
> > >       };
> > > } HV_MESSAGE_HEADER;
> > 
> > Well. I think TLFS is wrong. Let me ask around.
> 
> TBH, I hadn't considered that possibility :). I assumed it was a
> regression on our side. But I spent some time tracing the history of that
> struct all the way back to when it was in staging (in 2009) and now I'm
> inclined to believe a later version of TLFS is at fault here.
> 
> Based on what we decide in this thread, I will open an issue on the TLFS
> GitHub repository.
> 

I have confirmation TLFS is wrong and shall be fixed. Feel free to open
an issue on GitHub too.

Wei.
