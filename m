Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9645ADA70
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiIEUxV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIEUxT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 16:53:19 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D14F68D;
        Mon,  5 Sep 2022 13:53:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id ACBD22B05AEA;
        Mon,  5 Sep 2022 16:53:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 05 Sep 2022 16:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662411197; x=1662414797; bh=dK/8rV1ixS
        xoa3WuxRwDMTPWUXrVCRrggkOnUiQlxw4=; b=MEA6QzLjPFUjI1Jecqtm+r/jOB
        fH11vuykjNMP+1etv/zP9NNBdn9udN5LkV+Ct+TUQLdRULDt7N9bnPln4Fv0oXht
        7Ye6xJ/461F9XE8S+DFquqrmfg4rtyuGxlLCz2N4WYIeuU3oD1NSZ6OmgYOFX3si
        xPVRKq77IRHtHZRUK0/M/VaH1HULk50S7Ih67mdX7syusBJ7lcf7c+XEubdrqNSE
        bf2/RzjAxLMOihFnsMgIbpod1n8i4BMHEp2kBlj+CR1c4xY2Wwwt8gle2DP4mF38
        CMk24WaxHF00BmvDQfuQBOOnjixE06oCLNuwQGLaD/iF30dha6WkWMDoI6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662411197; x=1662414797; bh=dK/8rV1ixSxoa3WuxRwDMTPWUXrV
        CRrggkOnUiQlxw4=; b=vcE3ORENKCrd50xSDf6Ed+jbmMA+YBCFmZbt+22COH0b
        Z+Fba7JmxBL89v7bmrCNQvDFdudcGihSTb/pnbzj4fwExtSNjUGZ9Dnhba2u51Pd
        3jgO6jQipq3JZ/z4N4KJT3dvOegzxFdxQgNDRqrGQSwh/Ytm/6jNUS2CNKZwRHVV
        1LSenuTFIjr0b4QpJe9TE3E2EzG09fecRM8YBq6gJq0f+trEaRbKVrtY1OkCEH27
        hQiSurJ+2Sofg8IbkUq3oK1K6XrsjPJRutwRv5Imde+mCmTuSgTnGFsgyu7E2N9S
        P71wzsxQ3qjEhdY50u1VwD+Qhg8Ye8mJAo8BWunbFQ==
X-ME-Sender: <xms:vGEWY_l1RVkZ0tFGgq6zAqW1dfRM_gakuHiR9J9rH2w6op7XJQfNeg>
    <xme:vGEWYy0NE2LWuinioM8jjbMwDxzi21jVD58p-MZ9v-egSGmQgKFZYOgPUn07a8xn4
    wezNQZkZDAXfcAg7Q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vGEWY1pizwIrTNh2juMu0gIJ1MVPB_wwZXqggYMRDH8sFDNx2nSrEw>
    <xmx:vGEWY3kohYC7rBlSjjtRKh1N0pM2Y24mIc2LZBnyHKk2E4LR6Sgp9w>
    <xmx:vGEWY9213tQfHTe7XVgVeiPyjAYk-XMWmdAIfJ20qYGZPPbsKVtUlA>
    <xmx:vWEWY1-AbhYhOg3R63filW1MYZhngHvxdK0UrUhNQR9crlbqXG29MCJaWxk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 584D9B60083; Mon,  5 Sep 2022 16:53:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <8d931abd-ce7d-45da-b47c-239d4c7cd72f@www.fastmail.com>
In-Reply-To: <CACRpkdZemHScp9WW-7LaGtcXuvT2qzs_7nXS60icSWtPkEwMHg@mail.gmail.com>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
 <CACRpkdZemHScp9WW-7LaGtcXuvT2qzs_7nXS60icSWtPkEwMHg@mail.gmail.com>
Date:   Mon, 05 Sep 2022 22:52:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 5, 2022, at 9:30 PM, Linus Walleij wrote:
> On Thu, Aug 18, 2022 at 12:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Aug 18, 2022 at 11:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> > I'd like this applied to the alpha tree if there is such a
>> > thing otherwise maybe Arnd can apply it to the arch generic
>> > tree?
>>
>> Sure, I can do that.
>
> Could you apply this to the arch tree? I see no signs of life from
> the alpha maintainers.

Sure, I can do that. I also realized that we can actually fold
all of asm-generic/io.h into linux/io.h directly once this is
complete for all architectures. Probably better to leave that for
6.1 though.

I wonder if I should also add send a patch to mark Alpha as
'Orphaned' like we did for arch/ia64 a while ago.
It's already marked as 'Odd fixes', but the last pull request
from Matt was over a year ago now.

>> > +/*
>> > + * These defines are necessary to use the generic io.h for filling in
>> > + * the missing parts of the API contract. This is because the platform
>> > + * uses (inline) functions rather than defines and the generic helper
>> > + * fills in the undefined.
>> > + */
>> > +#define virt_to_phys virt_to_phys
>> > +#define phys_to_virt phys_to_virt
>> > +#define memset_io memset_io
>> > +#define memcpy_fromio memcpy_fromio
>>
>> We tend to have these next to the function definition rather than
>> in a single place. Again, I'm not too worried here, just if you end
>> up reworking the patch in some form, or doing the same for the
>> other architectures that would be the way to do it.
>
> I looked into this, for parisc it was pretty straight forward. alpha has
> a bunch of competing static inlines and externs and what not, I don't
> see it helping to inline this, IMO it's actually better like this: "those
> were defined somewhere in the birdnest of ifdefs above".
>
> If it is a big issue I can start to pry into it.

I would move the #defines specifically because the header is such a
mess, that way it should become clearer to anyone looking at the
file where the declaration is.

The header uses an unusual trick of declaring an extern
function first and then optionally overriding it with an
inline. I think it uses 'extern inline' in place of
'static inline' because older gcc versions would otherwise
reject this, not because it actually depends on the 'extern
inline' semantics.

It's probably not too hard to move the macros next to the
'extern' declaration for those functions that have both an
'extern' and an 'inline' version. Don't spend too much
time on getting it right if it doens't work right away though,
I don't think it matters all that much.

       Arnd
