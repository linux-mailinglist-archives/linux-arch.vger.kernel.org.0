Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F778CD25
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjH2Tpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbjH2TpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 15:45:13 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A2193;
        Tue, 29 Aug 2023 12:45:10 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5733aa10291so3204475eaf.3;
        Tue, 29 Aug 2023 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338310; x=1693943110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnGagmBfZYiioG3h7ZIo4cSowIxiux7AtfINlh/Cmno=;
        b=CB7t6+kPFUrLqQokhccUf6u77/jBg16GIiJ4jqKJoirOLDzUy+YWkMbXq0anJ6Whd9
         U/IkDOIq0U8m72B5Xo8mbMPx6wDnXl9NaJ1nbyLzAfNVSPcdpO/LI/eB0MOGpASb+0er
         OTpwCYmfHQeI9eDOUKGg0rVQ6OtsLq8Hm3awb7mRcpo8/uVVXGVj51L0xaoS1AuCUlNe
         RSUtoHxSj53ChexTEgbW8hBfzcK3B/fz9qedu89Kn9iBlKY5RSKFA6evVOvN+BliBav9
         DmzxnvD6aL2nrXkzNNFetDKB2vYKrPbQl10PknBQZOGeGKpWq59FBgUMh2ppAaNORgED
         yRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338310; x=1693943110;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnGagmBfZYiioG3h7ZIo4cSowIxiux7AtfINlh/Cmno=;
        b=eoBtKFdDVH6jYC018lOwSqlngWv9/FDXoXioTC9CwU9BtpgZnOKZhVs4upLKfXGSxC
         wSJXtyUirKULEw6Wx94OZz1QgLmC/1qN3Zo/UjU40xHgh1Y6X2EypYXlTeutelpV/g71
         UjDp9yO8dJysJeRYGFj63SGAeZVFQDrxJUht8mX3u3BvHHzWebW3k4k6VL0+NnIwudEh
         iG0aJpo9Gkc2V6Koyzv8vzSw3N5tNjUHVVmHIZ2IYtd3MN8TtxTjJtcLFvUPDj5Xb8up
         xXORCDCgiv56InZN6DDOZOg9JuMZre3YASnCITa9aOawNCJEY5xMavqHZzP5hdB1vnfJ
         aoJg==
X-Gm-Message-State: AOJu0YzkJHhQdVftWM6RL3b7zodxrr1t9O1wF2GDde2sLzTod9t4lcrn
        v1exaH0Xo3iiLIRE9iU1b8xT56lYKNbAsynQ2vUH5vz8
X-Google-Smtp-Source: AGHT+IE8AN/tVpouvGtwr0xoZsUC2TKm6JKSqyt7X4BW7SlhFx3IhvIuz1b6XTYYPS7XX0qWvsmjTJ6ehXu9Cn4WXf4=
X-Received: by 2002:a4a:3954:0:b0:571:24b4:15b7 with SMTP id
 x20-20020a4a3954000000b0057124b415b7mr46262oog.1.1693338310017; Tue, 29 Aug
 2023 12:45:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Tue, 29 Aug 2023
 12:45:09 -0700 (PDT)
In-Reply-To: <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 29 Aug 2023 21:45:09 +0200
Message-ID: <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/29/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 28 Aug 2023 at 10:07, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> Hand-rolled mov loops executing in this case are quite pessimal compared
>> to rep movsq for bigger sizes. While the upper limit depends on uarch,
>> everyone is well south of 1KB AFAICS and sizes bigger than that are
>> common. The problem can be easily remedied so do it.
>
> Ok, looking at teh actual code now, and your patch is buggy.
>
>> +.Llarge_movsq:
>> +       movq %rcx,%r8
>> +       movq %rcx,%rax
>> +       shrq $3,%rcx
>> +       andl $7,%eax
>> +6:     rep movsq
>> +       movl %eax,%ecx
>>         testl %ecx,%ecx
>>         jne .Lcopy_user_tail
>>         RET
>
> The fixup code is very very broken:
>
>> +/*
>> + * Recovery after failed rep movsq
>> + */
>> +7:     movq %r8,%rcx
>> +       jmp .Lcopy_user_tail
>> +
>> +       _ASM_EXTABLE_UA( 6b, 7b)
>
> That just copies the original value back into %rcx. That's not at all
> ok. The "rep movsq" may have succeeded partially, and updated %rcx
> (and %rsi/rdi) accordingly. You now will do the "tail" for entirely
> too much, and returning the wrong return value.
>
> In fact, if this then races with a mmap() in another thread, the user
> copy might end up then succeeding for the part that used to fail, and
> in that case it will possibly end up copying much more than asked for
> and overrunning the buffers provided.
>
> So all those games with %r8 are entirely bogus. There is no way that
> "save the original length" can ever be relevant or correct.
>

Huh, pretty obvious now that you mention it, I don't know why I
thought regs go back. But more importantly I should have checked
handling in the now-removed movsq routine (copy_user_generic_string):

[snip]
        movl %edx,%ecx
        shrl $3,%ecx
        andl $7,%edx
1:      rep movsq
2:      movl %edx,%ecx
3:      rep movsb
        xorl %eax,%eax
        ASM_CLAC
        RET

11:     leal (%rdx,%rcx,8),%ecx
12:     movl %ecx,%edx          /* ecx is zerorest also */
        jmp .Lcopy_user_handle_tail

        _ASM_EXTABLE_CPY(1b, 11b)
        _ASM_EXTABLE_CPY(3b, 12b)
[/snip]

So I think I know how to fix it, but I'm going to sleep on it.

-- 
Mateusz Guzik <mjguzik gmail.com>
