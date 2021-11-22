Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE95E459747
	for <lists+linux-arch@lfdr.de>; Mon, 22 Nov 2021 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhKVWX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Nov 2021 17:23:59 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46035 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233754AbhKVWX6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Nov 2021 17:23:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F04595C0216;
        Mon, 22 Nov 2021 17:20:49 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Mon, 22 Nov 2021 17:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=FCiOZI9Dv20tAQ/7weQX2U+Lw8g5MWM
        QEAl+y42pkKY=; b=QeNEi/AvK+hUIh19j4A+w35hKQD6AvtNdPGl90BKWAdJZbi
        X0dlB5XmiTonKKlE3TfNxWUA8CnP8C4D3Koui8OWgTNn6cgpFdmjmxPVqWvXY02x
        eUv5KaGaRNAiDXPnZlqP5GV6z5t64Op5ijxfokgiWt+prR/83JcgUu1KmW4p6u4p
        JWrYxfBvURPXEk9/RcT3Wf4G5HJcfA4NmjpabgA2+JAD9CwuOe2LTy+LKjjO84Hf
        6dgD0noO2GJRdKgwZlxuBSIBEnp8ChH+YV1go5nPw1qeqQOiqOnk2m7OB//nGa+r
        i5Wy9GudkLvgQ858Yy1KHtLuJw6dgrELjCE7RlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FCiOZI
        9Dv20tAQ/7weQX2U+Lw8g5MWMQEAl+y42pkKY=; b=ewXBhaKwZLdmIj+sVkHsf9
        a0YSi9sP0qm9FmmmKZiGKfjGEJqBOI0PwYjRT/tm8wPlVyMQpaHenat9tthmfJNp
        hvhhMkVPyq9aBgnxPz7vG+NaGRlLAooKioTubxNhyzraHFL6zN0O0DAfN1GZWG3u
        oNc2JXxb4rwNDCXYigmtGzeO8OZZsWGUoR1PXsSygAO/6RVqSRZXMkhjAzPmOR4o
        AoWnsRjtL5HXh4BSry0m48O5ZyiUxmlQvE3YrzNCIQy3zKIE7blR9Ue/2e6bWgJd
        mWBHpKCQyrbMfufQXgNpdfSqdFgJTBs564Da0Xhkrhd6YyKbSUpNw9cdAoAvzxtg
        ==
X-ME-Sender: <xms:wRecYZdfCh09993z-RORgZjn0BOI_8kLoYaGF3jMOdIUfnPfmvsI8g>
    <xme:wRecYXN5dggdlACAyRkvZsUt6oqUnQoyl00nJRjjEt5w9bYXw5dkjLf34AjrdJpZR
    YmCfMH1KLoUNkLkxxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdgkrggt
    khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
    frrghtthgvrhhnpefhuefhveeuffetfffgjeetgfekkeehfedtfeelgfehffffveehkeel
    fefgheffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:wRecYShg87In53jYFl4bkLTO_d4fVgJeFcvgzaVd7xtXrC2El82iwg>
    <xmx:wRecYS9Nx3NXMazQy4eNpUK3utqVVP3bE3-db4qGrhIhD0g_oDntPg>
    <xmx:wRecYVvby4ByQWrYB4nSaXRaL2-thVvNo16RHugYiavRR9uod8TCFQ>
    <xmx:wRecYdI655DXx77lkf7cprqbo_ioS7XxEV5dg57HePNcF6rLB4g8Og>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B74024A0079; Mon, 22 Nov 2021 17:20:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
Date:   Mon, 22 Nov 2021 22:19:59 +0000
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     "Cyril Hrubis" <chrubis@suse.cz>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, ltp@lists.linux.it
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
...
> +
> +#include <asm/bitsperlong.h>
> +
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>   */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif

I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate

 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
+ * In user space match <stdint.h>.
  */
+#ifdef __KERNEL__
 # include <asm-generic/int-ll64.h>
+#elif __has_include (<bits/types.h>)
+# include <bits/types.h>
+typedef __int8_t __s8;
+typedef __uint8_t __u8;
+typedef __int16_t __s16;
+typedef __uint16_t __u16;
+typedef __int32_t __s32;
+typedef __uint32_t __u32;
+typedef __int64_t __s64;
+typedef __uint64_t __u64;
+#else
+# include <stdint.h>
+typedef int8_t __s8;
+typedef uint8_t __u8;
+typedef int16_t __s16;
+typedef uint16_t __u16;
+typedef int32_t __s32;
+typedef uint32_t __u32;
+typedef int64_t __s64;
+typedef uint64_t __u64;
+#endif

The middle clause could be dropped if we are okay with all uapi headers potentially exposing the non-implementation-namespace names defined by <stdint.h>.  I do not know what the musl libc equivalent of <bits/types.h> is.

zw
