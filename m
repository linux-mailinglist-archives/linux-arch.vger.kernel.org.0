Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912627D4FC8
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjJXMbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJXMbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 08:31:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97008186;
        Tue, 24 Oct 2023 05:31:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698150662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HP05YnYT52F/EpUarcu+n7nWv8BJHObUjbTKRDaDnJY=;
        b=j5mUbwy44Qq9kxY8+ATVL2R33Mz4pyF9vZEY1eQgYZpgmuP8hPbbj0ADpyO9TbBnM+sIFa
        Wm5Pm+1wuX10acKf3RQdVjgDwwSll7IDDESNEX1xcv9C66oizpMgClCfojX+U5FsUGu7ke
        1NzDqh30dC28TmWdyZH7bsMQYkicderH7ZK7ZQYoFkX6tZ24RE3r+VLTdVX3gc5TxjENgn
        EGWzZ6QJAPmWa2bTzSYVSmIjs67q6YJ4rNQuk2AP0rs0S6OgkOTRJd3JinHR+vNljJfxZz
        mKjeZy5pxzNdl4ByOHSuVkDhHCaxfOz1Oir+jfE9PMqC6pzgQFCzg2n++4xXew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698150662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HP05YnYT52F/EpUarcu+n7nWv8BJHObUjbTKRDaDnJY=;
        b=qrCmO2SLn7GIkloVe9cBKK+7EUiekrt3cyqR83gySJXc1iDjy0zslml0EES94jaG6GN5/v
        xevB/jLHHQVZJWBg==
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
In-Reply-To: <20231024042645.GF800259@ZenIV>
References: <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231022194618.GC800259@ZenIV> <87wmvdd3p5.ffs@tglx>
 <20231024042645.GF800259@ZenIV>
Date:   Tue, 24 Oct 2023 14:31:01 +0200
Message-ID: <877cnccid6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24 2023 at 05:26, Al Viro wrote:
> On Mon, Oct 23, 2023 at 12:37:58PM +0200, Thomas Gleixner wrote:
>> On Sun, Oct 22 2023 at 20:46, Al Viro wrote:
>> > -	return checksum;
>> > +	return from64to16 (checksum);
>> 
>>   from64to16(checksum); all over the place
>
> Umm...  Is that about whitespace?

Yes, my parser choked on that :)
  
>> >  /*
>> > - * We report fault by returning 0 csum - impossible in normal case, since
>> > - * we start with 0xffffffff for initial sum.
>> > + * We report fault by returning ~0ULL csum
>> >   */
>> 
>> There is also a stale comment a few lines further up.
>
> Umm...
>  *  Returns : r0:r1 = checksum:0 on success or -1:-1 on fault  
> perhaps?

Looks good.

>> > +static inline bool wsum_fault_check(__wsum_fault v)
>> > +{
>> > +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
>> > +	return (__force s64)v < 0;
>> > +#else
>> > +	return (int)(__force u32)v < 0;
>> 
>> Why not __force s32 right away?
>
> Mostly to keep the reader within more familiar cases
> of conversion - u64 to u32 is "throw the upper 32 bits
> away", u32 to s32 - "treat MSB as sign".

Fair enough.

> It's still a nasal demon country, of course - the proper
> solution is
>
> static inline bool wsum_fault_check(__wsum_fault v)
> {
> #if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> 	return (__force u64)v & (1ULL << 63);
> #else
> 	return (__force u32)v & (1ULL << 31);
> #endif
> }
>
> Incidentally, in this case we really want a cast to u32
> rather than u64 - gcc is smart enough to figure out that
> checking MSB in 32bit can be done as signed 32bit comparison
> with 0, but bit 31 in 64bit is not special as far as it's
> concerned, even though it's a bit 31 of 32bit register...

Indeed.
  
>> As the callers just check for != 0 such a partial copy is considered
>> success, no?
>
> Check the callers...
>
> static __always_inline __must_check
> bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
>                                   __wsum *csum, struct iov_iter *i)
> {
>         size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
>         if (likely(copied == bytes))
>                 return true;

Duh. I think I stared at a caller of csum_and_copy_from_iter_full()
instead...

Thanks,

        tglx
