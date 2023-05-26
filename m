Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA10712961
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjEZPZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 May 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjEZPZl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 11:25:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB310E4;
        Fri, 26 May 2023 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fzBUUGDSePeEiX9gwB0ZqI0CRSJxQ9nzVTEYiUKgGDE=; b=tnSiDcCvgJS2frnsNgMYmk1Lt7
        nivbEypY3fFfz1VyUE8RweW7oW3gnI+I+XmlT3yKiVDDw9vuBR/BM5fRgWzRm/kuD1KAzFPuiG46J
        Uop+W0XLrLNr7vBlw6CjJHnn1IxESBuoCUjq3n8slDwXiXh2ddvzaSIEJTJX1Bxvh0rZw/29BPxFw
        0oryF1mbYJwKzqqJQ5bCEGZ9Ax+Nlt+gHnwzs8wpXtGkEMUIZa+uQAy+g4aNUhfMU7Iae/PqrKsxh
        fUa8epXuIMDwCcYjHGBD1FRv4FCSpl+hQsjR00kt86g50aeN+EARJeNJScoCc7mL/i6hfnUtHAFAD
        a9M4bJuQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2ZJL-002xeh-3B;
        Fri, 26 May 2023 15:25:00 +0000
Message-ID: <90e1b43d-92a4-50fc-e82d-4590a9651de1@infradead.org>
Date:   Fri, 26 May 2023 08:24:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
 <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
 <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
 <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
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



On 5/26/23 03:27, Akira Yokosawa wrote:
> Hi Randy,
> 
> On 2023/05/26 13:51, Randy Dunlap wrote:
>> Hi Akira,
>>
>> On 5/25/23 20:17, Akira Yokosawa wrote:
>>> On Wed, 24 May 2023 16:11:52 +0200, Peter Zijlstra wrote:
>>>> On Wed, May 24, 2023 at 11:03:58PM +0900, Akira Yokosawa wrote:
>>>>
>>>>>> * All ops are described as an expression using their usual C operator.
>>>>>>   For example:
>>>>>>
>>>>>>   andnot: "Atomically updates @v to (@v & ~@i)"
>>>>>
>>>>> The kernel-doc script converts "~@i" into reST source of "~**i**",
>>>>> where the emphasis of i is not recognized by Sphinx.
>>>>>
>>>>> For the "@" to work as expected, please say "~(@i)" or "~ @i".
>>>>> My preference is the former.
>>>>
>>>> And here we start :-/ making the actual comment less readable because
>>>> retarded tooling.
>>>>
>>>>>>   inc:    "Atomically updates @v to (@v + 1)"
>>>>>>
>>>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>>>                             non-native
>>>>>
>>>>>>   the operations to be described in the same style.
>>>>>>
>>>>>> * All conditional ops have their condition described as an expression
>>>>>>   using the usual C operators. For example:
>>>>>>
>>>>>>   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
>>>>>>   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
>>>>>>
>>>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>>>
>>>>> Ditto.
>>>>
>>>> How about we just keep it as is, and all the rst and html weenies learn
>>>> to use a text editor to read code comments?
>>>
>>> :-) :-) :-)
>>>
>>> It turns out that kernel-doc is aware of !@var [1].
>>> Similar tricks can be added for ~@var.
>>> So let's keep it as is!
>>>
>>> I'll ask documentation forks for updating kernel-doc when this change
>>> is merged eventually.
>>
>> What do you mean by that?
>> What needs to be updated and how?
>  
> I mean, scripts/kernel-doc needs to be updated so that "~@var"
> is converted into "**~var**".
> 
> I think adding "~" to the substitution pattern added in [1] as follows
> should do the trick (not well tested):
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2486689ffc7b..eb70c1fd4e86 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -64,7 +64,7 @@ my $type_constant = '\b``([^\`]+)``\b';
>  my $type_constant2 = '\%([-_\w]+)';
>  my $type_func = '(\w+)\(\)';
>  my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> -my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> +my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>  my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
>  my $type_env = '(\$\w+)';
> 

At a quick glance, that looks OK.
I haven't had enough coffee yet to be able to read all of that regex though.

Just submit the patch (when it is needed) to see what breaks. :)

>>
>>
>>> [1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")
>>

Thanks.
-- 
~Randy
