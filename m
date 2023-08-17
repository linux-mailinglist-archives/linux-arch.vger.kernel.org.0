Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDD77EF5A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347763AbjHQDEm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 23:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347732AbjHQDEO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 23:04:14 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415610FF
        for <linux-arch@vger.kernel.org>; Wed, 16 Aug 2023 20:04:12 -0700 (PDT)
Message-ID: <5c3829b0-1844-23b9-c708-88095d510954@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692241449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnrzOKIT2G97aygX0TXgfM6PIy16jcjv8My4Su4wFVc=;
        b=ej8uXug0Cd6LaTksy+HPPAsoH6A1KatkKy5VHgqAzAqspajnt1FXaWA6YDqZp5eVuei3Xo
        XXdIoGQDD9PPo69A1QLkSaOGrb/mfKJ/95q2MyjAAZmKJgwdHqmpwzHZZK/tCKDWZKLxr5
        UI0B+BISlAfu/u1DEzX5IA08JjtXXq8=
Date:   Thu, 17 Aug 2023 11:03:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Yanteng Si <siyanteng@loongson.cn>,
        Patrick Yingxi Pan <pyxchina92929@gmail.com>
Cc:     seakeel@gmail.com, Alex Shi <alexs@kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230811080851.84497-1-gang.li@linux.dev>
 <CANJ3EgExk-TC=qx0Dn7wA-RfTE-h3E_E+i1MctvhvV-VEUJFnQ@mail.gmail.com>
 <CANJ3EgGNQhGdppzYWxLOoJ9kqdCVxOOCi89-6qq638fyqnm2fA@mail.gmail.com>
 <24cf55ad-e40c-4d7c-9007-2906b26d74c2@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <24cf55ad-e40c-4d7c-9007-2906b26d74c2@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/8/16 11:06, Yanteng Si wrote:
> 
> 在 2023/8/15 19:08, Patrick Yingxi Pan 写道:
>> I haven't read over the entire text yet, but I've found a couple of 
>> places
>> where it goes __slightly__ beyond naive translation. The added paragraphs
>> seem to be supplementary remarks which I believe will help understanding
>> to some degree. But will they make future maintenance harder by breaking
>> the one-to-one correspondence between the two versions? After all the
>> original version is perfectly understandable without the remarks.
> 
> Yes, this can cause some maintenance headaches, but we can label it in a 
> suitable way：
> 
> .. note::
> 
>        译者xxx， bulabulabula.......
> 
>        (eg: vim Documentation/translations/zh_CN/core-api/cachetlb.rst 
> +189)
> 
> 
> Or simply in this way：
> 
> （译者注： bulabulabula.......）
> 


Good advice.

>>
>> In some other places, the translation lost some information which can
>> (and should) be fixed easily.
> 
> You're right！ translations with missing information are not accepted by 
> readers.
> 
> faithfulness > expressiveness > elegance    信 > 达 > 雅
> 

Since both of you agree to preserve the original meaning in English as
much as possible, and I'm not strongly insisting on "elegance" either,
we can eliminate this overly modified translation method in v2.
