Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E4575865
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 02:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiGOAEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jul 2022 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOAEG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2022 20:04:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8942B189;
        Thu, 14 Jul 2022 17:04:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b9so3239383pfp.10;
        Thu, 14 Jul 2022 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3ZTJgJrieoT1UdgTTqiqvukDGVLKLFMuIKTE7lODpM=;
        b=RQV4iwKe2wUPu88mMk1f6hs8+uQ1Ya6IG4iamvqBQZ0RnnatLUT16HB70JAQQsh2Rm
         s/ZRjb/ADi4YjYlOZNf4rRyEHJGwGJHwKIiG/DxJhiQvwFZFqo1yvOApgxPwBWTwkE5k
         n05fGFUuDSx5fRERuGNvyQqCRS4HEDE+CyUN+1lrE9LEmUj9d8Mvc4I81WAP7TNQhbiq
         9c+IqL2ykCq4gi9+rg+u/ZGtfmAwtRJNjCNwkj3iJLGUh8+Gjpmg4oeH3i+A1pwKbEKY
         E4dM1e/kl76zFL3umoiwRY/WGlN/y8IBrZ8AJfo6C4EuqIoxLlHZoCugbJerixMfjj8z
         2LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y3ZTJgJrieoT1UdgTTqiqvukDGVLKLFMuIKTE7lODpM=;
        b=CBA1RDm4a3y5QL8HX6Y81xa3Mh+2jUGkNrSUSoal9n8K8hJdS08NZ0PG/Vj64vUIUW
         V2WN7kCtzHiPbvyUPVvRD1/Ly/HfOtMTavM7ctN+47YyrYOxzeGFGF1TVbTxNLdFGLJn
         Qc8ERuT2T2SWo3JOAap/UN9NDUzgsGta5nzclALA7pYDNaLPcChCEstziYWF40v7wrlC
         7SgWr95rH7KhpQrPb3flvA4o9OL1HRSD/70nU8qD0mPwXRjORuhZ8luP0SQe8lXmaxGg
         fI0eie/azM216+cx6sNr1/SFBnTrrOoFjm2hCJfoozht4N9GoBbO7U2jFD5Dy222bL6G
         yQsg==
X-Gm-Message-State: AJIora/G3ZFpeETj66ro6tWLl+IcWWPA05fbADug8gRR+wpdDRSKZtTG
        yxqPBQBPHqnztm7po34Or7M=
X-Google-Smtp-Source: AGRyM1urj2GIv1EKKty6wS9S6o5S8NLwsi59Wfu0TRZljegQWACf5/nBdipXNUa9lHaMrUSBQbZy+g==
X-Received: by 2002:a63:c63:0:b0:3fe:e14b:b5a0 with SMTP id 35-20020a630c63000000b003fee14bb5a0mr9409241pgm.428.1657843444620;
        Thu, 14 Jul 2022 17:04:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w125-20020a636283000000b00419b1671c54sm1995347pgb.4.2022.07.14.17.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 17:04:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 14 Jul 2022 17:04:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <20220715000402.GA512558@roeck-us.net>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220624121313.2382500-7-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624121313.2382500-7-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 24, 2022 at 02:13:10PM +0200, Alexander Lobakin wrote:
> Currently, many architecture-specific non-atomic bitop
> implementations use inline asm or other hacks which are faster or
> more robust when working with "real" variables (i.e. fields from
> the structures etc.), but the compilers have no clue how to optimize
> them out when called on compile-time constants. That said, the
> following code:
> 
> 	DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
> 	unsigned long bar = BIT(BAR_BIT);
> 	unsigned long baz = 0;
> 
> 	__set_bit(FOO_BIT, foo);
> 	baz |= BIT(BAZ_BIT);
> 
> 	BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
> 	BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
> 	BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
> 
> triggers the first assertion on x86_64, which means that the
> compiler is unable to evaluate it to a compile-time initializer
> when the architecture-specific bitop is used even if it's obvious.
> In order to let the compiler optimize out such cases, expand the
> bitop() macro to use the "constant" C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well, so that it produces more efficient and simple
> code in 100% cases, comparing to the architecture-specific
> counterparts.
> 
> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
> 
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> 
> and ARM64 (courtesy of Mark):
> 
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Marco Elver <elver@google.com>

Building i386:allyesconfig ... failed
--------------
Error log:
arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'send_ebook_state':
arch/x86/platform/olpc/olpc-xo1-sci.c:83:63: error: logical not is only applied to the left hand side of comparison

Bisect log attached.

Guenter

---
# bad: [4662b7adea50bb62e993a67f611f3be625d3df0d] Add linux-next specific files for 20220713
# good: [32346491ddf24599decca06190ebca03ff9de7f8] Linux 5.19-rc6
git bisect start 'HEAD' 'v5.19-rc6'
# good: [8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good 8b7e002d8bc6e17c94092d25e7261db4e6e5f2cc
# good: [07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
git bisect good 07f6d21d6e33c1e28e24ae84e9d26e4e7d4853f5
# good: [5ff085e5d4f6700e03635d5e700f52163a6dc2a7] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 5ff085e5d4f6700e03635d5e700f52163a6dc2a7
# good: [eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
git bisect good eb9e3fdbdd8b61ef0f4bee23259fe6ab69e463ab
# good: [9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b] hexagon/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
git bisect good 9f2183cd961e5ddb7954eafb6bb01a495c6a9c7b
# bad: [e878aa5faf9ac8c0b5d0c3f293389c194c250fff] Merge branch 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad e878aa5faf9ac8c0b5d0c3f293389c194c250fff
# good: [cf95d50205f62c4f5f538676def847292cf39fa9] fs: don't call ->writepage from __mpage_writepage
git bisect good cf95d50205f62c4f5f538676def847292cf39fa9
# good: [5103cbfd92d3587713476f94f9485b96e02f0146] Merge branch 'for-next/execve' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good 5103cbfd92d3587713476f94f9485b96e02f0146
# good: [ee56c3e8eec166f4e4a2ca842b7804d14f3a0208] Merge branch 'master' into mm-nonmm-stable
git bisect good ee56c3e8eec166f4e4a2ca842b7804d14f3a0208
# bad: [dc34d5036692c614eef23c1130ee42a201c316bf] lib: test_bitmap: add compile-time optimization/evaluations assertions
git bisect bad dc34d5036692c614eef23c1130ee42a201c316bf
# good: [bb7379bfa680bd48b468e856475778db2ad866c1] bitops: define const_*() versions of the non-atomics
git bisect good bb7379bfa680bd48b468e856475778db2ad866c1
# bad: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
git bisect bad b03fc1173c0c2bb8fad61902a862985cecdc4b1b
# good: [e69eb9c460f128b71c6b995d75a05244e4b6cc3e] bitops: wrap non-atomic bitops with a transparent macro
git bisect good e69eb9c460f128b71c6b995d75a05244e4b6cc3e
# first bad commit: [b03fc1173c0c2bb8fad61902a862985cecdc4b1b] bitops: let optimize out non-atomic bitops on compile-time constants
