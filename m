Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDEC4281F2
	for <lists+linux-arch@lfdr.de>; Sun, 10 Oct 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhJJOgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Oct 2021 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhJJOgY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Oct 2021 10:36:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90CC061570;
        Sun, 10 Oct 2021 07:34:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b10so1783049iof.12;
        Sun, 10 Oct 2021 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzsW4oaRYWh/PSqb1gGOzEnZWrkrc4WMPo9eaQRhBrU=;
        b=fZWwjrQSPxBuf44Hgb6oDHvJ2UoqWrh7YB45ip6bKVAt2EixdLHmkFbDhKOZXHfbNk
         ZEdI1vTmSJAnPuBdtEnzWZ0B9je99aSjVm2DHFzcG2oTcOMIDqbBhtA0LKRjJxIwb87N
         nCceE/g7tXdbiIcMup1wk8EfteveV9TgANYzBncmOPqh6RBZY+dmVH4206x4Yru68T5j
         UwmrrMkioeeqDLPgsPY9SrQknlIwA5E1o4fo9k8AoNrCjDNVUqm4w/5MU7CPQ0t89YNJ
         l9iEisMhKtR3m9mgmkSE88R+LFoFd975xqcjCffEaE6FlY5d8Jj6r513B7zJ0QHwBgPo
         Xlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzsW4oaRYWh/PSqb1gGOzEnZWrkrc4WMPo9eaQRhBrU=;
        b=J2e1BZNP7s6D5940JnpRH3tHD/0w4gu7gPxV/oyH/Bi+yaB95hl1lHMSIXPIVeavvX
         OmsaY1osMWGA2KUv2lpx6NEQzPDrWDpYBWQ+QMsB187PUr6VPMlCXaSlE2idleDP5bw5
         d/DfSfs48118aIkDStJbom5mK81xJPSNSP1DlLnWHDHuBUMW05IaFRmKVv5NV+Gg04mY
         ufLxcvDfuOJUzM8XiyjwEEZjHCrNN5O8OC7S+qwujeaeUE6TU1Z+cSEIvSl9ErPkuxqV
         DYlE+GY9e+uQ79yVuG6MxdLCYz4X3VPaTZy+wCgKA/tmZuHDKmjzV1R+nY4+PQT2TvZv
         u4ZQ==
X-Gm-Message-State: AOAM5314jnAuqS72mjHOmsrkeW9tMdE5z2zvukA3yRFTUjvVY0wYz4gc
        FVTQOt7BRlvWd1lh7QpLfCw=
X-Google-Smtp-Source: ABdhPJyoLtFMZVKhdUvNCepzUYUZ8SqVlA4lvw+MI+kIReJzAzSq9HUedKaX9U1fa4DNaC8mgeFNFg==
X-Received: by 2002:a02:cb1e:: with SMTP id j30mr15179400jap.143.1633876465976;
        Sun, 10 Oct 2021 07:34:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q17sm2704829iot.16.2021.10.10.07.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 07:34:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id F413B27C0054;
        Sun, 10 Oct 2021 10:34:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 10 Oct 2021 10:34:23 -0400
X-ME-Sender: <xms:7PliYT2doylFjvF9hEnyzLigkkpyfGeVhvTOcGEuoxYKzHBIbjlN8g>
    <xme:7PliYSHdINz_oZ35XC7uzVOJHVfPHJj4l0xN_BUwLmOInXVrrQsJigOOUru-A9Bmg
    PGEUWqwGYGvxGQTyA>
X-ME-Received: <xmr:7PliYT4ldrAcafRkJkTNR_nt4YgMHoT491kcp9DKosq1WcHLIIhLbWf61AZMpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:7PliYY37zqVWGBVl7FbrMnF7zHHH4gZtK3k2LYjw9Flzqc_JIynk3Q>
    <xmx:7PliYWGNYff1CwHCujNj3ACaXLCHn8WKlAhrwq_WhTDJZDbpz5tUEw>
    <xmx:7PliYZ_04O0L-uCmXkSHcM8CiaxRMSbMlDLSGNO6gr4QePFtZX3QPA>
    <xmx:7vliYWIjcQRkKKISz2Tnpuy-TQopFsxr6WQwEapabV9bq7_poSyU8GUCjB0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Oct 2021 10:34:19 -0400 (EDT)
Date:   Sun, 10 Oct 2021 22:33:05 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, Daniel Lustig <dlustig@nvidia.com>,
        will@kernel.org, peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        parri.andrea@gmail.com, mingo@kernel.org, vincent.weaver@maine.edu,
        tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
        eranian@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        stern@rowland.harvard.edu, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
Message-ID: <YWL5ofEuAH2NUGjj@boqun-archlinux>
References: <YV/rH0TeokccdbMD@boqun-archlinux>
 <mhng-9504267b-2dee-4c16-b7a5-4c4360066b5e@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-9504267b-2dee-4c16-b7a5-4c4360066b5e@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 09:32:58AM -0700, Palmer Dabbelt wrote:
> On Thu, 07 Oct 2021 23:54:23 PDT (-0700), boqun.feng@gmail.com wrote:
> > On Fri, Oct 08, 2021 at 04:30:37PM +1100, Michael Ellerman wrote:
> > > Boqun Feng <boqun.feng@gmail.com> writes:
> > > > (Add linux-arch in Cc list)
> > > >
> > > > Architecture maintainers, this patch is about strengthening our memory
> > > > model a little bit, your inputs (confirmation, ack/nack, etc.) are
> > > > appreciated.
> > > 
> > > Hi Boqun,
> > > 
> > > I don't feel like I'm really qualified to give an ack here, you and the
> > > other memory model folk know this stuff much better than me.
> > > 
> > > But I have reviewed it and it matches my understanding of how our
> > > barriers work, so it looks OK to me.
> > > 
> > > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> I'm basically in the same spot.  I think I said something to that effect
> somewhere in the thread, but I'm not sure if it got picked up so
> 
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> (RISC-V)
> 

Thanks!

> (I don't feel comfortable reviewing it so I'm acking it, not sure if I'm
> just backwards about what all this means though ;)).
> 
> IIUC this change will mean the RISC-V port is broken, but I'm happy to fix

No, the RISC-V port is not broken, this patch only strengthen the
unlock(A)+lock(B) to TSO ordering, as per the previous discussion:

	https://lore.kernel.org/lkml/5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com/

RISC-V's current lock implementation is fine, and it's still OK if
RISC-V still to queued spinlock, since as Dan said in that email thread,
the following code still provides TSO ordering:

	FENCE RW, W
	store A
	ll/sc B
	FENCE R, RW

Regards,
Boqun

> it.  Were you guys trying to target this for 5.16?

