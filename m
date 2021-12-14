Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802064747E1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhLNQYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhLNQXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:47 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B148C061374
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:38 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso13417257wmj.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YXzf2AmImQ6mywVvUf+Dd2SadORvaqMGa98N/8wEyCE=;
        b=WoieykU0vE3e7pyI/oyga8gaBev/YztJjf73B/DEvIxeumtlBa6EUTmjuc4jcmIMLX
         nVUK3c6ez+TVQFQQ2qMETFAL6aiqaRThJuloL8YuWdGBKZ5ep7MSrmnoDQm4AO9kgdAl
         Wh4CgLx/HAje1tAx7yMO3KMwNXVBThP1eOIpJDnxdyxM+4UrOYrM4a/bX/s2rpzdsiwU
         w83IY5U7lohcI5Alm77PKO3vv8zFBRwoiJyz1TJ9O0g6pUWPazaH/MqKhRKEXIDVDco2
         g1gKxls5sjcT3gjd3g4b5NOHfK6sfVPvNX4hIXL++00vy5xc7dkvJxn86YqeRYlTuU4F
         FuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXzf2AmImQ6mywVvUf+Dd2SadORvaqMGa98N/8wEyCE=;
        b=0ml/rh2jNLTdxUfeEiBstjskqfH9/7WEaVmJQu+ehm7UxBlUOXSza7ShuXxI6uAngR
         9z8kuPJJGxM6IO1L7IZkSKKimNxl+23EtXH3dkfcYVUGS5cKuVpWN0E+pmRvTbkLjXXx
         axj6vJ8N1nNhfWJjcobdrlIIaC8u9tSGhuxaLg9ocFKD9OM45bTY+z8za1yOx+fg0jcj
         tPQlWSLNQ4IZOpR+/dBM5E31FT08ho9wHqegg5rUtOS7K5UruNej7TMS2lt7YTlImx/y
         5kXnPhZHCGdPnWFEy3pSu+vnCLnbv8S6I6N2nQPah7a3PIKh8IHh1x/LMI36men4mig8
         Nk5w==
X-Gm-Message-State: AOAM532vywhcRjJDOJD7lCgVDeyFYaxoCyVPfx6OjNXhThDW83lhg4QF
        jRWJQUBwAy2SJ2iJgRmqg+EBkmljhS8=
X-Google-Smtp-Source: ABdhPJwPL8nrsavt08DbsW8quI6O5ixz52gAqZYkOXc5DfWMgtMM43VM2EUKGgLQG6hcWYM+aM6wKoh/iSg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:6111:: with SMTP id v17mr6757949wrt.512.1639499016732;
 Tue, 14 Dec 2021 08:23:36 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:45 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-39-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 38/43] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dentry_string_cmp() calls read_word_at_a_time(), which might read
uninitialized bytes to optimize string comparisons.
Disabling CONFIG_DCACHE_WORD_ACCESS should prohibit this optimization,
as well as (probably) similar ones.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I4c0073224ac2897cafb8c037362c49dda9cfa133
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 760570ff3f3e4..0dc77352bc3c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,7 +125,9 @@ config X86
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
-	select DCACHE_WORD_ACCESS
+	# Word-size accesses may read uninitialized data past the trailing \0
+	# in strings and cause false KMSAN reports.
+	select DCACHE_WORD_ACCESS		if !KMSAN
 	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.34.1.173.g76aa8bc2d0-goog

