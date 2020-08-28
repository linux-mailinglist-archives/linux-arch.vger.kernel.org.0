Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC6255292
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 03:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH1BeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 21:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BeQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 21:34:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A55C061264;
        Thu, 27 Aug 2020 18:34:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so8045099qka.3;
        Thu, 27 Aug 2020 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gh2R5C2QjOQ666oc79uAj1kKwvvc0RN64Qt09/HynQs=;
        b=co7X3hz5vvze5RP5XTWGnx8RUsuXrkVkgqO7xNh/JE+dHWA/TyQtSkXBWADzbyJadx
         T0c+SXWIN8WI/21JNgiLb5HUWAqNkoP/mMff+f1r7RCKTh7JIK68q53N+1U9hXY3dQgS
         uOeSLR1F8CG2K+7F9pk6zJdvemWnk6qekG7PYs5u31304PnesqQRIwY7ZRS69Ei993JT
         7W5nBJYR5osmGyZRTBpaJmFk2JKIW3SZ3Gg7DOcgxhLehe90axbSX+sZUEU4hsgCPuMp
         kV4/q3E5Q74NHPn5NDlvkWvBDoOeo9MA3WFaeXQEqb5fj6n8emRhN/WW0YrgGNN7y5Np
         h7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gh2R5C2QjOQ666oc79uAj1kKwvvc0RN64Qt09/HynQs=;
        b=eunTECGZl8CUUbXxkV++F066OBYkV7xymbt4rHPBd6mcIHy532k41JBSatelNxU5GM
         kW19P/8gcL32V5NqlSVniTrsl8nW22aQPbuSlrFID0cJVMI9Jdurs5jVY1SxiX7b74un
         8Moai/AtD+K7gl+u28sVhNeQcgiBgkJGDlrq2ALtu79Hj5XTFouOHcsarJw1YN56x5af
         +sM/Xwojetc6UHt+UCfnVwjHRF2wnBHpOOm9zoQi4UvsDWMTJmcac7zt89L6X1OPIXod
         tCK7WgijTS3zF1/HFlLj1CYIiUcMBnBX21Qp4Gw5gqE9GGgLeMAMXhRArPNIAbrxnJTj
         S/mw==
X-Gm-Message-State: AOAM531+DgK4X+Rsk1yVc7P4bXaM7YLsuoQDSf8RuArmgQfD1fzmOWWd
        P1zURITbLsl5Vl82dc+iVLI=
X-Google-Smtp-Source: ABdhPJwC5dR8KjB6ukidKXYL8mRsVjbdUzD5dwALrHMiGFd9jRfI5DhafXvsggJAHmjFqo0qxA39+Q==
X-Received: by 2002:a37:ed5:: with SMTP id 204mr3992627qko.405.1598578455012;
        Thu, 27 Aug 2020 18:34:15 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e63sm2658202qkf.29.2020.08.27.18.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 18:34:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 97CC527C0054;
        Thu, 27 Aug 2020 21:34:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 27 Aug 2020 21:34:13 -0400
X-ME-Sender: <xms:FF9IX9dS_Yp2ZKkBeec48r-YKN6-S--qSRVulVn_Zyn2_wLfPGRy2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddviedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FF9IX7OLc94TMsHppDsCijhN35_ysf4qSRH0uCHQa5KoZCcAJxhhfQ>
    <xmx:FF9IX2ilGYE-rtewURniFTIyJRip-vph-QOZgNWzqnNgCLKZQTOsgg>
    <xmx:FF9IX29JSvOOE1jnqVpx-dQ5J81i7I-6N_LcUN1IbgVGGAs3P5OYOA>
    <xmx:FV9IX1EDrPt68M1TnRMiyrgxq7ko1fnQDd0tjVgaM0RXk02JpHCY6YX_ifQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF1BE306005F;
        Thu, 27 Aug 2020 21:34:11 -0400 (EDT)
Date:   Fri, 28 Aug 2020 09:34:10 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Cameron <cameron@moodycamel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200828013410.GA49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
 <20200827190804.GA128237@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CAFCw3do_4TrZSQ6kYQ7Y1RYTuD+PfXRyZFp7gSDs2oUXrBZGqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCw3do_4TrZSQ6kYQ7Y1RYTuD+PfXRyZFp7gSDs2oUXrBZGqQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 03:57:22PM -0400, Cameron wrote:
> On Thu, Aug 27, 2020 at 3:08 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > So if try_cmpxchg_acquire() fails, we don't have ACQUIRE semantics on
> > read of the new list->head, right? Then probably a
> > smp_mb__after_atomic() is needed in that case?
> 
> Yes, there needs to be an acquire on the head after a failed cmpxchg;
> does the atomic_fetch_add following that not have acquire semantics?
> 

Yes, you're right, the atomic_fecth_add() following is a fully-ordered
atomic, so could provide the necessary ACQUIRE semantics. I was missing
that. Maybe a few words explaining this helps.

Regards,
Boqun

> Cameron
