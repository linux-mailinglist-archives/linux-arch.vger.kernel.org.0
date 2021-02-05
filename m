Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46174311004
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhBEQyI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhBEQto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 11:49:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA64C061A2D
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 10:29:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so5148099pgj.4
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gKrMLsfGobXkiI6sjUHxc4o3Yi1e64+iFtcBHCUDvY=;
        b=AiVGW8ZfV6b/ee/LcCv+Op+DKesFAlTEGF/07NV2m2QST+5RqOHjwLrN8SOTlsHXpp
         GbTzYG/+F9OEtL49Tmfgwy9qbiHLoh6BzlrxNqzQJg8e0KXxzOS/DRVO7uq4SegSZl/A
         bNR0Obo6GjVDXaQLKqtbvrdxhjKO3vjvpLXwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gKrMLsfGobXkiI6sjUHxc4o3Yi1e64+iFtcBHCUDvY=;
        b=oEv1uYQn45UKfMbWidHKdsQVLqiNfV83OHqSMrZgjRXoD4D1KDO03EmBEbS9fT9Quf
         Jd9E20c9dZfXJfoH614TbS5Gy6oxNyq/XrZKXzfDPJ6Q4MvTQX51pZOy8kfqTLK0MCd5
         nanxCl/YRtNK7zSNrM+eqdCRbO3+le1F9dIFQakU+nFKBrAu2SXfXXDqXQmNGldeNNhC
         rHl5Jp72hEfV2VrMEt+Z+TzZv4b1quO1qKA4k7ZOgW0p2774G4KVq1vRSwx6gYhd9EvW
         3LUo+6MvhaW0bgxfAZV8yj00PMkMy4FnLNf5ABOLMfNbhr3G2UT/cx9QiRfsAsc848UH
         02Tw==
X-Gm-Message-State: AOAM530tuXv04W9JtQpg6LAUKZDQ3mrbAPrjciteTzYtcjyDv3LGu84Y
        n9qLoSPWauaeFBm9NLyTJ+HZUA==
X-Google-Smtp-Source: ABdhPJzgdXL2yWJ9K+9ihBWlUxHBRPB2BDMQz9MrbEyfZkzXsv0feLphNyFqyBnHRUIq1f0V1bWsMQ==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr2771317pfd.43.1612549752486;
        Fri, 05 Feb 2021 10:29:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3sm9644169pff.217.2021.02.05.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:29:11 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:29:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
Message-ID: <202102051028.A10679FF@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
 <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 05, 2021 at 10:00:21AM -0800, Yu, Yu-cheng wrote:
> On 2/5/2021 5:59 AM, Borislav Petkov wrote:
> > On Wed, Feb 03, 2021 at 02:55:28PM -0800, Yu-cheng Yu wrote:
> > > +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> > > +{
> > > +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > > +				      DEFAULT_RATELIMIT_BURST);
> > > +	struct task_struct *tsk;
> > > +
> > > +	if (!user_mode(regs)) {
> > > +		pr_emerg("PANIC: unexpected kernel control protection fault\n");
> > > +		die("kernel control protection fault", regs, error_code);
> > > +		panic("Machine halted.");
> > > +	}
> > > +
> > > +	cond_local_irq_enable(regs);
> > > +
> > > +	if (!boot_cpu_has(X86_FEATURE_CET))
> > > +		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
> > > +
> > > +	tsk = current;
> > > +	tsk->thread.error_code = error_code;
> > > +	tsk->thread.trap_nr = X86_TRAP_CP;
> > > +
> > > +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> > > +	    __ratelimit(&rs)) {
> > 
> > I can't find it written down anywhere why the ratelimiting is needed at
> > all?
> > 
> 
> The ratelimit here is only for #CP, and its rate is not counted together
> with other types of faults.  If a task gets here, it will exit.  The only
> condition the ratelimit will trigger is when multiple tasks hit #CP at once,
> which is unlikely.  Are you suggesting that we do not need the ratelimit
> here?

Since this is a potentially unprivileged-userspace-triggerable
condition, I tend to prefer having a ratelimit. I don't feel _strongly_
about it, but I find it better to be defensive against log spamming
(whether malicious or accidental).

-- 
Kees Cook
