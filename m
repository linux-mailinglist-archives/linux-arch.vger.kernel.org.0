Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3065467450
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 10:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379532AbhLCJ6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 04:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhLCJ6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 04:58:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B107C06173E;
        Fri,  3 Dec 2021 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KuDYRRXIU8uwGVnlVILD3XbuYJoxfOWwY4s5Uu98bYc=; b=RLPAF9o1UFaj2OysnGq6t8bq05
        zhY9Ouqf05ano45hk2S9wDCd1l3VSirW2+ABM6hdlTHNarLsaIYylu0V/avfnYLD7UJ52VOax60TE
        tIe9CwqODH/HBfFRYpr/HAENvEcsUB1bPGFBPTsl2nkMoHj3kGqtBByNfeY7E1PHYopreWwgPWoNY
        7MDVXLcfpB7YetaZMXNTUW+ZRRLkL55A878GvAzQ2EKH2xTz/CWxj7v/p7MNcXfrcWF5plCDSLk1M
        HqgPbUCFawjcG+b/du5eMf64uxDRkVd5J6/hP4qeDJuvOJbFImDuviq7L92IWJI1AUKF2Sc8IGouV
        iQG5PaVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt5HE-0085k1-Ej; Fri, 03 Dec 2021 09:54:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41EC230001C;
        Fri,  3 Dec 2021 10:54:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BC542B36B3A8; Fri,  3 Dec 2021 10:54:48 +0100 (CET)
Date:   Fri, 3 Dec 2021 10:54:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 06/14] FG-KASLR: use a scripted approach to handle
 .text.* sections
Message-ID: <YanpaIwPMEQangH6@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-7-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-7-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:06PM +0100, Alexander Lobakin wrote:
> +#!/usr/bin/env perl

> +		($name, $align) = $_ =~ /^\s*\[[\s0-9]*\]\s*(\.\S*)\s*[A-Z]*\s*[0-9a-f]{16}\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]{2}\s*[A-Z]{2}\s*[0-9]\s*[0-9]\s*([0-9]*)$/;
> +		if (!($name =~ /^\.text\.[0-9a-zA-Z_]*((\.constprop|\.isra|\.part)\.[0-9])*(|\.[0-9cfi]*)$/)) {

:-(
