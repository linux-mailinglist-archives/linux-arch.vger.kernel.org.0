Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1B3CB5C1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhGPKNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbhGPKNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 06:13:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA8C06175F;
        Fri, 16 Jul 2021 03:10:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w14so12224428edc.8;
        Fri, 16 Jul 2021 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9ZH6xY225ft4o01XlrzMLmvWLH2occkG4KNrsfQi6M=;
        b=tC0JMTzTrulko5j72cWSlkfiJqM8a7ageHXvYhG3Uv6xUKwdlYvC0cJjzCdRwmT1Wz
         GVd1JYL2BhKXi1HEfgZ54jOmSMkgCdMhzX+ops3cnOoSyx8WIr/kJT9ztLWuki1ge/mK
         pRDQ4USJPnzULA2cCgk4K3Lz+1SfdmbydOR5ZNfER8hTkNwlKOS1ytGrEkNAWKnNUf5e
         fvd19moc8UFUM4Kv+XKDC2Gvc5LMRcC0UFj0IxNr6CEb4x6ZkOAukzfOi+vX2oJ2goHv
         Prg1mk8vBoHNtE+Db6VkOg6ddPiTKWbFS/RlWINgnq3wPptv6EKPyeHlGdm7U1NcoSZY
         RpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9ZH6xY225ft4o01XlrzMLmvWLH2occkG4KNrsfQi6M=;
        b=D4EDFO3jUN4TM+skBvZBMeCfE12MBcvz4m7TQrRADqAa+C5ubbvRezYmJVpHROAjse
         LU/2+L3H6sj3sS1qJ+fc6eWDXalrOFBvQnCpX8BmN/g+D3vgBmq8hgixY5fHwl5tVq0s
         duv9fgcB3KCHZFEb9/knDtfiRnf8x52SVIpvf2fOh4OnCiTOEPnJgGpN5XGjI49Gujbe
         8ocFQ87dipnwFiJtWSVcItqUZNV/HZvd7GydUK3LSV98gZGVG5+xPHL1+Ve/smppIYsq
         O3qx8NlZcGPyce/W6PK3HPEDT835jbOua3B2aebIYAFSPF1DPHD/zNjqPRICG3p4sU5z
         IxyA==
X-Gm-Message-State: AOAM532A6mGntew+oroISJDI37qif/PpsJ34I0nBH0cQ35DLlSjSIbuz
        UbTFocLSDKH5+DdtpYzDrOC9Cam0BA==
X-Google-Smtp-Source: ABdhPJyFgoeTwHNz7AcIUGS5494lDOaqMMKys9Mz1FQtTk4qbtMVe0JpTxrRTBYXtbfa+wzuIOJjxg==
X-Received: by 2002:a05:6402:1849:: with SMTP id v9mr13211273edy.108.1626430208459;
        Fri, 16 Jul 2021 03:10:08 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.48])
        by smtp.gmail.com with ESMTPSA id e22sm3561811edu.35.2021.07.16.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:10:08 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:10:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, hch@infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] Decouple build from userspace headers
Message-ID: <YPFa/tIF38eTJt1B@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <CADYN=9+ZO1XHu2YZYy7s+6_qAh1obi2wk+d4A3vKmxtkoNvQLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADYN=9+ZO1XHu2YZYy7s+6_qAh1obi2wk+d4A3vKmxtkoNvQLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 16, 2021 at 11:03:41AM +0200, Anders Roxell wrote:
> On Wed, 14 Jul 2021 at 19:45, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >

> In file included from
> /home/anders/src/kernel/testing/crypto/aegis128-neon-inner.c:7:
> /home/anders/src/kernel/testing/arch/arm64/include/asm/neon-intrinsics.h:33:10:
> fatal error: arm_neon.h: No such file or directory
>    33 | #include <arm_neon.h>
>       |          ^~~~~~~~~~~~

> If I revert this patch I can build it.

Please, see followup fixes or grab new -mm.
https://lore.kernel.org/lkml/YO8ioz4sHwcUAkdt@localhost.localdomain/
