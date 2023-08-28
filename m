Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606078B735
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 20:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjH1SZv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 14:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjH1SZQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 14:25:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD11184
        for <linux-arch@vger.kernel.org>; Mon, 28 Aug 2023 11:25:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so53485181fa.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Aug 2023 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693247111; x=1693851911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YYQjGDw6zrjA4gHYIkErDzKVOCQS4WllI1Xx3Q7eP4=;
        b=AbLTto9YaaycJ6PseRR/9rn/3LeY1lrSFUOsVXEZ0Vg7k5UOTza0jIYpCa8BcKfTcc
         5PzdKf+Ze5kABNb34m64J7b1dy80iKIBKHfCROKIcoB59I9jB++1blIfNmnYCh3Mj1sQ
         NyhJT6rl3n4Ra0infY5+Q3KPwU8AOFdTsU8Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247111; x=1693851911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YYQjGDw6zrjA4gHYIkErDzKVOCQS4WllI1Xx3Q7eP4=;
        b=Sf8BjyciPkCj9o1sYkQWNTdj4dvJLk1fNv+Tn0yHA3ZCJaz8g8w92Cbl1LOqaErAfz
         HnT6jmZbRj70XNGRHRUDV76IeGaMgjUc1poKOnjC/8470tm6vUhvz0Z22ty4YSwdtJmH
         rTaJDojJ7Mjvo1fv00LpltlSVy43zuz68Q9aj8LmPt7K+h2pd4XVMm9EClt36/BAZUa2
         wLexB6SrDhpqa9VTqjsWhDCx4xDUXCR+eQh/0fiZaYPR3bvCytorUpZsTIvVq4JNm14n
         MLJZlhE1yM6z5zikcYcHdvAW8vuei7Eai7/BpEacyubPTfsxlP5aMHfQKeoyPf0NzS73
         cDOA==
X-Gm-Message-State: AOJu0YxVfCTgdldHd06oY7EtevHJR0SBD+9vUPXMGmemChU3ajejC66l
        MzDRClvVCfVPSsyD0HQ4nhYJBAfvBNRKons9cStfZQ==
X-Google-Smtp-Source: AGHT+IEfaJpE2aypVyiKCq58VLuMTu+6221e57sZQYiJOWVgJ42QyYgEr5CR71SGbYkqHgnMUeB1wA==
X-Received: by 2002:a2e:6e0c:0:b0:2b6:eb5a:6504 with SMTP id j12-20020a2e6e0c000000b002b6eb5a6504mr20732884ljc.18.1693247110736;
        Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b00982a92a849asm4948518ejb.91.2023.08.28.11.25.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso4604861a12.2
        for <linux-arch@vger.kernel.org>; Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
X-Received: by 2002:a17:907:a04d:b0:9a1:e758:fc6e with SMTP id
 gz13-20020a170907a04d00b009a1e758fc6emr11440118ejc.10.1693247109830; Mon, 28
 Aug 2023 11:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
 <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com>
In-Reply-To: <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 11:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
Message-ID: <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Aug 2023 at 11:04, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Other files do it (e.g., see __copy_user_nocache), but I have no
> strong opinion myself.

So the __copy_user_nocache() thing is a case of that second issue -
see my comment about "some sane visually sensible grouping" of the
numbers.

Look closer, and you'll notice that they aren't actually sequential.
They are of the form XY where the X is the grouping, and Y is the
local number within that grouping.

That case also comes with a fair amount of comments about each group
for the extable entries.

But yes, we also do have a number of thos e"sequential labels". See
for example arch/x86/lib/getuser.S, where we then end up having all
the exception handling at the end because it is mostly shared across
cases. It's ugly.

We also have a lot of ugly cases that probably shouldn't use numbers
at all, eg csum_partial(). I think that goes back to some darker age
when things like "assembly is so trivial that it doesn't need any
fancy explanatory labels for code" was ok.

See also arch/x86/lib/memmove_64.S for similar horrors. I wonder if it
is a case of "use compiler to get almost the right code, then massage
things manually". Nasty, nasty. That should use legible names, not
random numbers.

I also suspect some people really thought that the numbers need to be
unique, and just didn't know to use local numbering.

             Linus
