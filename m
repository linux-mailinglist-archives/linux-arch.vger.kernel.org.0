Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6415642653
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 11:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLEKE3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiLEKE2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 05:04:28 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA91151;
        Mon,  5 Dec 2022 02:04:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F23963200951;
        Mon,  5 Dec 2022 05:04:22 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 05 Dec 2022 05:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670234662; x=1670321062; bh=MRVUFL54lN
        ZS7+NYJKrB4wUaNpwj6xU2cIPBiaS9V9Q=; b=Cbt8VWFrWRAdKMceDnYy3EPreW
        ox25Ctgw7ZTObiHEnDtyl0iWK6rQrrZvjjAqfoHh1yWnlEyzSN0ayOy3+pl0td1N
        M3q9uGJJfApXBLEyOjrIBKLZDkSZ1O+IUGIk+sG9/q9RAHdFoqPDZHGFTs4gTC3T
        e1GB9Cctn8KWzf6uw7U0dJG2q+0l7SdsjHxHel7y+NOx84aubCn9TKOdb8kkLjN3
        GltIsCLti/PUAzJG86iZU0fSyl+WVz9edJlaRsAwmBgEFkdf0FcvjAmA7/gixYEZ
        a1A1eYB/28cGJy3qxWYzqhbIT0lPYtWde8pZETzoP92M+fX1mNZC4q85OXMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670234662; x=1670321062; bh=MRVUFL54lNZS7+NYJKrB4wUaNpwj
        6xU2cIPBiaS9V9Q=; b=o79jNTYwp9sbOUDauYqMu4XA6yCsWEaJH1fzKisSIf5p
        3OA1yZ5jBfGsyGVBaKwX7HG7xo1KSmclHa05RMt/W3wP3fI43m+ovYIM/5MHoF0S
        W6lwJ/p18zDbPP4Xy9mdeYEt47zChnItIRPlR8K5w3b72N33SPdReedrqU2FyQbl
        EspBUP0a0S/GpXmr/g14aSoUXyV1oNOrjJYDEKDcBFwq7N+J8rV7vVw2bnTSJX93
        mw6gg+aS3IQjoMVBIVsfbV9rV3sDXbNEzg7xPsGT05XuXtBOnPh2s5qRttCRGAan
        qepv8aaOlNSzg4jbwDmRD6Mno1CGLoWa7Cs2ZlCKOg==
X-ME-Sender: <xms:JsKNY8Jfp6VZhgpkzNsLWDo0fn3OLOVXLgH_RpukLLAgypcSyOuVsg>
    <xme:JsKNY8ItGrMcpxzNAzFZEUJSD_haNrqZ_wHFK_jMQuLycPBsBjyhVOXJuYu4o0cJU
    7gGABDL1xplWh4UV4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JsKNY8sfeinptuMGHHc31JaHBfhkv5bRv36SOqgJCLMWCYv6Q7OI_A>
    <xmx:JsKNY5ZXl__pInIAafJ0YQD5zIndXHxufRrkiCN5W13n3s1G3URIxQ>
    <xmx:JsKNYzbTrNrw2d5sjFLmi6DlGtLmG-g_Ew3XEt6DglBkNcyMwPSvrQ>
    <xmx:JsKNYyV1n14qmF6vJr725hNAr9AWnjja4TGdv695cO9UUaf34sXxLw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 240B4B60086; Mon,  5 Dec 2022 05:04:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2a3d3359-a5fd-453b-81f1-35c7a35fc12d@app.fastmail.com>
In-Reply-To: <1670229006-4063-1-git-send-email-chensong_2000@189.cn>
References: <1670229006-4063-1-git-send-email-chensong_2000@189.cn>
Date:   Mon, 05 Dec 2022 11:04:01 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Song Chen" <chensong_2000@189.cn>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] include/asm-generic/io.h: remove performing pointer
 arithmetic on a null pointer
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022, at 09:30, Song Chen wrote:
> kernel test robot reports below warnings:
>
>    In file included from kernel/trace/trace_events_synth.c:18:
>    In file included from include/linux/trace_events.h:9:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic
> 	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic
> 	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note:
> 		expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>
> The reason could be constant literal zero converted to any pointer type decays
> into the null pointer constant.
>
> I'm not sure why those warnings are only triggered when building hexagon instead
> of x86 or arm, but anyway, i found a work around:
>
> 	void *pci_iobase = PCI_IOBASE;
> 	val = __raw_readb(pci_iobase + addr);
>
> The pointer is not evaluated at compile time, so the warnings are removed.
>
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> Reported-by: kernel test robot <lkp@intel.com>

The code is still wrong, you just hide the warning, so no, this is
not a correct fix. When PCI_IOBASE is NULL, any call to
inb() etc is a NULL pointer dereference that immediately crashes
the kernel, so the correct solution is to not allow building code
that uses port I/O on kernels that are configured not to
support port I/O.

We have discussed this bit multiple times, and Niklas Schnelle
last posted his series to fix this as an RFC in [1].

      Arnd

[1] https://lore.kernel.org/lkml/20220429135108.2781579-1-schnelle@linux.ibm.com/
