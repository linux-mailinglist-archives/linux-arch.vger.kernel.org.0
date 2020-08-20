Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F824C704
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgHTVJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHTVJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Aug 2020 17:09:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED6C061387
        for <linux-arch@vger.kernel.org>; Thu, 20 Aug 2020 14:09:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 189so1714476pgg.13
        for <linux-arch@vger.kernel.org>; Thu, 20 Aug 2020 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjiSaglQ75jI6j88glVf44Uda/sc/Nr405Wx3MU9i90=;
        b=KFYniuhUyJt0GJ/A5NuqlGTAZAU0+V6ncRNsqE69SnlvmWq3pPM1dcbNXIRc0yOFfS
         ntNdLnM8VpRXyXQP28VGNro2B+sblcS3igMaecVpFUisMoLpkoaihi/0QtfLnd9fSxle
         qS3nnwfCInkPpXuf33rVOZB3rs20oebdgTRl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjiSaglQ75jI6j88glVf44Uda/sc/Nr405Wx3MU9i90=;
        b=jm1i1CjUN1AMDGnriG/LohPGtZjtXTOuwUMvtmgUOPmvWGusuC641yuDQfeTGQrVQE
         iYEZmqieZPOw7nUgQufanHoWboWOfPKww/ZkdPztHzoGRe37FOPmFwGtHyT930d6EK8c
         V9WO0GQ2YmpyM9AOx7WcMtqa6Rd2dHUGcxCNeGBMRLWYjaTDAOXInpQZtFBzfaIGuhLD
         Er7OZnujXRa+m5k3QCYbSEOzIiVKbM95kdGLkPtXrjs5j5FCuWG0GlJBtrY7Bi0xuGty
         BD/SIDdg9o2dq/gM3zL8oT0Z7LvPLzWJXEBu7egoeK0trt7Aw+XZlkzdvK9hlBkg2JBL
         nI3Q==
X-Gm-Message-State: AOAM533Ehld3twk+3QdaGwm7IJrsMm3vl1xIzJ2f7LiERcaNvVU5v8kP
        a8rwgHJ/2ZHwEK109WxEbcnA7A==
X-Google-Smtp-Source: ABdhPJzOdlZPLpvYzaIPGI9VzyzZNO0QSe5HCusBzEZ5k6gseQIYvoR42UFn1kWQeXXeIPfqkQAIZw==
X-Received: by 2002:a63:b51a:: with SMTP id y26mr456024pge.376.1597957769546;
        Thu, 20 Aug 2020 14:09:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm3824348pfh.168.2020.08.20.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:09:16 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:09:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to
 change the syscall number at entry via orig_ax
Message-ID: <202008201404.6A0D5736@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 09:44:39PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 19 2020 at 10:14, Kyle Huey wrote:
> > tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
> > modifications to orig_ax in a syscall entry trace stop are not honored
> > and this breaks our code.
> 
> My fault and I have no idead why none of the silly test cases
> noticed. Fix below.

Hmm, which were you trying? Looking just now, I see that the seccomp
selftests were failing for all their syscall-changing tests.

Regardless, I can confirm both the failure and the fix.

Reported-by: Kyle Huey <me@kylehuey.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>


kernelci.org is *so* close to having the kernel selftests actually
running with their builds. :)

https://github.com/kernelci/kernelci-core/issues/331

-Kees

> 
> Thanks,
> 
>         tglx
> ---
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 9852e0d62d95..fcae019158ca 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  
>  	syscall_enter_audit(regs, syscall);
>  
> -	return ret ? : syscall;
> +	/* The above might have changed the syscall number */
> +	return ret ? : syscall_get_nr(current, regs);
>  }
>  
>  noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)

-- 
Kees Cook
