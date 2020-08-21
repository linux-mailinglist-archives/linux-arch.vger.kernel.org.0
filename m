Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8524DFA5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgHUSbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgHUSbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 14:31:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D59C061574
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 11:24:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so1175594pjd.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+HGPUUEt/yeZPA3aGMYIqvfoymS1eSd9/ssdWii5Ww=;
        b=gL3E2vI4RdEkGoqPQ5bhPya5HSCwBlSpXY7p6WmAA99o71qfrPhE/NpMCkBqecqy+V
         +JME0II/bywwuTEmErR+Mov3glI2MHbzDimh1+IVoyx05yRlgpV32YCuX4SeJi8nxsqH
         F+DPGriKAagurCtecEduI7KobxI4nsJyNM8PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+HGPUUEt/yeZPA3aGMYIqvfoymS1eSd9/ssdWii5Ww=;
        b=GKU/moLr/k1qjHNevPHQSaMCs1W3q120XIhD5I9r9oYYeMP2yfocARk8mJXznPQHCt
         gyEoKdRiknDK9xlOiz054Bcz15C7qFCFVJrEtsvXYn/7Af58jNc+vuVclLKVeIxXlw8V
         GDrycG46bwfwqkC+pFPhrEDqtXQY/utKC2OY4+KvgwyN/6yXd4Bkv5ZRwFS6E7h9MZ3M
         nDrO9GbuyCH0W6Oi8JgtHgccGFFkbwKud7g13WIPrFyw3Xvyx335vavFSJuQqcIivEMh
         UXNrTL6AQjhKuPyLtfu4DAieGud0fwp+m2LRPWHhe8gvSmgyZ8xIUbXoIdjT8jv66tyP
         A8nA==
X-Gm-Message-State: AOAM533P/GxH9y7gUsaTiodz7vUjlpOpofmqSQyE7x13Sg4gLPxeUnoS
        gxNkOeSZRATOoF6w6wHPeUl0OQ==
X-Google-Smtp-Source: ABdhPJwY3MUwUyYflRLBpNg5NofmVB1Nw4sxCEvR4NrTn4s3G8/7jK9B7t0fPN6uAooj0VHUOYEZGw==
X-Received: by 2002:a17:90a:34c3:: with SMTP id m3mr3347042pjf.71.1598034267529;
        Fri, 21 Aug 2020 11:24:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm3273433pfr.39.2020.08.21.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:24:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:24:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Message-ID: <202008211123.AD9EA0441@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <20200801025325.GA2800311@rani.riverdale.lan>
 <202007312235.4A48157938@keescook>
 <20200801171225.GB3249534@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801171225.GB3249534@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 01, 2020 at 01:12:25PM -0400, Arvind Sankar wrote:
> Actually, moving it to the end also requires marking it INFO or
> stripping it out when creating the bzImage. Otherwise we get back to
> that old problem of materializing .bss/.pgtable in the bzImage.

Yeah -- I wonder what the best way to make sure we avoid causing the
.bss appearing again...

-- 
Kees Cook
