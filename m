Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66D4B292B
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351396AbiBKPiN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 10:38:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351394AbiBKPiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 10:38:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394013A;
        Fri, 11 Feb 2022 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZsqYYuB5zPz4U2XvwTMc7Gwvie5cfcQX4xHf1kN4geA=; b=lhI/YJi2qjzHxmqjjPK8JUNboc
        ELI4IMRWe4IJCl+h4E80XJqj1r2cvVckQdNY7MsZ4rSJcC5OHXZnE17vBcaWvad9TqsQS7uYDMZoc
        zJdah9V3x6bIlCrd4LnTyHADuZU+AWDPwCmox+GPAwDgNzoVJCHCx+M4/jtduxkjqdOmhpbHeVAhw
        tNoWavJzu7HFS6IlzQhV9C73xEopKbRU4nHMSiPN9uxoAlZAvJ6zIJDJnFDcRGgzqelEJQMVkvmAx
        YxbR5s1DYOcCPOo1IqIDqjzmY/2yL9NSDDEAomSd5QGOCwT6y6Sx411ri6MQR4hI56UPRhn4RlCL1
        wlXfZY8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIXyu-0093dN-LI; Fri, 11 Feb 2022 15:37:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F341A98630A; Fri, 11 Feb 2022 16:37:06 +0100 (CET)
Date:   Fri, 11 Feb 2022 16:37:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle
 .text.* sections
Message-ID: <20220211153706.GW23216@worktop.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-11-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209185752.1226407-11-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 09, 2022 at 07:57:47PM +0100, Alexander Lobakin wrote:
> +sub read_sections {
> +	open(my $fh, "\"$readelf\" -SW \"$file\" 2>/dev/null |")
> +		or die "$0: ERROR: failed to execute \"$readelf\": $!";
> +
> +	while (<$fh>) {
> +		my $name;
> +		my $align;
> +		chomp;
> +
> +		($name, $align) = $_ =~ /^\s*\[[\s0-9]*\]\s*(\.\S*)\s*[A-Z]*\s*[0-9a-f]{16}\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]{2}\s*[A-Z]{2}\s*[0-9]\s*[0-9]\s*([0-9]*)$/;

Is there really no readable way to write this?

> +
> +		if (!defined($name)) {
> +			next;
> +		}
> +
> +		## Clang 13 onwards emits __cfi_check_fail only on final
> +		## linking, so it won't appear in .o files and will be
> +		## missing in @sections. Add it manually to prevent
> +		## spawning orphans.
> +		if ($name eq ".text.__cfi_check_fail") {
> +			$has_ccf = 1;
> +		}

How is that relevant, x86-64 doesn't and won't do clang-cfi.
