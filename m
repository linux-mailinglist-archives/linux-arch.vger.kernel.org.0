Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3035F49BF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJDTcS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJDTcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 15:32:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C406696E5
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 12:32:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gf8so11177273pjb.5
        for <linux-arch@vger.kernel.org>; Tue, 04 Oct 2022 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2IH8tEaBNUJUhlSQeqfFFR10kAzhCNDmBQkNCBhNbwo=;
        b=IdypEmuXWawFBdcHvEhd6ksx6DklfESbyWquWbCkuj85gFh8vAi3YTFtL6x1TFDBdo
         4vpS7F1oLY/TRy8lXUYx/Tzbe3wKWlW2rY647p4DR2Zx0xz9Vmk2lZntCiHnmMqPhacs
         S9dn+pkGTWgmV8c5ZA8O42VK4MOFeIf7uXPI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2IH8tEaBNUJUhlSQeqfFFR10kAzhCNDmBQkNCBhNbwo=;
        b=SRhcc7texPu4D6MznZjTYCaQDLn+Bet7x710VtqyOG2zfdnZsnEM6WtT6dbCJ3Y5oF
         oqoiS7MugT38LdxjG4vC8NpxwXSH+3ba21NezOQA0pZGYlEJThbIyaZokKVh8X5BKEaL
         UVQXlJNfM6+zBcYwm6EnXeQNIPNgv3zbg66mjiNi/lPxuhUlJHwsEpw2dEtqpDeJoPWy
         dQubZzESsu10Ut5AWgCw27aPnV0/kMWHQD3f16sQtwnMeB+80XSrOSw/wb7HwLWOp/rV
         PmE/mdZNfKi4A4Y7BVN/cVMQLAuOU3Nu/KbVM4lkmvQbTsZZWkCUXtWxca7z3DxYs6PD
         eRSg==
X-Gm-Message-State: ACrzQf3rNSSb+YyhZFuW0jUNhulWvJflWKLOnbfEGYkca46XPIyqe2v4
        8ZnFgA0t7JZIqOH4Wxz3nqnqmA==
X-Google-Smtp-Source: AMsMyM7ZgnbRL5j5vxtAYQskFyiI9m6Jng0jRwmWtojPF0jt9sUxdX7NDJFfugkkHWlwVBeeLzBCdQ==
X-Received: by 2002:a17:90b:380e:b0:202:d747:a044 with SMTP id mq14-20020a17090b380e00b00202d747a044mr1255562pjb.170.1664911935982;
        Tue, 04 Oct 2022 12:32:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b00179f370dbe7sm9265341plh.287.2022.10.04.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:32:15 -0700 (PDT)
Date:   Tue, 4 Oct 2022 12:32:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Dave Hansen' <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <202210041229.99F8CB38B@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
 <202210031203.EB0DC0B7DD@keescook>
 <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
 <4b9c6208d1174c27a795cef487eb97b5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9c6208d1174c27a795cef487eb97b5@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 04, 2022 at 10:17:57AM +0000, David Laight wrote:
> From: Dave Hansen
> > Sent: 03 October 2022 21:05
> > 
> > On 10/3/22 12:43, Kees Cook wrote:
> > >> +static inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
> > >> +{
> > >> +	u64 val, new_val;
> > >> +
> > >> +	rdmsrl(msr, val);
> > >> +	new_val = (val & ~clear) | set;
> > >> +
> > >> +	if (new_val != val)
> > >> +		wrmsrl(msr, new_val);
> > >> +}
> > > I always get uncomfortable when I see these kinds of generalized helper
> > > functions for touching cpu bits, etc. It just begs for future attacker
> > > abuse to muck with arbitrary bits -- even marked inline there is a risk
> > > the compiler will ignore that in some circumstances (not as currently
> > > used in the code, but I'm imagining future changes leading to such a
> > > condition). Will you humor me and change this to a macro instead? That'll
> > > force it always inline (even __always_inline isn't always inline):
> > 
> > Oh, are you thinking that this is dangerous because it's so surgical and
> > non-intrusive?  It's even more powerful to an attacker than, say
> > wrmsrl(), because there they actually have to know what the existing
> > value is to update it.  With this helper, it's quite easy to flip an
> > individual bit without disturbing the neighboring bits.
> > 
> > Is that it?
> > 
> > I don't _like_ the #defines, but doing one here doesn't seem too onerous
> > considering how critical MSRs are.
> 
> How often is the 'msr' number not a compile-time constant?
> Adding rd/wrmsr variants that verify this would reduce the
> attack surface as well.

Oh, yes! I do this all the time with FORTIFY shenanigans. Right, so,
instead of a macro, the "cannot be un-inlined" could be enforced with
this (untested):

static __always_inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
{
	u64 val, new_val;

	BUILD_BUG_ON(!__builtin_constant_p(msr) ||
		     !__builtin_constant_p(set) ||
		     !__builtin_constant_p(clear));

	rdmsrl(msr, val);
	new_val = (val & ~clear) | set;

	if (new_val != val)
		wrmsrl(msr, new_val);
}

-- 
Kees Cook
