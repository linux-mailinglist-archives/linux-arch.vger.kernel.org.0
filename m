Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB59605488
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJTAjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 20:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJTAja (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 20:39:30 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F462C8
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 17:39:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so11883464qkm.4
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWFty6dFQpYyrkEdAH1uJ4wkhdCD5dnU4AL+htgFXmY=;
        b=GyjTTjrEberaB84XqhfJGUe6Z01GsAcKjAHnBqgJULvR918dxSuZNti9tMFPxpuGlE
         MYZAPh1ARSVn2/jBiolCEQ3kg9ZQ9llE8CPAlIrRJxj2yWaHhmOhxJ9mpdfddf98hnfa
         Es3WUJRJ1Fv9UyZKqqXCbXXO+DHe7Ajo9i65c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWFty6dFQpYyrkEdAH1uJ4wkhdCD5dnU4AL+htgFXmY=;
        b=Q0+V2plAY6S4tUHZo1MXw3HVOX1w//zHfnsQx3zKRay9uRQZ2BCQFig+ayiDZCg7Sz
         WZn5NWQmXjD/b75aqTBnU+kaa/6QgYlu3EqyZOKWSrH0aOMnM2tiQeCr2C4tj0PtzLG+
         D6rzZSB6m+KitAtBauGZZUgMBFEmYPmHikAM5jb4azZ9X9XrIHbq4YKu5wKM7LZnAhdM
         kP/U7BTyau05UpZXUOytmTBv4nNAtFU5d+WCoengqlc4EfmtLYI3I2xQ9mHBw9P8P6xt
         wTB7L2tU63UcK1ZzzlyoMjUYekR2JWEl0GwsQlGeQ19EQP0UEbx1tXZ1ajlZYWbb8V+g
         AgEg==
X-Gm-Message-State: ACrzQf3Au30KwrMGmtSD0J6NWSbtZ9PvsozCTlkflacie3fjYivrT3D5
        fswshCDhYgnmSMTwhTUDG37IlanfY9GzAw==
X-Google-Smtp-Source: AMsMyM7S7QdQGENeO4PYSoEpcl/IRImu17bUANt3bj2PeL1Zhyyfbqzqa7G6sJZQ7pp5hQJ96pOhgA==
X-Received: by 2002:a05:620a:27d3:b0:6ee:c091:f365 with SMTP id i19-20020a05620a27d300b006eec091f365mr7724305qkp.634.1666226355041;
        Wed, 19 Oct 2022 17:39:15 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a404f00b006ee91ab3538sm6597856qko.36.2022.10.19.17.39.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 17:39:13 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id bb5so12809010qtb.11
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 17:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:420d:b0:38d:961c:a57c with SMTP id
 cp13-20020a05622a420d00b0038d961ca57cmr8975604qtb.678.1666226353131; Wed, 19
 Oct 2022 17:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com> <Y1CP/uJb1SQjyS0n@zx2c4.com>
In-Reply-To: <Y1CP/uJb1SQjyS0n@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 17:38:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
Message-ID: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 5:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Given I've started with cleaning up one driver already, I'll keep my eye
> on further breakage.

I wonder if we could just check for code generation differences some way.

I tested a couple of files, and was able to find differences, eg

  # kernel/sched/core.c:8861: pr_info("task:%-15.15s state:%c",
p->comm, task_state_to_char(p));
 - movzbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
 + movsbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
   call _printk #

because the 'char' for the '%c' is passed as an integer. And the
tracing code has the

        .is_signed = is_signed_type(_type)

initializers, which obviously change when the type is 'char'.

But I also checked a number of other files that didn't have that
pattern at all, and there was zero code generation difference, even
when the "readable asm" output itself had some changes in some of the
internal label names.

That was what my old 'sparse' trial thing was actually *hoping* (but
failed) to do, ie notice when the signedness of a char actually
affects code generation. And it does in fact seem fairly rare.

Having some scripting automation that just notices "this changes code
generation in function X" might actually be interesting, and judging
by my quick tests might not be *too* verbose.

             Linus
