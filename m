Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC95BAFE7
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiIPPJX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIPPJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 11:09:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D002A98EC
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 08:09:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t65so20650809pgt.2
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4R00t3D0GnXDRz5F9l2Kk2rqoyZp2jq6sAMUbdTmoVQ=;
        b=Gq1QrMj4uW2owlgOsg2RS/vKPgdQquRZQhOsCEk8Oeu+QOA4LHi48cczbWLplZil/3
         F+5j48hd8IDyIHR/kMrltGLRa5rzU4FsDd4cHfB/5wtQuDKw2ydH/gCExHFM7rl+7Fq4
         xd/xx9vXTejXOSfnQe0Da6IrqJeCIuqd9l7KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4R00t3D0GnXDRz5F9l2Kk2rqoyZp2jq6sAMUbdTmoVQ=;
        b=i/BWee11l+GTROnPGEl2c5Xom42QIjKbPgFABUIjosFDg/Qou6vnEenn7576N7oq+X
         rO1Ey3u7amfpE2U0CY8TqoPNaGLe0C6uDVj8dNdINs3Vy0KTO00g/mDp+9+A+eaAZlLz
         4kHlUZ+Mx1cpM6QBYAcngmtwNZyAAZTC8hGwaIODmAsKY8PlNJPCkHurnShyC5XwoqeI
         jcGpFTvqtnQdmmAz7gNk7MXYmxgKTFGK9vEdIrQkeOvmB2dcTG7dhAy9++clzBvXImCC
         OkXzT7U/R4x9NCh6kkcYpfGyW+F7UvzVbbV6kN4FIz65Os20mFDYFy4P8f96dC8IDbW8
         imRA==
X-Gm-Message-State: ACrzQf1P9WOQKVCSjdtEhFX+MssI1Wf9pMjN96dF04NEvrPV6/Y8sgiy
        ZVt8PcjVZJ2V9bynaXsG2XV6YA==
X-Google-Smtp-Source: AMsMyM43t4mawdkrjwz+XsE+S9srFkgpjDkolkxGjJeOl5juIi7HKJJ2I/Oi3erFUtfSUa2N10eBIw==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr5265285pfu.28.1663340958813;
        Fri, 16 Sep 2022 08:09:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090aea0e00b00200558540a3sm1596538pjy.53.2022.09.16.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:09:17 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:09:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] usercopy: Add find_vmap_area_try() to avoid deadlocks
Message-ID: <202209160805.CA47B2D673@keescook>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916135953.1320601-4-keescook@chromium.org>
 <YySML2HfqaE/wXBU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YySML2HfqaE/wXBU@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 03:46:07PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 16, 2022 at 06:59:57AM -0700, Kees Cook wrote:
> > The check_object_size() checks under CONFIG_HARDENED_USERCOPY need to be
> > more defensive against running from interrupt context. Use a best-effort
> > check for VMAP areas when running in interrupt context
> 
> I had something more like this in mind:

Yeah, I like -EAGAIN. I'd like to keep the interrupt test to choose lock
vs trylock, otherwise it's trivial to bypass the hardening test by having
all the other CPUs beating on the spinlock.

Thanks!

-Kees

-- 
Kees Cook
