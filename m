Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099123246D6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 23:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhBXW2v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXW2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 17:28:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4420C061574;
        Wed, 24 Feb 2021 14:28:10 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id a13so4150305oid.0;
        Wed, 24 Feb 2021 14:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ml1ODi0kbhU+05qftW0EgSQZXlvbak4aIvECP0XMcr8=;
        b=ohs7z461rdqHw8Oi3RZE/9WV1ZMBLPT3vLMCXgoNS8EmuP0zSGScn+MzJAW+zvP8oh
         c1e27DB/qNX255+Hfq/0aAa1AVAWEGIH1P1CFlUPosGMvkj1+amoqZJpTiqVcoVY2pOf
         mW28RZJjH9hkv5kauVt+eLaGq5e1NlnngdWVSTidlou5xN7onkFlX7ERwzo28Gj0Wr7c
         zwLP4z4E68BJaTzPr0uHLIWXs/6Y2wiHHDv+EutoNdsYgzY4Q5QQYNtUxJA+v0fA8fZX
         gjA37SeedzGgK75GqKTxPShJUMeu7QiL2Pf8XYDy4ixHIEDCsGpc7ahP36alKnfr7OHl
         HGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ml1ODi0kbhU+05qftW0EgSQZXlvbak4aIvECP0XMcr8=;
        b=Ha9+VLc1Jhp5rYhU9ClwSSAQd2HA6KZqw1tQ3mza/oHhiv9/6h5SAHXGCmEYM+6J7K
         +t4Dz9594osPFDfrzlFuMW/ZAfLk5NeOyYfgYCEL5A/ZJABBDD0pBFBKLDUdGXrvKEST
         EjkPE1ewM90fYN0uK2RC1KyCfPoOhiKg+c20X5pyWOCA3RHV6zwQBOzYTag1RBLeNVGL
         14gObwj6qWv4zPW3Xm/YqfSKPI52LsgH6lQDdotBC9RofxLdfU/6bHamta30sao6D9lg
         rcPocBrVEoNO0fg2zEvpPGVT8g9cL4WIs6A2tIxxMhZp5ts0h1awDYU1mIt4mC7Vlz9k
         fDWw==
X-Gm-Message-State: AOAM533wZj01hNKv6Jfb8b6luWYGAU9m8hyQBNi4MI9rdXeKOHSd+SOt
        +Rzju9mq7qTrarmIV4sk924=
X-Google-Smtp-Source: ABdhPJw5khRVoPOKf4Clkys33gUDj/xuRsVY2C8UyDiecRo0VXwWrOcHycZmchRPbxDhZkQD9ya4Kw==
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr4146086oiw.161.1614205689974;
        Wed, 24 Feb 2021 14:28:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm636595otf.44.2021.02.24.14.28.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 14:28:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Feb 2021 14:28:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v9 01/16] tracing: move function tracer options to
 Kconfig (causing parisc build failures)
Message-ID: <20210224222807.GA74404@roeck-us.net>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-2-samitolvanen@google.com>
 <20210224201723.GA69309@roeck-us.net>
 <202102241238.93BC4DCF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102241238.93BC4DCF@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 12:38:54PM -0800, Kees Cook wrote:
> On Wed, Feb 24, 2021 at 12:17:23PM -0800, Guenter Roeck wrote:
> > On Fri, Dec 11, 2020 at 10:46:18AM -0800, Sami Tolvanen wrote:
> > > Move function tracer options to Kconfig to make it easier to add
> > > new methods for generating __mcount_loc, and to make the options
> > > available also when building kernel modules.
> > > 
> > > Note that FTRACE_MCOUNT_USE_* options are updated on rebuild and
> > > therefore, work even if the .config was generated in a different
> > > environment.
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > With this patch in place, parisc:allmodconfig no longer builds.
> > 
> > Error log:
> > Arch parisc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at scripts/recordmcount.pl line 405.
> > make[2]: *** [scripts/mod/empty.o] Error 2
> > 
> > Due to this problem, CONFIG_FTRACE_MCOUNT_RECORD can no longer be
> > enabled in parisc builds. Since that is auto-selected by DYNAMIC_FTRACE,
> > DYNAMIC_FTRACE can no longer be enabled, and with it everything that
> > depends on it.
> 
> Ew. Any idea why this didn't show up while it was in linux-next?
> 

It did, I just wasn't able to bisect it there.

Guenter
