Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02D723B135
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 01:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHCXrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHCXrR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 19:47:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A5C06174A;
        Mon,  3 Aug 2020 16:47:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so1001227pje.1;
        Mon, 03 Aug 2020 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZyIOGyXvGoWyVgpe6lMSEU3Lh4L4f7rUlyfG7uAF2bs=;
        b=tCVXV5dDP0sDqcuGj8j01E2XwxH+3jXttYLUYybxXmz/9/ncIQTDG2VF2Lrkm0Ul23
         VEalCLWgIVUjsbD52jx5UjTDoTFfuRXWnS6xTprlUKYAza/D68A39ouPFnV7lwCCv+Ph
         eQ1MMg1rIiJCacr4SXEi+FRdqsbAADoyM7L0WnRFByF2YQ3VKhJ5/1IVLCSQD4evkJJE
         ae6Py5Dgjo4WgIrix1tbGPkijWrS4Ku9gaX5OZm9uyZz9Aq7trjEOJr4rZNxOxPxVWy5
         B4fpnOHv8LXKXwvh6M9Z3Bs1+YW3H72oo/d3y8+DwPwJHepmtUGpxG3XjMJQap0srI82
         DJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyIOGyXvGoWyVgpe6lMSEU3Lh4L4f7rUlyfG7uAF2bs=;
        b=NGhtpK+LtvGQm3xnM3D5k4Ut22cYxp5ufhy3ADv2tALLgGkXw9qitA0IT1BFK8upc9
         VwoqpO0H+O0GTqtdulOyYgNoBfn0NhZfziAG4va+Iu2WSsG4bs0A15RQ3y/B/NpkWqxV
         55chistKr9+M91J7AUyipPXtVc2uQIdoHFGwvMudEN11BZPW2HWSuFMBdF/pplNFR+1r
         vq+JCAZ+9qEgrfgKY57t5FskiT1dnbn5/g0zhhMTe8bqFaosqJk9k276aVPDQEy8jTBr
         oyl+P+nXwEb8HGd0C3Dde0VAcNwm49vZaCX02XLi+cmoZW6ePP+KU/NR/4xa9Z6v+rxo
         9LbA==
X-Gm-Message-State: AOAM530IWkCqk3qRzo2zga0ESVCbiCivnkMw5UE7+ZV/5t3bENxMAAFB
        RVvILOfpRBK5t00kaQJRq+mqelcH
X-Google-Smtp-Source: ABdhPJwpTYLSOc9+nMUubN13f9LJByOdVdA7OoYwfrtOWiOoLPj6IaVx8XPi1pPpjRVVbGt31wBRew==
X-Received: by 2002:a17:90a:d904:: with SMTP id c4mr1581963pjv.145.1596498437278;
        Mon, 03 Aug 2020 16:47:17 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id o16sm22034123pfu.188.2020.08.03.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:47:16 -0700 (PDT)
Date:   Tue, 4 Aug 2020 08:47:14 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] asm-generic/io.h: Fix sparse warnings on big-endian
 architectures
Message-ID: <20200803234714.GL80756@lianli.shorne-pla.net>
References: <20200803151134.3740544-1-shorne@gmail.com>
 <CAK8P3a1m=PPg1sDdRsCz7BOu44-zD87b80SvdZbMuvfLTWsc-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1m=PPg1sDdRsCz7BOu44-zD87b80SvdZbMuvfLTWsc-A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 03, 2020 at 09:50:59PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 3, 2020 at 5:11 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On big-endian architectures like OpenRISC, sparse outputs below warnings on
> > asm-generic/io.h.  This is due to io statements like:
> >
> >   __raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
> >
> > The __raw_writel() function expects native endianness, however
> > cpu_to_le32() returns __le32.  On little-endian machines these match up
> > and there is no issue.  However, on big-endian we get warnings, for IO
> > that is defined as little-endian the mismatch is expected.
> >
> > The fix I propose is to __force to native endian.
> >
> > Warnings:
> >
> > ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> > ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> > ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> > ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> > ./include/asm-generic/io.h:215:22: warning: incorrect type in argument 1 (different base types)
> > ./include/asm-generic/io.h:215:22:    expected unsigned short [usertype] value
> > ./include/asm-generic/io.h:215:22:    got restricted __le16 [usertype]
> > ./include/asm-generic/io.h:225:22: warning: incorrect type in argument 1 (different base types)
> > ./include/asm-generic/io.h:225:22:    expected unsigned int [usertype] value
> > ./include/asm-generic/io.h:225:22:    got restricted __le32 [usertype]
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you just merge that through your openrisc tree? I don't have
> any other asm-generic changes for this merge window.

That's fine with me.  Thank you.

-Stafford
