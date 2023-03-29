Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6CC6CED2C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjC2Pm0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjC2PmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 11:42:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8696135;
        Wed, 29 Mar 2023 08:42:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 159AE5C00A9;
        Wed, 29 Mar 2023 11:42:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 29 Mar 2023 11:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680104541; x=1680190941; bh=g4
        kHrEowDgNpfJvpROnRHbgAmyyUXv8cp51hnQwqNfA=; b=PyC2SosgS0wI2qyuyZ
        8I1huT30LSUNGQRWhSG7ehj0bbh0OrF+Yf257m7kOivTEDZ53dtqluEdcqxqvPkT
        KIfiPo67hRBvw+GY1IAmuLaOfFNczHgNJuk/4aZ/S41F5MnxnicTGCdb6YcF1NVJ
        fgqdhADST+G+KrKc7QWAB2nx7u9JxXCfj/KoTG7ozpKOwDQrFvQDyraAnfgQi+y9
        L3vi2XQgACUsFuqf1UKWVRSFHK6LZftPcTNSRlnSYfnA7TKzvWNYWJ4hmxTN1DpV
        cDYlrOOYdCwmywLgHDnX11orZXznL9gsAyOwiOK80I5vbvPfJblVjh0GM+gmCbX7
        WlZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680104541; x=1680190941; bh=g4kHrEowDgNpf
        JvpROnRHbgAmyyUXv8cp51hnQwqNfA=; b=G6aurwmS0jGXgg6xfGzlXhXc074VI
        5csONtOtQLbIfhmW9ovxiLJnN0i/mdQWnI+A2ZF6SqAURLaGXfbyQsSjOjsdsQvf
        Q+2aVFyao1llljQqEHEwl5Menwgcoxv1p10tJ0UtW5VMvnXSOs2E9i1sxKm9ChVi
        sIq+cmazwFavNVf2npM9YIyLadxnhazH9tHCBs7HC13wbfqqfefVvWeUHDniLsOv
        cXriWZWgAvw42kggofzDmj77CJJmbMY0tNzqPor9DzoGFmChResCKOGelKGcQaeQ
        8OmUgKDUVVs0MP+OHBMZRxEA06ut91kUSTMsfBdS8b3KywC4gueJIdq5g==
X-ME-Sender: <xms:XFwkZJH0v5Il8a1OrdoCKCNR0xpEj4DCFtkdW2y3WsbYFNu15B7Wwg>
    <xme:XFwkZOWDF23GuDC3SWJIejh3QSzXJIXmU5QGLj3u_EFLmxFn8kUddi5ZS5jFPY-yA
    zZNZ-tNG_FqmEnS0SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XFwkZLI-_7fUXFwvXi5r5Nob3e6iaAvEMTsD9LaBmpP7BY4DvT210Q>
    <xmx:XFwkZPEJ_RYZI5IW9Rcinlo1GTFTM5-YXTa4SFlOO10bMMKz6kre1w>
    <xmx:XFwkZPWFG4WMIKkVWQaE9P06BzpCxTIc3V3KN2C7qzjM1JiuN9M8qw>
    <xmx:XVwkZDkfL0COabxa7z2t0r6vvM6iV4Yr14PD5_mG4XFHRdNA0hYioQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EBDBB6008D; Wed, 29 Mar 2023 11:42:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
In-Reply-To: <20230329151515.GA913@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
Date:   Wed, 29 Mar 2023 17:41:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Oleg Nesterov" <oleg@redhat.com>,
        "Gregory Price" <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, avagin@gmail.com,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>, krisman@collabora.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jonathan Corbet" <corbet@lwn.net>, shuah <shuah@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, tongtiangen@huawei.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of access_ok
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023, at 17:15, Oleg Nesterov wrote:
>
> This look as if access_ok() or __access_ok() doesn't depend on task, but
> this is not true in general. Say, TASK_SIZE_MAX can check is_32bit_task()
> test_thread_flag(TIF_32BIT...) and this uses "current".
>
> Again, we probably do not care, but I don't like the fact task_access_ok()
> looks as if task_access_ok(task) returns the same result as "task" calling
> access_ok().

I think the idea of TASK_SIZE_MAX is that it is a compile-time constant and in fact independent of current, while TASK_SIZE
takes TIF_32BIT into account.

     Arnd
