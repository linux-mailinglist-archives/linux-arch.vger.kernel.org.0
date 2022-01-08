Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23078488361
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiAHLyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiAHLya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 06:54:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EAC061574;
        Sat,  8 Jan 2022 03:54:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w20so16328689wra.9;
        Sat, 08 Jan 2022 03:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LRHExVyfqWb+CjlvuZOFy5IY4pp0xV737GyYU0gQJqY=;
        b=dhR4qC1zWBI/BYofjo0JBp6GSuRVM4PtMqn3wpYt+OfRYZA3hu6GjQhgd6Qng1xcuj
         VSvBddIy5gV5KuhbrGoO5t2Z8fZ3gOHSv1Fwh8pd3QHvSiyp2AT+C1xr0aAQYQ69uWND
         Rsm67RworqPvMm1UAVUSXzftKO7FhkiyqSM3UpRW3LBo0CPXKEK577vqVHvp3S0M44xG
         MQG6JNmtmJl33mruzUXQxRMgyR8jH1P42Bsnzyg4JoERzs7ooFoD8KdQdZpEANmvX+XA
         QLoehmgEt7GTCMTSuriEricCRns63iSlH6CT6CiVOAidj3NWkER394eXR0/vaTJwwD0U
         Bm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LRHExVyfqWb+CjlvuZOFy5IY4pp0xV737GyYU0gQJqY=;
        b=XCsI9cntt4JNRBMm8ezUU+X2Qa8hCSJIo/rMmR5Aa2c3tPv6w/nq9o0OGFIsOR3BcR
         EFW+Dr7xoNWQhejdvTLnQoVKFYLs62Tc8DM4U45I3NXYrNOD7agcHP2B5fiEZNL6TC39
         bhk+HKFpoRcmqQCYzU2YD0xQi/EQQBoXY4meeH+F1a27Ngpj5xvR+8XZRuSsszvrbcS4
         jSQfqve/jSm+7za42hfIo/3EujQh7msxyReqYnvCpCn9yjPjQC5xSuqrOMnUrgBOdxgx
         nRkHf5TrnKNvVDx062nmoUEl6NKhUcVGj3Yfy49dhi58o620viydlMziljr/8COl6lZh
         b+Aw==
X-Gm-Message-State: AOAM531lWDVuRoc6WO/eAWmK9GJFQ0Lc4Coe8tJn68wZ85y8z0xKZHbE
        fdgKus0WkjerH43TMkbir3yMdAj5zDs=
X-Google-Smtp-Source: ABdhPJwgBlb6v6JR6QP7yO5yqdQZRJJ9sLZO2j0NeN+fBYL1HYkmvkAe2VDjKBPC0aTOTceZHbfPHQ==
X-Received: by 2002:a05:6000:24b:: with SMTP id m11mr12586202wrz.122.1641642868870;
        Sat, 08 Jan 2022 03:54:28 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id bd21sm1433232wmb.8.2022.01.08.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 03:54:28 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 12:54:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <Ydl7ch/up7qJqByj@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdeJgJFRRsIb9pah@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdeJgJFRRsIb9pah@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> On Tue, Jan 04, 2022 at 11:47:30AM +0100, Ingo Molnar wrote:
> > > > With the fast-headers kernel that's down to ~36,000 lines of code, 
> > > > almost a factor of 3 reduction:
> > > > 
> > > >   # fast-headers-v1:
> > > >   kepler:~/mingo.tip.git> wc -l kernel/pid.i
> > > >   35941 kernel/pid.i
> > > 
> > > Coming from someone who often has to reduce a preprocessed kernel source 
> > > file with creduce/cvise to report compiler bugs, this will be a very 
> > > welcomed change, as those tools will have to do less work, and I can get 
> > > my reports done faster.
> > 
> > That's nice, didn't think of that side effect.
> > 
> > Could you perhaps measure this too, to see how much of a benefit it is?
> 
> As it turns out, I got an opportunity to measure this sooner rather than
> later [1]. Using cvise [2] with an identical set of toolchains and
> interestingness test [3], reducing net/core/skbuff.c took significantly
> less time with the version from the fast-headers tree.
> 
> v5.16-rc8:
> 
> $ wc -l skbuff.i
> 105135 skbuff.i
> 
> $ time cvise test.fish skbuff.i
> ...
> ________________________________________________________
> Executed in  114.02 mins    fish           external
>    usr time  1180.43 mins   69.29 millis  1180.43 mins
>    sys time  229.80 mins  248.11 millis  229.79 mins
> 
> fast-headers:
> 
> $ wc -l skbuff.i
> 78765 skbuff.i
> 
> $ time cvise test.fish skbuff.i
> ...
> ________________________________________________________
> Executed in   47.38 mins    fish           external
>    usr time  620.17 mins   32.78 millis  620.17 mins
>    sys time  123.70 mins  122.38 millis  123.70 mins
> 
> I was not expecting that much of a difference but it somewhat makes 
> sense, as the tool spends less time eliminated unused code and the 
> compiler invocations will be incrementally quicker as the input becomes 
> smaller.

Indeed, that's a +140% speedup in build performance, not bad. :-)

I also got around testing Clang (12) myself, and with my 'reference distro 
config' I got these results:

 #
 # v5.16-rc8
 #
 Performance counter stats for 'make -j96 vmlinux LLVM=1' (3 runs):

 55,638,543,274,254      instructions              #    0.77  insn per cycle           ( +-  0.01% )
 72,074,911,968,393      cycles                    #    3.901 GHz                      ( +-  0.04% )
      18,490,451.51 msec cpu-clock                 #   54.740 CPUs utilized            ( +-  0.04% )

                 337.788 +- 0.834 seconds time elapsed  ( +-  0.25% )

 #
 # -fast-headers-v2-rc3
 #
 Performance counter stats for 'make -j96 vmlinux LLVM=1' (3 runs):

 30,904,130,243,855      instructions              #    0.76  insn per cycle           ( +-  0.02% )
 40,703,482,733,690      cycles                    #    3.898 GHz                      ( +-  0.00% )
      10,443,670.86 msec cpu-clock                 #   58.093 CPUs utilized            ( +-  0.00% )

                 179.773 +- 0.829 seconds time elapsed  ( +-  0.46% )

That's a +88% build speedup on Clang - even better than the +78% speedup on 
GCC(-10).

Thanks,

	Ingo
