Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF222C7EF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXO2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXO2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 10:28:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68850C0619D3;
        Fri, 24 Jul 2020 07:28:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so1329947edx.8;
        Fri, 24 Jul 2020 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=il2LsBLjvHfYQTVklZtI9AB69ScRx+ohJeS6BAWuA8M=;
        b=fUMcN0BLJY85ccxvXHeSf3v1EULmYklWVNL6IZJ13AWfEmWJP39qtWX57MfIBybP2d
         XukeiRGeddXVnlyg4DRE5EJN602jTfwRu1wZTWPFFNLWnyzFphvGH16fXMAJYLKfYCKb
         xBcG6/8BQF/1wvEdEaogLsFdaFvKcUan4UYFtD410a4VqSeE4T15HhNzeKC6L3SYyZsY
         7zAwUt2xFpGn0xa7K5n4J9U4Kfnzc6rl4W+FYfH0+AOo0nrWy1ajlBUaQpoMe9BF6RUh
         YVe9MFPOytAtWjRZO8eP+5kK/qgTPa7+yUm8ezKDzNKn+qxXogdu0nJzGjLzLpzlQ44A
         TcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=il2LsBLjvHfYQTVklZtI9AB69ScRx+ohJeS6BAWuA8M=;
        b=mZsMpTuaYchjtS77WxdQh5bAcXKnwi8xQZo4GYUQWkVtXaVB5yAJQqbJU6N4b6uWIz
         oKnd3oX4dd4xxJwi/Im6FcVyHtBOSDv5WfwS2gelI3BPHS2dSJFBhyIfK6wlL6ITsqkj
         CNBiaCqfTvFzzhR737eqviknfypIsuxm/Gf6eehdiXTL5n4BN6Y3Gb+TwjCDbd097YQz
         NS+W9x3s8G5AUdCs06ADeJIM4CXTCtDosI4ZFuDFAXPOu/VBMlRXT9hhEl9DdwYC6WiD
         3JQJsNBNfmXHnjquYxegYUifzyGi+0M0Wbzulm6CilaqdlESPFwDNG1gr7HybnW4QCVZ
         bSLw==
X-Gm-Message-State: AOAM533pcp4mGFPNeJFB6Vhaj4G2bza9k8i3OJ3u4THl/R0eUa6Ep8BS
        IrRypD5tBvNQW88X6wU9D4k=
X-Google-Smtp-Source: ABdhPJzoy04mJnRre4BxmTzP0caW8fkKkmOWG/75icNsVKX2o1P5utTx+A6LNb/R7T2rXtHHc/5Plg==
X-Received: by 2002:a50:e60b:: with SMTP id y11mr6947200edm.74.1595600931170;
        Fri, 24 Jul 2020 07:28:51 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f16sm791487ejr.0.2020.07.24.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:28:50 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:28:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 13/15] x86/entry: Use generic interrupt entry/exit code
Message-ID: <20200724142848.GB651711@gmail.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.711492752@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722220520.711492752@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the x86 code with the generic variant. Use temporary defines for
> idtentry_* which will be cleaned up in the next step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

There was a comment that still referenced the old x86-specific API 
names - the patch below updates them.

Thanks,

	Ingo

====
 arch/x86/include/asm/idtentry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 73eb277e63ab..a9fb57f06d39 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -128,7 +128,7 @@ static __always_inline void __##func(struct pt_regs *regs,		\
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */

