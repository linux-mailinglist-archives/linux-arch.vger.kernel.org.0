Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F46C6810
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjCWMT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWMTS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 08:19:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3E27D54;
        Thu, 23 Mar 2023 05:18:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E794B5C021D;
        Thu, 23 Mar 2023 08:18:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 08:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679573915; x=1679660315; bh=S5
        J8p2Vi8Lq9WKpHfGz7SPZv0rwtdwDhT7zpOSz2Ai8=; b=foNrYKAsedHOJ8bf1H
        HrXQH3liQ/ZFGu8ixsyJqi8tMW+XIyIEq/QS/JK/6sT6aLkeYQsqf4LiOhz5ODhB
        lB0ImwoVjh8UsUD8BZF742MxbTMbJtoPQUehpKfD2X+RNDrX4bbc+DhTs8EGrQB0
        NqHfCuiVMwYDRX0yBfJENpuY+ActQOlnz+HBQ/P75DGQuPnvEr/orO2PprfuxNMz
        OsGVT5WhH7dRXp+t0HUu0n5hGZts+5SEVf4GA5P+IUl/2jRem0BigRDGhQeiyZ8u
        ne0c2ELSHd/dWsfXuct/Ct3NlOH0/EmNxKFsz5+K7NtFKq3A1insTGzW7m8cKUrf
        Eqdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679573915; x=1679660315; bh=S5J8p2Vi8Lq9W
        KpHfGz7SPZv0rwtdwDhT7zpOSz2Ai8=; b=jFkJMLAjUnn66tHhoGqTDAskf0Mpb
        dOVrWU2Zq6dIllNLelfk2zT85k2gHMY0b2MP9KNzmZAIcXtf4o/4j8sC5k86RM75
        u7V43JZS8VdKh1N8gvWhhpzqg5SMUgi9ogCciE5libzzJAjoMo99gb7QnkzOx9tM
        wTdaiz394FBCcq0YP8gt8FaNmKlAMHaTdjCWKbpCA0YvHVvZw2UEpbVF/ptYephe
        BinEaneUORefTSGSRIFI8t86i8zYTSl/SR12ahwCaPe19DwsGbNVFTol04KcN1Vr
        f3vxxLwvsV6PCJOH+vJ2PtrSwt7ixPnbCzlHDuy8SD9ByG+EXOmu7Zpmg==
X-ME-Sender: <xms:m0McZF3Vm7UhHt0cI37dRaQXVZWrFqCuX9LqMNAT_l3Vclmexlch7Q>
    <xme:m0McZMGCvfQTUwIn9CN4lquJHPUeMXj_bK4C3UANViID05YLAkZfxcRrvE8hhafFD
    Wt4yzoxcG6tGbitnKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:m0McZF5qdlduZrQcvgn3EWqwWpkolof8X8uDhNYFPh6l5kJcf87jkg>
    <xmx:m0McZC0qh3gu0RhvMe5ZPWzd2bBsihwOhoo-z6YCBU5W-Pn3uzMjBw>
    <xmx:m0McZIEnMeWp2Vx9TzZpb4pw4k72rPIv78F4OPH5QTNvLcCXYljlTA>
    <xmx:m0McZGamLMz4ZSLjcO5BgKmyRNSYK5bj597vvKEG5sG6jf-jKD0bHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9442CB60086; Thu, 23 Mar 2023 08:18:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <56a3e16e-d686-440e-86b7-ee41f9d19fb1@app.fastmail.com>
In-Reply-To: <20230224-rust-ioctl-v2-1-5325e76a92df@asahilina.net>
References: <20230224-rust-ioctl-v2-1-5325e76a92df@asahilina.net>
Date:   Thu, 23 Mar 2023 13:18:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] rust: ioctl: Add ioctl number manipulation functions
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023, at 13:08, Asahi Lina wrote:
> Changes in v2:
> - Changed from assert!() to build_assert!() (static_assert!() can't work here)
...
> +/// Build an ioctl number, analogous to the C macro of the same name.
> +const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
> +    core::assert!(dir <= bindings::_IOC_DIRMASK);
> +    core::assert!(ty <= bindings::_IOC_TYPEMASK);
> +    core::assert!(nr <= bindings::_IOC_NRMASK);
> +    core::assert!(size <= (bindings::_IOC_SIZEMASK as usize));

Just to make sure: did you actually change it according
to the changelog? It still looks like a runtime assertion
to me, but I don't really understand any rust.

      Arnd
