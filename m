Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D423037A4B2
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 12:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhEKKh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhEKKh4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 06:37:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E16C061763;
        Tue, 11 May 2021 03:36:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so27952794lft.1;
        Tue, 11 May 2021 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPTGhSdYS1EwXktDTrRYGbw3xN/gpinHXJ0dbeYJ3es=;
        b=uLAisls4ltrVE4/Ogyxj6kPvgrmoXy2pwMhFXj+C/1mOobjpzx0EP8xJNpPURz4OnO
         aG3Dll4zNPrlWeqY0JdN4+eQlLJTqkmso/8DyY9YVmessQPzyJGx/DXBAEwNcJv4I27Q
         dg3nz34jHrmu6DbuXxwJVHRD0x+uCOGhKYluvrALG/nIBDwCUIJj+kta9gu9WH3LwJe/
         6S4Ak774b1i9g7BRjnIg41lyA7bGEuj7lcaAlvpjpXPArfdeOpBG1SBXs9nJhirvfFT4
         o1JWaFsxWH/O4AHF7N+q/aFWJ3nib2f/V8tR/oKhB8oiytYd2RPUHCqGVg+W7jV8oYac
         tfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPTGhSdYS1EwXktDTrRYGbw3xN/gpinHXJ0dbeYJ3es=;
        b=f8/vt//XrJy704kJNh2waKlp3YZsMZ+uAOD0l42NI6JU92yXMGwD6vy0RUXIoTJkjP
         gtpGDp1wB00wiDHRrFb9t8HtrOYEE+gMEMN8hIlGmOtqyox8fLOxINn8icm9q0OO81zA
         76s3s/P2o9sfFNBCrzvz3Ha1nQ6DvmA3CUneyFimTuKUpKThx97Mjl3MwhQP5b737TCL
         /jdck+rlFbY8Ki/3EjD01hMMqwUXEwZ9kxA5u+i58/xH0qqzC1bGNxa39X65zDz2Q0TV
         PFtuzxCPGOHShbYHeX+waI4yOnlkM4Dfc4+reEyabEkwh7tn9J6THEKkzI6AyQBkgjSX
         DBWQ==
X-Gm-Message-State: AOAM532sPGsatCmp0u3vUXVS1J1KMgPHRralHkN7TjBduN5dLDF8KGwJ
        oUKxalrJrve35t2zxceNwKw=
X-Google-Smtp-Source: ABdhPJxH3TGCNCqhpUbtkmWcuM1loUXzrtKYaQ4Uv96NT1vQ/n7AYKCj9cmK9h40us2sMTkRMZ1b/Q==
X-Received: by 2002:a19:c111:: with SMTP id r17mr19841633lff.564.1620729408667;
        Tue, 11 May 2021 03:36:48 -0700 (PDT)
Received: from rikard (h-158-174-22-223.NA.cust.bahnhof.se. [158.174.22.223])
        by smtp.gmail.com with ESMTPSA id n7sm2548891lft.65.2021.05.11.03.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 03:36:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 11 May 2021 12:36:44 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
Message-ID: <YJpePAHS3EDw6PK1@rikard>
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard>
 <YJoyMrqRtB3GSAny@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJoyMrqRtB3GSAny@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 11, 2021 at 10:28:50AM +0300, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 12:51:58AM +0200, Rikard Falkeborn wrote:
> > On Mon, May 10, 2021 at 06:44:44PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > Does the following work for you? For simplicity, I copied__is_constexpr from
> > include/linux/minmax.h (which isn't available in tools/). A proper patch
> > would reuse __is_constexpr (possibly refactoring it to a separate
> > header since bits.h including minmax.h for that only seems smelly)
> 
> I think we need to have it in something like compiler.h (top level). Under
> 'top level' I meant something with the function as of compiler.h but with
> Linuxisms rather than compiler attributes or so.

Right. Will you send a patch, or do you want me to?

It would be good to get confirmation that __is_constexpr solves the
build failure.

> 
> Separate header for the (single) macro is too much...
> 

Agreed.

> > and fix
> > bits.h in the kernel header as well, to keep the files in sync.
> 
> Right.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

With Best Regards,
Rikard
