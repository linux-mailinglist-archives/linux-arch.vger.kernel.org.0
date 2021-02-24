Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEB324519
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 21:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhBXUSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 15:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhBXUSG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 15:18:06 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C529C061574;
        Wed, 24 Feb 2021 12:17:26 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 18so3715765oiz.7;
        Wed, 24 Feb 2021 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ylNlgfdcvRYOD6kXq/95XnGE6RgCAMqXvQ1uBMMg7TU=;
        b=RhNsZyzXgtTZGyid5j7nVxfjC5vdc5cxSATcD8rc+cg00YD/Uu1qopgE0wLckdrrfh
         AMbMPE6l42p5jtO2qEMlB6RBoiy/u6oeOfBKxB9YDRU+CyIdVN+OqiFMfONkZ5OBUyJT
         pYqWHcQ9YjSGTuxG6MK2ztRqiuOxyxd7MkbB895Aoxto9JgmmfUqRh2iu5hVc54oWKUI
         Gq97bliEvUmmhPnIPYtuOBB/ESNbs1xmeQ5jhfh/sAVUw4iaxufO7htAed0SwH5o4oJe
         scdddBN+FqryhHDKlk8OmTM346/xXlWpfcKrSkUNbd9PEEnxF6oU6vnbhOaAA+zbLoP9
         RTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ylNlgfdcvRYOD6kXq/95XnGE6RgCAMqXvQ1uBMMg7TU=;
        b=YGC7euZ5PUqaO7Xk+uCvufUqnIKXA2RBj6FjYNmpe29GjRa9zcy2/91LbNfrlu8JJi
         67FqRsz09rCaIFgAiQ/S+xAY98+cN0XNFbM/OPh1HvyKZ7jGRT/0iDF36yxQ4iRmnf5S
         lIte+f2olPsa2VFMVQcE/Dq/2kLSdEhl57oEvaNh2zUCmqlGBBbs6AtqPmiQDHqEw822
         FWhKKosySqiDZgQqLDBFzeJW7A0qRYFkOe1SBeU4qkY0i1TJqP4vPehIdyvEC9Ukf+so
         TIQKUzBmHu5/dWOS/9FKuGp/fSZNaE31yhCC1sSxk16CRUC5iCv2H03jHRn189QmPola
         tcMA==
X-Gm-Message-State: AOAM5324hpkIL5vSocIcPEx6ITCxnKxoEZYpOrRU0V1rKz5GkL34DPKI
        1xf+9oL08N+PB/xjSzdnRhI=
X-Google-Smtp-Source: ABdhPJzDBcW556aZO7mgeeunZgHfhSVx/5GFriwJvwVEbAj9sOwTknCGBEak65KhGzHJp7g/DrTp8Q==
X-Received: by 2002:aca:ad0d:: with SMTP id w13mr3743625oie.170.1614197845430;
        Wed, 24 Feb 2021 12:17:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n93sm572233ota.37.2021.02.24.12.17.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 12:17:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Feb 2021 12:17:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v9 01/16] tracing: move function tracer options to
 Kconfig (causing parisc build failures)
Message-ID: <20210224201723.GA69309@roeck-us.net>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211184633.3213045-2-samitolvanen@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 11, 2020 at 10:46:18AM -0800, Sami Tolvanen wrote:
> Move function tracer options to Kconfig to make it easier to add
> new methods for generating __mcount_loc, and to make the options
> available also when building kernel modules.
> 
> Note that FTRACE_MCOUNT_USE_* options are updated on rebuild and
> therefore, work even if the .config was generated in a different
> environment.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

With this patch in place, parisc:allmodconfig no longer builds.

Error log:
Arch parisc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at scripts/recordmcount.pl line 405.
make[2]: *** [scripts/mod/empty.o] Error 2

Due to this problem, CONFIG_FTRACE_MCOUNT_RECORD can no longer be
enabled in parisc builds. Since that is auto-selected by DYNAMIC_FTRACE,
DYNAMIC_FTRACE can no longer be enabled, and with it everything that
depends on it.

Bisect log attached.

Guenter

---
# bad: [414eece95b98b209cef0f49cfcac108fd00b8ced] Merge tag 'clang-lto-v5.12-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# good: [b12b47249688915e987a9a2a393b522f86f6b7ab] Merge tag 'powerpc-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect start '414eece95b98' 'b12b47249688'
# bad: [f6e1e1d1e149802ed4062fa514c2d184d30aacdf] Merge tag 'gfs2-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect bad f6e1e1d1e149802ed4062fa514c2d184d30aacdf
# bad: [79db4d2293eba2ce6265a341bedf6caecad5eeb3] Merge tag 'clang-lto-v5.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 79db4d2293eba2ce6265a341bedf6caecad5eeb3
# good: [9d5032f97e9e0655e8c507ab1f43237e31520b00] dt-bindings: mediatek: mt8192: Fix dt_binding_check warning
git bisect good 9d5032f97e9e0655e8c507ab1f43237e31520b00
# good: [f81f213850ca84b3d5e59e17d17acb2ecfc24076] Merge tag 'for-linus-5.12-1' of git://github.com/cminyard/linux-ipmi
git bisect good f81f213850ca84b3d5e59e17d17acb2ecfc24076
# bad: [112b6a8e038d793d016e330f53acb9383ac504b3] arm64: allow LTO to be selected
git bisect bad 112b6a8e038d793d016e330f53acb9383ac504b3
# bad: [3578ad11f3fba07e64c26d8db68cfd3dde28c59e] init: lto: fix PREL32 relocations
git bisect bad 3578ad11f3fba07e64c26d8db68cfd3dde28c59e
# bad: [22d429e75f24d114d99223389d6ba7047e952e32] kbuild: lto: limit inlining
git bisect bad 22d429e75f24d114d99223389d6ba7047e952e32
# bad: [dc5723b02e523b2c4a68667f7e28c65018f7202f] kbuild: add support for Clang LTO
git bisect bad dc5723b02e523b2c4a68667f7e28c65018f7202f
# bad: [3b15cdc15956673ba1551d79bceae471436ac6a9] tracing: move function tracer options to Kconfig
git bisect bad 3b15cdc15956673ba1551d79bceae471436ac6a9
# first bad commit: [3b15cdc15956673ba1551d79bceae471436ac6a9] tracing: move function tracer options to Kconfig
