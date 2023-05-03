Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C846F53BE
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjECIxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjECIxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 04:53:15 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB138E57;
        Wed,  3 May 2023 01:52:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id E927C2B0695E;
        Wed,  3 May 2023 04:52:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 04:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683103975; x=1683111175; bh=IS
        4EM5wdsuSjV61ICnK1JWQzvfZmpsEGvr2M9gQsBDg=; b=xFunroi/7DC9ShYZYF
        0mkS1O4uFFPq6Ixts8x5XfA1TtFTRvtgFMSPwmY/QxmzmL4BwSEk1AAGZOWlkaw8
        G/Qp1sWYevvX+sFvbpTZcf3rjLOBulkJ8Uiuvi16V7J3DjTqeQNEK8iP4a9KjnGf
        AZFDczkFoeVbNFRXPynwrYtDmJgetJTY2yHzUYvc3J0ZzuF1bobFPZSiPlRGEuYf
        3e67ij/DjoLjlsBxu1+3uM5MYZv9w2R9m7KD9LMhSly7TtZLqeq0jrg0Gls3kupf
        1G1xcF49uh5fi9NgbQILKNzf3cG1mEsLRM3xpKbKP5GH0OST4rDQ5eyIyIPDKIcL
        OBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683103975; x=1683111175; bh=IS4EM5wdsuSjV
        61ICnK1JWQzvfZmpsEGvr2M9gQsBDg=; b=fOZ/xI4I2hlVOsmaVXohE0GxuJ/WQ
        5W+sIMqjJ3nKPDW8LmKpdh2luVCCtpTNFkUrKdi1fAsUK6C/2B6+1tLefS1ddRsr
        MmMAFZgcqtocNbZny1ua3NZ6+E5xbqP8/5bWqckB5cYLDA5DGxh9x+UY8Pw2fq+p
        S79jlVyAhJjFWrlrypp8EpWc1dMwsc5a9hw/oePA/lCbQIxkR5ZeY/6Xsftlhc+l
        Htz3SpG1C/s3uhEXjE4MxVAJDLcu8PvU5jAfsiTFb/NVUr9dk100g0e4uViCzcCf
        84BNNVhGsrK57sej9W1I7Khq+NtVWqm5iYASgfRGRnF5bgsaTBk7l9gdA==
X-ME-Sender: <xms:5iBSZB6waEbkoZSuAcdjwPbQtxZjM_QjNWuH9Z89bJoEVoKZECP9XQ>
    <xme:5iBSZO4MbLBKe8qyXRGJZconrK-wkSHbbvOY5Nn3ucu39n3eNmHGgS9BbDQks5mVi
    9deu1Go1vvXng1b94w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5iBSZIetZ3io1_WwWrG5A5y-vWMtX6jG-iRLHYUbU3H91u2JRZxyIg>
    <xmx:5iBSZKKYY7kwklx5HX9jBu4cyX4FKYnhz1QuC9yZ8w_mnITQhCunaw>
    <xmx:5iBSZFJNJdiIT89CdIrMdBTAeYA7OFOs9bKV0VCjpS-TfgXa9njB7Q>
    <xmx:5yBSZKCtfTyRWweziCf0h6B7K9kpLs7LYO6VLyOu5dz5_qpxplsAo3N_Uvk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 45BA2B60086; Wed,  3 May 2023 04:52:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <0ecbc92c-7e42-4958-988b-abc265f039bf@app.fastmail.com>
In-Reply-To: <97bbdb2f-6245-caf2-c0f6-d628873bd6db@suse.de>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org>
 <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
 <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
 <97bbdb2f-6245-caf2-c0f6-d628873bd6db@suse.de>
Date:   Wed, 03 May 2023 10:52:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, "Helge Deller" <deller@gmx.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-m68k@lists.linux-m68k.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        loongarch@lists.linux.dev, "Vineet Gupta" <vgupta@kernel.org>,
        sparclinux@vger.kernel.org, "WANG Xuerui" <kernel@xen0n.name>,
        linux-snps-arc@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 3, 2023, at 10:12, Thomas Zimmermann wrote:
> Am 03.05.23 um 09:19 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>>>
>>>> There are countless examples where the above are not followed,
>>>> but to my best understanding the above it the preferred way to do it.
>>>
>>> Where did youher this? I only know about this in the case of asm/io.h
>>> vs. linux/io.h.
>>>
>> 
>> I understand that's the case too. I believe even checkpatch.pl complains
>> about it? (not that the script always get right, but just as an example).
>
> Do you know if that's the general rule? If so, we might want to 
> repurpose <asm/fbio.h> for the framebuffer I/O functions.

It's certainly the general trend across all of the kernel to have
drivers prefer including linux/*.h, and to move stuff from asm/*.h
to linux/*.h as it gets generalized across architectures.

     Arnd
