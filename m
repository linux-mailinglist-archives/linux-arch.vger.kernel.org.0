Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3F5FC874
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJLPd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJLPdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 11:33:25 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE3E319C;
        Wed, 12 Oct 2022 08:33:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F14D5C00D6;
        Wed, 12 Oct 2022 11:33:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 12 Oct 2022 11:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665588801; x=1665675201; bh=p46JJgtAdn
        om3Y0Add8r9JIUoWNZUEiLnPyZNJRpZL0=; b=grWUM07WK4ujl6DYMF2oCDykzc
        R2YXZIK+2jB3phTxqA5kFcHsLaChyfa6wFn3WgiZ+UmygkFPRgjvD7Fst/M0TL2v
        OtUg6YzMEGSjlW1/FFmhkXY4hQLkpXi+uEM8beKFx/cjx3LAV6lFs0Al5Wp+BXez
        YKFvvL8HcZFOYSpGx+0/9fVBZkUAtIjib7MuBcy5a5ozl4XQrpogbG0fHnIC7+VI
        s/GLRc+wn5ulBV10Q+ONwn1w7Jxng17EQ4XIP9UWFVcqlpVYXojrW4LIZebij5r6
        c9Taq7bJrILbSRkPahh/1hBhPuLbh5fh1wD96rdSG5iH9v+DWXSTIJc5EwYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665588801; x=1665675201; bh=p46JJgtAdnom3Y0Add8r9JIUoWNZ
        UEiLnPyZNJRpZL0=; b=r8MRYbUFdGX2N0CSQslCsGokunE10rTGgPPhwrQaxasP
        F1kGKq0kclUrE2MBRyWbvfJ+8Dxzg2sbc45bNIGTCSyewIK8d7yEXz3/qzuEsTSo
        MQZaNNa8R5rd6XcHHyJdysG5QIvSmq9wypWlIkcYYEoqC1X4nZYccmVu2l298qFg
        1B34GqRkkCnpbQX1u/MFq2TblhEVDZVSoEoxJDcbqATPz77766knTBj1SugdjFBx
        hLrWdVVnHfn3571d31+BZSFnUC/57c1A8pB5Ltn0HdakpuRJmPIGdWFSMBEgFVNG
        n4cJNb0MPrNHmdJyEw/KA6Y8kHCDi5JsYKC1L7JVFw==
X-ME-Sender: <xms:P95GY7mexFwbDp5ju7nPMzw_fEYmfJ26oCj4skT5_8b5YNP4NogPkw>
    <xme:P95GY-3m0y7QOQM18D0qvemnMrfCDKRSsWA8ITtVPObXiKkpwxMg588eo3ZZ9CA87
    8JjiddEwsYJkXFf2TE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:P95GYxqZjrHW-bsevMX0QjgE2Pa_BYfH4A23Xz1Qtx_a2gRaaH_Bdg>
    <xmx:P95GYzn4H6y8PRSNuFtCAgUThrxt-L-u5yqYFVAjal-OCicPm83Kqw>
    <xmx:P95GY52qb4EvffvFOIfUw58Ev6fT-Tqx_WSet0E55uGTRiQJhSGF8Q>
    <xmx:Qd5GY2kGaQGz9jZMxvPYvCizq-6ImEQuaWATbJ9RSqzZRFkpyjD1AA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 68F12B60086; Wed, 12 Oct 2022 11:33:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <e99d33ff-4bfe-4727-a5ca-f4987b871ccd@app.fastmail.com>
In-Reply-To: <20221012140519.GA2405113@roeck-us.net>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
 <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
 <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
 <2e110666-7519-4693-8a89-240cbb118c7e@app.fastmail.com>
 <20221012140519.GA2405113@roeck-us.net>
Date:   Wed, 12 Oct 2022 17:32:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 12, 2022, at 4:05 PM, Guenter Roeck wrote:
> On Tue, Oct 04, 2022 at 10:28:24PM +0200, Arnd Bergmann wrote:
>> On Tue, Oct 4, 2022, at 9:42 PM, Guenter Roeck wrote:
>> > On 10/3/22 06:03, Arnd Bergmann wrote:
>> >> On Mon, Oct 3, 2022, at 12:45 AM, Guenter Roeck wrote:
>> >
>> > Looks like something was missed. When building alpha:allnoconfig
>> > in next-20221004:
>> >
>> > Building alpha:allnoconfig ... failed
>> > --------------
>> > Error log:
>> > <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> > arch/alpha/kernel/core_marvel.c:807:1: error: conflicting types for 
>> > 'marvel_ioread8'; have 'unsigned int(const void *)'
>> >    807 | marvel_ioread8(const void __iomem *xaddr)
>> >        | ^~~~~~~~~~~~~~
>> > In file included from arch/alpha/kernel/core_marvel.c:10:
>> > arch/alpha/include/asm/core_marvel.h:335:11: note: previous declaration 
>> > of 'marvel_ioread8' with type 'u8(const void *)' {aka 'unsigned 
>> > char(const void *)'}
>> >    335 | extern u8 marvel_ioread8(const void __iomem *);
>> >        |           ^~~~~~~~~~~~~~
>> 
>> Right, I already noticed this and uploaded a fixed branch earlier today.
>> Should be ok tomorrow.
>> 
>
> Unfortunately that did not completely fix the problem, or maybe the fix got
> lost. In mainline, when building alpha:allnoconfig:
>
> arch/alpha/kernel/core_marvel.c:807:1: error: expected '=', ',', ';', 
> 'asm' or '__attribute__' before 'marvel_ioread8'
>   807 | marvel_ioread8(const void __iomem *xaddr)
>
> The code is:
>
> unsigned u8
> marvel_ioread8(const void __iomem *xaddr)
>
> The compiler doesn't like "unsigned u8".

Right, I fixed up a different bug and introduced this wrong type.
I didn't catch my mistake until after the pull request was
merged, but fixed it in

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=2e21c1575208

which should be in linux-next. I was giving it a little more
time to be see if there are any other regressions I caused.

     Arnd
