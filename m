Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000A231689
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgG2AAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 20:00:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46923 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgG2AAf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 20:00:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id 74so3701063pfx.13
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 17:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9WqMZ97j3+53daSNfhsHBQoaaEy2kmohpeoSYJwCfQ=;
        b=LucxF+qp8wyzSWGdR9Xt/XR4YqJwKp6xuvn7o9jgEV6Puw8ruA0sYCBoThbatqZFkX
         1g+AtxWTcZxsWDQXdKDybdNoqOcSwYihSikZZhPSaNIUF8GyK8czNEjOUnj6Wf1KSbbL
         zZ7j7DYRFLZMgpzoHOnuz/QiT0AyiN1r2prHa0EqRszSJuQcNvyQao3e9yiMy2tQ20ph
         oI6ML7FwV9/XOjWNhbDpIl9VEPcUE+BJU7QyyQY2e2yAl9liIGtdL0Zaug/LAy0dZUwd
         CBCBMy+FRWCeGQokV6IGna6U9BtmJOVwLQJTyg9I7yXlTSOVnC4W2/NErwWdLKm5OA7e
         wOhg==
X-Gm-Message-State: AOAM531vyaEKK6UxuzqWXDsLU4vEk7SdkfetgV63A7QHDiy/ZKMNmR8T
        QRCUYJCiMsjaj4WY9FE8sEk=
X-Google-Smtp-Source: ABdhPJyFmGfdKxBOVYNB0K3oYpdOdGvgaS6f+zykhySlRqWDjKCdtOoWyxd3+w1bPIRhQIyPPc3YTg==
X-Received: by 2002:a63:6e08:: with SMTP id j8mr26766982pgc.187.1595980834535;
        Tue, 28 Jul 2020 17:00:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c134sm172298pfc.115.2020.07.28.17.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:00:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0E2E040945; Wed, 29 Jul 2020 00:00:31 +0000 (UTC)
Date:   Wed, 29 Jul 2020 00:00:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
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
Subject: Re: Add and use a generic version of devmem_is_allowed()
Message-ID: <20200729000030.GI4332@42.do-not-panic.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 02:19:20PM -0700, Palmer Dabbelt wrote:
> As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
> implementation of devmem_is_allowed() that's exactly the same as the version in
> a handful of other ports.  Rather than duplicate code, I've put a generic
> version of this in lib/ and used it for the RISC-V port.
> 
> I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
> (though this is the first version, so they're unreviewed).  The other three
> obviously depend on the first one going on, but I'm not putting them in the
> RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
> yours along with the others then please say something, as otherwise I'll
> probably forget.
> 
> I've put the whole thing at
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
> generic-devmem .

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
