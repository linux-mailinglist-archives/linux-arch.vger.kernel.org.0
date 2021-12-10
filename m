Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA0470171
	for <lists+linux-arch@lfdr.de>; Fri, 10 Dec 2021 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbhLJNYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Dec 2021 08:24:31 -0500
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61129 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbhLJNYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2021 08:24:30 -0500
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id A2E342E1EC;
        Fri, 10 Dec 2021 08:20:49 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=E68Man9i8uGbUzpPImAfkcG0qQQ=; b=M3i/hG
        +azN6LUuLTqwmsHeWkGG7FXoUTNLjKlcghu0jP1JL7tMcr1g3DLKr0EwVhjeBZ/L
        y8icsjLdxH0UvesHgER6DOoFGERVbG5wJCPvby524NWd/jljcQFS250sFKI/vS4w
        tPkXHLp5Tqj+0NTd4s++EeeXGODc+op0P7iZ8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 7B5532E1E9;
        Fri, 10 Dec 2021 08:20:49 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=t/i4EcgilqHL2J/A6MZhr8Rb0kiWWXpYExUCO+guzKc=; b=wl6ECYHXf3DMmbJe3rjaV3PHwRQeyftEtMeaXX/tLxVUyMNdWluOEpCkL6gCK68AGUCs3Qpr5a/bOUni3SRDm7odrxxtfU+++aqtjURc2s+DqWbqYpQ+/IlgADslc0PIS+iauEYxKrzGgFVDccc1X5aVWjPyjohZIr9jY6hiZmc=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D48B2101024;
        Fri, 10 Dec 2021 08:20:48 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5172A2DA003C;
        Fri, 10 Dec 2021 08:20:47 -0500 (EST)
Date:   Fri, 10 Dec 2021 08:20:47 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "H . J . Lu" <hjl.tools@gmail.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions
 into separate sections
In-Reply-To: <20211210110102.707759-1-alexandr.lobakin@intel.com>
Message-ID: <2onsnq80-p1s8-00-roo9-n02q74319ro@syhkavp.arg>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com> <20211202223214.72888-6-alexandr.lobakin@intel.com> <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net> <20211210110102.707759-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FD891D6C-59BB-11EC-A1FA-E10CCAD8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 Dec 2021, Alexander Lobakin wrote:

> I could do unconditional
> 
> .pushsection %S.##name
>                 ^^^^^^ function name
> 
> but this would involve changing LDS scripts (and vmlinux.lds.h) to
> let's say replace *(.noinstr.text) with *(.noinstr.text*).

Yes, this is meant to be used with a linker script that expects the new 
name.


Nicolas
