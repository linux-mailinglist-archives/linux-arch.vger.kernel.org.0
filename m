Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8975CC25
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGUPls (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGUPlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 11:41:47 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E1E6F;
        Fri, 21 Jul 2023 08:41:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0E4933200065;
        Fri, 21 Jul 2023 11:41:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689954101; x=1690040501; bh=6J
        7BKGMI7owfks+x7fQJRcecsf8Hj64J7kF7tz1vUtc=; b=A5MleABLoFt1S/H1FX
        lAd3hMYSivC47C1cOQ23II5KS7K3NFfO4Ta2hebV51rUfaWP5B+SqMe/ZZd1Tmus
        nquyvl30YF60+WlzevuP1gHcb3jUUglS6LprAw/0g4gGhUTsS2GwVtNf8A8bKOzB
        d7ycPKywidmMgZUxdZ9N6HlpVPSx8+Wa0C22mvMO6Anqi1izYc+t6S5Vo3ase3Hr
        iEF3tWSf3pl7jSqEUX20yU5/Zp+htaDXu5vHagPp644pe8TYXpNl+2/lcSuuMWuT
        R8QtU8GJAHn+rb7X9sDpYX/54RRWAeBd0XRZgrf+MFLNNvXqFJmNbSlcKGXFsWme
        uLcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689954101; x=1690040501; bh=6J7BKGMI7owfk
        s+x7fQJRcecsf8Hj64J7kF7tz1vUtc=; b=KKFUI9USNjtZMK1UdjRiKOrASU2aB
        UwohSbcZoSv0MovXUckWbly517ofaKs1zFVOJlQoRpKoNDE6n81yJy0HEW/Az56B
        7Y7311UFyE/EypKG3NMS1Edd9ottFeawbysIwjTlyq9uufaAtKVWO2eLv4Iq4czx
        1u2EBWFE1iKXplu1ETWoc33u0KtduzQssM1lns3atfH4SVDSIN9qshRYzIaq1xis
        +WZhezXcgSr/PbyHJ5S8ZYMjMGnC+yh1ZmmX/tdfTa36ZAsrOBdV0LGRrx+RcaWV
        4k3I+bwZmw6WubmuDLaF7LzwjFegAY7g/pmDITvpCrageJPvJ76kXzZNg==
X-ME-Sender: <xms:NKe6ZFJ4883KwLyAS3MNwRODRbel1d6GgCQExW2GBXtZuh_1rsuOmg>
    <xme:NKe6ZBIDUr56imC4GjQgSpH2jKn_3Dbt1-nZbnfg20GBL3tS5p4a9V08ocYnqsbeO
    LKI9bvXRilH9PddYYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NKe6ZNvSpR_w1_n2miOYV9s9Oy2ZpvME9VozPddNB-shifUX7c5Ipw>
    <xmx:NKe6ZGb10gUS0FokO32Zwnmle5bg_T6t_hG7yVneWAJ5Z0KzLWlkYg>
    <xmx:NKe6ZMbkl-16Z8wVJle4U2R1QnUqNbeTlAOBVl4K5_7JHlkcbP-alQ>
    <xmx:Nae6ZMpiUann84kkg_MYKDy1mqCV6oeq0PtiXp_7ndx9EswpOi4tQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D723FB60089; Fri, 21 Jul 2023 11:41:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <2a1f8ae6-ed2b-4fe8-85af-df64e9c84794@app.fastmail.com>
In-Reply-To: <20230721105744.022509272@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.022509272@infradead.org>
Date:   Fri, 21 Jul 2023 17:41:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jens Axboe" <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com,
        "Andrew Morton" <akpm@linux-foundation.org>, urezki@gmail.com,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
        malteskarupke@web.de
Subject: Re: [PATCH v1 05/14] futex: Add sys_futex_wake()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023, at 12:22, Peter Zijlstra wrote:
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -465,3 +465,4 @@
>  449	common	futex_waitv			sys_futex_waitv
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
> +452	common	futex_wake			sys_futex_wake

This clashes with __NR_fchmodat2 in linux-next, which also wants number 452.

> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -909,6 +909,8 @@ __SYSCALL(__NR_futex_waitv, sys_futex_wa
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  #define __NR_cachestat 451
>  __SYSCALL(__NR_cachestat, sys_cachestat)
> +#define __NR_futex_wake 452
> +__SYSCALL(__NR_futex_wake, sys_futex_wake)
> 
>  /*
>   * Please add new compat syscalls above this comment and update

Unfortunately, changing this file still requires updating __NR_compat_syscalls
in arch/arm64/include/asm/unistd.h as well.

> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
>  COND_SYSCALL(get_robust_list);
>  COND_SYSCALL_COMPAT(get_robust_list);
>  COND_SYSCALL(futex_waitv);
> +COND_SYSCALL(futex_wake);
>  COND_SYSCALL(kexec_load);
>  COND_SYSCALL_COMPAT(kexec_load);
>  COND_SYSCALL(init_module);

This is fine for the moment, but I wonder if we should start making
futex mandatory at some point. Right now, sparc32 with CONFIG_SMP
cannot support futex because of the lack of atomics in early
sparc processors, but sparc32 glibc actually requires futexes
and consequently only works on uniprocessor machines, on sparc64
compat mode, or on Leon3 with out of tree patches.

      Arnd
