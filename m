Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92282604E4B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJSROp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJSROl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 13:14:41 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637235E66A
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:14:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g10so19976390oif.10
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KQxzROgST2+8KIjtVZdr5+s36xe/ZTzSg3ETS6Z3ulQ=;
        b=LHMjzMXASHQR480KuNviD0xWrYZLfPGTCqeVvQUzo3gve/gy/NSntm2Y3IkOnCwj1p
         +2IyuKYK8OWw/x9y83GLy2MuG6uqB0UvRc95PvRt9RDfj9DT+fECM5grlCAHIYJa4yIC
         pJNjoJ+eCxvdc3VlvJicxtqeqtYoTOSjDGAh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQxzROgST2+8KIjtVZdr5+s36xe/ZTzSg3ETS6Z3ulQ=;
        b=JTk7sPyrRdsIBU1+0FsosNH6dwuqfISUnkyiF8y5N4EFpirF3OxG2LaKKDCMm6JkQk
         T/QXZiUcW4xL0IPJKdS7ZDG3bsmLGNaqr/bpBMYqCgt3e0KjjEwD6AYALjNEYCIds44r
         OE3BeHM7oGkKN3zA1FGEeIuz/dGhx2/VochOR5aIhjjJP2NpVaFlCyEQ1XicTor4UiZw
         pxeJA38ylQGFDI2TMaZ7aTG6g1NYpaQeVXgf0J9oLVq7E89Iz1dc+iewUwktEH14VSXt
         +7GTUAHTbc4/Ibh3FsVu+ilzJf1Y0HgJPDh4Tze5l6tYZSQki5u2IO3EVhy3mHhVwetE
         8gOA==
X-Gm-Message-State: ACrzQf1CptKMKK9umaFnF290OjGU2oQCLDwzPk8U5JHbZrvVPqqEE6uJ
        outPnOCTMXhucrvVD/ASHr/LO1Jt0db5sQ==
X-Google-Smtp-Source: AMsMyM48hZaguSMxA/OBG79saV0+b732YxNefq5ycpf9aEoKB2+DkcRekSMmMXSx2JUpKB5DIoKgkw==
X-Received: by 2002:a05:6808:e90:b0:345:6ee0:9a68 with SMTP id k16-20020a0568080e9000b003456ee09a68mr5104956oil.173.1666199678344;
        Wed, 19 Oct 2022 10:14:38 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056808221200b00354e8bc0236sm7145302oib.34.2022.10.19.10.14.36
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:14:37 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id l5so19978135oif.7
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:14:36 -0700 (PDT)
X-Received: by 2002:a05:6808:23c3:b0:351:4ecf:477d with SMTP id
 bq3-20020a05680823c300b003514ecf477dmr5072747oib.126.1666199676600; Wed, 19
 Oct 2022 10:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
In-Reply-To: <20221019165455.GL25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 10:14:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
Message-ID: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 9:57 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> This is an ABI change.  It is also hugely detrimental to generated
> code quality on architectures that make the saner choice (that is, have
> most instructions zero-extend byte quantities).

Yeah, I agree. We should just accept the standard wording, and be
aware that 'char' has indeterminate signedness.

But:

> Instead, don't actively disable the compiler warnings that catch such
> cases?  So start with removing footguns like
>
>   # disable pointer signed / unsigned warnings in gcc 4.0
>   KBUILD_CFLAGS += -Wno-pointer-sign

Nope, that won't fly.

The pointer-sign thing doesn't actually help (ie it won't find places
where you actually compare a char), and it causes untold damage in
doing completely insane things.

For example, it suddenly starts warning if  you *are* being careful,
and explicitly use 'unsigned char array[]' things to avoid any sign
issues, and then want to do simple and straightforward things with
said array (like doing a 'strcmp()' on it).

Seriously, -Wpointer-sign is not just useless, it's actively _evil_.
The fact that you suggest that clearly means that you've never used
it.

                      Linus
