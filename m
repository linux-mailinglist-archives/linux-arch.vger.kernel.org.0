Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E41B1D9B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 06:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgDUEcz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 00:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUEcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 00:32:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F74C061A0F;
        Mon, 20 Apr 2020 21:32:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t199so10976179oif.7;
        Mon, 20 Apr 2020 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UPMkss+54nGeDEwUR0+B1eg0ik2cEEjdyo7gLfq4mZQ=;
        b=IbqY0T412B5N50cDtGLuhIl6vaYmZdIMd0m1/R6Fcn20HYyASzEQ1E7QtlJ4KvkHwq
         gzhwt90fkvp/7TN/oNLEWhoRq2KL9ehdgZYRewt72o6jkGANG58IEUQVq00ia1w47dCZ
         h352h3Djs6eTkfrNf0nxfAb/8ZCDM7STlW9uevFruo6RhtaGdiiFNNA3Bmg3TCzP11sf
         2DOXpBEUNBV5GjRgZA1ia9wJMLfyzur1fOuo3ieqwFLd9gTkl2RnkqdEA4jRH2qymeHt
         wnMbqs/iXd9WAv8bqmj657w2nitRplahkeNP8ovn3aGLvFL890z70UWAfDKp/oG/HyMd
         KuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UPMkss+54nGeDEwUR0+B1eg0ik2cEEjdyo7gLfq4mZQ=;
        b=O9e/jii+YqAQIBira20uUM2K7w2IyZedfH5cLPK7XFja2FTV5MqeqpDS6isK4Svbfr
         A5xTFjF/wgywEfsRfEpylWoNKYC7cI+bNB7Zv2vbCx1VUzw/Rr5ctDgsSk3xEj+mS45W
         4ljP7M5VxvCFN+nAmFHBeHzXfwU63JuZhg08tY1zr9vrwse42R09/bPSbZvPh3P0h7Dm
         sTfpQY2qGyI450xuUpx9Op8Fn/fEA/z1QQqyymWwz2bClkx1YxJrnINQT609Phx6ey12
         v45gWsR5EI+v4rJwRump6zwcSXWeo+kEAc/NEb8vRU9tBcS0PNp37RVQAmNk8NUuYODF
         P3/g==
X-Gm-Message-State: AGi0PuY3cgsdUJtTyeIvp3cd4ofHs+dd3PwUFdi7KhLG3sUc+YXDIbSC
        Xv2V4UOkCgw/Q30EF1GH7Gg=
X-Google-Smtp-Source: APiQypJ6BCzvMaYmwECLmlhAdgsbT8Tp8b6yZlEFnUnaUHlK6Cj8w3aKn0UQZxsETngzkzn06ylZcA==
X-Received: by 2002:aca:4d47:: with SMTP id a68mr1979522oib.60.1587443573940;
        Mon, 20 Apr 2020 21:32:53 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q15sm471569otk.78.2020.04.20.21.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 21:32:53 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:32:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/6] Silence some instances of -Wtautological-compare and
 enable globally
Message-ID: <20200421043251.GA4996@ubuntu-s3-xlarge-x86>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200420210332.7ff9652c8bdca7fb91ccfb0c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420210332.7ff9652c8bdca7fb91ccfb0c@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Mon, Apr 20, 2020 at 09:03:32PM -0700, Andrew Morton wrote:
> On Tue, 18 Feb 2020 21:54:17 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Hi everyone,
> > 
> > This patch series aims to silence some instances of clang's
> > -Wtautological-compare that are not problematic and enable it globally
> > for the kernel because it has a bunch of subwarnings that can find real
> > bugs in the kernel such as
> > https://lore.kernel.org/lkml/20200116222658.5285-1-natechancellor@gmail.com/
> > and https://bugs.llvm.org/show_bug.cgi?id=42666, which was specifically
> > requested by Dmitry.
> > 
> > The first patch adds a macro that casts the section variables to
> > unsigned long (uintptr_t), which silences the warning and adds
> > documentation.
> > 
> > Patches two through four silence the warning in the places I have
> > noticed it across all of my builds with -Werror, including arm, arm64,
> > and x86_64 defconfig/allmodconfig/allyesconfig. There might still be
> > more lurking but those will have to be teased out over time.
> > 
> > Patch six finally enables the warning, while leaving one of the
> > subwarnings disabled because it is rather noisy and somewhat pointless
> > for the kernel, where core kernel code is expected to build and run with
> > many different configurations where variable types can be different
> > sizes.
> > 
> 
> For some reason none of these patches apply.  Not sure why - prehaps
> something in the diff headers.
> 
> Anyway, the kmemleak.c code has recently changed in ways which impact
> these patches.  Please take a look at that, redo, retest and resend?
> 
> 

Thank you for doubling back around to this but we are good here. These
warnings have all been fixed in Linus' tree without the need for the
first patch in the series.

For those curious:

63174f61dfaef ("kernel/extable.c: use address-of operator on section symbols")
bf2cbe044da27 ("tracing: Use address-of operator on section symbols")
8306b057a85ec ("lib/dynamic_debug.c: use address-of operator on section symbols")
b0d14fc43d392 ("mm/kmemleak.c: use address-of operator on section symbols")
afe956c577b2d ("kbuild: Enable -Wtautological-compare")

Cheers,
Nathan
