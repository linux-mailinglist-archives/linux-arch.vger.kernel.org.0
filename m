Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8B6A1829
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBXIoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBXIoV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 03:44:21 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447B305DC;
        Fri, 24 Feb 2023 00:44:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 952FA5C0114;
        Fri, 24 Feb 2023 03:44:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 24 Feb 2023 03:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677228256; x=1677314656; bh=wd581eFP3K
        lFvq0U5aP/IpGssCNvXt/Gl6A0XM6S2f8=; b=Monkq1jJUfCZdOoiz1FE83JYuY
        /6RUz5BC3xZtyIEf5ljLKr1dAyekA5oFnuLom7W/uC9diIWNz0L6OeM5+BmVmGVD
        M14ozvZ9dUDNeydSFXcHXXKUAHwrxxn1pu8pgPD5wH34Q2bmZcLhTCp1BJgGXLtF
        PjoIdVBjXsAx7FlIh8/hmim7eiWdkf3O7ihTW3o1fOlINP2LP7ttoH2yYvHcSdR+
        tkbzBSbgwlDmRnVXT3xCz7Eq3n8lpzMfmizZbmGpIvZ7EtjFpvBj4Z9fGc4lwRnV
        VJtZk+JrBWWE0cxCcx/jCMO7VDEdSpvxBcf32nUW70TBys4qC+LyxSWISbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677228256; x=1677314656; bh=wd581eFP3KlFvq0U5aP/IpGssCNv
        Xt/Gl6A0XM6S2f8=; b=e/TmRPCS0wj/UWm+XzSLvIZ7jY+LnhpHxE3O5247TutF
        9XkRyxGoGAX0vIdf8uHr91M18S7KiWl589pWfM331mKO2hq0iU3djNTg1ej57zQH
        l5qPJP8qzRXhEkZx1K2rnj0OZCtu705aqCzLPoijpoCzsITyRgPBKiiO954FBRk+
        MEgFcUU+RNpKE+jOgghUpgnze5Am2XS6by2Md6NfZItwiiOnIoLEv5U1URKSLWt6
        srx6M5sqPk6k3JwVPyGb5V717p2Y3gL0uUX1aERG/9nVKCCJXtNf/Xc5QX4QZmt+
        9P3rJPvFfrpkgBpM23faLFUt9n/pD0UCQA2mWhfxhw==
X-ME-Sender: <xms:4Hj4Y8HUBy7BvSvp656WhypfqVyJqB9dYDk3RC8_nMme50d0bXplrw>
    <xme:4Hj4Y1UYXWpQoZIQwpkwZWOC3iAja6rrHgWYpv409hOephFfTzpkogQExvtSecI_Y
    GL8m_RzZBunNEhuLGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4Hj4Y2ISPAlmrZ2ZCcuv7Cn4x6FCV0dZA7W9Ja-_8_9eVMv-GxEJ1Q>
    <xmx:4Hj4Y-FLUxr5PzRy7UmjPJ3CaSSrTo_g7U-IFBmblWyo2hHHoYp7pg>
    <xmx:4Hj4YyU5U1kox6vJSm0QB9PTNPu4-xZW_QNvTYns3y8mRoyRcsGCrw>
    <xmx:4Hj4Y2pXfBw3evWyOYheDyOrmguy0dPo-pulBKDAVmqGm79NUZL3Mg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B2C8B60086; Fri, 24 Feb 2023 03:44:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <0818df3a-76c9-4cb3-8016-4717f4d5bf18@app.fastmail.com>
In-Reply-To: <20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net>
References: <20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net>
Date:   Fri, 24 Feb 2023 09:43:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] rust: ioctl: Add ioctl number manipulation functions
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 24, 2023, at 08:36, Asahi Lina wrote:
> Add simple 1:1 wrappers of the C ioctl number manipulation functions.
> Since these are macros we cannot bindgen them directly, and since they
> should be usable in const context we cannot use helper wrappers, so
> we'll have to reimplement them in Rust. Thankfully, the C headers do
> declare defines for the relevant bitfield positions, so we don't need
> to duplicate that.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

I don't know much rust yet, but it looks like a correct abstraction
that handles all the corner cases of architectures with unusual
_IOC_*MASK combinations the same way as the C version.

There is one corner case I'm not sure about:

> +/// Build an ioctl number, analogous to the C macro of the same name.
> +const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
> +    core::assert!(dir <= bindings::_IOC_DIRMASK);
> +    core::assert!(ty <= bindings::_IOC_TYPEMASK);
> +    core::assert!(nr <= bindings::_IOC_NRMASK);
> +    core::assert!(size <= (bindings::_IOC_SIZEMASK as usize));
> +
> +    (dir << bindings::_IOC_DIRSHIFT)
> +        | (ty << bindings::_IOC_TYPESHIFT)
> +        | (nr << bindings::_IOC_NRSHIFT)
> +        | ((size as u32) << bindings::_IOC_SIZESHIFT)
> +}

This has the assertions inside of _IOC() while the C version
has them in the outer _IOR()/_IOW() /_IOWR() helpers. This was
intentional since some users of _IOC() pass a variable
length in rather than sizeof(type), and this would cause
a link failure in C.

How is the _IOC_SIZEMASK assertion evaluated here? It's
probably ok if this is a compile-time assertion that prevents
the variable-length arguments, but it would be bad if this
could lead to a BUG() or panic() in case of a user-supplied
length that is out of range.

     Arnd
