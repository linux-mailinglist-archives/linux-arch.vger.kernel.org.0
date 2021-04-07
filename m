Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433D335759C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349258AbhDGUNM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349257AbhDGUNM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 16:13:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FDAC06175F;
        Wed,  7 Apr 2021 13:13:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y16so135811pfc.5;
        Wed, 07 Apr 2021 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwldfrHGB7cvjNDHe6gxp+OQ0DSzEe0anuIQnT5lIYc=;
        b=dKW4tyxbGX73iHxH5Iha60EvcjCvKI+5hrpqwPPcbjELczGr/kzgfdsnLJJsWtOJbP
         ubOwwaB3iZb/RBJ+1QPkWGQAjFPjPBqh2IboNE1nH7H1pZZqyeSqspXh1PeeRkVlyVq3
         D+oq7t34NOHRn9OQqu4dUPDeY2QjjFesL1gh9WM+knJrz1i5ZQMIlvyZpNZOQKqZbOKS
         4CB8O8zOE9mVX0eyokxf96eDPzy8oTdAAN584lU799CDSvkBRtjLRtC/rvSTel9pIKWP
         gshTMF9nTcU8N6w8UNgn+aG83qEZcXRIQj51bqqxl3MvzOMunlFLxakjAhVMSVBe674a
         jRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwldfrHGB7cvjNDHe6gxp+OQ0DSzEe0anuIQnT5lIYc=;
        b=rXerty21UGmpdCTPjnHq5rg76oOHvDDEyFJL1khsUyGRbvZeSDVdY5dzOhNdrM2Om8
         VkyHV2tS+1jS7mRmPcVAzULtI+vfypUy7acOl1qwHvOzSjUuPK4Xv/l8nmLjfbfvblmR
         W6YA2LUNl6vyqVLJYPO4ntfczXIfVgKSKYiQ0OSSo23zZO+QaCtW1ZlHzsdxApDcGfzJ
         xK1lW/QR5Jt4wE3ARF4KlVqqxqfKPXLcvpJMbiJ7u4VwVJa6CCojDtj3CViPO6+g3DEG
         yO9QcoVJg/w2I9dU+IiXi4RSDxPBHeTqDuh9n6laLY/UCbcm1TSUGMUiqUpGFQ+YuY4D
         rWDg==
X-Gm-Message-State: AOAM533JmvcVa4xtOni6+me2ZLjO1ov8C3oFKJPiMJwoU/M9fBfIF9/t
        ZVW/sIPL5PS1j98PdUKq5V8=
X-Google-Smtp-Source: ABdhPJx1TzjDHM8SCpdazwwikZp8MB63xmALxAEXVlHdCjBoBVsMzPPllM88y4Piph/rcIdj06SGPw==
X-Received: by 2002:a65:610f:: with SMTP id z15mr4931593pgu.360.1617826380553;
        Wed, 07 Apr 2021 13:13:00 -0700 (PDT)
Received: from localhost (g191.124-44-145.ppp.wakwak.ne.jp. [124.44.145.191])
        by smtp.gmail.com with ESMTPSA id m1sm5878421pjk.24.2021.04.07.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 13:12:59 -0700 (PDT)
Date:   Thu, 8 Apr 2021 05:12:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, guoren@kernel.org,
        linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>,
        sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210407201258.GH3288043@lianli.shorne-pla.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
 <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 11:47:49AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 08:52:08AM +0900, Stafford Horne wrote:
> > Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> > OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> > one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> > xchg16/xchg8 emulation code?
> 
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 is guaranteed crap.
>
> All the architectures that have wanted it are RISC style LL/SC archs,
> and for them a cmpxchg loop is a daft thing to do, since it reduces the
> chance of it behaving sanely.
> 
> Why would we provide something that's known to be suboptimal? If an
> architecture chooses to not care about determinism and or fwd progress,
> then that's their choice. But not one, I feel, we should encourage.

Thanks, this is the response I was hoping my comment would provoke.

So not enabling CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 for architectures
unless they really want it should be the way.

-Stafford
