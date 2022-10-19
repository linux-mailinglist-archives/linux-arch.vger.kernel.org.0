Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03987604F5D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJSSLD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJSSLC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 14:11:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82A1799B7
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:10:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m81so20179495oia.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGR0rDpTW7xgTFS4grRDMvtr/PpXo8umrs2yrJ3UML4=;
        b=f3558QuEtp4oWAGxzHD+nDzX3s6SI6mqk07d4unwH/uZPll67kvPzY5AlfzYZxg+X6
         zTvnWZUR0E1tCYrtFi8p6tx/eQUaR2VTkJl/mvo2YuQvLCirD1YWJB+uMQf8JMGXKP2W
         aSE+S294zj9djVP4FNih8XJ1S1uIJi++YZ+5HcWgOVKJgWDE5yCARXTCgtR/KOlGbhbw
         1NhjRBzW2Z973G/YIF7Bkxhfyd1R4ltMyZk1UPVJ7daouoWbA5/MQhDb0MSgOwsymsd1
         Mpqg/WMXHG8MhM6u6vKyBivd8kgGCyhxnJD2YGfEq4797fki4azwmj016iMI484UoGo2
         cPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGR0rDpTW7xgTFS4grRDMvtr/PpXo8umrs2yrJ3UML4=;
        b=RcerAVqEOTrrwpIQPEE2fzo97K64W9GDvarQzu/5faP/kfo9Mvm2ngPWh1JE7vIcMq
         exeiLWxdDY4rGJxWYo200weDew60wliJW8o9Xlu6aJlkgb7fFmlg7lAnTOR/qA7W32g9
         PHVCTj5HOHim4eedj9hEZTbDkK7MGjlELIi0DnPHjCaJVdZUoSYJIl3mI2OKGrpdqtAd
         IxHQPqd4C8SkBXL8KybZ+UK8a9+IESFwD7/OtA7Z86rZCx3Nsic14X5Gdh9C8qQS+9b1
         Z8cH1bVMCofMfjga8DU5jA0zNlkvR45s+m2vsulvPosXx2DMcsQHty/aH5rQEbH60nnb
         TtAw==
X-Gm-Message-State: ACrzQf22U3cEPGzGE1QydaiXBRapXymOcT6YAIk/krHDtW0UisIoXOiX
        pTnBoO+xDAOaKG3GEcF9BwLOuTeO7SjgWTUqyIz3m9ueAeKPXA==
X-Google-Smtp-Source: AMsMyM7MuUj4C35EpdRK3az+tECYwbYHlpD6xn0OX0sCzW4tLI+w8FIXQovOYVJg+ChLDWtMvTKNoWMI0kE/hHHzMJY=
X-Received: by 2002:a17:90b:1a8d:b0:20d:be0b:a320 with SMTP id
 ng13-20020a17090b1a8d00b0020dbe0ba320mr32474975pjb.107.1666203046751; Wed, 19
 Oct 2022 11:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com> <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Oct 2022 11:10:34 -0700
Message-ID: <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 10:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 19, 2022 at 10:14 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The pointer-sign thing doesn't actually help (ie it won't find places
> > where you actually compare a char), and it causes untold damage in
> > doing completely insane things.
>
> Side note: several years ago I tried to make up some sane rules to
> have 'sparse' actually be able to warn when a 'char' was used in a
> context where the sign mattered.

Do you have examples? Maybe we could turn this into a compiler feature
request.  Having prior art on the problem would be a boon.

>
> I failed miserably.
>
> You actually can see some signs (heh) of that in the sparse sources,
> in that the type system actually has a bit for explicitly signed types
> ("MOD_EXPLICITLY_SIGNED"), but it ends up being almost entirely
> unused.
>
> That bit does still have one particular use: the "bitfield is
> dubiously signed" thing where sparse will complain about bitfields
> that are implicitly (but not explicitly) signed. Because people really
> expect 'int a:1' to have values 0/1, not 0/-1.

Clang's -Wbitfield-constant-conversion can catch that.
commit 5c5c2baad2b5 ("ASoC: mchp-spdiftx: Fix clang
-Wbitfield-constant-conversion")
commit eab9100d9898 ("ASoC: mchp-spdiftx: Fix clang
-Wbitfield-constant-conversion")
commit 37209783c73a ("thunderbolt: Make priority unsigned in struct tb_path")

>
> But the original intent was to find code where people used a 'char'
> that wasn't explicitly signed, and that then had architecture-defined
> behavior.
>
> I just could not come up with any even remotely sane warning
> heuristics that didn't have a metric buttload of false positives.
>
> I still have this feeling that it *should* be possible to warn about
> the situation where you end up doing an implicit type widening (ie the
> normal C "arithmetic is always done in at least 'int'") that then does
> not get narrowed down again without the upper bits ever mattering.
>
> But it needs somebody smarter than me, I'm afraid.
>
> And the fact that I don't think any other compiler has that warning
> either makes me just wonder if my feeling that it should be possible
> is just wrong.
>
>                    Linus



-- 
Thanks,
~Nick Desaulniers
