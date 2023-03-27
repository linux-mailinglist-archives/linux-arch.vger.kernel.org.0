Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE646C9F66
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 11:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjC0Jaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjC0Jai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 05:30:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7617D46AA;
        Mon, 27 Mar 2023 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8DqjXeO1tc2m6wXJ4uu/hd4TZQ+nIIRzc4UwCMqvjG8=; b=ju+MEMZ16NRWnIDWX78+WhqTZD
        ikrhVB7IopcJONyDZgU+z4k71dPM9zCprIgO9Yh6YW/iq+MBarJoh/04SRlg3RmPOLuA8DaaoZY4F
        F8Z2boePxShTaCL+vLO/ogb7T0r0qjHF6PRAE3bn18c0iH1Lc6T1XWvk+1uOQggT65mD3k1/PnYkr
        sHSgh4bFQu3XQgTnsNGV1nzKLrse91+KjHFkGmTsYep0WiKeiiAjAvOZ1FQJU/AR7XmJ1k1xh2itY
        Ujh0eJBNbGzJQkLenUzehssEwGgfLXN4fqfc1sxeAcUHVYt0EZ2cH5ZbRwwMCEg5BSk/1bpaWeayX
        rtGZ0RDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgjBC-007HH2-81; Mon, 27 Mar 2023 09:30:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 488B73001E5;
        Mon, 27 Mar 2023 11:30:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8DF82014D86B; Mon, 27 Mar 2023 11:30:16 +0200 (CEST)
Date:   Mon, 27 Mar 2023 11:30:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        gcc-patches@gcc.gnu.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
Message-ID: <20230327093016.GB4253@hirez.programming.kicks-ass.net>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325085416.95191-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:

> In the compiler part[4], most of the content is the same as Sami's
> implementation[3], except for some minor differences, mainly including:
> 
> 1. The function typeid is calculated differently and it is difficult
> to be consistent.

This means there is an effective ABI break between the compilers, which
is sad :-( Is there really nothing to be done about this?
