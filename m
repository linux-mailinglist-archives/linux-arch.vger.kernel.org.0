Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE722ECFC
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgG0NRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgG0NRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 09:17:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99753C061794;
        Mon, 27 Jul 2020 06:17:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gg18so13653996ejb.6;
        Mon, 27 Jul 2020 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iNBgboLv8PrTHcQjEn6Y9Jz21Y45h4oiyFqkeuFiwIo=;
        b=m9lNB2hwvTAN4kqxBWcMSgc2vgMnClGnzEA91il0qX2jUYtR538v0I2sE26G/ytH/P
         T4RpMxw+ereB4LMTBg2ajmg9kqdKW0PgzzSeU8sTmBmdVnTqfF+APt1NR6U7rTn935Vq
         RQz9PBK/vu4qFbPbvkHcqKwFfkOzCuJ4h+lGMYyZXSMcIcrTC+SXb72CDkt1H97ma2U4
         dxl6QtFhkWvIB5irb0Xg+cpAMxL/blcAidpAhInbfCNTpdTTjQPSxxB84V3NvhskyUdN
         m/7dCRpV+nbGGnpwKuOtMgwrYNVnDEROAp6X0BETYaS+7C3vmXsY7wLNy0rSb/5F4ZFM
         L7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iNBgboLv8PrTHcQjEn6Y9Jz21Y45h4oiyFqkeuFiwIo=;
        b=EFjzxGHrmun2nl3QRhnhxyVcjCg6/UU2lg64V8z7YOWVKVdiwOglopAt9qA/w/5y9c
         vdWP2cjJZXvcFttgo8MD5PyL1+ay6Sk88mwMnout2fkGhjm26RbEkVhcIr33VqWA6w6k
         xnpbKF431XeNQtmKO3cRv8Jlox7Kiy3tD2x9SlGwJHygoWrpxH+hnTyD9uLWD7bebfNq
         vCEPbDmLdicWOOIJXWe9DdJFzUjKGoxiNF78DbbUne5Gg3sZUmGQw4f6dAIbrpmHyyG4
         4cPazL885UfYZNXQ8eD4Tv3gSF9mzfEWwYxbVWypMGACpgsgJmfqG+p8qecxOvJSjblA
         cN8A==
X-Gm-Message-State: AOAM533xmZiyfUlkDBiaZqeas9wn/+yOpV6s1l0UB82lHP22lwjifaQq
        wXUsf7qyBMs9AO0GEOy+q2s=
X-Google-Smtp-Source: ABdhPJyVxWiINoqkfFlfIcdrJsa1NvE979dm5Bc7LcNowaJCcOqoBIdVfKcSurwauXtjizprI63uuQ==
X-Received: by 2002:a17:906:1751:: with SMTP id d17mr20468545eje.140.1595855854375;
        Mon, 27 Jul 2020 06:17:34 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y7sm6961705ejd.73.2020.07.27.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:17:33 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:17:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     peterz@infradead.org
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, x86@kernel.org, linux-sh@vger.kernel.org,
        borntraeger@de.ibm.com, jcmvbkbc@gmail.com
Subject: Re: [PATCH] lockdep: Fix TRACE_IRQFLAGS vs NMIs
Message-ID: <20200727131731.GB105139@gmail.com>
References: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* peterz@infradead.org <peterz@infradead.org> wrote:

> 
> Prior to commit 859d069ee1dd ("lockdep: Prepare for NMI IRQ state
> tracking") IRQ state tracking was disabled in NMIs due to nmi_enter()
> doing lockdep_off() -- with the obvious requirement that NMI entry
> call nmi_enter() before trace_hardirqs_off().
> 
> [ afaict, PowerPC and SH violate this order on their NMI entry ]
> 
> However, that commit explicitly changed lockdep_hardirqs_*() to ignore
> lockdep_off() and breaks every architecture that has irq-tracing in
> it's NMI entry that hasn't been fixed up (x86 being the only fixed one
> at this point).
> 
> The reason for this change is that by ignoring lockdep_off() we can:
> 
>   - get rid of 'current->lockdep_recursion' in lockdep_assert_irqs*()
>     which was going to to give header-recursion issues with the
>     seqlock rework.
> 
>   - allow these lockdep_assert_*() macros to function in NMI context.
> 
> Restore the previous state of things and allow an architecture to
> opt-in to the NMI IRQ tracking support, however instead of relying on
> lockdep_off(), rely on in_nmi(), both are part of nmi_enter() and so
> over-all entry ordering doesn't need to change.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig.debug   |    3 +++
>  kernel/locking/lockdep.c |    8 +++++++-
>  lib/Kconfig.debug        |    6 ++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

Tree management side note: to apply this I've created a new 
tip:locking/nmi branch, which is based off the existing NMI vs. IRQ 
tracing commits included in locking/core:

ed00495333cc: ("locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs")
ba1f2b2eaa2a: ("x86/entry: Fix NMI vs IRQ state tracking")
859d069ee1dd: ("lockdep: Prepare for NMI IRQ state tracking")
248591f5d257: ("kcsan: Make KCSAN compatible with new IRQ state tracking")
e1bcad609f5a: ("Merge branch 'tip/x86/entry'")
b037b09b9058: ("x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()")
dcb7fd82c75e: ("Linux 5.8-rc4")

This locking/nmi branch can then be merged into irq/entry (there's a 
bunch of conflicts between them), without coupling all of v5.9's 
locking changes to Thomas's generic entry work.

Thanks,

	Ingo
