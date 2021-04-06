Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020DA355B9F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhDFSoN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbhDFSoL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 14:44:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EFC06174A
        for <linux-arch@vger.kernel.org>; Tue,  6 Apr 2021 11:44:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id g10so7992450plt.8
        for <linux-arch@vger.kernel.org>; Tue, 06 Apr 2021 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQnC4YbqcPkvvMzS/WXtytqd+L3POj6wkG54irRdxac=;
        b=YAhhm9BkpY5y7HrE34KfvVWOVgEO0sYzWSUTiqziDNEK4+3Lral7Ghh0posJjIrz61
         tfc63YozQ8TRMvb+TNGvA+LWvP4faXgXV6k8KT0Nv6y/u9B7f1LE4XzO3OjKob023F9j
         xZGLdr3UYpKw1f93SAnQ8fSdVZaYmuMHTRPdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQnC4YbqcPkvvMzS/WXtytqd+L3POj6wkG54irRdxac=;
        b=mG6oNllUpEET4yfgbKIYUZvk2LsYJbnr4cpeVdKagd+c9Z4gOxi71On9PqKOg2uNn/
         HsWKQ5GjbUO9LDP0v6cJ0O5uvlHXitX3rQ16anvobCYFPuQ/8CZg6kwDHUWxsvFfj9kY
         3wFAGiTDLOVeAOodQwJXs6OOC7krbtyZTygLf/7PhoVI+6Ptz+FO0LJaxPIY5Nm25+aX
         bkwseuvdX+ySFazJIATMEoQb3dh6vP06gOQXyz6x7b+p131cGGFaXfs6kbdq9ta5lxMp
         fXN7UI4v52+XW1SomkWGigEi62TSP2nQzKJrPJuYpGsgj/0gmiSu7KeKCWXaxeE+Uxzh
         OkJQ==
X-Gm-Message-State: AOAM533W3OMA1fNF6RHHocZsZImIoerS/Mymbyx7rJ+lWGozcrkvc+FU
        VS+MVMad/1jp+lJIF9CTQM2XeA==
X-Google-Smtp-Source: ABdhPJyp4uPolhdsa5/w7momD80MPZDhhBi9SUuWfIFW/E/FawC4pgs3YQmUW7xHztXcPiXJ8/E+QQ==
X-Received: by 2002:a17:902:e74e:b029:e5:bde4:2b80 with SMTP id p14-20020a170902e74eb02900e5bde42b80mr30088911plf.44.1617734642419;
        Tue, 06 Apr 2021 11:44:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm3610423pjh.9.2021.04.06.11.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:44:01 -0700 (PDT)
Date:   Tue, 6 Apr 2021 11:44:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <202104061143.E11D2D0@keescook>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I like it! Do you have a multi-arch CI to do allmodconfig builds to
double-check this?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
