Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740844AD3A1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbiBHIjn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 03:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbiBHIjm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 03:39:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE3C03FEC6;
        Tue,  8 Feb 2022 00:39:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644309579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=malCeE34Yhe4BdItL2LmoONOvx92hBQ5PhbsSDSuu48=;
        b=OA6Qnin2X/V+AetG5uDMHxjNPza8j0ICBOeftFT17UwCs8BRoy0lHgSXS2L4aaGBdprUEc
        kIVcXLXkD9Rjr/pBpeFlJwQAwjriCwz/05sZxV6cRzNrJjOLSWVrnWs9uUevZi+t6rxQ5u
        t5rpjzLP1kl3enpI8auU8B/8HbqFujITpMa/n8kQBFds5opWrXrbd6O/y2YMybAHmwd8bv
        qU5JDEb6xk3s0jTzJLqTY/tLQYeIGJfMHUZfqoiyQVnBaLny47488jta1wAlgUsMXjjxle
        WYzZfO/a21HpWlEaKqerQelEO8HJANGcXH7QoVug6QK6mI/rbMMY1xksZ/L1Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644309579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=malCeE34Yhe4BdItL2LmoONOvx92hBQ5PhbsSDSuu48=;
        b=z1jiuM/itl3h/7cW66mjltdtUu5ZbTR04wBBpxC2k7ifMaEXC8s2xTgH1VBXCMbnCf+8hH
        upo4f1X27jV/HQAA==
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/35] x86/cet/shstk: Add Kconfig option for Shadow Stack
In-Reply-To: <20220130211838.8382-3-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-3-rick.p.edgecombe@intel.com>
Date:   Tue, 08 Feb 2022 09:39:38 +0100
Message-ID: <87v8xpvjjp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30 2022 at 13:18, Rick Edgecombe wrote:
> +config ARCH_HAS_SHADOW_STACK
> +	def_bool n
> +
> +config X86_SHADOW_STACK
> +	prompt "Intel Shadow Stack"

It's also available on AMD, right?

Thanks,

        tglx
