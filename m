Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4D55390A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352415AbiFURjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 13:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352406AbiFURjr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 13:39:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DCB1C10F;
        Tue, 21 Jun 2022 10:39:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so4983675pjj.5;
        Tue, 21 Jun 2022 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mm0iD6HT9Mx8CXXEjxAdU1TvUV4Ez2s5c81pc2wmXwg=;
        b=Cpkt5sgP0fqAe+Y1iRtsx8qe+2jJ5InANoetmpK6UNu1KPb9jca4X2hLmzTTN1WqPF
         AU0N56w++P4mZB3mMlojr8wWM6bXtyDQsj/chEau1PJEWu/RbPlbW8FkMaEMDcuPhG5r
         NO9U1XfR4Ff0tZM0w5zbEK3DXlzrhHV7B8JwF4bM67grhmMuaBqYmjgCMyeRoaWlti7C
         oSeeejFFPjPSIRjK9+1Rgrl2zWynXbFQRm7FQYkAlfB/wIgHuMlRiuxIjmRIwu5lXPCE
         0Z5+P7a9Rw480gqVmvlY0WIZSXBMO/pcQ7u54RbQuXhy+qhX+mUtGNe0SZOZMRjQfaGC
         hf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mm0iD6HT9Mx8CXXEjxAdU1TvUV4Ez2s5c81pc2wmXwg=;
        b=RUgcl7rL7IdSWWFD6qs7/DMLSajLQ+ND+DI93mFzP9GEELexvxELPkYsLRWV5VoscD
         m2iCPeSdzxxaIRlbJTW4a+UyTqgRHD728fEw0sWpp+5zLPB3Dake2f2Ea1kngNQSgPww
         ZS44z3Wk73d25ppXRGUF2R8WuhyT46KcAdbY32skeQUHbFKPEVaQ+8HCHifbIY/KOW2E
         at4w1pMRd/QekuKCoh+xldrTopHr8lhjfbT50bEgHzINzGnKQEN1KOUumy2BlrwJFk6t
         8T4ZLWJT2JtUyKMIFN4lEk/lPZLdgz9vPqtrhbiyPoQpxUtScczfdZArH4hCqryDbSN4
         8uwA==
X-Gm-Message-State: AJIora/Nuv4KcXctTMUE/b3dQKALG8795vuSP86e3LwjKxKnIMvwqjIQ
        fYg0KsDJDM3u9ZxRPKDui9s=
X-Google-Smtp-Source: AGRyM1tK7vJkGhs4aAwjMWhpAIqeIo4Bvt11WfobTLLuR1i8TRAIfeLZcBg7z4nUYaKeHpF0qxaBHg==
X-Received: by 2002:a17:90a:2e02:b0:1ea:c661:7507 with SMTP id q2-20020a17090a2e0200b001eac6617507mr43707102pjd.133.1655833186113;
        Tue, 21 Jun 2022 10:39:46 -0700 (PDT)
Received: from localhost ([172.85.181.54])
        by smtp.gmail.com with ESMTPSA id cp1-20020a170902e78100b00168f329b282sm10960496plb.155.2022.06.21.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:39:45 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:39:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <YrICYCW0fCb0Rh8/@yury-laptop>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
 <YrCB/rz3RM6TCjij@FVFF77S0Q05N>
 <20220620150855.2630784-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620150855.2630784-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 05:08:55PM +0200, Alexander Lobakin wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 20 Jun 2022 15:19:42 +0100
