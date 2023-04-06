Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BEE6DA226
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjDFUDV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjDFUDT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 16:03:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B083D0;
        Thu,  6 Apr 2023 13:03:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 03CAB5C018C;
        Thu,  6 Apr 2023 16:03:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 16:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680811396; x=1680897796; bh=alW+rItMMZUBv3x2WJDrCkS16QOeGSZn6sF
        y9BwGDDA=; b=a1ENtT/Kd7sEGN62GAhjp4PF0eOGkwiuFTaHixKRImwlqxVJjGB
        tKW5nMApOSWk0uUQ871fNLq8480laJcgHpmaK1x0Klpy+cTCLzCl/oYjCLuDn94A
        kRzS8wNPGgtWMxSWyLL2G3Loft5y4HhwSDYuFfxC87arv7nBfzbWWeW4mOBdIDB8
        h0F7AoHmI1Ezo9HI6DRnDumpeAKvXLKpY9gktbcA8Pf21Fhm291PYtqeQliLnva8
        muW4htisShgzyKXsOWafQXG6e8H1uPJdDfirl/FBsDBWPpnF1uOFowBlYY0DOP5C
        VTJafPktTik6jWUF1Zk/Ike8Yf26I6w69tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680811396; x=1680897796; bh=alW+rItMMZUBv3x2WJDrCkS16QOeGSZn6sF
        y9BwGDDA=; b=MucNCKYY+nfqafXm7sZiWP3KvPbHU5kIN2coW9dtgElWX2c4PKl
        n8xoeGpegG69jbejq8lxquHD3k7hOKcYUX6YsrkVeT6XU/3Ju3feFlTefh9VUJOy
        MyJ/SDJWSQrkyK4eO992pjmPgAe36gp8CusyHNq5tzrlk1gaDDXqD/bsH8xvWyDH
        U/zhiI8zG98YmPaRlz5vKtZNnLSzC5zyY8ly1ZMLOrwYgNJhXFaUZpqE5moP0DpK
        Ya2C8M/suVJhTLD8+fODywpuF7+MLQfDdX2dKaZbX3EqkEGZCHIEEpNCoW1UrnfD
        OTbA7AY5Lf/dJ+Og58KAjMsfhWIlfylkwJw==
X-ME-Sender: <xms:hCUvZLYKcpD7tr3s6NTe1ZHTlZWf9IxM1lQeHzn7r7-rsOfRdKnlJg>
    <xme:hCUvZKYv7PGRWx1SCo19N4xJFGR-BePPajWWtFJRKLuVYRclKNFDJOxyYCZPPIlif
    xpVSrXKEk6xkfLM3g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hCUvZN_FxwwvxXNGWHoM_6a888kMP9dKo1FlYiXsuNl4n2Rm6jixPg>
    <xmx:hCUvZBoGTf1PLQrA-qQo7qK9iGjRxSG_a0MEHP3_-wi1U7FmCcJbkA>
    <xmx:hCUvZGq5gnWWA0mWEkAKkOdpNfdoM-FPGeuN40JKYbGolxYaGFuyAQ>
    <xmx:hCUvZN3JH7YqIgDH0SzUuJgIHOS7vg5AhacnyODNmV8Es7VswefKbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BB63B6008D; Thu,  6 Apr 2023 16:03:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <bc11f501-f020-4e90-9588-5d234e96159d@app.fastmail.com>
In-Reply-To: <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
 <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
Date:   Thu, 06 Apr 2023 22:02:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir Oltean" <vladimir.oltean@nxp.com>,
        "Matt Evans" <mev@rivosinc.com>
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023, at 19:04, Linus Torvalds wrote:
> On Thu, Apr 6, 2023 at 1:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> Some of the less common I/O accessors are missing __force casts and
>> cause sparse warnings for their implied byteswap, and a recent change
>> to __generic_cmpxchg_local() causes a warning about constant integer
>> truncation.
>
> Ugh. I'm not super-happy about those casts, and maybe sparse should be
> less chatty about these things. It shouldn't be impossible to have
> sparse not warn about losing bits in casts in code that is statically
> dead.
>
> But we seem to have lost our sparse maintainer, so I've pulled this.
>
> I also wish we had a size-specific version of "_Generic()" instead of
> having to play games with "switch (sizeof(..))" like we traditionally
> do.
>
> But things like xchg() and user accesses really just care about the
> size of the object, and there is no size-specific "_Generic()" thing,
> and I can't think of any cute trick either.

There is actually one idea I had a while ago that would (mostly)
solve this:

As far as I can tell, almost no users of
{cmp,}xchg{,_local,_relaxed,acquire,release} that actually use
8-bit and 16-bit objects, and they are not even implemented on
some architectures.

There is already a special case for the 64-bit xchg()/cmpxchg()
variants that can get called on 32-bit architectures, so what
I'd prefer is having each architecture implement only explicit
fixed length cmpxchg8(), cmpxchg16(), cmpgxchg32() and optionally
cmpxchg64() interfaces as normal inline functions that work on
the respective integer types.

The existing interfaces then just need to deal with non-integer
arguments (four byte structures, pointers) that they handle today,
as well as multiplexing between the 32-bit and 64-bit integers
on 64-bit architectures. That still leaves a theoretical sparse
warning when something passes a 64-bit constant, but I don't think
any code does that.

     Arnd
