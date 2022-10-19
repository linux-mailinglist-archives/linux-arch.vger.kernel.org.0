Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63709604DF9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiJSQ7J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiJSQ6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 12:58:48 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3FE1D20D8;
        Wed, 19 Oct 2022 09:58:35 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29JGsuT6001975;
        Wed, 19 Oct 2022 11:54:56 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 29JGstV1001974;
        Wed, 19 Oct 2022 11:54:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 19 Oct 2022 11:54:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <20221019165455.GL25951@gate.crashing.org>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019162648.3557490-1-Jason@zx2c4.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 10:26:48AM -0600, Jason A. Donenfeld wrote:
> Recently, some compile-time checking I added to the clamp_t family of
> functions triggered a build error when a poorly written driver was
> compiled on ARM, because the driver assumed that the naked `char` type
> is signed, but ARM treats it as unsigned, and the C standard says it's
> architecture-dependent.

> So let's just eliminate this particular variety of heisensigned bugs
> entirely. Set `-fsigned-char` globally, so that gcc makes the type
> signed on all architectures.

This is an ABI change.  It is also hugely detrimental to generated
code quality on architectures that make the saner choice (that is, have
most instructions zero-extend byte quantities).

Instead, don't actively disable the compiler warnings that catch such
cases?  So start with removing footguns like

  # disable pointer signed / unsigned warnings in gcc 4.0
  KBUILD_CFLAGS += -Wno-pointer-sign


Segher
