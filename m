Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686E74264F1
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJHG5d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHG5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 02:57:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC49C061570;
        Thu,  7 Oct 2021 23:55:38 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h10so1935421ilq.3;
        Thu, 07 Oct 2021 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKGevevwONOfIKEa+OiDyyhkmEnPcm0iFc2htm5Lyqo=;
        b=KY7t4NxXJ7OR5s4ckAMJVIk+YHAkgxTX+aS9RgzyIlZd+Nzo/K5k9ht8INPm5qPzoc
         bsQ/GdczcZjT/MYvVx3xAi2tMtkc2kHzMHi6g84s+psg6550HrfrdDaLJIYq7FruMVER
         0iAg523ho1kqqdfZPnb46XuWS8zrJXUY8iAMVBFl9jFZNpR5HPfnp7OhzM2ln8AzwXCl
         W0MMS8qM5aSlKiGi6pu5kvE0tIlAF7jHYMXr0cYFss9K0IF5o82B6DTTrR6wgdKZqa3x
         4R/dyhIi+C/MB486nhMpbN85lvgUfT3ctGu6MJais+xieiPhfu5L0nkmIWsYrpb1adlv
         9CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKGevevwONOfIKEa+OiDyyhkmEnPcm0iFc2htm5Lyqo=;
        b=NycZHj25pP9vdr8fQqxUqYFMKzC2WTQT3+m1zsfnmxaPaXs/ZgLK9sST1HN6Z8trlp
         wTd9tXvoG0QgdMLY9xWDmXk6iX9/xGBSM0VM5/ENUMegB/EtU3fR907LCE+7usJq9vWJ
         MseMqWtrnnwZlYDYq8dh/RMv5FToom79m3CFkptIfWeHvQLdOEM/sPVN2YP59ewXZUs3
         WgNX9mAjPUijw3CRVXDGiYnwtvNMWVJ84Ra6s5VaoX2l+heVkDp34/9zYg4lZDIcELgm
         wTAuLixNRG7zwy8QWxWKHbDbxDNnzQNar8ndBC5ojpr7z5Behwb02Ma2tMvKP8X4hL/2
         f9lA==
X-Gm-Message-State: AOAM5327RxWRBXZubIavCKXXimjGwadmSHlzKVTwiS3r7Z7nM7I5dK2z
        ARuhHKTybLgYPDwMNyV0ruI=
X-Google-Smtp-Source: ABdhPJxmdQ8XgFiTrMR+NfTVlVHnwmn+qpQEgA9QKSfK0VT6t2OfxD5oxisPAZvNb9Kd6/u+h15mMw==
X-Received: by 2002:a05:6e02:1b07:: with SMTP id i7mr6893330ilv.63.1633676137691;
        Thu, 07 Oct 2021 23:55:37 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k5sm606991ioc.7.2021.10.07.23.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 23:55:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 24F1927C0054;
        Fri,  8 Oct 2021 02:55:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Oct 2021 02:55:35 -0400
X-ME-Sender: <xms:Y-tfYRepBgxCNnShVcPP4z2sYcFQPlnAGuG8i9jtqNkRQJxGJ9BMmA>
    <xme:Y-tfYfPE6jVZN-YQHQXBjcD-mujAJUol53lOf__IZmtcRVJSMyrelhS1V8jxoAhxE
    pI_whhAaXFgjnyKSw>
X-ME-Received: <xmr:Y-tfYaiFTCO7O4AprFZLgIoG6qOyi3_rhhVv-ayxofUMDq8xxl_WcEfSBg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudelledguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfeg
    vdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Y-tfYa9EbfPTE0rKYAcDhFOkxmucqYL4OInoKEK1gfy2bduiu-WDfg>
    <xmx:Y-tfYds80yAMfGf42B_F-gWHC3bkWinWA4StVeKGwsEb7xWUG6GE_g>
    <xmx:Y-tfYZFHaEcHhAMygQy41DLfXjoDHoZy2I-IKThAhkd497IAdrPrNw>
    <xmx:ZutfYRRTB6Xgps-nWi10Ozy_Mwxsi1ZhqEOUh5NloA9LsPMUT_MCKjob6QI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Oct 2021 02:55:31 -0400 (EDT)
Date:   Fri, 8 Oct 2021 14:54:23 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
Message-ID: <YV/rH0TeokccdbMD@boqun-archlinux>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <YVZiGdWXfbsHs2xa@boqun-archlinux>
 <878rz4nkw2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rz4nkw2.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 04:30:37PM +1100, Michael Ellerman wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> > (Add linux-arch in Cc list)
> >
> > Architecture maintainers, this patch is about strengthening our memory
> > model a little bit, your inputs (confirmation, ack/nack, etc.) are
> > appreciated.
> 
> Hi Boqun,
> 
> I don't feel like I'm really qualified to give an ack here, you and the
> other memory model folk know this stuff much better than me.
> 
> But I have reviewed it and it matches my understanding of how our
> barriers work, so it looks OK to me.
> 
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 

Thanks!

Regards,
Boqun

> cheers
