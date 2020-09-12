Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC32676B2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgILAK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 20:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgILAKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 20:10:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72880C061573
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 17:10:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id md22so3254173pjb.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ptEAU1Xnng1x4phMWyVZ560k80eHq758Hzhoynkaycc=;
        b=X9GwGioE/sKlB0N60NGjN7QVepFxUFBUgG8XStPDYy6zg1BVuEqovR/eJ6oHvaTG/6
         iaHvt0uhANQpifz3K87589CfbzpkWkab4jtrLcxwJ4YXZngIB4byQpCfgPUtJz6wcWio
         6cE79xeS3xd/Wr+C5QTZg6Oc33JTJ4EaRmDWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ptEAU1Xnng1x4phMWyVZ560k80eHq758Hzhoynkaycc=;
        b=G+YvB3GB+JtXojfd9Dpb0Jb1T7veX2DAh1ybVjEC+28C1VvH7f03CU5+jezQ9JibyV
         G5SuIxCh3k/VOn1pxS6oLOEQxyRDxRUAH68JgYnyM2lftBt5yxoGUqMf0pc/SvvtFUic
         kNVlSH+0F82NN8J81KHTlhpB7KjAv3Jj4VWxn7535mQ7o7ySALcvxsiYAsxepW7nqAkB
         rGryXGvFjVfFZ4doNv3JZDMTMomqiWjaAiYIxS/CeBDJq1ZpLGnuE7U01ZTuO0p3ULvH
         zllg1eftYZHiqbf84ylUbp70Aiinbggoqt8R0WeB0NOvwTH6zSC7yaRJtedMQOOQdYPU
         Bp5g==
X-Gm-Message-State: AOAM530fklpvRoAjuAKRxDiiH8JyDuD2tpSRxHB2duZ7oGZiCrgG45Vl
        /re+rjv0JHe56nUTtx34PMLX3Q==
X-Google-Smtp-Source: ABdhPJyh4lfB9JNG/vzpZH+PDZ3Lh1qXXu4Qj1pA+d2IYVrAkYtb65TxuiV74KkGkwUeM4NLNt1Kew==
X-Received: by 2002:a17:90a:46cd:: with SMTP id x13mr4417827pjg.101.1599869454586;
        Fri, 11 Sep 2020 17:10:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm3155923pft.84.2020.09.11.17.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:10:53 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:10:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <202009111609.61E7875B3@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
 <87a6xzrr89.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6xzrr89.fsf@mpe.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 09, 2020 at 11:53:42PM +1000, Michael Ellerman wrote:
> I can observe the difference between v5.8 and mainline, using the
> raw_syscall trace event and running the seccomp_bpf selftest which turns
> a getpid (39) into a getppid (110).
> 
> With v5.8 we see getppid on entry and exit:
> 
>      seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (7ffff22c46e0, 40a350, 4, fffffffffffff7ab, 7fa6ee0d4010, 0)
>      seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304
> 
> Whereas on mainline we see an enter for getpid and an exit for getppid:
> 
>      seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (7ffe2f6d1ad0, 40a350, 7ffe2f6d1ad0, 0, 0, 407299)
>      seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027

For my own notes, this is how I reproduced it:

# ./perf-$VER record -e raw_syscalls:sys_enter -e raw_syscalls:sys_exit &
# ./seccomp_bpf
# fg
ctrl-c
# ./perf-$VER script | grep seccomp_bpf | awk '{print $7}' | sort | uniq -c > $VER.log
*repeat*
# diff -u old.log new.log
...

(Is there an easier way to get those results?)

I will go see if I can figure out the best way to correct this.

-- 
Kees Cook
