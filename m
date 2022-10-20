Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE366055D1
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJTDMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 23:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJTDMG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 23:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0113FDF0;
        Wed, 19 Oct 2022 20:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBF7619D7;
        Thu, 20 Oct 2022 03:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B04C433D7;
        Thu, 20 Oct 2022 03:12:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UYPPWo07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666235520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qadNFZ7XWekAb/DyZLHG/LNLJMySf8HJL6Ybo4oyuUY=;
        b=UYPPWo07B4JIquDZmfeMceCq/7TtxQ6+A1anGpsJuDWQP7mLbxXUNzp45Z3SSOvKGJKF0i
        F9bsBR7UsgpNykbqeqOjU4d28CF26tefLa9feTLt/xP+Lh8M/17pyrKrphSFmzXqMpbpLG
        aYqFfA8ad216c82Dm64hXKfYGEMBE5I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7c50f5bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 03:12:00 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id o28so9184345vkn.11;
        Wed, 19 Oct 2022 20:11:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf0h0/Tadi32Ztg+REpu9BJ44rRFNpy+pzIXkB+R3qTCiJFMVjaX
        PRHyM7G2WIshF/XJ9h1OKAFdNwDrza35QTsqtBw=
X-Google-Smtp-Source: AMsMyM6bTiFb+XKZ7aoBA18LydUNCto9/ceSwOPm+hNQxvS4xU5UEdlUYPzLFfCMDc9XYweqgfL3hCwkYcFoBa2v1aI=
X-Received: by 2002:a1f:e0c4:0:b0:3ab:191d:e135 with SMTP id
 x187-20020a1fe0c4000000b003ab191de135mr5171014vkg.41.1666235518593; Wed, 19
 Oct 2022 20:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
 <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
 <202210191209.919149F4@keescook> <CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com>
 <Y1Bfg06qV0sDiugt@zx2c4.com> <CAHk-=wjsbYJuO=3331LmQGePXWAdHEdT33HOup53shjMJFan6Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjsbYJuO=3331LmQGePXWAdHEdT33HOup53shjMJFan6Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Oct 2022 21:11:46 -0600
X-Gmail-Original-Message-ID: <CAHmME9p6BKrV6r3Rh5Cwq2AvV6-=ZQEKK=k10EqV_+yDCdWq4g@mail.gmail.com>
Message-ID: <CAHmME9p6BKrV6r3Rh5Cwq2AvV6-=ZQEKK=k10EqV_+yDCdWq4g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 6:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 19, 2022 at 1:35 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > I wish folks would use `u8 *` when they mean "byte array".
>
> Together with '-funsigned-char', we could typedef 'u8' to just 'char'
> (just for __KERNEL__ code, though!), and then we really could just use
> 'strlen()' and friends on said kind of arrays without any warnings.
>
> But we do have a *lot* of 'unsigned char' users, so it would be a huge
> amount of churn to do this kind of thing.

I think, though, there's an argument to be made that every use of
`unsigned char` is much better off as a `u8`. We don't have any C23
fancy unicode strings. As far as I can tell, the only usage of
`unsigned char` ought to be "treat this as a byte array", and that's
what u8 is for. Yea, that'd be churn. But technically, it wouldn't
really be difficult churn: If naive-sed mangles that, I'm sure
Coccinelle would be up to the task. If you think that's a wise
direction, I can play with it and see how miserable it is to do.

(As a sidebar, Sultan and I were discussing today... I find the
radical extension of this idea to its logical end somewhat attractive:
exclusively using u64, s64, u32, s32, u16, s16, u8, s8, uword (native
size), sword (native size), char (string/character). It'd hardly look
like C any more, though, and the very mention of the idea is probably
triggering for some. So I'm not actually suggesting we do that in
earnest. But there is some appeal.)

Jason
