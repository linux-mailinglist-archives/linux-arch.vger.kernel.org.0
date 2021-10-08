Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE426E82
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJHQTV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 12:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhJHQTV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 12:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=MPJCIuBfRJFxdEeSKix14lm8blSJ1fkUKXjPbImU3zJQ/LOSzh4PkcXMmTrbEfLdvKMPm5
        ZeCZQV4k76CBZG6vXAZmw+JrDj039m9TDvAlKJ9rau0rqWSeUxTlgfX933R+Qyn4wi2bsg
        c1dTUUX789bt86HuspIGIpYD5a3Ln3c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-3KG9-ht8ODSQK6Yz4In8Cw-1; Fri, 08 Oct 2021 12:17:14 -0400
X-MC-Unique: 3KG9-ht8ODSQK6Yz4In8Cw-1
Received: by mail-qk1-f198.google.com with SMTP id l3-20020a05620a28c300b0045db8137fa9so8685037qkp.5
        for <linux-arch@vger.kernel.org>; Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=LvZYU0jXuayqzqBk9LedhICAs21ZODFDRabf76UBf+ka4hOAp3Y2dzXMAp7QaB1RFi
         56NWkYScneDIbsf1OY5TopTcz4o04QFA6Y7a38ZrlYtZyOolISF3Cp/NPfgFSwHBAWnB
         33CMYkE6ySZ04i7Mj3ixK/EanPVuw5zNctLT7j6twUKBCXbT3HZOhQlThNUWX70PX6SQ
         zGAQhOEwY6tlUC1Ts0sEXy5uxj7y90JQ95M/pepUT3DsWcsdEOPm5akJlLX8ytq4fsy7
         M1X8jJGzIq0G7aFkTq4xeINWbIUcz1Zqu8sZRPLFZyLznjUHyCtToVvTaCv9M0FxbMqb
         V2ig==
X-Gm-Message-State: AOAM530Ci+Y6UbdoXtpnXX6BOIavXMervyp56dbLnsMfVdHvyvaZfYUt
        P0mOtFk/AmUq2PBpOQHf6VhQfO3dKI306xRfBcCE2a2mc/aN1SyBmqW5VbO7D+RpKWxnKIINjFg
        1icf/FAVlR532zjICV8SU/w==
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523268qvv.30.1633709834200;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6ExCuEMbasm/gLwW//wQY0/4UCLYUOl4ssvLqUvFOcMjFiAJy1vmJaiafPCJcjnPk3KtghQ==
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523255qvv.30.1633709834017;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id p19sm2730266qtk.20.2021.10.08.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:17:13 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:17:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, keescook@chromium.org,
        jannh@google.com, linux-kernel@vger.kernel.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, vgupta@kernel.org,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211008161707.i3cwz6qukgcf4frj@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> > told it to via skipnr, because I'd expect that
> 
> It's what most archs happen to do today and is what
> stack_trace_save_tsk() as implemented using arch_stack_walk() does.
> Which is I think the closest to canonical we have.

It *is* confusing though.  Even if 'nosched' may be the normally
desired behavior, stack_trace_save_tsk() should probably be named
stack_trace_save_tsk_nosched().

-- 
Josh

