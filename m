Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560164E127
	for <lists+linux-arch@lfdr.de>; Thu, 15 Dec 2022 19:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLOSnt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Dec 2022 13:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLOSnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Dec 2022 13:43:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FB286E9;
        Thu, 15 Dec 2022 10:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAE20B81C29;
        Thu, 15 Dec 2022 18:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD585C433EF;
        Thu, 15 Dec 2022 18:43:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="flZq12FL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671129810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2wIk9Iy3lO0eyDurNiRd13Y8NnkLNZtrzeTYAQ5/0k=;
        b=flZq12FLtve8AI4p3IkuE70hLdYvdwU6KPaOtMYG8Oa7VX5Ve9o7hw2Q/fWm5t7a/Oe0Lm
        B8jsGuyyAA7hix9P5en6ZZ+FBzZ+NHQaiqECHkCWJ0DZ8XGNqxr+0KaOs8Nbf9ACUPSaCr
        ArNMjYAx2KHNdymTBvZC9C1/jP9/pEQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c972e1f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Dec 2022 18:43:30 +0000 (UTC)
Date:   Thu, 15 Dec 2022 11:43:28 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: string: Make char intermediate in strcmp() signed
Message-ID: <Y5tq0OSjTvADFnEZ@zx2c4.com>
References: <bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 15, 2022 at 02:30:04PM +0100, Geert Uytterhoeven wrote:
> Since char became unsigned, strcmp() always returns a positive number.
> 
> "res" is used to store a byte difference, so it should be signed.
> 
> Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> See "Re: [PATCH v9] kallsyms: Add self-test facility"
> https://lore.kernel.org/r/CAMuHMdWM6+pC3yUqy+hHRrAf1BCz2sz1KQv2zxS+Wz-639X-aA@mail.gmail.com
> 
> I'm wondering how many surprises like this are still hidden...

OOOOOOOOOOFFFFF! Not sure how I missed this one. Perhaps the ASM alluded
the coccinelle scripts. Anyway, thanks for catching it, sorry for the
bug, and here's my:

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

I assume you'll send this out for the next tranche of m68k fixes.

Jason
