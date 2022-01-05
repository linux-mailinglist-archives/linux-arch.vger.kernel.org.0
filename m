Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570E6484B9D
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiAEAUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiAEAUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:20:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D41C061761;
        Tue,  4 Jan 2022 16:20:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q14so147155228edi.3;
        Tue, 04 Jan 2022 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDbU1kj34UMWw/qTzlhM7eSBun7e9w/1neHTsviDCAI=;
        b=bPPmygOAG5tVVPOwFV8D0riSscD+Im6II1WEcywcC33AefldB0PhZQvx4diULh53ih
         qrnyuVhk0sJOjvd+jfD33OGkstu9HsWIhgniqi59UnoQhy3HSJ9RPKqJl3fVdQvofIpo
         +yHAJVdgbgHlZINRN1Dq52wj13djpvQS4G7uCNCL64EfiNS0bXkmtuaLoOlb73rHqSXf
         TF0RI5uWSMl2dTL7sEGYKcHbNe9pWqgjPbMLOmxH2MjMIb6Z/g4U3NY5hzR2iZrZ+Slg
         StrPTx/RNMqAUUrDMya7lcLR7iQy+rAA9nzHnZpODOnfZxM5S5t6qqjvzZDS0/A3mh18
         53kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IDbU1kj34UMWw/qTzlhM7eSBun7e9w/1neHTsviDCAI=;
        b=hCXQ+Wx5WV6OdDKchMvvAO/GPB3s2q0w1p8bMwKJOlrW/Ic4MUFZx5I344RwDg6bjt
         UFVJQdjTpFC7YoKoBwa9ZQuxTVM/rbK+MUbssvzWRgf5pcKHNnRzBPJ1rWQYMpYZmqeX
         ZYwhJgg8g/YBzklNO4sByNGI21zxEJyDtpYy/KyFh/oRj5mz6+1KTv7HsfeMLur67DxL
         zdPKVqo9PK8gJ5FZrVGbycy9Sv1ibpOfj3AUgZsmY+4mthQZOH+CylHW6LlJ+mKj9yO6
         mvxlILZMA58dIK0ECqHTlgQjwUAc40sNFSMKiyLhFGckeSFrzIMma9tVkIhSZhmPAwu6
         tGXg==
X-Gm-Message-State: AOAM5320PLFAqAn5cbOrJoMk/c2rsVf75mObvqW2032Nydf44ErAJ/3v
        BrNjoBr5zi+4K2bmuc2pM0nnE85bNbo=
X-Google-Smtp-Source: ABdhPJxskks3Pd8N4UAavKBRQ9f1aed6hiyrJvAMxloD2sXbO5IBOoYHeauxTHhjrjJS4TaRCIc6SQ==
X-Received: by 2002:a17:906:a091:: with SMTP id q17mr40602282ejy.669.1641342035022;
        Tue, 04 Jan 2022 16:20:35 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id ky10sm9551054ejc.151.2022.01.04.16.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:20:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:20:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev
Subject: Re: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned
 attribute to the head of the definition
Message-ID: <YdTkUBSLCQv7++FN@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdQpSigW9X224obC@gmail.com>
 <YdSJH7empIUq9vbE@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSJH7empIUq9vbE@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> Nowhere does it mention that it accepts the attribute before the type 
> keyword and neither compiler respects the attribute if it comes before 
> the keyword but at least clang warns: https://godbolt.org/z/E9fTecKPv
>
> $ cat test.c
> #include <stdio.h>
> 
> struct foo {
>     int a;
>     int b;
> };
> 
> struct __attribute__ ((aligned (64))) bar {
>     int a;
>     int b;
> };
> 
> __attribute__ ((aligned (64))) struct baz {
>     int a;
>     int b;
> };
> 
> int main(void)
> {
>     printf("struct foo alignment: %zd\n", _Alignof(struct foo));
>     printf("struct bar alignment: %zd\n", _Alignof(struct bar));
>     printf("struct baz alignment: %zd\n", _Alignof(struct baz));
>     return 0;
> }
> 
> $ gcc --version | head -1
> gcc (GCC) 11.2.1 20211231
> 
> $ gcc -std=gnu89 -Wall -Wextra test.c; and ./a.out
> struct foo alignment: 4
> struct bar alignment: 64
> struct baz alignment: 4

Ugh - so my changes there are outright buggy.

I'm reverting all those attribute position changes as we speak ...

I'm actually happy about this in a way, as it settles the issue nicely. :-)

Thanks,

	Ingo
