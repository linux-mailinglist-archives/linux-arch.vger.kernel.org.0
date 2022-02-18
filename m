Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4434BBBF0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiBRPMh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 10:12:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiBRPMg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 10:12:36 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B2129B85
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 07:12:19 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t21so1848033qkg.6
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UFK1H0MLL3zfV8rrVT42KAQLrDb10EeLRg7qACWBZgo=;
        b=loqXxekcoX4BlDC6iJQG0PRWrLmv96YvYeNl8NRamBd2P2OGZnI0oi2OBzO5/s8rhl
         T+PXXlTJp48Z+7ULhVkAqr9KouVemM7c8uUYgfL8QJYTv12dM4D8HDCxA0SDDpUhGOvg
         rE5oFChEjkRNN04dRyvaVz5kbXhbhHWa1S8RXEqKgxqJ9VPxpBhGsDP3+sEp4wKCq39Q
         dG9tbJMPhNg+QCNvnwXuWzsvFTtj0VJCYY0sjVhMuNodOyeHr9bFiaeXdANNhcKhZxk2
         y1x49gtOrmgtEUcvR4vYY5ULHDEpPUdlFhiU0tJXMWUkdNB/+4dbfbamE96F8vrSX6yS
         OGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFK1H0MLL3zfV8rrVT42KAQLrDb10EeLRg7qACWBZgo=;
        b=uELZguVG9juVmk9qjCjsczOMcLrQ/aSfGIlWf1PeLJ5sKOHarvIXbjb4/jPGNhY/wN
         dhWmg9OnHZSyZQsrC2E3tQRR9sirLWejlG/dJnvnqlzw6Sz5/5iREjuhiXkSK50w6E/I
         vQkKhwG+A8nxIHbBjG4RQs6kW4yhmd845PPdi1oStRYs4wE/lPx+W3AFkRZGiXbZKQXB
         O3/AJmbN3hDBpxmQeB6+EhV6HAKcAHfWBPEGnLQNsR4P94TmDn6SLtB7RxsA8Ij0mZdS
         OuZQxuUrnsEqzRhitLzIvZrtNBZHdIygJYrVZbqObV8qql1G5M4g9atGudenqjJNRT+4
         bOEg==
X-Gm-Message-State: AOAM531RNNr21Xl1nnPKuHZFMGjiUccbvlwKksve8/gUGEzfonFAzxWm
        RrdVqchKlLoCEFlcDYXv4Pbzzg==
X-Google-Smtp-Source: ABdhPJyZJc9V59o/iPIJ6jZ7/kpiQxhh7Z5dMrM80fj+rWapsiOI8tOm/ORLO0hRQDXn6isRJ+AEkw==
X-Received: by 2002:a37:af81:0:b0:502:7ea:34e7 with SMTP id y123-20020a37af81000000b0050207ea34e7mr4972743qke.737.1645197137730;
        Fri, 18 Feb 2022 07:12:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i12sm23483248qkn.83.2022.02.18.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:12:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nL4vg-006d8h-D0; Fri, 18 Feb 2022 11:12:16 -0400
Date:   Fri, 18 Feb 2022 11:12:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Message-ID: <20220218151216.GE1037534@ziepe.ca>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217184829.1991035-5-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 07:48:20PM +0100, Jakob Koschel wrote:
> It is unsafe to assume that tmp != mdev can only evaluate to false
> if the break within the list iterator is hit.
> 
> When the break is not hit, tmp is set to an address derived from the
> head element. If mdev would match with that value of tmp it would allow
> continuing beyond the safety check even if mdev was never found within
> the list

I think due to other construction this is not actually possible, but I
guess it is technically correct

This seems like just a straight up style fix with nothing to do with
speculative execution though. Why not just send it as a proper patch?

Jason
