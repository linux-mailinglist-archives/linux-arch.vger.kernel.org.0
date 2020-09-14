Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2432695FD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgINUEK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINUEJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 16:04:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397DC06178A
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 13:04:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so451281pjr.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ajhHJz1gbeguv7fK0Au1e3qVDEqjerkQfY+fM8vzCCM=;
        b=CdEu6eSd17f/rk+wfAgK/BrqcVAQIAIBjP+4xk9dVA6ehCXoX8DmYKL0CAhajwAIMG
         my1lgEZzRYjb0bDJCpWwQtRx85YChWHge3kcwzvvRT3QOFQ0mP60F+tJVzsyeRM0SNiT
         /zvcEr86RGaB+T9OplOmrOoW5XSMoRS2MYKc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajhHJz1gbeguv7fK0Au1e3qVDEqjerkQfY+fM8vzCCM=;
        b=ByQ8xQo0GPMsb1bSXJcq9ZwqiMKQFAAz61ou5WSn+VvAaiIC3btz4yUkuwVjDcltK5
         k4rtorcnjaG8IA2X1VLf54BilVPVhaEqXueQA9z3dqEJzaqrwJHWuzLMNz0wHnq78KVS
         604BK57kfnDLko+kVXkLXPcvNGBXd0+YUD63wxf01RCq7KntXa8I6RUbp0hqK8qBX4Ll
         TXWqN2Xk/juFrlgrIHZHklm2286sWZTVYCpJ53TuzUTOg89beXvsYRL8x7/b+E9saQAq
         fkfita1VYJjkj95n6CwW+gP+qMAnZlZOGopfKUYfFMU31Uz8WCPC06zwjUr76EOSfzt9
         32Dg==
X-Gm-Message-State: AOAM531zQVnkBqdQFlKRm33jV+Fb6ZgH3eNKN790eF0nejTdsYMUTHf8
        XUbwyBPbRItqpOXi79GYi1JvqA==
X-Google-Smtp-Source: ABdhPJw3YjGHWrvjXN7tCQLQdNHZkCPff5W+k6kJgt9qjZ+YtqW3xrMBKUir8djUXs8pTT88pQs2fA==
X-Received: by 2002:a17:90a:df0b:: with SMTP id gp11mr925413pjb.64.1600113848920;
        Mon, 14 Sep 2020 13:04:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm11461663pfq.53.2020.09.14.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:04:08 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:04:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to
 change the syscall number at entry via orig_ax
Message-ID: <202009141303.08B39E5783@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
 <87a6xzrr89.fsf@mpe.ellerman.id.au>
 <202009111609.61E7875B3@keescook>
 <87d02qqfxy.fsf@mpe.ellerman.id.au>
 <87o8m98rck.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8m98rck.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 13, 2020 at 08:27:23PM +0200, Thomas Gleixner wrote:
> On Sun, Sep 13 2020 at 17:44, Michael Ellerman wrote:
> > Kees Cook <keescook@chromium.org> writes:
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 18683598edbc..901361e2f8ea 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> >                         return ret;
> >         }
> >  
> > +       syscall = syscall_get_nr(current, regs);
> > +
> >         if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
> >                 trace_sys_enter(regs, syscall);
> >  
> >         syscall_enter_audit(regs, syscall);
> >  
> >         /* The above might have changed the syscall number */
> > -       return ret ? : syscall_get_nr(current, regs);
> > +       return ret ? : syscall;
> >  }
> 
> Yup, this looks right. Can you please send a proper patch?

I already did on Friday:
https://lore.kernel.org/lkml/20200912005826.586171-1-keescook@chromium.org/

-- 
Kees Cook
