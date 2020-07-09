Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781FE21A9A0
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIVUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIVUU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CBC08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k5so1322915plk.13
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=q32i0M4AAOmiL37Cc0ms5q6mnstnv6IiqgVgbQXeWWw=;
        b=geDW/4VsFmUd2iNoTqYiNeXFLB883oZctQXAs2D86DOrrhvJ3uX9T7CfnHv5Qy7vgf
         dzmPz9mVhZH0PSriVPyhCQSBfGcqiaXjVk1ySds3e3W2JsGOtmDKlZh74wbWhAKInjfN
         pF+Tm0A9E9wZURlI0Xpp3trFNMxBoXEkxjVq/PWMuXrbYfSRwxX6JN7t6TDWdlKDmIq/
         vgUQV6OIc4cBDwhI+sVjljmGBwlDGIdoqXnPsxjM1LSaEGZj3Qg/qRW65M+KoT/lGlNY
         EFzpdT9qAmQXVB14FTyDMXRwPQQoPWElXVOJ8UdoKk39vx5Lo5w5a2gvMJ8Sz0uziPZD
         Do/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=q32i0M4AAOmiL37Cc0ms5q6mnstnv6IiqgVgbQXeWWw=;
        b=LqFrjBpATk36NwF1yJs0oIdOo0tF5ArWSdsxQsvDwtksd+Mx1nEDzcEKDw3Li1ibo+
         ahKxzoZD7B4FJRajlKQbDVN5Kcr8dKI+rUM/B1danvqZFHtNntibuiboBZKlrq2qNPFM
         +789EoE2VGacLn8o60a6VOkicqzT3+9N3sreF2YPPbaFk7C+ksObSCPJFt8Mv0uGxA7l
         DS433OLY9VxSkrJ9MzUwj1DP9E4MqKpuY+WLYkbgRC+e6BJ9lSbq0cRVjEjeD+2a7IBG
         A+M48Kou3AO360s+yE+wCz/xoMPx9KM8EvHFWG0KBsY2HVjx/TNhpBo8gWKP5h/xYpjh
         SaMg==
X-Gm-Message-State: AOAM533XTcwWh9OfqxMx0iIpPPa6rwrblGG6oa+AmOeTNFFArSIMcNk1
        pwTg8nWO6nA0qsc4JaFY/1+x9A==
X-Google-Smtp-Source: ABdhPJykG/WLVKUlYBnUN3nHkl5YVtpBexbKLtvO2GxnZHrRM9jePVegtvJ1EN3BQSn7pk6voA/Y5A==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr1926985pjx.169.1594329619856;
        Thu, 09 Jul 2020 14:20:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 7sm3617059pgh.80.2020.07.09.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:20:18 -0700 (PDT)
Subject: Add and use a generic version of devmem_is_allowed()
Date:   Thu,  9 Jul 2020 14:19:20 -0700
Message-Id: <20200709211925.1926557-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com,
        broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net,
        rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org,
        krzk@kernel.org, zaslonko@linux.ibm.com,
        matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org,
        clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
implementation of devmem_is_allowed() that's exactly the same as the version in
a handful of other ports.  Rather than duplicate code, I've put a generic
version of this in lib/ and used it for the RISC-V port.

I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
(though this is the first version, so they're unreviewed).  The other three
obviously depend on the first one going on, but I'm not putting them in the
RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
yours along with the others then please say something, as otherwise I'll
probably forget.

I've put the whole thing at
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
generic-devmem .

Changes since v1 [<20200709200552.1910298-1-palmer@dabbelt.com]:

* Don't have GENERIC_LIB_DEVMEM_IS_ALLOWED select ARCH_HAS_DEVMEM_IS_ALLOWED,
  instead just adapt the users.
* Remove ARCH_HAS_DEVMEM_IS_ALLOWED from the arch Kconfigs, as I forgot to do
  so the first time.


