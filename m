Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF2740E24
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjF1KGw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:06:52 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53607 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235289AbjF1KCZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:02:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id CBDC43200065;
        Wed, 28 Jun 2023 06:02:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 28 Jun 2023 06:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687946541; x=1688032941; bh=jr
        26aMNCJW0isrXg6UfE/c6yGNQaJhjRzD6v2gyhJiU=; b=go17TU7pTv/88ZkN9V
        azy1f3TEVC4eh2cFjnlQc2THDkHBS+hRIb/NP5smWX8p6PlBu7xeOqAwlNdA81xY
        TUkBeDN7zTDh3o36eA21ZlUjbEU5candTuxAFq3YHskdZd/8uzhKvCwlBRFaGmdd
        aw1DR0kZe/ksoI20WFqSBO+gM8dqlB2IUHdEh7hlP+DT2hdznnJW574L5g0d9Vwg
        D5GtZjfLSEZm7snNwyXu0b74sIjEKF42ZMc7wLhJUDcHtrRk1pCpLasCCyCNEkNH
        gV3ANc4YxQxjgWGLghO3x/mfFHkqhgIEr6KQRrJWV7koAkLG/LAXcn4K1lzvyzUI
        urqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687946541; x=1688032941; bh=jr26aMNCJW0is
        rXg6UfE/c6yGNQaJhjRzD6v2gyhJiU=; b=gu+CZY1l55I1TAbIiJdtfb7gL+Up+
        PXTJtGjBdA7pyur7SHIEFhf45EIjdwgUuG47YxZDuzXjF4zqkDy4OiEdtckEj+KR
        hT3c4gY9Y8Zbs1P5SY8EHl0lfEF5tOTz1ibyRcHsSCjras6I5fLzCyyxANm9O9rU
        FVjvcx80F96DvBDGL+up2UfzkUD00xBJwSuVlTnkAORCl20tNBC0S4IY68yWazFd
        sRTsJIk0gTG0ZZ6ABFprGWXtT33+zqf8wgcxS5IQc5dg10rRJNJvCtnze0zHHTMT
        BP1xXByoUkKMsH9aQ8m1uEdksBkSYB7QcQVWzSEgMwfeR+G/jQ51lOkLA==
X-ME-Sender: <xms:LAWcZED4fNZxTlKrdjBmHxJP-sckGwx35hV9UkqQISEoQIfhRmo-JQ>
    <xme:LAWcZGhPNT2BfytOOn8bcbgj-iEhpLaDXkzpKrTalDsNK6BfgCbkrCcgQAl4ySoEj
    TpHsdXpmtJtJ4PC5BI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LAWcZHmXSlCpeeyNoZE7_0LnoPbJ74fdoPhH1-tEgZSeUBVdS7LK5g>
    <xmx:LAWcZKygSArf1RXeJy6o-saV1OnxLw5eXJf69NNMxU3YltpCM4robQ>
    <xmx:LAWcZJS1GiS98HbAAxa5aqyjTH6zrMIgmdtULLLD7yJ2KFbTG__paQ>
    <xmx:LQWcZIAyk7e_edqPJYxvNmmrL7ukerO_p8vou2sRrc2B0RKlJg_Qaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F7CEB6008D; Wed, 28 Jun 2023 06:02:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <afe5194e-fd49-4cc9-9a8c-e7671c55d664@app.fastmail.com>
In-Reply-To: <d9ffc44c-c4ae-4f01-bc0b-ee5359a24a0a@app.fastmail.com>
References: <20230417125651.25126-18-tzimmermann@suse.de>
 <c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net>
 <55130a50-d129-4336-99ce-3be4229b1c7d@app.fastmail.com>
 <d4156e51-102f-36b4-e42c-938268b4b608@roeck-us.net>
 <d9ffc44c-c4ae-4f01-bc0b-ee5359a24a0a@app.fastmail.com>
Date:   Wed, 28 Jun 2023 12:01:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Cc:     "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "KKees Cook" <keescook@chromium.org>,
        "ees Cook" <keescook@chromium.org>
Subject: Re: [v3,17/19] arch/sparc: Implement fb_is_primary_device() in source file
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 24, 2023, at 16:21, Arnd Bergmann wrote:
> On Sat, Jun 24, 2023, at 15:26, Guenter Roeck wrote:
>> On 6/24/23 02:27, Arnd Bergmann wrote:
>>> On Sat, Jun 24, 2023, at 03:55, Guenter Roeck wrote:
>>>>
>>>> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko]
>>>> undefined!
>>> 
>>> These all look like old bugs that would be trivially fixed if
>>> anyone cared about sparc.
>>> 
>>
>> Odd argument, given that this _is_ a sparc patch. Those may be old
>> bugs, but at least in 6.4-rc7 sparc64:allmodconfig does at least compile.
>
> I think we clearly want to fix the fbdev regression you found, and
> maybe bisect the atomic64_test as well to see if that was caused by
> a recent patch to get it into a working state again.

I have bisected this as well now and sent a trivial fix, see
https://lore.kernel.org/lkml/20230628094938.2318171-1-arnd@kernel.org/

      Arnd
