Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623AD30F804
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhBDQcr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:32:47 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44443 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbhBDQcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 11:32:16 -0500
Received: by mail-wr1-f50.google.com with SMTP id d16so4201547wro.11;
        Thu, 04 Feb 2021 08:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYU9bh4CkxipE81WEoDluz6pVp6f8gibc7rj0DSwtJU=;
        b=kCBFcWFsczeDEK/CqICnhJP0giiFGG3W6gwX60tzii9rK9ak04DLNtD08WTRvCu/Jy
         0tkECAJuR/nFpQCs6iT3SWct0wH9jeIm6NgkIrtPSAk/QdfbbGHKnV5sGI/kZ11Ma5gH
         1oazJT2nDeGVgLvmb5rYp2y3WVBFdpAAgIivVdnTsmOlVhUvc+NTCtUMJS+DV5QYPREs
         sMnO8HStkDF6ZaQ/qJMNhF8BK8IrICMxWl/loiR/s8aryDqIBBb2fLhO2be8UyS3J+JE
         g8fE0SuUXc82LE0D2pseUY+KQ0nDgKn7vt4BiMOAb/E5xl851MKLV+pG4hlXxW7NPW3J
         eW+w==
X-Gm-Message-State: AOAM532hfjbmU8/JOFZkyUEBq1KTHMXBYuHBwu+zPHZBEmqmdLxeCe8v
        9NlN5nShFQYl7RLAnWBA29I=
X-Google-Smtp-Source: ABdhPJzTbgWhdm9DCf+s2VSEHyWYnOJ0XIq4qUmMw/dSgwUJqX3hG9GJKdI3Tx/RMe50+5belhNhiQ==
X-Received: by 2002:adf:e381:: with SMTP id e1mr194880wrm.22.1612456293701;
        Thu, 04 Feb 2021 08:31:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i7sm8818889wru.49.2021.02.04.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:31:33 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:31:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
Message-ID: <20210204163131.4i63wpyyauvcsdpc@liuwe-devbox-debian-v2>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
 <20210201185513.or4eilecqhmxqjme@liuwe-devbox-debian-v2>
 <MWHPR21MB159351D13368615E9E3A8C46D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159351D13368615E9E3A8C46D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 04:28:38PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Monday, February 1, 2021 10:55 AM
> > 
> > On Wed, Jan 27, 2021 at 12:23:43PM -0800, Michael Kelley wrote:
> > [...]
> > > +/*
> > > + * Reference to pv_ops must be inline so objtool
> > > + * detection of noinstr violations can work correctly.
> > > + */
> > > +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> > 
> > sched_clock_register is not trivial. Having __always_inline here is
> > going to make the compiled object bloated.
> > 
> > Given this is a static function, I don't think we need to specify any
> > inline keyword. The compiler should be able to determine whether this
> > function should be inlined all by itself.
> > 
> > Wei.
> 
> There was an explicit request from Peter Zijlstra and Thomas Gleixner
> to force it inline.  See https://lore.kernel.org/patchwork/patch/1283635/ and
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/include/asm/mshyperv.h?id=b9d8cf2eb3ceecdee3434b87763492aee9e28845

Oh. noinstr. I failed to notice the comment. Sorry for the noise.

Wei.
