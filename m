Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A5753D46
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjGNO1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjGNO1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:27:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1133C14;
        Fri, 14 Jul 2023 07:27:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 05934320094C;
        Fri, 14 Jul 2023 10:27:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689344827; x=1689431227; bh=u5
        ipAH4K0NlmFos4pkZwsy4Cy+qhc8YEhRBvZpa54NA=; b=NVDxZZVQVdpDVPqMKF
        5D21skUCKYkBUX497oLptmP4rm9ICbEKrL3/5o+aefL42+DszscNov6Sfg1O1oO+
        HyZcRFc2l0D9E8L2ljfTyZEC0je25cILkj/SbcX9sec1bZzujiS/c/qUpKVt2Hxv
        6VGve5GLs5640rZYzr1+XX2nqpAE6TumggKWqyPPibpMRqEaogZ4u6jTEr3tsR0R
        ZcCd8h54KnIXnVlbnFxbbx6itIuJ7NLVXgIkBVJGQ/MTe3L2FwyAUDrWcq8jvABZ
        nclMpn0mHQMre0DfXOAm5IudfTcgMdLYhcsx28XlTakAQFXYCCiJ9QaMPdI4Bzp0
        KVPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689344827; x=1689431227; bh=u5ipAH4K0NlmF
        os4pkZwsy4Cy+qhc8YEhRBvZpa54NA=; b=coRg7x1pxfRs2SC9fY5YA59F+siDT
        6kOl1drANxJlueREdmaiFWHCiyyvyhzXlj9NiaIHH2Tt6876pe5/xvWRUbr2JIhv
        Ur8Y0fDRofH+vFA3ILQuRieNJ77P4KrjpL7i9HHwV4rOHmReGS6AhrxnRAFHQHde
        4Q+BCBTOykfF94B/+2za0O+96x+Xkc6GZRkHgfQsuUtC6i8KFDyFi37rV+SxsLjI
        eQ0GbaFsfeFFALg59LnFlGWGyBgWgiqHVjP6qefjUz7p2Vrt333mCwi2y4NXk43n
        nDY4Dtm8i3tjIPs263JDEWZlpObxB1G7iYlM0wFH3Kf0sEMPQHvWLD8uA==
X-ME-Sender: <xms:OluxZC9DTx8Y8-wywcFqtpsskU0D37co4wcnbbUUHKWimDNo7TjG7A>
    <xme:OluxZCvxZYTiE3jfJy1gwHDY-3f59jg_JOsE8Zwzuhj_pkPQyfdAgTWsplCeYdajm
    QiujwdcIRtfAekmdB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OluxZICpGItmE8gfLHTOGNvfLMwZpHl5XTXoPCQvOx313FjyL5e-TA>
    <xmx:OluxZKeXrOjQy0cgy4DxY_TA4TvKwlPxdqrA4YcHebgQynYRuaRcqw>
    <xmx:OluxZHNg9P2Nj0YH2WQC5JcDggvfROI_cXobdTjmKEto0od7fh6iXw>
    <xmx:O1uxZFs-HwGyC7FXsyYG3dQR9GPrMfGT1EIX3fF6jZBYdshTZXJMaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F37AB60092; Fri, 14 Jul 2023 10:27:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <c5a09710-a7a1-43df-ac25-42e8f3983f9c@app.fastmail.com>
In-Reply-To: <20230714141218.879715585@infradead.org>
References: <20230714133859.305719029@infradead.org>
 <20230714141218.879715585@infradead.org>
Date:   Fri, 14 Jul 2023 16:26:45 +0200
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
Subject: Re: [RFC][PATCH 04/10] futex: Add sys_futex_wake()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023, at 15:39, Peter Zijlstra wrote:
>
> +++ b/include/linux/syscalls.h
> @@ -563,6 +563,9 @@ asmlinkage long sys_set_robust_list(stru
>  asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
>  				unsigned int nr_futexes, unsigned int flags,
>  				struct __kernel_timespec __user *timeout, clockid_t clockid);
> +
> +asmlinkage long sys_futex_wake(void __user *uaddr, int nr, unsigned 
> int flags, u64 mask);
> +

You can't really use 'u64' arguments in portable syscalls, it causes
a couple of problems, both with defining the user space wrappers,
and with compat mode.

Variants that would work include:

- using 'unsigned long' instead of 'u64'
- passing 'mask' by reference, as in splice()
- passing the mask in two u32-bit arguments like in llseek()

Not sure if any of the above work for you.

       Arnd
