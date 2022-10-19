Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202060513D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJSUXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiJSUXT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:23:19 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D0D1C25FF;
        Wed, 19 Oct 2022 13:23:16 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29JKFhWg016370;
        Wed, 19 Oct 2022 15:15:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 29JKFgLV016366;
        Wed, 19 Oct 2022 15:15:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 19 Oct 2022 15:15:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <20221019201542.GN25951@gate.crashing.org>
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org> <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com> <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com> <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com> <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:56:00AM -0700, Linus Torvalds wrote:
> After fixing fortify-string.h to not complain (which was indeed about
> strlen() signedness), it turns out a lot were still about 'char', but
> not necessarily the <string,h> functions.
> 
> We use 'unsigned char *' for our dentry data, for example, and then you get
> 
>      warning: pointer targets in initialization of ‘const unsigned
> char *’ from ‘char *’ differ in signedness
> 
> when you do something like
> 
>     QSTR_INIT(NULL_FILE_NAME,
> 
> which is simply doing a regular initializer assignment, and wants to
> assign a constant string (in this case the constant string "null") to
> that "const unsigned char *name".

It cannot see that all users of this are okay with ignoring the
difference.

> That's certainly another example of "why the heck did the compiler
> warn about that thing".

Because this is a simple warning.  It did exactly what it is supposed
to -- you are mixing "char" and "unsigned char" here, and in some cases
that matters hugely.

> You can literally try to compile this one-liner with gcc:
> 
>      const unsigned char *c = "p";
> 
> and it will complain. What a hugely pointless warning.

Yes, there are corner cases like this.  Please open a PR if you want
this fixed.

It is UB to (try to) modify string literals (since they can be shared
for example), but still they have type "array of (plain) char".  This is
historical :-/


Segher
