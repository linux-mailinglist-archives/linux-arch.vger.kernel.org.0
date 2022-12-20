Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016CD6519FD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 05:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiLTEb5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 23:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTEby (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 23:31:54 -0500
X-Greylist: delayed 1129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 20:31:53 PST
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB18DEBB;
        Mon, 19 Dec 2022 20:31:53 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BK4Bcj21617553
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 19 Dec 2022 20:11:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BK4Bcj21617553
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1671509502;
        bh=4fkXFH0sW5ZGQC33LFxm1QzpGPoew8Q0xRPlzvCq1nQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Pi5fP/o5I2P1JC2H3FoVs5Rgkk/IsKgVSe499ohBroXNnQWUaqlfizGtLhY3jnIH4
         BVBgKJ2JdCZvkXA3PqduOSIWKj97/qSH8ucxQPkuAgaTHgCKLVeDHijKmjdRiBus/C
         16cOgJMYRHlr4XtkFoneI3WWGJ42aNqBth5twrPgBZgE1aBbUTvGjRWgVWfG7WZCjO
         lrETkKASOjTTNZAwHR21esKipc8XRi4fA6dqXXVJ754vl0xn7lKq4sMWuiwn7k4GoL
         V/e8eZL5+3/AiYXJuq1pDKyIwAV3HuzExlLYUPrpVOJcHxHnOZHz6ZEJlPIh0h3Yhn
         1tde5K+LCO3wQ==
Date:   Mon, 19 Dec 2022 20:11:37 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
User-Agent: K-9 Mail for Android
In-Reply-To: <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
References: <20221219153525.632521981@infradead.org> <20221219154118.889543494@infradead.org> <Y6CJsWBhcbKatZNg@zx2c4.com> <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net> <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com> <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
Message-ID: <7C23FA3C-A967-4BAE-970B-5E6FAF4DE037@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On December 19, 2022 7:50:47 PM PST, Herbert Xu <herbert@gondor=2Eapana=2Eo=
rg=2Eau> wrote:
>On Mon, Dec 19, 2022 at 06:03:04PM +0100, Jason A=2E Donenfeld wrote:
>>
>> Is there a patch at the end of the series that adds it back in to use u=
128?
>
>Could we do some ifdef trickery to reduce the amount of code churn
>please? Changing everything away from u128 and then back to it seems
>silly=2E
>
>Thanks,

Seems like "merging common code snippets" is something we at least used to=
 do with single patches=2E=2E=2E
