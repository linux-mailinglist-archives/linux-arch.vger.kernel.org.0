Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D267425CF10
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIDBYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 21:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgIDBYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 21:24:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16E8C061244;
        Thu,  3 Sep 2020 18:24:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 60so3508780qtc.9;
        Thu, 03 Sep 2020 18:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DCar6p+BerNTwBIOjSSDhhKMTYZUeaLOP7U1DRIXsek=;
        b=T/jIh1JqgASZVTdVZquD7MV2wTw0pqX0z+s+QnYoN8WJ8KcMICj+gShvUbCyCzjy+k
         gxWj3IvBXfNzWP2G4FQcaHGOyTq8tTByBs1m+6bfjPRfpckC+SWcYgWDiZp5cWanT0/T
         DXG7CU1Va3/m9Ncl4VrZbUXINwCzto3iEFMD14s7W67ajUUSb6ad01gqVPb7ybQhuVnO
         +jCvxQq3O+ou7CznylwFUeb1w2DnPAAiONnK26kxRY8VXq3YeCLLfP3qG+m/QtfHNJ3D
         +fpvL0UMLz3/QOoNXFcg+XYWPLDoxAgYMYs+6yl4oQxH1sJiDNX9RuooxFTPBrMu/IjG
         sFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DCar6p+BerNTwBIOjSSDhhKMTYZUeaLOP7U1DRIXsek=;
        b=JqBaBTHRm3StzhxAkde2PKVPmLUY5auf4Yk25CkY+odI9EE/SL+K8vTXv8TSaaXG4P
         I5o5tm6KxWV2ccgmYc/OHcN1t4Ew43U1Ko3KMBemOyEEJFtBLT6FgnnyRitvLz19YHHb
         UJW0kxmb2CNoWK653lhxhQKeqpK809mU0s2Fll7Aio2FqdXWJoTjLxOpusHlMcQ8+EDp
         zWjUwcbgU31i6UyPn+DY0bZhXoErnpLjjtg+d/yoOQlCDoO0EqyaK5BD+dOLSn1Mtex6
         ZHI5Wvt9Y5Bvm67UmbllCb9KHllkbEu9dTswTEp/pNAqahUeJdAFrxmqEI+5f3UnbtSn
         Yjaw==
X-Gm-Message-State: AOAM531Y1bkfa4o5tHEDNbrJxmMF5t4Mtz40nHwNYyGs/NWVbX37QMiJ
        gNLLnb2ZNpo4wHas0ad9Iqk=
X-Google-Smtp-Source: ABdhPJwkxkmSthL103b5xWmN5EwCZVBtOZF2RnRh243/fUUUv/sjPNinZVHawqBoHmMNRM4vZqFTyw==
X-Received: by 2002:ac8:1417:: with SMTP id k23mr2212424qtj.89.1599182688424;
        Thu, 03 Sep 2020 18:24:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b199sm3435069qkg.116.2020.09.03.18.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 18:24:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C9A6427C0054;
        Thu,  3 Sep 2020 21:24:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 21:24:46 -0400
X-ME-Sender: <xms:XZdRXx0khH3mFpusNE0FWTbI27XoZoNUf310TpnOgpjcfS3jE6N38Q>
    <xme:XZdRX4GKZ-LBJSbbXw52euf0aa15V2P4qJuSLChJdmcr1E-Ru0Uwr4pp0xC2NsYMb
    Pqp0jfIHeKXY98mzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduud
    durdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XZdRXx430vCqn4Z8PKiCIiUGxPkdWgOjTmf7XyvX9b9Vj_-xxoIosg>
    <xmx:XZdRX-3XkX-ReXSr4PEkKbssjCUWFWwL9FuhNO1K_PGtUidk3qpKYw>
    <xmx:XZdRX0Gi1yn70Cc4y4aDVjZHtIRCaaxzxTN9D8_AVIasa-5Pw8ynIQ>
    <xmx:XpdRX4Fyvw814QnuW6MVseWbKWf4oFuBHC9_QQ-aEhIJOHee-WIVuQb3nHg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B806328005A;
        Thu,  3 Sep 2020 21:24:45 -0400 (EDT)
Date:   Fri, 4 Sep 2020 09:24:43 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH kcsan 18/19] bitops, kcsan: Partially revert
 instrumentation for non-atomic bitops
Message-ID: <20200904012443.GB7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
 <20200831181805.1833-18-paulmck@kernel.org>
 <20200902033006.GB49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902061315.GA1167979@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902061315.GA1167979@elver.google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 08:13:15AM +0200, Marco Elver wrote:
> On Wed, Sep 02, 2020 at 11:30AM +0800, Boqun Feng wrote:
> > Hi Paul and Marco,
> > 
> > The whole update patchset looks good to me, just one question out of
> > curiosity fo this one, please see below:
> > 
> > On Mon, Aug 31, 2020 at 11:18:04AM -0700, paulmck@kernel.org wrote:
> > > From: Marco Elver <elver@google.com>
> > > 
> > > Previous to the change to distinguish read-write accesses, when
> > > CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
> > > the non-atomic bitops as atomic. We want to partially revert to this
> > > behaviour, but with one important distinction: report racing
> > > modifications, since lost bits due to non-atomicity are certainly
> > > possible.
> > > 
> > > Given the operations here only modify a single bit, assuming
> > > non-atomicity of the writer is sufficient may be reasonable for certain
> > > usage (and follows the permissible nature of the "assume plain writes
> > > atomic" rule). In other words:
> > > 
> > > 	1. We want non-atomic read-modify-write races to be reported;
> > > 	   this is accomplished by kcsan_check_read(), where any
> > > 	   concurrent write (atomic or not) will generate a report.
> > > 
> > > 	2. We do not want to report races with marked readers, but -do-
> > > 	   want to report races with unmarked readers; this is
> > > 	   accomplished by the instrument_write() ("assume atomic
> > > 	   write" with Kconfig option set).
> > > 
> > 
> > Is there any code in kernel using the above assumption (i.e.
> > non-atomicity of the writer is sufficient)? IOW, have you observed
> > anything bad (e.g. an anoying false positive) after applying the
> > read_write changes but without this patch?
> 
> We were looking for an answer to:
> 
> 	https://lkml.kernel.org/r/20200810124516.GM17456@casper.infradead.org
> 
> Initially we thought using atomic bitops might be required, but after a
> longer offline discussion realized that simply marking the reader in
> this case, but retaining the non-atomic bitop is probably all that's
> needed.
> 
> The version of KCSAN that found the above was still using KCSAN from
> Linux 5.8, but we realized with the changed read-write instrumentation
> to bitops in this series, we'd regress and still report the race even if
> the reader was marked. To avoid this with the default KCSAN config, we
> determined that we need the patch here.
> 

Thanks for the background! Now I see the point of having this patch ;-)

FWIW, feel free to add for the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> The bitops are indeed a bit more special, because for both the atomic
> and non-atomic bitops we *can* reason about the generated code (since we
> control it, although not sure about the asm-generic ones), and that
> makes reasoning about accesses racing with non-atomic bitops more
> feasible. At least that's our rationale for deciding that reverting
> non-atomic bitops treatment to it's more relaxed version is ok.
> 
> Thanks,
> -- Marco
