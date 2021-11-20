Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD2457DCA
	for <lists+linux-arch@lfdr.de>; Sat, 20 Nov 2021 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhKTMUW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Nov 2021 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhKTMUV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Nov 2021 07:20:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76BC061748
        for <linux-arch@vger.kernel.org>; Sat, 20 Nov 2021 04:17:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 137so7345214wma.1
        for <linux-arch@vger.kernel.org>; Sat, 20 Nov 2021 04:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YaZx2Y1Vt1Ut2aTw36wNCypRpJkUbfgmQVTDZ0VmVgg=;
        b=G0DspSlupKx4AUg5ZT7ltXNlBHPMlfmebwsWLEI0fjNTzN8FF+OAjnHjjkowTA3YTz
         Y5DGUFU1RqZBdH04tC0xC/avnxq/1+skZ0VCOq1mgUIzCnpJtEHJO9HK7/LIwnRXoRp+
         rQz4achBubaElapoI9/Vm6An/nbj7zuytcNNa5DhyFwX7BkkRnuS8Iy3LlaG3ID6GztZ
         YpZ8RDsV1eLdYDx5VL7v/6AvQ5yHQGI/Q2ZK570uO4q6u0byapqvyd9zlkeZnOLpkU1l
         Bk8c8Y3m+sCLMdxBlSNTFQ2wLo1WPxZZmXJqgWQbyyzXvjmZnY54fmRSKov6jhnyPm7k
         mNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YaZx2Y1Vt1Ut2aTw36wNCypRpJkUbfgmQVTDZ0VmVgg=;
        b=PecNLUefm1IxbQnWhaBGJKqxzWvEB1peS+Z2+45mnrsU3VRyHU2gWvZNj0pjkJ9DZo
         4zcde1/zifuSX4kaLw63mz95LwQgtLGDm6fDCeBzPtstetu0s6T4MASuancdBoj0qojn
         /p5rPKFeylo1I6S3QDbYFfsFGP7FOoaaJBLh3uF8AHBHfeiPAVW/tzFZYuj2MWYtpmxD
         jTSeN/VBTuPsmj1kGBIDJW7iWcku8Me8MQB2tMnTiyaBe3PbbLFSg62Q/CErIWLQCXlf
         /WtCPUUxlP0AIjHadUwPc4F/VRhO2u+6OP2EuOMm+QeYlDFqutHKzBqBkUxeTe5UQWGb
         mtNA==
X-Gm-Message-State: AOAM531lGRiox/pInFe/OgmbT7vM5OT2rZmUJn7PkBLwI5Nc14tiWX/+
        05yWE9fmjijWsSFPC9C2VddK1A==
X-Google-Smtp-Source: ABdhPJwhl1qUNp/ARRgHBsOEZYB2zBIGB9ymLIhCgmSIMnKiuQtGzmOMF1KU2l9Kmdis+/qTqfvOjQ==
X-Received: by 2002:a05:600c:3486:: with SMTP id a6mr9590995wmq.32.1637410635476;
        Sat, 20 Nov 2021 04:17:15 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:847c:11cc:32b2:b152])
        by smtp.gmail.com with ESMTPSA id az15sm2620938wmb.0.2021.11.20.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:17:14 -0800 (PST)
Date:   Sat, 20 Nov 2021 13:17:08 +0100
From:   Marco Elver <elver@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Message-ID: <YZjnREFGhEO9pX6O@elver.google.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
 <202111151116.933184F716@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111151116.933184F716@keescook>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 15, 2021 at 02:06PM -0800, Kees Cook wrote:
[...]
> However, that's a lot to implement when Marco's tracing suggestion might
> be sufficient and policy could be entirely implemented in userspace. It
> could be as simple as this (totally untested):
[...]
> 
> Marco, is this the full version of monitoring this from the userspace
> side?

Sorry I completely missed this email (I somehow wasn't Cc'd... I just
saw it by chance re-reading this thread).

I've sent a patch to add WARN:

	https://lkml.kernel.org/r/20211115085630.1756817-1-elver@google.com

Not sure how useful BUG is, but I have no objection to it also being
traced if you think it's useful.

(I added it to kernel/panic.c, because lib/bug.c requires
CONFIG_GENERIC_BUG.)

> 	perf record -e error_report:error_report_end

I think userspace would want something other than perf tool to handle it
of course.  There are several options:

	1. Open trace pipe to be notified (/sys/kernel/tracing/trace_pipe).
	   This already includes the pid.

	2. As you suggest, use perf events globally (but the handling
	   would be done by some system process).

	3. As of 5.13 there's actually a new perf feature to
	   synchronously SIGTRAP the exact task where an event occurred
	   (see perf_event_attr::sigtrap). This would very closely mimic
	   pkill_on_warn (because the SIGTRAP is synchronous), but lets the
	   process being SIGTRAP'd decide what to do. Not sure how to
	   deploy this though, because a) only root user can create this
	   perf event (because exclude_kernel=0), and b) sigtrap perf
	   events deliberately won't propagate beyond an exec
	   (must remove_on_exec=1 if sigtrap=1) because who knows if
	   the exec'd process has the right SIGTRAP handler.

I think #3 is hard to deploy right, but below is an example program I
played with.

Thanks,
-- Marco

------ >8 ------

#define _GNU_SOURCE
#include <assert.h>
#include <stdio.h>
#include <linux/perf_event.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <unistd.h>

static void sigtrap_handler(int signum, siginfo_t *info, void *ucontext)
{
	// FIXME: check event is error_report_end
	printf("Kernel error in this task!\n");
}
static void generate_warning(void)
{
	... do something to generate a warning ...
}
int main()
{
	struct perf_event_attr attr = {
		.type		= PERF_TYPE_TRACEPOINT,
		.size		= sizeof(attr),
		.config		= 189, // FIXME: error_report_end
		.sample_period	= 1,
		.inherit	= 1, /* Children inherit events ... */
		.remove_on_exec = 1, /* Required by sigtrap. */
		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
		.sig_data	= 189, /* FIXME: use to identify error_report_end */
	};
	struct sigaction action = {};
	struct sigaction oldact;
	int fd;
	action.sa_flags = SA_SIGINFO | SA_NODEFER;
	action.sa_sigaction = sigtrap_handler;
	sigemptyset(&action.sa_mask);
	assert(sigaction(SIGTRAP, &action, &oldact) == 0);
	fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
	assert(fd != -1);
	sleep(5); /* Try to generate a warning from elsewhere, nothing will be printed. */
	generate_warning(); /* Warning from this process. */
	sigaction(SIGTRAP, &oldact, NULL);
	close(fd);
	return 0;
}
