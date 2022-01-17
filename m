Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40349116A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiAQVtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 16:49:36 -0500
Received: from pb-sasl-trial21.pobox.com ([173.228.157.51]:54843 "EHLO
        pb-sasl-trial21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiAQVtg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 16:49:36 -0500
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 16:49:35 EST
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 574E91F98F;
        Mon, 17 Jan 2022 16:38:39 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=zHTCsXhUflqG5NDTDETust6K8wY=; b=l3aqFz
        fcswXCeUZAknRJXQfFykkxtIqxRVp6V0lwKzhODdF5qUUAmqBx3ry8Sbr4HCSXc7
        02Low6RVnJGWn3rhYnDMkvGdNCY3UyBx3ssiQZonv2Alr+VU1/5c8NDYOq7O41Re
        U0vEEf+WJlphqJc0Jv3odUeJYB146gB8F/4Hk=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 38CE11F98C;
        Mon, 17 Jan 2022 16:38:39 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=97k/YWCIM2xZt1fXcNpvHo0/q7gN6rGe/OBE09sgPW0=; b=tGjceoNgnUQowKwZBQcMObZYxb0XkZetLIAKdSEDPkirP5BZKs01nVYlbqUJFKnnjLnjmDdaYC/dR1wmwGbZAWgxzx+b64cU+JqFgxKUYKT7fi2x+qluy+wlPpXzsdOAH10spiimWmr8h8YXgPGuIhVnuRup2CrBCkA7znTINms=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10961178028;
        Mon, 17 Jan 2022 16:38:36 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 0B3022DA0040;
        Mon, 17 Jan 2022 16:38:34 -0500 (EST)
Date:   Mon, 17 Jan 2022 16:38:33 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Borislav Petkov <bp@alien8.de>
cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v9 04/15] arch: introduce ASM function sections
In-Reply-To: <YeXasIO5ArXxtw1J@zn.tnic>
Message-ID: <8n284257-9665-s3q1-6833-rn966p87qoqs@syhkavp.arg>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-5-alexandr.lobakin@intel.com> <YeXasIO5ArXxtw1J@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: D377A396-77DD-11EC-BE07-C85A9F429DF0-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 17 Jan 2022, Borislav Petkov wrote:

> Thanks for explaining this. The gas manpage is very, hm, verbose
> <sarcarstic eyeroll> ;-\:

GNU tools tend to be far better documented in their info pages.


Nicolas
