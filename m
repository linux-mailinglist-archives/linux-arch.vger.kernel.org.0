Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEF4C1B8A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 20:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiBWTMz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBWTMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 14:12:54 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04A26114
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:12:25 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id w7so952520qvr.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nWjAURTXXFUt4V9KPu3K0BgdcVkHvnbRCLY8V8ZLyTQ=;
        b=gmhsmcTiDoYU7aSdGVFyN+rym7mHAfe/gELsswwblGvGEyBAIz3xKmzfy0IUiOaPvk
         gvexjsWRALM3JhcrEUssGZ/CYBEKRPcbCWMIwiXtpGu/XwNWzWjauS33ywJ8jTFM/FdH
         GTUbIauA+5k3WLUweM12er+GPgsxrcuHzYO+nMOYln6CPBbTc6LkjWMgzj0/fSQrVNgR
         zDOEiBGeAsgKh2FRY0rwYCBMEQyJegVvSG/URKwYo1dDBWjoDBCfpqIRF2ycshUmtDS8
         xxwQp9PJEJHGdFdYEZ9Q+3YIqo6vDmwJ2bfYkpba60bWkW4dYizaW6YHW8ZhdZ0JdXtx
         3hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWjAURTXXFUt4V9KPu3K0BgdcVkHvnbRCLY8V8ZLyTQ=;
        b=lrCPUNotht5pws1mMdAlBr+4h4LsTvCDhIFon1YbskOjkxyVOaHppgvZRH/hf/uCtc
         e6CpSWU7ZSCXq+JfS3+xFNh6lK5jiMJcHbLaC6WZcKvlh3c0G0zpNEd7Olfij/S8p0oC
         CyMZtqiUpv7MSjh6NplWxdt6EqC3YNHqXs5lZPYoRPOuusmbEv6dgluMoQ8Fx//vi5v6
         7DqnzBYDh7MK2zN09qnOn3LsgkDy3mE9CjYMkmNYkAa8CaYhaNYyNs4ptpQbrB29zCCw
         6jSsQ9BfyHDxcAeHPMpZqJTyz5YmTTbHk1vtz3EPLa6qAlcQlLDpW5VtJVfJFKUOqMiB
         w7+w==
X-Gm-Message-State: AOAM532tsheRfp7BOTcZ4VbKEQ1Y/o6Kc6F/zOdky/NLY975dffe8OOU
        zPAgaGBdfXuaX8Js65X2fsApvnSr46WZYg==
X-Google-Smtp-Source: ABdhPJxzoEo9EUkOhZuahOgNwguvUhyWayCfkdT5Cqa71z8iHTlwb9JaXlbVKc1MXzozbYCnwZBuRg==
X-Received: by 2002:a0c:a9d7:0:b0:432:662d:e1b6 with SMTP id c23-20020a0ca9d7000000b00432662de1b6mr989319qvb.73.1645643544832;
        Wed, 23 Feb 2022 11:12:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h18sm205742qke.61.2022.02.23.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:12:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nMx3m-001hEw-Qg; Wed, 23 Feb 2022 15:12:22 -0400
Date:   Wed, 23 Feb 2022 15:12:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
Message-ID: <20220223191222.GC10361@ziepe.ca>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
 <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
 <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 11:06:03AM -0800, Linus Torvalds wrote:

> And as such, you not only can't dereference it, but you also shouldn't
> even compare pointer values - because the pointer arithmetic that was
> valid for loop entries is not valid for the HEAD entry that is
> embedded in another type. So the pointer arithmetic might have turned
> it into a pointer outside the real container of the HEAD, and might
> actually match something else.

Yes, this is what I had put together as well about this patch, and I
think it is OK as-is. In this case the list head is in the .bss of a
module so I don't think it is very likely that the type confused
container_of() will alias a kalloc result, but it is certainly
technically wrong as-is.

> So elsewhere I suggested that the fix to "you can't use the pointer
> outside the loop" be made to literally disallow it (using C99 for-loop
> variables seems the cleanest model), and have the compiler refuse to
> touch code that tries to use the loop iterator outside.

Oh yes, that would be really nice solution.

Jason 
