Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B482D800C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbgLKUdU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 15:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbgLKUcw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 15:32:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15666C0613CF
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 12:32:12 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g18so7939188pgk.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8W3/RL0f9oAdrIxjf8Wk4dr9AqOCR7oiy6Dk2qCm7R4=;
        b=kVr/+Nim2nL0QsMtIjlrxXUxggHwMco9JmUhn39E47IrJZQPf1fk17INy3gRCDSY6g
         yxdd+cLlSoMNdCrS2SnzRplLf22ex4ZehwgzDwAb6t6F8ZCiWV3zRrZ6AysxKbSAYRkc
         pxZnpNi/EWlDxgSCsLOzZFNeHYIv4SycNtlKjce65owcduBpVcJKz9IXuIY1O4/g2Syq
         Qokp0xW3WrAf7bkV6cOQV6BKm4vuyCWEDBEaB6DR1ERREMwmEqkuFkdF04fOkoCQGwRl
         ROSzA0jT6QH+8N8YXQKc0RDdb4wwSVIjFpAu9eTswtKvklNUXPMn0KFXmffOwRWRLqVT
         aAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8W3/RL0f9oAdrIxjf8Wk4dr9AqOCR7oiy6Dk2qCm7R4=;
        b=GrStJ5R1fZ1hVoeo4TX52e4KoSOVAYEHRzErNI/O+HQuJN3w6mLZO4vgrn0GsMthfS
         BmZ9KnKW5ENV52OTaAnxoo7iwmapqjFQ93DhcTZMu8U3C8/e/KvEg9dqUgsd9/B5+f6i
         9RpRivbmrfvhl+8kFEsFmu9xKH1Pg8sOPYcmjXc2utpTSY5QpPFoic5LkV01x6046X/b
         fSlAld7qOR9nxkhOzRRY5pg6O6fJNxrJjcBS6X5cWMzWIvHygi08SdG1sAsE5z+kh1DL
         Wbtyu8LXj3sktiEwyHA5/6MIjCpih6zlz9zP/Cx584ai/vJHyN+gOKzgfKfhEBZ6p+hw
         8XQA==
X-Gm-Message-State: AOAM5332qhWoNe/831um3MRTku3hcf3it8Lsi3vbrGAS7/20iragIV2o
        8XBxAXlMzgK0iJJkUdCAlEfb+A==
X-Google-Smtp-Source: ABdhPJz+BVwwwTYnds7keGOkOEjkvsXV4svAE+CVjrOFQYmI8D+rh2kTyUWBE44zfww+oWXuQ4UG/Q==
X-Received: by 2002:a63:5d05:: with SMTP id r5mr13431438pgb.442.1607718731584;
        Fri, 11 Dec 2020 12:32:11 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y27sm11640213pfr.78.2020.12.11.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:32:10 -0800 (PST)
Date:   Fri, 11 Dec 2020 12:32:10 -0800 (PST)
X-Google-Original-Date: Fri, 11 Dec 2020 12:32:07 PST (-0800)
Subject:     Re: Add and use a generic version of devmem_is_allowed()
In-Reply-To: <20200729000030.GI4332@42.do-not-panic.com>
CC:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gxt@pku.edu.cn,
        Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org,
        akpm@linux-foundation.org, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mark.rutland@arm.com,
        james.morse@arm.com, alex.shi@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org,
        zaslonko@linux.ibm.com, matti.vaittinen@fi.rohmeurope.com,
        uwe@kleine-koenig.org, clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mcgrof@kernel.org
Message-ID: <mhng-9ffad092-5af3-4350-8417-99e79623272a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 28 Jul 2020 17:00:30 PDT (-0700), mcgrof@kernel.org wrote:
> On Thu, Jul 09, 2020 at 02:19:20PM -0700, Palmer Dabbelt wrote:
>> As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
>> implementation of devmem_is_allowed() that's exactly the same as the version in
>> a handful of other ports.  Rather than duplicate code, I've put a generic
>> version of this in lib/ and used it for the RISC-V port.
>>
>> I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
>> (though this is the first version, so they're unreviewed).  The other three
>> obviously depend on the first one going on, but I'm not putting them in the
>> RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
>> yours along with the others then please say something, as otherwise I'll
>> probably forget.
>>
>> I've put the whole thing at
>> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
>> generic-devmem .
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks.  Davoid pointed out that I forgot about this, so I just rebased it onto
5.9 and merged it into my for-next.
