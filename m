Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5181ED714
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCTuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCTuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 15:50:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F145C08C5C0;
        Wed,  3 Jun 2020 12:50:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so55623pjb.5;
        Wed, 03 Jun 2020 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7XFgyV44I0lW+W/V50iJVD640G0FdtEv8nJXk2ZIvpk=;
        b=vAIl4e4ht+P8wL0EOggqGErvUs+YKpvv8ClDf8DV8ahjk/2LhFr51G7k2rcRUWCUJt
         oJgDjYzyUiX3uAd/J02JdMmmPmuatW0OwKbqSos5klLTfr2wC5Nh6b1xMhGIesZSkwbK
         CdlfndLz2thEnbEuCYPf8F9/FfW3c+3K28ZtxgNMwppJ7VxcybEn9n8S1p8oH34gCtyZ
         R7dakjRhtUHP8CEzEol4KOaGY50wPVK4TU6Ao6rKCgoJeGAgzr4yt4g1Qpr1q5iOt6rI
         nquCMBsQKIikiG+uNIwZpNI2ODSrZRR0lW3jGoqjEXLxSoFDM39Q3S5BH6EILbEl1aUa
         FrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7XFgyV44I0lW+W/V50iJVD640G0FdtEv8nJXk2ZIvpk=;
        b=M1iaPJGf06GHvpDVZw/aW7Qo6YASzEvc6nBEV5Tnt3jLK1VlyMvGMA0TQoMBxTAgPK
         +VViKHnkukyP4Axov6XUKGs4HSB+Fr0i4e0hVMzYBWb0SCK4M3i5QtViJFWyvHCNC3VS
         y15L6VkSITKmnclBacXeYNGOSNEvGUU2w7YGDe07wum1O4KrxHS0VYbOsucUHdru+KPv
         g5FujIcBlpdLQwtkGnfplzg93YfFnZQTqEvWeN60UgrgYx7GI4oWD79VjXBPWvqV8z1h
         447v3VVgL5WNglYW+MkKlnNCsptHygWp+X13Dv6Fg3s+ALQ0TDRzWr4V2dgUrEOaJO2p
         ul4Q==
X-Gm-Message-State: AOAM532wi/WD6Nh9J7qXOTnlQVCIRxPy/N4AVUlmEh4GCXXykXqTbMUc
        0DrLZl7ftpWm0QYoQ00rtdk0skFz
X-Google-Smtp-Source: ABdhPJwNib3BJ/jcBxpmHWSBmm6zNwTtSuR79lF/gRHnIWtGZZiLrgUgElCjPYpmutoIeLVwSfoJuA==
X-Received: by 2002:a17:90a:65c4:: with SMTP id i4mr1630234pjs.5.1591213816861;
        Wed, 03 Jun 2020 12:50:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l25sm2189310pgn.19.2020.06.03.12.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 12:50:16 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:50:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 05/14] ia64: csum_partial_copy_nocheck(): don't
 abuse csum_partial_copy_from_user()
Message-ID: <20200603195015.GA3364@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 03, 2020 at 08:10:38PM +0100, Al Viro wrote:
> On Wed, Jun 03, 2020 at 08:37:14AM -0700, Guenter Roeck wrote:
> > On Fri, Mar 27, 2020 at 11:31:08PM +0000, Al Viro wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > Just inline the call and use memcpy() instead of __copy_from_user() and
> > > note that the tail is precisely ia64 csum_partial().
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > This patch results in:
> > 
> > arch/ia64/lib/csum_partial_copy.c: In function 'csum_partial_copy_nocheck':
> > arch/ia64/lib/csum_partial_copy.c:110:9: error: implicit declaration of function 'csum_partial'
> > 
> > for ia64:{defconfig, allnoconfig, tinyconfig}.
> 
> Argh...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Yes, that does the trick.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
> index 5d147a33d648..6e82e0be8040 100644
> --- a/arch/ia64/lib/csum_partial_copy.c
> +++ b/arch/ia64/lib/csum_partial_copy.c
> @@ -12,7 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/string.h>
>  
> -#include <linux/uaccess.h>
> +#include <net/checksum.h>
>  
>  /*
>   * XXX Fixme: those 2 inlines are meant for debugging and will go away
