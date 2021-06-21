Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06C3AE1E4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 05:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFUDjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 23:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhFUDjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 23:39:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FDC061574;
        Sun, 20 Jun 2021 20:36:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x16so12546951pfa.13;
        Sun, 20 Jun 2021 20:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xLiu6z7n8Nm4pgvs/bW2NXTNeK55NaWWpQGLLIvDVng=;
        b=S5rqecO5NnewVMiMgfEHBfVJRZG9DzFsYkSVQ/EFVweec1CqVq+fziE2JAteDFz7hb
         gw7srdiAAkBuFrsn8uyX3zPk1OLrFCbSRHe5kRgRTu9nPpcsrJGJ2CmehyJoJTz73Q/n
         CIIplHkKDn/X9xYpzxQHk1uC7tHbMq0bnAs+TFiWbtcgL3zZIO/K2cXgVv3wgeR970/W
         P8TZLmviFCrV1teriIklo40jrRJOoO3donZvc79Vkyz7IptxOVwgC1YmUnH6UOqmiaS/
         2dEG1K+YrBe3F+VsnA55g2h3uQrQgfc057DDfipoELXgQBCjs5Mtnfr+FUO2ZC5BUHmN
         iWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xLiu6z7n8Nm4pgvs/bW2NXTNeK55NaWWpQGLLIvDVng=;
        b=D7Nxk8iXoGTcRNBSLGVCZHLPKelB2G2wf1z3QseeGifPifWUhkd0e7XhwrTo3mKmvt
         yMDxFNK/w9eApEObVJTyZ+LD7cvc/QZE1m9SAAUvz1z+hn2qu/3AS+gI+yraVAmSKQPw
         zMbCnzZHqwzEPTLfohYO5+veqnTEOlikZ0s5iWaUzFwCqEatnZrwfSaDs0foNnJJLVaP
         SSurwKfMOd4oRffVfzZfh6DMqybfxCAQhq89YmFCMI2+wKqrQDMw07gFgb3T3UK3nH1x
         bUxVYKk86X3EuVBf7BtPXrlVpTShdLlqcnfGHWJYhDKvxUlLP+RossXWAg50Kbj54TnT
         7sMg==
X-Gm-Message-State: AOAM530LJ5c4SwX10YfLRXFI47vRowaua9xaBjSn3TCU+cNMvtqXtSNH
        Jxp8SNAtSCxT1QD3SQGm14g=
X-Google-Smtp-Source: ABdhPJxVBdwsRiX1C8pmBuP+luLGE83oud1sbsqsWQaBPVj49ppFiH84WMPluWwEQgGhK3WPEUFq5w==
X-Received: by 2002:aa7:8244:0:b029:2ec:968d:c1b4 with SMTP id e4-20020aa782440000b02902ec968dc1b4mr17307756pfn.32.1624246612404;
        Sun, 20 Jun 2021 20:36:52 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id b5sm11515267pgh.41.2021.06.20.20.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 20:36:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133> <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
 <YM/5KAlgTtR6ncOl@zeniv-ca.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9db8096e-677f-3852-6ca4-28143a228ec3@gmail.com>
Date:   Mon, 21 Jun 2021 15:36:41 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <YM/5KAlgTtR6ncOl@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,


Am 21.06.2021 um 14:27 schrieb Al Viro:
> On Mon, Jun 21, 2021 at 02:01:18PM +1200, Michael Schmitz wrote:
>> Hi Eric,
>>
>> instrumenting get_reg on m68k and using a similar patch to yours to warn
>> when unsaved registers are accessed on the switch stack, I get a hit from
>> getegid and getegid32, just by running a simple ptrace on ls.
>>
>> Going to wack those two moles now ...
>
> Explain, please.  get_reg() is called by tracer; whose state are you checking?

The check is only triggered when syscall tracing (I set a flag on trace 
entry, and clear that on trace exit)... From the WARN_ONCE stack dump, 
it appears that I get the warning from inside the syscall, not 
syscall_trace().

> Because you are *not* accessing the switch stack of the caller of get_reg().
> And tracee should be in something like syscall_trace() or do_notify_resume();
> both have SAVE_SWITCH_STACK done by the glue...

And that's where my problem may be - I stupidly forgot to set the 'all 
registers saved' flag before calling syscall_trace() ...

I'll fix that and try again. Sorry for the noise!

Cheers,

	Michael



>
