Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140242E183
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhJNSnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 14:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231393AbhJNSnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 14:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AafzswapDPTkg7dAS5SeXPSsZy6CJIYT17ewfhavBbM=;
        b=dwHtVUzBvVGDJWoanRznwanFG+Oagmjx5Lugxt4huoPd4tbbcjuXEJiTEx31nW/ulxzILm
        T9LL7+LtVqq9ewVda+i3thZ1SKLCmMKaheDkdlfZQd8YfgHDHVckFaFf/DUI7Zz+mdmJHP
        nzJDDrsVLgkXLPVGaPm9bikOYJtj2GQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-JPC30igLOYyUBEkMsgfjgg-1; Thu, 14 Oct 2021 14:41:32 -0400
X-MC-Unique: JPC30igLOYyUBEkMsgfjgg-1
Received: by mail-qt1-f199.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso5138013qtj.7
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 11:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AafzswapDPTkg7dAS5SeXPSsZy6CJIYT17ewfhavBbM=;
        b=U4ThLgYikVKCoUorpQzRoSfKt1dEQ2zGEnXZJXQISsJQaB8wlw6Y3HlFPkKFlDiM+2
         FR9po6NuXJVvDwsvK40MKo+4vHN3508p1SPiacmmsXQRDgrdyvce0AieqVEQy0XyhXjC
         +C3B+0xyfftthE4k4pf9q8Lktpsid/K6nTM1hiABGqNZ5yZ3k8fve4bhbs8WHYnXl+Ud
         qLKc8W2qNdM7TgN762kl1C58nFj7gh8B0W9Uve6RJ7J7PqSGGvZ9l2VuMB9kDXqYOfr0
         vqdPfjDOkmFtTgGPOsPUZGhsXged1IkMPzUMEx8DMht5chQ0a0BTRyblLgKB94Jwne/m
         UhYw==
X-Gm-Message-State: AOAM5312MNCtfgpi7kBxEIUoGOsirbtphC6T0e+oDL3AAEZPwsPKPyL2
        79UNqqtw6RYOJktYKdmIHMTLsfyla9PV+R2Y/+lu1DiP9dGzB2/DP1aoKl/s1asPbz2DBy1mNaO
        jLogVdZ75KYx1MZVTDVJZbg==
X-Received: by 2002:a05:622a:148d:: with SMTP id t13mr1305794qtx.393.1634236891940;
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygjoXS46jv87A7o06lSdoC2FnrbnpPOHamvT2pDm+KpgKrYNPS45xs+2q6vSVC0kHBygMcKw==
X-Received: by 2002:a05:622a:148d:: with SMTP id t13mr1305732qtx.393.1634236891674;
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h14sm1823421qkn.4.2021.10.14.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:41:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
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
Message-ID: <20211014184125.4qu7lih6uwvx35qs@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
 <20211008161707.i3cwz6qukgcf4frj@treble>
 <20211014180738.GC39276@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014180738.GC39276@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 07:07:38PM +0100, Mark Rutland wrote:
> On Fri, Oct 08, 2021 at 09:17:07AM -0700, Josh Poimboeuf wrote:
> > On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > > > stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> > > > told it to via skipnr, because I'd expect that
> > > 
> > > It's what most archs happen to do today and is what
> > > stack_trace_save_tsk() as implemented using arch_stack_walk() does.
> > > Which is I think the closest to canonical we have.
> 
> Ah; and arch_stack_walk() itself shouldn't skip anything, which gives
> the consistent low-level semantic I wanted.
> 
> > It *is* confusing though.  Even if 'nosched' may be the normally
> > desired behavior, stack_trace_save_tsk() should probably be named
> > stack_trace_save_tsk_nosched().
> 
> I agree that'd be less confusing!
> 
> Josh, am I right in my understanding that the reliable stacktrace
> functions *shouldn't* skip sched functions, or should those similarly
> gain a _nosched suffix?

Correct, the reliable variants need to see the entire call stack and
therefore they shouldn't skip sched functions.

-- 
Josh

