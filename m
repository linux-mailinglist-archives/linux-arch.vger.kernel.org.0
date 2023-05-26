Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A7711EFE
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 06:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjEZEvo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 May 2023 00:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjEZEvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 00:51:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05651119;
        Thu, 25 May 2023 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=movR2kgaqhuJ0kfo+Y7vgQbU8GIGLJXozmT4bEwaGeU=; b=w5z2ShyZWO3yUGUdUK+xJe80v+
        7mch2mHhZtYK6vWzLRnG9KczU7EbFNKu2GJu4P3uLK3znFuByYuwKN6o3ajPVUeVYAt/GyBmSgyxd
        U3jfdJfQAhBIt1q9z77QArvay08XGBovrGU+ws4GnyjOyfnt5tKme6eiBRi35wOv4L8nF1ixdGcs4
        T5amoGvYHythK8KxLzBbxd+zvIJtiBjzQ+8d5W7MM3TELcqrHFTNnG1mN4E/4hfvJEw3hYkPYcdRP
        DL58OIxsPfXlhwkJ+0kIVftMLplJHAL4PA4uL8wUWdTb7vLTzvVUvXt0FUZpWlHi0Ya/doWAbNk/p
        Gni4NbEA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2PQQ-0011Tf-23;
        Fri, 26 May 2023 04:51:38 +0000
Message-ID: <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
Date:   Thu, 25 May 2023 21:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
 <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Akira,

On 5/25/23 20:17, Akira Yokosawa wrote:
> On Wed, 24 May 2023 16:11:52 +0200, Peter Zijlstra wrote:
>> On Wed, May 24, 2023 at 11:03:58PM +0900, Akira Yokosawa wrote:
>>
>>>> * All ops are described as an expression using their usual C operator.
>>>>   For example:
>>>>
>>>>   andnot: "Atomically updates @v to (@v & ~@i)"
>>>
>>> The kernel-doc script converts "~@i" into reST source of "~**i**",
>>> where the emphasis of i is not recognized by Sphinx.
>>>
>>> For the "@" to work as expected, please say "~(@i)" or "~ @i".
>>> My preference is the former.
>>
>> And here we start :-/ making the actual comment less readable because
>> retarded tooling.
>>
>>>>   inc:    "Atomically updates @v to (@v + 1)"
>>>>
>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>                             non-native
>>>
>>>>   the operations to be described in the same style.
>>>>
>>>> * All conditional ops have their condition described as an expression
>>>>   using the usual C operators. For example:
>>>>
>>>>   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
>>>>   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
>>>>
>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>
>>> Ditto.
>>
>> How about we just keep it as is, and all the rst and html weenies learn
>> to use a text editor to read code comments?
> 
> :-) :-) :-)
> 
> It turns out that kernel-doc is aware of !@var [1].
> Similar tricks can be added for ~@var.
> So let's keep it as is!
> 
> I'll ask documentation forks for updating kernel-doc when this change
> is merged eventually.

What do you mean by that?
What needs to be updated and how?


> [1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")

thanks.
-- 
~Randy
