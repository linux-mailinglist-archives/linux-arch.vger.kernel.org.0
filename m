Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276246532B9
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiLUOxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiLUOxn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 09:53:43 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C323BE2;
        Wed, 21 Dec 2022 06:53:35 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id k189so13507752oif.7;
        Wed, 21 Dec 2022 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ1vWq6QP9ooDh1F7PrBShWOEwM3JaOtots6tMwnEDc=;
        b=Hs2hcpE0GixDU25RniztxZmHLXy34nD9KFMNSV29735FvbMtBz3cpTbGWOxvtBS9zF
         vaw4/Qg/6ezcFbIXoD1PjbhHHIrQDBC2ASh5xVR3Oe3iG/9p28Q8lOykWBO5s+GKl3CH
         ZGBYQO7BiCM7KRhFsPqp2n/6inknqI7Wh6CifUfSONGShOCOxrpq7nQ9dZv2YyJxiUJd
         B8c21cS60GltUWxHv6MwyPeIQKEgYXwH+sLbiaZVp2D0v7CMlXH65+WTR2Byio9KZvgz
         JdBCMvRII6lNyS44ubIXKPuSSRiefU0YD/rB/5ziuRKMrcsPSS1TBSfLMt2t7V/UA8K4
         CwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ1vWq6QP9ooDh1F7PrBShWOEwM3JaOtots6tMwnEDc=;
        b=bhn7MFeYypZ1Ah3p1MKeNY685whO4B/DU6pvHhX8/0YuX49LLOCFqhAC+sHF7huvDm
         gc8aKNKvKPY6d4mw8b1mMo6f7Qt4NxAOTf2WV26Ub3KHZD1HY6/RzJ0Wp8SePs+38B0X
         qg+nXdZB6CQJFSbGSAGQA7C+PziSwtKum/O7b4YevvOC8/x2grIfGc06LG1HfeMplQTY
         e+yGHQ61XUqUUHTb/n1KT8lj9FSr2WEOwdsJ/rFRRqnmIkIot5fjPxq81S3QJXyNvO6p
         eomgTDMeTb/uw2nKNnQ5ODvslJ0u9O8jldPBeI7kQ7LWo5sZgydK8sCrPUqi/I5Lw4xY
         sq8Q==
X-Gm-Message-State: AFqh2krYz7gH9gEMu9jwWekC/VHUPRKSlzG7zDhuOfvshFANNpmhI+ju
        Wx4CX6EWcbrPwdfKWqtafZg=
X-Google-Smtp-Source: AMrXdXt0S1FoFk2/7ZiH1/8hO/xt4vAhVm8o0RNHfG/IxvIRBA2rBtKlfdM/MIfm+QFP5yebYl94pg==
X-Received: by 2002:a05:6808:bc3:b0:360:d800:d10c with SMTP id o3-20020a0568080bc300b00360d800d10cmr1091986oik.34.1671634414991;
        Wed, 21 Dec 2022 06:53:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s8-20020acaa908000000b00354d8589a15sm6768140oie.45.2022.12.21.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:53:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 06:53:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <20221221145332.GA2399037@roeck-us.net>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019203034.3795710-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> Recently, some compile-time checking I added to the clamp_t family of
> functions triggered a build error when a poorly written driver was
> compiled on ARM, because the driver assumed that the naked `char` type
> is signed, but ARM treats it as unsigned, and the C standard says it's
> architecture-dependent.
> 
> I doubt this particular driver is the only instance in which
> unsuspecting authors make assumptions about `char` with no `signed` or
> `unsigned` specifier. We were lucky enough this time that that driver
> used `clamp_t(char, negative_value, positive_value)`, so the new
> checking code found it, and I've sent a patch to fix it, but there are
> likely other places lurking that won't be so easily unearthed.
> 
> So let's just eliminate this particular variety of heisensign bugs
> entirely. Set `-funsigned-char` globally, so that gcc makes the type
> unsigned on all architectures.
> 
> This will break things in some places and fix things in others, so this
> will likely cause a bit of churn while reconciling the type misuse.
> 

There is an interesting fallout: When running the m68k:q800 qemu emulation,
there are lots of warning backtraces.

WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha12,aes)' before 'adiantum(xchacha20,aes)'
------------[ cut here ]------------
WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha20,aes)' before 'aegis128'

and so on for pretty much every entry in the alg_test_descs[] array.

Bisect points to this patch, and reverting it fixes the problem.

It looks like the problem is that arch/m68k/include/asm/string.h
uses "char res" to store the result of strcmp(), and char is now
unsigned - meaning strcmp() will now never return a value < 0.
Effectively that means that strcmp() is broken on m68k if
CONFIG_COLDFIRE=n.

The fix is probably quite simple.

diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
index f759d944c449..b8f4ae19e8f6 100644
--- a/arch/m68k/include/asm/string.h
+++ b/arch/m68k/include/asm/string.h
@@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
 #define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char *cs, const char *ct)
 {
-       char res;
+       signed char res;

        asm ("\n"
                "1:     move.b  (%0)+,%2\n"     /* get *cs */

Does that make sense ? If so I can send a patch.

Guenter
