Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447D228B06
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgGUVVM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgGUVVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:21:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59494C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so60226pfc.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wo2KSkt2uKsTjaxUKUx/AXgKzZQLVgE9fv7oC1pgM9U=;
        b=fxicQTWxrU2WqFRihd/VZT/MbC0QG/JVXizq/OhLoM/dTFzG3ztptOTItob3McBPXl
         s/8rfUZi4yvPRDPzB4x1DM25Qk+bOwKx9ZxSOBscZuk4ExZ2eBtnhHe9rpBAjbWdJNu3
         j1RWLpTE+MfqYyimAtHkTaWYpckroafRcSc40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo2KSkt2uKsTjaxUKUx/AXgKzZQLVgE9fv7oC1pgM9U=;
        b=LndOPUcJNs3o0bdOax5N8acDf5LENmesMugeKI36iCCp+CZ2ztInsTcLZQGESC/ByW
         k3Rgqaa162DudSqIMWHWhA4HsOi6lLBinEPoRXmtAwbEZUdcKgr5MZ7XmLibMf9X97z4
         Q956XgNrsfKlY8bW4PHV5pivnPZD/htKmnXPS8nh7XL2qFOjT4TFnH+/24G7sOn5NDJE
         8cD2PNHK4imnAMzdkDBa0uDNgQHoL43QcpKvsl/3+qsggWQ35x2znPaPk1UY1db6V389
         YwjjCWccHtfRYHoqwhzNOdL+nXEi20j68BX5ZgPjQu0seNl2bjjox+7LwaFP0z/Hc1Rc
         zruQ==
X-Gm-Message-State: AOAM532GE6XThxm48FAbjslkQpAVNnYLZ8/0/qHqvevlQd/yhY/+XyyT
        V3xDI+4ap0zX2rCqHHKbz0n44A==
X-Google-Smtp-Source: ABdhPJxDDnyEVXIY4rLb+RsPBAy4yKWxQVpSGTnpY8gFur3vVyP2p27baBMA8SghPFnQbtOFo9/T2w==
X-Received: by 2002:a62:6305:: with SMTP id x5mr26195638pfb.81.1595366470930;
        Tue, 21 Jul 2020 14:21:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm21380770pfg.63.2020.07.21.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:21:10 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:21:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 01/15] seccomp: Provide stub for __secure_computing()
Message-ID: <202007211421.FE862FEE@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.348199175@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110808.348199175@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:07PM +0200, Thomas Gleixner wrote:
> To avoid #ifdeffery in the upcoming generic syscall entry work code provide
> a stub for __secure_computing() as this is preferred over
> secure_computing() because the TIF flag is already evaluated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
