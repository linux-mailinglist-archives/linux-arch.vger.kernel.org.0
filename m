Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8186025FB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJRHkW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJRHkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 03:40:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1530F58;
        Tue, 18 Oct 2022 00:40:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so13048978plr.6;
        Tue, 18 Oct 2022 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOfQD7WV26JdvCO9u7YC2zo8JQP2uvgx0evc5JAvmCQ=;
        b=KG/nFedhXqMIGHRyrdtJN9vNJh91Pzsy7nl/Y7WeRghoTILU4tAEjKBgWcEYzeUgMc
         TQQcW91xU5mSOJHYOB2C3Na5bm5qCCU0Hi+l2DxKn3Na5SGZr7PImfSthBLVe/2V1x/K
         FKAXKuGVjoNVdyJaavdBSnxTPB400yl7ASpE3w9GCgrhGLSCblGCDrgz/MyjQjOJJPwK
         j49QIkiDzyJRs+tFEZca1b5Y7Ka7bXPgvK/5XAILOrdc7GaJDeN/P/SntGrjHRwfXCCm
         nHwlthXJs2t66j/LUZOqk6vgasK3w9v0MoNDtLI0W02l/JaIhOkRqA9+zmNGKVZ+dNcd
         LJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOfQD7WV26JdvCO9u7YC2zo8JQP2uvgx0evc5JAvmCQ=;
        b=uduaPBLo3p53QTCMy0AV8LvdXT9zVccpiCiZf8SNj2sI3CNZPf6iqkraSp5ELjCX84
         WHh7JFJfdPe5iZzVxGLi/OjSPA2tgqFKNqTTjueZubLCviUwpV1CuWO5Selbz9ASldi5
         Q+K1DM4vCxevlWX3FXVZL3r+FDKY0gLfT4gp8oeY3IcS7A2/iKm1GgPJdMSDKOB7mHJ/
         Db1O4uPIl01sEsOZgbIPBRVTxXnrTu51CrLBXTsxrb/tl1vSv3jr4O4s9P8p6Xbs928c
         fI+B0vHke6J974xBNvb0L/4ZxefZ0ddQKFbqDfMU6i0TaL9wcHGo6aB3WRebt/HtAiW6
         jimQ==
X-Gm-Message-State: ACrzQf1RFrDzzhpLC80/KWminJPLgWkfiKElMe5pFACdm/qOQsVpBlgC
        k8mtkUbr++n7kZ++Jxy85H4=
X-Google-Smtp-Source: AMsMyM5NGsernZyNo6NTm8WlTjWTBAkj4adEi/xXU4fL9BoeS8K4GNEYUKDDzDXzfD29ktWYEtK/fA==
X-Received: by 2002:a17:90a:f192:b0:20d:2ea6:4b18 with SMTP id bv18-20020a17090af19200b0020d2ea64b18mr2158151pjb.27.1666078812674;
        Tue, 18 Oct 2022 00:40:12 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r16-20020a63e510000000b004308422060csm7304780pgh.69.2022.10.18.00.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:40:11 -0700 (PDT)
Message-ID: <a91e8216-7767-9126-e1d2-c67846cf32fc@gmail.com>
Date:   Tue, 18 Oct 2022 16:40:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for
 writel() example
To:     Arnd Bergmann <arnd@arndb.de>, Parav Pandit <parav@nvidia.com>
Cc:     bagasdotme@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
 <12f51033-1461-43f9-8d8d-cd726fbb4758@app.fastmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <12f51033-1461-43f9-8d8d-cd726fbb4758@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Oct 2022 08:44:09 +0200, Arnd Bergmann wrote:
> On Tue, Oct 18, 2022, at 3:37 AM, Akira Yokosawa wrote:
>> On 2022/10/18 5:55, Arnd Bergmann wrote:
>>> On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
>>
>> "a barrier" can mean "any barrier", which can include a full barrier
>> in theory.
>>
>> So I'd rather make the substituted text read something like:
>>
>>   Note that, when using writel(), a prior wmb() or weaker is not
>>   needed to guarantee that the cache coherent memory writes have
>>   completed before writing to the MMIO region.
>>
>> In my opinion, "or weaker" is redundant for careful readers who are
>> well aware of context of this example, but won't do no harm.
> 
> I think that would be more confusing than either of the other variants.
> 
> Anything weaker than a full "wmb()" probably makes the driver calling
> the writel() non-portable, so that is both vague and incorrect.

Do you mean there is a writel() implementation somewhere in the kernel
which doesn't guarantee an implicit wmb() before MMIO write?

Or do you mean my version is confusing because it can imply a weaker
write barrier is sufficient before writel_relaxed()?

I'm confused...

        Thanks, Akira

> 
> The current version works because it specifically mentions the correct
> barrier to use, while Parav's version works because it doesn't
> make any attempt to name the specific barrier and just states that
> adding one is a bad idea regardless.
> 
>       Arnd
