Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42C26D6BB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQIei (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIQIee (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Sep 2020 04:34:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1994C06174A
        for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2020 01:34:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so1101087wrv.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2020 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pk1ggKwYhiZFij3cWsXPx/AsObXSSswRVDTN18QPE2I=;
        b=OqIh71Za/Sfud+/Ld2OIcnclZx0GScK1SioXnMYhhN+wJMXNO+nPqZVsSowByH13lC
         IA6VorWMqWg30MkyELqC6xs0OUIYHEpQ1N2DayLyrSn6ouvhsIfCAuKYtjiTW+wd3ouU
         jb3YvRKbbD2HnPJAhGCH53RJMDZ6i/Jg/pj2l3dAbI5yyfqfzyqgHU8awtuhdEs/sEHb
         J5gH3ixTa90rSdfYZcFrvEw9cFofCjgTDONXYlmxjKFrqpT2OyF+JPKkg7+0luusumjR
         ZI8i1Pjyu6ykougSn/5jMLvYtGPzAD6CVr/1WKJDk5qo6HFoWi/zZ+Ua9z+YFBgCzakv
         8CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pk1ggKwYhiZFij3cWsXPx/AsObXSSswRVDTN18QPE2I=;
        b=V367B0q1HSriZKn4PY1FL9JSxsdcLm4FwlRqY/I9YXP4BKHBxs0oPYBmMcaS24qjZX
         zb9jve8P3+PQycsRmVGKEf3t7ZudJndWzQpfU6W4fLM8Iclhe7kIiqOrBPHyUd9z45k0
         SR0cjuPYWuBQstNlMTS86x1YKzHHp//Fwane/+F/pmKA3g5vT8GzJyyFpbyfgvPdxR+S
         5qDNEBooaO07ouC4f0gQ2j3MgXT45LzqxgJU8Ez0T04WhoAaFaG/JNkwyTTdS5YFDwnS
         ozEJuYAXG+82fdJzQ4Fe0kwYD2vHYIsVr/m9S6Uy8HQnT/rWfNHRWzeiYPfA3tGdAVc2
         Xprg==
X-Gm-Message-State: AOAM533eGPyH/HFVHCf5ChNXQBQ4gRCCI4QEgLavOeXEshjH+pMtfGJ6
        PzpB9eODA1VKRjeZ4ZhiNEmpkA==
X-Google-Smtp-Source: ABdhPJx4CDiIDgawZUzofKbr1/03K2/UnXYclUCZ/yVoEIhOqk5tUiGj9MxMh78vMqiYe0X3zEL3rw==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr30654727wrs.230.1600331672159;
        Thu, 17 Sep 2020 01:34:32 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:1155:1c40:3244:2fc2])
        by smtp.gmail.com with ESMTPSA id s17sm39708604wrr.40.2020.09.17.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:34:31 -0700 (PDT)
Date:   Thu, 17 Sep 2020 09:34:30 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Andrew Scull <ascull@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 03/10] kvm: arm64: Remove __hyp_this_cpu_read
Message-ID: <20200917083430.sxe4rpwp2lrdu3hq@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-4-dbrazdil@google.com>
 <20200910111225.GC93664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910111225.GC93664@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Andrew,

> > +#ifdef __KVM_NVHE_HYPERVISOR__
> > +#define __my_cpu_offset __hyp_my_cpu_offset()
> 
> Is there a benefit to this being used for __KVM_VHE_HYPERVISOR__ too
> since that is "hyp" too and doesn't need the alternative since it will
> always pick EL2?

Minor time and space savings, but you're right, makes sense to treat them
equally. Updated in v3.

> > +/* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
> > +#if defined(__KVM_NVHE_HYPERVISOR__) && defined(CONFIG_DEBUG_PREEMPT)
> > +#undef	this_cpu_ptr
> > +#define	this_cpu_ptr		raw_cpu_ptr
> > +#undef	__this_cpu_read
> > +#define	__this_cpu_read		raw_cpu_read
> > +#undef	__this_cpu_write
> > +#define	__this_cpu_write	raw_cpu_write
> > +#endif
> 
> This is an incomplete cherry-picked list of macros that are redefined to
> remove the call to __this_cpu_preempt_check that would result in a
> linker failure since that symbol is not defined for nVHE hyp.
> 
> I remember there being some dislike of truely defining that symbol with
> an nVHE hyp implementation but I can't see why. Yes, nVHE hyp is always
> has preemption disabled so the implementation is just an empty function
> but why is is preferrable to redefine some of these macros instead?

That was my initial implementation and we could probably sway others in that
direction, too. That said, I just tried it on 5.9-rc5 and there are two more
dependencies. No idea what changed sinced the last time I tried, maybe I simply
messed up back then.

Basically, this_cpu_ptr translates to:
  __this_cpu_preempt_check(); per_cpu_ptr(sym, debug_smp_processor_id())

__this_cpu_preempt_check: should be empty for hyp
per_cpu_ptr: needs mapping of the array of bases in hyp, otherwise easy
debug_smp_processor_id: needs a clone of 'cpu_number' percpu variable

Neither of these is particularly difficult to implement, and two will even be
useful going forward, but it still feels too fiddly for posting this late in
the 5.10 cycle. So I suggest we stick to the macro redefines for now and I'll
post those patches for 5.11. WDYT?

You can find the patches on branch 'topic/percpu-v3-debug-preempt' of
https://android-kvm.googlesource.com/linux.

David
