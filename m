Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E997436BD7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 22:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhJUUOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhJUUOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 16:14:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E6C061348
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 13:12:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om14so1317305pjb.5
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Ek7RgOwQo6oJqpx6aSl8YI4w/pI0VmvGrf1HSIb4ek=;
        b=BEnza5xUZ93dogoSka391+0wAiJJYs7DOiH9ZvJxE1u+ayGaphHREY8GNQQxw0s0Eo
         x1XUuYeagK0f7K7X3kixjzOmzucZbivYTd/n4qxF5/h7qr831kDXBZ3lKlXPBQvFiUFh
         MsmUPi3fl10giw3oyPPj5r7fVWTmI+vKy73TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ek7RgOwQo6oJqpx6aSl8YI4w/pI0VmvGrf1HSIb4ek=;
        b=0G7om//tgCVDO20+ukfXWPZyaHPpMlVNBZrMSEO3W9XVAI+F4TwhauSiO+lNPhJI0N
         m+lf19P2LuCJtCIRPgt3fQvXADEIC6vFiCnxaP2BIhEd/k9lQyClqWTxcMfajhZ3Zizi
         LhiQ9tPXQY8k0rD6d8wD1x8ETJJanJObxCm9kHOCqBKJ3Idg1MhEGTBv54ydMhGYHoFj
         A+rwCK9GJOXKQ2fTOeUpEM3KqAeJ0jtLn65C43z3C+J9N2ZVsd67V7f/yNi9+bSB/iEk
         sq9o9d0XJmmXtdavKilbRw+CYY9NrI2Axcf4cuJC/yMQVOZ78PFu16zM2GRDbR6vkpx5
         0oeg==
X-Gm-Message-State: AOAM530GaMKtlh6ryq8fuMOVDkXdy6S9w1n8txZ3OPmtl0tWpjDv20H2
        qTuEPnUS7SohV0ISJ8ns9MmM5Q==
X-Google-Smtp-Source: ABdhPJw9SrHBTtasS3Bfmsb5CfE2diIVE50no/cuh2ZoFTd2ifa2y4aRKorwhx2paF9Otm/4I696tQ==
X-Received: by 2002:a17:902:ba85:b0:13e:c846:c92e with SMTP id k5-20020a170902ba8500b0013ec846c92emr7110023pls.57.1634847150794;
        Thu, 21 Oct 2021 13:12:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15sm7192276pfr.92.2021.10.21.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:12:30 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:12:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Jann Horn <jannh@google.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, Michal Hocko <mhocko@suse.com>,
        deller@gmx.de, Qi Zheng <zhengqi.arch@bytedance.com>, me@tobin.cc,
        tycho@tycho.pizza, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        metze@samba.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110211310.634B74A@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <f4b83c21-4e73-45b6-ae3a-17659be512c0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b83c21-4e73-45b6-ae3a-17659be512c0@www.fastmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 01:03:33PM -0700, Andy Lutomirski wrote:
> 
> 
> On Fri, Oct 8, 2021, at 4:55 PM, Kees Cook wrote:
> > This makes sure that wchan contains a sensible symbol when a process is
> > blocked. Specifically this calls the sleep() syscall, and expects the
> > architecture to have called schedule() from a function that has "sleep"
> > somewhere in its name. For example, on the architectures I tested
> > (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":
> 
> Is this really better than admitting that the whole mechanism is nonsense and disabling it?
> 
> We could have a fixed string for each task state and call it a day.

I consider this to be "future work". In earlier discussions it came up,
but there wasn't an obvious clean cost-free way to do this, so instead
we're just fixing the broken corner and keeping the mostly working rest
of it while cleaning up the weird edges. :)

-- 
Kees Cook
