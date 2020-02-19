Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBE164B3B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSQ5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:57:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55246 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSQ5D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:57:03 -0500
Received: from zn.tnic (p200300EC2F095500C57DC876B1A4488F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:c57d:c876:b1a4:488f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 498D21EC0CD9;
        Wed, 19 Feb 2020 17:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582131422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wBQ/V+Owq77r5fLvZwGz8LVJdcyZkflLLKgxNcXUSdA=;
        b=WTdKP+F8vPWRVBlx/zejK9TZPtBxxTegXT2VRNnuYGBmVzrcYo9tT3T30aH1SPdsy7bEX5
        rIpJWs1GMLcTov1wdGw4WAkVEg0mDXpqNXsT3qjsPfnyd0QvTKyMPvaxtLsjTqM0EZo3p7
        MmxGKc8Z9xW4JBr2/eniYUv1QjEa/IM=
Date:   Wed, 19 Feb 2020 17:56:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200219165650.GB32346@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
 <20200219103126.33f67cf3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219103126.33f67cf3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 10:31:26AM -0500, Steven Rostedt wrote:
> Probably should document somewhere (in a comment above nmi_enter()?)
> that we allow nmi_enter() to nest up to 15 times.

Yah, and can we make the BUG_ON() WARN_ON or so instead, so that there's
at least a chance to be able to catch it for debugging. Or is the box
going to be irreparably wedged after the 4 bits overflow?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
