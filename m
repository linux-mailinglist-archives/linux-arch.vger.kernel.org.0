Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ECA355FC1
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 01:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbhDFXwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 19:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhDFXwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 19:52:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEEC06174A;
        Tue,  6 Apr 2021 16:52:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so286002pji.5;
        Tue, 06 Apr 2021 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r0Ha/Gv3pAkjmgqqsKcPiH9tlZnqWzms79uqmOiSHMs=;
        b=DoH08R29BGwmuj6eSbyG3BUk0CMYUOgrE7l1ib0WohqefmBPVt3sY22jJOdDf2ba3M
         OraAYZNzGMrAjzLBt/oLKxSGP5xVkpQwVYlEyQ+FCAxk1AucZMSXaKaX4yes8IpuX9bx
         k/PK2mwZ7S6C7V1Otv/hHIYsXqEQzWVrSgtZ7Smoc3vdWQK5bfkyy5fWevoxUBoneWfM
         UlLNvmrFvT/LKV17m0n35Iq2WXwO1WQ94cKquKeKdq4Eo0jQbOkxVxjhAnmnUDMrZ/jw
         sjVzOf22KCT3mTqKrrakDQ7hCLtkS68PqKVrr3avChCGt1YUrsIst96sJ5oXc8I6D0zL
         +AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r0Ha/Gv3pAkjmgqqsKcPiH9tlZnqWzms79uqmOiSHMs=;
        b=aSfq4wLV33gZoxXuQxAynvZwOvSHfBBeqCtoVnLo8iFCLJGj+NsK/Rpc3EAgbou/0s
         X/0lvT5XDgYjvocVAxntjaMiBxsxokPy/MuHLBOvDKBpY8kmOQOuPwr7s6t/8iDPvGSe
         /VlkWvbiJXnL8tee6A/M4hWLcjiIDDVZXgcccO2UfFCxX4E7HuesGtqTSxnc2ENzv83d
         ynONeFI0S6Ih1TbyXY2svmCGT+VQS0H7+hT+/RO7Tgu4ZLlH9k0+gWJladRdDxgZBSSu
         GQZ+s7U194ACcRGOq8HEtSlkdT/CqDA5J2x2HixvC4u1daaGh7pxv9ogNy4AWbF9b+3k
         Guqg==
X-Gm-Message-State: AOAM533y51c6yROMdvXiUe/0YwWezevgdqIaUz3M1gHFSG2NFwTBPU9f
        iZsDQbYWmnIZc3PGUj0JcxI=
X-Google-Smtp-Source: ABdhPJxtumeckyy0f77HdPuOn8G6N6f+xOhLUrB9QPIL+nP1d3kOEbilw2AHpr0vnTb2lu4tnB14Mw==
X-Received: by 2002:a17:90a:6385:: with SMTP id f5mr590598pjj.212.1617753131320;
        Tue, 06 Apr 2021 16:52:11 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id k21sm19587938pfi.28.2021.04.06.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:52:10 -0700 (PDT)
Date:   Wed, 7 Apr 2021 08:52:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     guoren@kernel.org, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        Anup Patel <anup@brainfault.org>, sparclinux@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210406235208.GG3288043@lianli.shorne-pla.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyRrBjomDCPOBUd@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 12:51:56AM +0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Mar 31, 2021 at 02:30:32PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> > 
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >  *  0- 7: locked byte
> >  *     8: pending
> >  *  9-15: not used
> >  * 16-17: tail index
> >  * 18-31: tail cpu (+1)
> > 
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > 
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
> > 
> 
> If the architecture doesn't have sub-word swap atomic, won't it generate
> the same/similar code no matter which version xchg_tail() is used? That
> is even CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, xchg_tail() acts
> similar to an xchg16() implemented by cmpxchg(), which means we still
> don't have forward progress guarantee. So this configuration doesn't
> solve the problem.
> 
> I think it's OK to introduce this config and don't provide xchg16() for
> risc-v. But I don't see the point of converting other architectures to
> use it.

Hello,

For OpenRISC I did ack the patch to convert to
CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y.  But I think you are right, the
generic code in xchg_tail and the xchg16 emulation code in produced by OpenRISC
using xchg32 would produce very similar code.  I have not compared instructions,
but it does seem like duplicate functionality.

Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
xchg16/xchg8 emulation code?

-Stafford
