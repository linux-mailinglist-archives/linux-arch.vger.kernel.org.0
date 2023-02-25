Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180B6A26D7
	for <lists+linux-arch@lfdr.de>; Sat, 25 Feb 2023 03:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBYCoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 21:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYCoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 21:44:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D95193E4;
        Fri, 24 Feb 2023 18:44:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0266441A42;
        Sat, 25 Feb 2023 02:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677293039;
        bh=i/EW8iI1WXt3iL181qkF6snb7P647ktI1koCI56RqSw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=wTmCtYW+KwZhGzbBJaPs5CX+u/g5Vj24/8vV8C5IxFsnS6gcbl9eXGB06XyCFjUi8
         2Qr8vzyRmW6JB6jEg6L9EAKEkzyjQH73z4GYsDasG1u8Bu2afUBnVCbcvmrkfGynuv
         /vhRmoN9P1FeVyITmZa8faqJmk9qE9fPPYKRm+2i7u5QPq4HIdX4j8/EVCjb0JjfTI
         DnzCwEieu2sahFb9Q5gHEpcLhP+2bgqdJ6WlTKR7mikinEgsfKOa2WJ1fOd8wNGOUE
         tWkm/rrwIjkNfbXx7B5NdrNdrTba51tl6DnN5uqJvnuATN/HKkBRXVvOUu/9GicKFo
         plj+l7Ddw+Skw==
Message-ID: <61f734d6-1497-755f-3632-3f261b890846@asahilina.net>
Date:   Sat, 25 Feb 2023 11:43:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: ioctl: Add ioctl number manipulation functions
Content-Language: en-US
From:   Asahi Lina <lina@asahilina.net>
To:     Gary Guo <gary@garyguo.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
References: <20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net>
 <0818df3a-76c9-4cb3-8016-4717f4d5bf18@app.fastmail.com>
 <20230225003852.1bbedc54.gary@garyguo.net>
 <8d6575bc-ffd8-fe03-c46f-eba9cfdbcbfa@asahilina.net>
In-Reply-To: <8d6575bc-ffd8-fe03-c46f-eba9cfdbcbfa@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25/02/2023 11.38, Asahi Lina wrote:
> On 25/02/2023 09.38, Gary Guo wrote:
>> On Fri, 24 Feb 2023 09:43:27 +0100
>> "Arnd Bergmann" <arnd@arndb.de> wrote:
>>
>>> On Fri, Feb 24, 2023, at 08:36, Asahi Lina wrote:
>>>> Add simple 1:1 wrappers of the C ioctl number manipulation functions.
>>>> Since these are macros we cannot bindgen them directly, and since they
>>>> should be usable in const context we cannot use helper wrappers, so
>>>> we'll have to reimplement them in Rust. Thankfully, the C headers do
>>>> declare defines for the relevant bitfield positions, so we don't need
>>>> to duplicate that.
>>>>
>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>  
>>>
>>> I don't know much rust yet, but it looks like a correct abstraction
>>> that handles all the corner cases of architectures with unusual
>>> _IOC_*MASK combinations the same way as the C version.
>>>
>>> There is one corner case I'm not sure about:
>>>
>>>> +/// Build an ioctl number, analogous to the C macro of the same name.
>>>> +const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
>>>> +    core::assert!(dir <= bindings::_IOC_DIRMASK);
>>>> +    core::assert!(ty <= bindings::_IOC_TYPEMASK);
>>>> +    core::assert!(nr <= bindings::_IOC_NRMASK);
>>>> +    core::assert!(size <= (bindings::_IOC_SIZEMASK as usize));
>>>> +
>>>> +    (dir << bindings::_IOC_DIRSHIFT)
>>>> +        | (ty << bindings::_IOC_TYPESHIFT)
>>>> +        | (nr << bindings::_IOC_NRSHIFT)
>>>> +        | ((size as u32) << bindings::_IOC_SIZESHIFT)
>>>> +}  
>>>
>>> This has the assertions inside of _IOC() while the C version
>>> has them in the outer _IOR()/_IOW() /_IOWR() helpers. This was
>>> intentional since some users of _IOC() pass a variable
>>> length in rather than sizeof(type), and this would cause
>>> a link failure in C.
>>>
>>> How is the _IOC_SIZEMASK assertion evaluated here? It's
>>> probably ok if this is a compile-time assertion that prevents
>>> the variable-length arguments, but it would be bad if this
>>> could lead to a BUG() or panic() in case of a user-supplied
>>> length that is out of range.
>>
>> This is a very good point.
>>
>> The code, as currently written, will cause a compile-time error if
>> `_IOC` is used in const contexts (i.e. used in const generics
>> arguments, or inside a `const {}` block), and it will become a runtime
>> `BUG()` if used elsewhere.
>>
>> We do have a facility to enforce compile-time checks, that's
>> `kernel::build_assert!()`. If runtime values are used and the
>> compiler can't optimise these assertions out, a link failure would
>> be triggered just like how our C code does that.
>>
>> Lina, could you change these `core::assert!` calls to build assert?
> 
> Thanks, I'll do that for v2!

Come to think of it, _IOC() isn't even public right now, so you can only
use it via the typed wrappers that take an actual struct to take the
size of. So it would only (always) panic if someone tried to use it with
a huge structure definition. But anyway, these clearly should be
compile-time assertions, so I'll change it to that. If someone wants to
use dynamic sizes in the future we can refactor it then.


~~ Lina
