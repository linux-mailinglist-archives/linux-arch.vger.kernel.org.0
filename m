Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7B201BAA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jun 2020 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgFSTxv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jun 2020 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbgFSTxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 15:53:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F8C06174E
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 12:53:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so4863565pfd.6
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anG95SJd4AOjTnI4MV3+T4SvuNW+x6NMVdWZoSy8e08=;
        b=ha9EfugfFqrYvP9ncS5JDX/+xka+I18knexTDvSEUg3ZZbryI7a/FLIh6rXbkvHOES
         h9ujOx/D0LNG/bvHVXHGHYuGvaBOEvr390y7KSfwiaD/IR/aV/nVT/jKrFqWjIHCUjyp
         pKx8tPOkcfw+AMC9k4Y1o7kg3qc1QC/Tvgvsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anG95SJd4AOjTnI4MV3+T4SvuNW+x6NMVdWZoSy8e08=;
        b=Rv3NVobny7+DiEjsHloysqeFnbxtcwT5F5mOufz9e9IJUZTaEat5382qoaOZ8ZV1s0
         pC8vWvwUwG0LXMdnDIqA6G8Fp1RiZQ6Iw2fG49tUCYm6TZ6ONeqFfxK7HrA3zZMg44Bx
         r7c0HyQsXYghwlWDaaqTm9X3/NJyMMqDm9MFJDhxQD9YeSwLt306vaXR5ILhdT+yCJd6
         SNnVo+xiXGR3MbinCpTzG7tH6N0Q1rczU+qUXgTLfftaOYiJsY/a7qzDqkoZ0PQmIByj
         aIOBGDCoFWymxh1yxJt5plTKtp0+bjlfcJrhYWnGdWa/EydIb4b5DwObjJLPj34JEKQP
         idfA==
X-Gm-Message-State: AOAM531K44GQp1u/NpG6EsaSv8oIlN1o/Ijx4OvWNvWLrzc+A2r26KCZ
        +wjQcH0EHn0FTeatSMtduNjSEQ==
X-Google-Smtp-Source: ABdhPJzHp+ulgh26iR+Xv3g/K0aOiw7U9M6bVmBEmxiFXk8mFx/tiNvkiTra7x6B5etHiCFnYsht0g==
X-Received: by 2002:a62:5c03:: with SMTP id q3mr9555744pfb.58.1592596428586;
        Fri, 19 Jun 2020 12:53:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm6473821pfo.105.2020.06.19.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:53:47 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:53:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
Message-ID: <202006191253.B00874B22@keescook>
References: <202006191236.AC3E22AAB@keescook>
 <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 19, 2020 at 12:42:14PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The terminator for the mode 1 syscalls list was a 0, but that could be
> > a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> > listed first and the loop construct would not test it, so there was no
> > bug. However, this is fragile. Replace the terminator with -1 instead,
> > and make the variable name for mode 1 syscall lists more descriptive.
> 
> Could the architecture instead supply the length of the list?

It could, but I didn't like the way the plumbing for that looked.

-- 
Kees Cook
