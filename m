Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8840760515C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiJSUfa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJSUf0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD83FA34;
        Wed, 19 Oct 2022 13:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72963619D2;
        Wed, 19 Oct 2022 20:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9ACC433D6;
        Wed, 19 Oct 2022 20:35:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ox4LmpHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666211721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txdjrnQxkksG5klYgF5siV+ewaBIwJ9LoBxaecxqpbM=;
        b=ox4LmpHNCKy/7WPZCY7YOHMQ0vRz/vsVgq/eohG2xXAea9aXzjSWmRDnJSO0FjvzpzJeKG
        pNvC3iC9GgUPUdh0ge/wjY9HNVZHnjRyviwzo6em+tfsLxcnLqQJ3purFrPGM757Z4IsXA
        2nmxgu2Zr0i+ZEDbZAA1U2q3qLRA1sk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8d11adb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 20:35:20 +0000 (UTC)
Date:   Wed, 19 Oct 2022 14:35:15 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <Y1Bfg06qV0sDiugt@zx2c4.com>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
 <CAHk-=wiD90ZphsbTzSetHsK3_kQzhgyiYYS0msboVsJ3jbNALQ@mail.gmail.com>
 <202210191209.919149F4@keescook>
 <CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 12:30:59PM -0700, Linus Torvalds wrote:
> The crypto code uses 'unsigned char *' a lot - which makes a lot of
> sense, since the crypto code really does work basically with a "byte
> array", and 'unsigned char *' tends to really be a good way to do
> that.

I wish folks would use `u8 *` when they mean "byte array".

Maybe the attitude should just be -- use u8 for bytes, s8 for signed
bytes, and char for characters/strings. Declare any use of char for
something non-stringy forbidden, and call it a day. Yes, obviously u8
and s8 are just typedefs, but they're a lot more explicit of intent.

Jason
