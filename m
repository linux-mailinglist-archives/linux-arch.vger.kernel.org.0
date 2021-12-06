Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B5469050
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhLFGH3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 01:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237597AbhLFGH2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 01:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638770639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wo70tjI7q1UAqboatbwLl0h/uu/FTe3Affu+qnLiGkQ=;
        b=UGcZpCZDojgTEw8MOtaor7QeIdaHHeQlsEVZpk7JrAqyerZ8aTHoxb0ZHU+/3ptGXn8Ijw
        9veK8HQ8MDJfbhgZ2F+U9QLKhgL98XboojjWtspNksU1vLrKIvhgp/1pLrbLQntdUkT7Jq
        ha2WaGvNrcd8LWT2vgaA7H4KW50ibaE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-4zvSP8F8NGOq6PAx6hEi4Q-1; Mon, 06 Dec 2021 01:03:58 -0500
X-MC-Unique: 4zvSP8F8NGOq6PAx6hEi4Q-1
Received: by mail-qv1-f71.google.com with SMTP id q9-20020ad45749000000b003bdeb0612c5so10712335qvx.8
        for <linux-arch@vger.kernel.org>; Sun, 05 Dec 2021 22:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo70tjI7q1UAqboatbwLl0h/uu/FTe3Affu+qnLiGkQ=;
        b=aj4SRuXD8Hy3EHw/+kP50IV1v8xGyquIvjw3O2ST85K63AmBsJwxn4HRnYV/QVNKZi
         +DiLFjwMTLw/L6KkInby3GXu16aArFk0SRztYB+KY/tKv+EWFgnGQGHcBdFGKXfuh3kS
         J/P7ELuAmnfqK9qXeeA1KsABTMPooYVSOIxanN374ITIP1l+FRkbV/Epnu4WaZqjPIim
         w/g6t6HoB1wDxiRFGsrI+oaKcB1xv2pJ8SzLMw1w8e2XpqnQTlrS7zNJnGfAeR+CM8Oe
         lgFjGXJDqC9MozVAJOxNlb6EbwJIiLcq6K97uMhTyTSaM66LhVUEAAcMBUj7bBbEBiC3
         0jwA==
X-Gm-Message-State: AOAM531Gtwkx+Ke54iTR9SmqyYOJGb0FUa1R+UdRXoF79nKjLGKCCbdv
        usOemp1tWkvu+Wm/pycYLdcfT51YL+1pGtmrqucxf2CXmM1exhKUWL9ToR5tdfNtDBL8G/0HidW
        Xcr6D9O+Snli9MawAUxEbiA==
X-Received: by 2002:ac8:5bcf:: with SMTP id b15mr37503552qtb.474.1638770637755;
        Sun, 05 Dec 2021 22:03:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBlcOgv7DcKhfVmXiMUiPn6jj3Lbd0IoNd3WtPjyxukoKwU1wdw7FB6qmJfkTYOfo/DTS8HA==
X-Received: by 2002:ac8:5bcf:: with SMTP id b15mr37503536qtb.474.1638770637542;
        Sun, 05 Dec 2021 22:03:57 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y20sm6176312qkj.24.2021.12.05.22.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 22:03:56 -0800 (PST)
Date:   Sun, 5 Dec 2021 22:03:50 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 08/14] livepatch: only match unique symbols when using
 FG-KASLR
Message-ID: <20211206060350.f4hqug2jhgjlaw3c@treble>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-9-alexandr.lobakin@intel.com>
 <YansAlTr0/MfNxWc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YansAlTr0/MfNxWc@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 11:05:54AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 02, 2021 at 11:32:08PM +0100, Alexander Lobakin wrote:
> > If any type of function granular randomization is enabled, the sympos
> > algorithm will fail, as it will be impossible to resolve symbols when
> > there are duplicates using the previous symbol position.
> > 
> > We could override sympos to 0, but make it more clear to the user
> > and bail out if the symbol is not unique.
> 
> Since we're going lots of horrendous things already, why can't we fix
> this duplicate nonsense too?

I assume you mean using this new linker flag: "-z unique-symbol"

https://sourceware.org/bugzilla/show_bug.cgi?id=26391

-- 
Josh

