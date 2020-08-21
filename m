Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACCB24E094
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHUTSS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHUTSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:18:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE30C061575
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:18:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so1543590pfh.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iH/eGhwplhANu5ngguYajhAAOM68U/Ap6x/YYMCKQeM=;
        b=c9nTXlQNMxlTkjUEBmI7ZJXRVD9/w0VzmwP7XYcrlwJNqIvD9e/4Bg7nhro9mqIRHX
         W7TkfsuoDy1IphU7AxA4ZmZuKL9yG5AjEURR9d4qU8313miQfcRhOmwz9VC758r41oVz
         RNirK13ZYv7MZlL30hWsJsl0GdCKhM2nFuYk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH/eGhwplhANu5ngguYajhAAOM68U/Ap6x/YYMCKQeM=;
        b=Lf1ImaLWYQaDXVL9BHAmr9I/ckeYIV4hVrCj6HcIarmGRssApkSzPV4Rdk7mg+FN0q
         3Pr1AzkT5P3wiqP63xi9qF8WBTwv5hpde+jy+D2wcmtIJa2DADN7tNDbJj3p1OIlZQs4
         AMnAUfrsMI0AC/wpg4UVMLZGg9C/o7qeOW318ff/g3fviVLt4h5qsY+0pkkVW3mV52xU
         F/ovmoQyl2JbATA5GmLYbpxs9g9+y/KOKxzT6odqO9v3oZOd6W3dgeVbf9g1Uq0F1R8I
         MD7ceMIUrZdElQB4l187DE2jNoVetqrDcqohjBSv9e9Hrtwwc27USoG4lPOLIaZzg9lx
         Bf4g==
X-Gm-Message-State: AOAM5309ZmSpDuaphZgmEBZdIiRtNP95wZcYv23IKuPOD8421iJuIoq2
        GyyK2eyRcZPmSYHTIW0r//+Wlg==
X-Google-Smtp-Source: ABdhPJw5LmRHZmwZ/AvZZhq0vdAI/mHYL/NERH3jKS/lDJIqSghu3bjCZwheNmuG7UoQaGfupCNrTw==
X-Received: by 2002:a05:6a00:22c9:: with SMTP id f9mr3657627pfj.212.1598037492193;
        Fri, 21 Aug 2020 12:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm3413592pfg.68.2020.08.21.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:18:11 -0700 (PDT)
Date:   Fri, 21 Aug 2020 12:18:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Message-ID: <202008211216.3812BBA0C8@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <20200803190506.GE1299820@tassilo.jf.intel.com>
 <20200803201525.GA1351390@rani.riverdale.lan>
 <20200804044532.GC1321588@tassilo.jf.intel.com>
 <20200804160649.GA2409491@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804160649.GA2409491@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 04, 2020 at 12:06:49PM -0400, Arvind Sankar wrote:
> On Mon, Aug 03, 2020 at 09:45:32PM -0700, Andi Kleen wrote:
> > > Why is that? Both .text and .text.hot have alignment of 2^4 (default
> > > function alignment on x86) by default, so it doesn't seem like it should
> > > matter for packing density.  Avoiding interspersing cold text among
> > 
> > You may lose part of a cache line on each unit boundary. Linux has 
> > a lot of units, some of them small. All these bytes add up.
> 
> Separating out .text.unlikely, which isn't aligned, slightly _reduces_
> this loss, but not by much -- just over 1K on a defconfig. More
> importantly, it moves cold code out of line (~320k on a defconfig),
> giving better code density for the hot code.
> 
> For .text and .text.hot, you lose the alignment padding on every
> function boundary, not unit boundary, because of the 16-byte alignment.
> Whether .text.hot and .text are arranged by translation unit or not
> makes no difference.
> 
> With *(.text.hot) *(.text) you get HHTT, with *(.text.hot .text) you get
> HTHT, but in both cases the individual chunks are already aligned to 16
> bytes. If .text.hot _had_ different alignment requirements to .text, the
> HHTT should actually give better packing in general, I think.

Okay, so at the end of the conversation, I think it looks like this
patch is correct: it collects the hot, unlikely, etc into their own
areas (e.g. HHTTUU is more correct than HTUHTU), so this patch stands
as-is.

-- 
Kees Cook
