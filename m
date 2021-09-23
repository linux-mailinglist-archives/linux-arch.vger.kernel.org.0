Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F99416817
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhIWWfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 18:35:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbhIWWfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 18:35:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632436445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2ZhBYtJSvsZ3l7DnjO1RVJlU7qQTq328JBw+26BNO0=;
        b=AP2AqeL2It81p8EYgU0ybGho7LB+fApxbTmly/ggs1shuqHQQHYakj1Y1V64qry/bSY5fB
        2kDyrurJ4kW1q6toAyoMrundluRj28RNSBBxzhUcUaD7xwLJN+kCJVvUlomT3h97kSHj8o
        PugfBxdna1AC/63Xf/5FiWrNiEZrkG8ciEUvptOAVbWcGsxPkpbnspRAqsDLGLWpPslChE
        CNUyzYQkYKv15igtp86SI/tiEIzIbea5VlmKkc+miIXpNcUdQinOMyYf8+FkJMjO1bdr6F
        IIi8xhJK7pywp4oE/tW+BwPA9Nrm/Vjhr+/Xun85rlj8oeopPa6/wC5J4tB3SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632436445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2ZhBYtJSvsZ3l7DnjO1RVJlU7qQTq328JBw+26BNO0=;
        b=C0Pn5U/YXm47mFk3fbXZQ1wtQFg7AG5C8SWwYN78P+hG8M5mLENfAsMrk+hXP+9nAoB1Lm
        aKpHY+vQmzE6zOAw==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 04/13] x86/fpu/xstate: Enumerate User Interrupts
 supervisor state
In-Reply-To: <20210913200132.3396598-5-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-5-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 00:34:04 +0200
Message-ID: <87ilyqgbvn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> Enable xstate supervisor support for User Interrupts by default.

What means enabled by default? It's enabled when available and not
disabled on the command line.

> The user interrupt state for a task consists of the MSR state and the
> User Interrupt Flag (UIF) value. XSAVES and XRSTORS handle saving and
> restoring both of these states.
>
> <The supervisor XSTATE code might be reworked based on issues reported
> in the past. The Uintr context switching code would also need rework and
> additional testing in that regard.>

What? Which issues were reported and if they have been reported then how
is the provided code correct?

> +/*
> + * State component 14 is supervisor state used for User Interrupts state.
> + * The size of this state is 48 bytes
> + */
> +struct uintr_state {
> +	u64 handler;
> +	u64 stack_adjust;
> +	u32 uitt_size;
> +	u8  uinv;
> +	u8  pad1;
> +	u8  pad2;
> +	u8  uif_pad3;		/* bit 7 - UIF, bits 6:0 - reserved */

Please do not use tail comments. Also what kind of name is uif_pad3?
Bitfields exist for a reason.

Aside of that please use tabs to seperate type and name.

> +	u64 upid_addr;
> +	u64 uirr;
> +	u64 uitt_addr;
> +} __packed;
> +

Thanks,

        tglx