> 
> > On Fri, Jun 17, 2022 at 04:40:24PM +0200, Alexander Lobakin wrote:
> > > So, in order to let the compiler optimize out such cases, expand the
> > > test_bit() and __*_bit() definitions with a compile-time condition
> > > check, so that they will pick the generic C non-atomic bitop
> > > implementations when all of the arguments passed are compile-time
> > > constants, which means that the result will be a compile-time
> > > constant as well and the compiler will produce more efficient and
> > > simple code in 100% cases (no changes when there's at least one
> > > non-compile-time-constant argument).
> > 
> > > The savings are architecture, compiler and compiler flags dependent,
> > > for example, on x86_64 -O2:
> > > 
> > > GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> > > LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> > > LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> > > 
> > > and ARM64 (courtesy of Mark[0]):
> > > 
> > > GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> > > LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> > 
> > Hmm... with *this version* of the series, I'm not getting results nearly as
> > good as that when building defconfig atop v5.19-rc3:
> > 
> >   GCC 8.5.0:   add/remove: 83/49 grow/shrink: 973/1147 up/down: 32020/-47824 (-15804)
> >   GCC 9.3.0:   add/remove: 68/51 grow/shrink: 1167/592 up/down: 30720/-31352 (-632)
> >   GCC 10.3.0:  add/remove: 84/37 grow/shrink: 1711/1003 up/down: 45392/-41844 (3548)
> >   GCC 11.1.0:  add/remove: 88/31 grow/shrink: 1635/963 up/down: 51540/-46096 (5444)
> >   GCC 11.3.0:  add/remove: 89/32 grow/shrink: 1629/966 up/down: 51456/-46056 (5400)
> >   GCC 12.1.0:  add/remove: 84/31 grow/shrink: 1540/829 up/down: 48772/-43164 (5608)
> > 
> >   LLVM 12.0.1: add/remove: 118/58 grow/shrink: 437/381 up/down: 45312/-65668 (-20356)
> >   LLVM 13.0.1: add/remove: 35/19 grow/shrink: 416/243 up/down: 14408/-22200 (-7792)
> >   LLVM 14.0.0: add/remove: 42/16 grow/shrink: 415/234 up/down: 15296/-21008 (-5712)
> > 
> > ... and that now seems to be regressing codegen with recent versions of GCC as
> > much as it improves it LLVM.
> > 
> > I'm not sure if we've improved some other code and removed the benefit between
> > v5.19-rc1 and v5.19-rc3, or whether something else it at play, but this doesn't
> > look as compelling as it did.
> 
> Mostly likely it's due to that in v1 I mistakingly removed
> `volatile` from gen[eric]_test_bit(), so there was an impact for
> non-constant cases as well.
> +5 Kb sounds bad tho. Do you have CONFIG_TEST_BITMAP enabled, does
> it work? Probably the same reason as for m68k, more constant
> optimization -> more aggressive inlining or inlining rebalance ->
> larger code. OTOH I've no idea why sometimes compiler decides to
> uninline really tiny functions where due to this patch series some
> bitops have been converted to constants, like it goes on m68k.
> 
> > 
> > Overall that's mostly hidden in the Image size, due to 64K alignment and
> > padding requirements:
> > 
> >   Toolchain      Before      After       Difference
> > 
> >   GCC 8.5.0      36178432    36178432    0
> >   GCC 9.3.0      36112896    36112896    0
> >   GCC 10.3.0     36442624    36377088    -65536
> >   GCC 11.1.0     36311552    36377088    +65536
> >   GCC 11.3.0     36311552    36311552    0
> >   GCC 12.1.0     36377088    36377088    0
> > 
> >   LLVM 12.0.1    31418880    31418880    0
> >   LLVM 13.0.1    31418880    31418880    0
> >   LLVM 14.0.0    31218176    31218176    0
> > 
> > ... so aside from the blip around GCC 10.3.0 and 11.1.0, there's not a massive
> > change overall (due to 64KiB alignment restrictions for portions of the kernel
> > Image).

I gave it a try on v5.19-rc3 for arm64 with my default GCC 11.2, and it's:
add/remove: 89/33 grow/shrink: 1629/966 up/down: 51456/-46064 (5392)

Which is not great in terms of layout size. But I don't think we should
focus too much on those numbers. The goal of the series is not to shrink
the image; the true goal is to provide more information to the compiler
in a hope that it will make a better decision regarding optimizations.

Looking at results provided by Mark, both GCC and LLVM have a tendency
to inline and use other techniques that increase the image more
aggressively in newer releases, comparing to old ones. From this
perspective, unless we find some terribly wrong behavior, I'm OK with
+5K for the Image, because I trust my compiler and believe it spent
those 5K wisely.

For the reasons said above, I think we shouldn't disable const
bitops for -Os build.

I think this series has total positive impact because it adds a lot
of information for compiler with just a few lines of code.

If no objections, I think it's good to try it in -next. Alexander,
would you like me to fix gen/generic typo in comment and take it in
bitmap-for-next, or you'd prefer to send v4?

Thanks,
Yury
