Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9179B21A8A0
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGIUIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUIM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27EC08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so1454915pgm.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Q0u+ghHjJat2tciyUX1Wacu6e3RR04dbPYpHQAKH1XE=;
        b=KnIIIqN3s6KhBZh3AyqkGpXYB9BZWlXi1AJ1rxdTymORJaZJnKeaNLDDh1UfPf+E+/
         8Lg6Oi1o2n6rAPZylI6JGSDL+qZayQ3Y3aSQ6hgVeC0qby2lByeu832z1Fg/1aDyzLQf
         kS5n+gwFHS2InuDDWHeiEwVY7ZDiF4yulJv3VwTr3/0aKeFYaW3GHnGxDaYIPwhyCVGS
         4+2BdURZoUMwgPQjUDa/M6gQwwvK70S6JY2EYfIMzfk1UlfORNwLWM6fue8rjuWejkRG
         ZXrVeZFtCVI1+eDl7mN2K5BwHA1kYPj5/40WuAyGPEEDem/jdKOeiLYb84LTKvE+nywh
         emEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Q0u+ghHjJat2tciyUX1Wacu6e3RR04dbPYpHQAKH1XE=;
        b=XZxvGU/9As4ime21qbXIXuNpTkdFFjH5sWve1R8X02F1O/eqp4emFQp/ZJjiC9QmbP
         PUicB2TK4LzKQmol7SrgMqoFggQaPRCmgrl5SFSL/nTsFJmJYO78AiISPlB9eoVxiaPf
         GpE0PZKqvh0c0QlYK0+OGCk9PD20o6IWgjxkylw6I7gaECaHWa4MMytmuyhaLp2Fx8lw
         sXVO7Uj3EWZiHHde3FKuBdecNSulc9JD/S4gpYNBbRDEKmr7uQVx8UJVbmEFkWMVR4hV
         smWIwoexQA/PvUoUPfKAgA/nD0tNVkXKMOnIe5hDnLrgZIWkStGTWcnFdCla/OiVXmH0
         jJhQ==
X-Gm-Message-State: AOAM532CgtlqvjLQ8uBsOuax5gvJa0NkZIbjqkezp2Mms4FOgkFK37+a
        qzppeq7vcrXZ/6v+miqG1bQolQ==
X-Google-Smtp-Source: ABdhPJxOB97sUtsu8ZrmtJokh0OJEA49w3aoCwF7IfEXGT1IwMqiowNcZ7FmHprplX0SXTMGdWA/Lg==
X-Received: by 2002:a63:dd09:: with SMTP id t9mr54505309pgg.41.1594325292249;
        Thu, 09 Jul 2020 13:08:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gx23sm3441387pjb.39.2020.07.09.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:11 -0700 (PDT)
Subject: Add and use a generic version of devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:47 -0700
Message-Id: <20200709200552.1910298-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, zong.li@sifive.com
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


