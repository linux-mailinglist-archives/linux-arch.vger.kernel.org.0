Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE163903C1
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhEYOTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 10:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233719AbhEYOTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 10:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621952282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oa52fjyfDcLuJ2a6WgRHumQI+pkf/uzRwCiMTwmmI6w=;
        b=dYAr8b49lf07D1gTls+jNiMjtsHgGBUYQI4pkY2j6ECcz3BEV3jkpxh4oPX7HGuT/GpFT0
        b3j+mkMDRTDtL/UjM+HSruzCfl2cT6AHy8ArgMSDKzKgPLHCqJOAH85g0YIGeUK36Chn3A
        0noufmd7OQuSke1MKJ9WHDFeQgtv6JM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-1BbfFnfvMuirtifwd1SYfA-1; Tue, 25 May 2021 10:18:01 -0400
X-MC-Unique: 1BbfFnfvMuirtifwd1SYfA-1
Received: by mail-qk1-f200.google.com with SMTP id a24-20020a05620a1038b02902fa6ba180ffso29878234qkk.0
        for <linux-arch@vger.kernel.org>; Tue, 25 May 2021 07:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Oa52fjyfDcLuJ2a6WgRHumQI+pkf/uzRwCiMTwmmI6w=;
        b=gTruHgvRrFTc7PdBftf3MphX7rr7bQoA9Dcbj4CKd0WVWg7qtwakLobiLUrLzFdd2v
         dQeCoW3EbdBxyOQ8MuSt2cDpbn8msHxmvmxlQzlX40WLbDofgwDfUJR/So0H4WpUBDWn
         MankNoh/UFJd/SWlWXoHwrbtFhYBCIt52yiAGUPv1O5+NUYlDwFG+GWU5fUEWRWcl9Aj
         2JMTns8LPFj1q7pe3zqtK1eJCUMF5bf6I6jnQn8JtgSW93IfuV/THni0QKijbGepL0RQ
         kaSN80OAbuj/J6R/gY/3ca/kzMB5M4ZPuYCUTuve0sYVtK3wcUjDplshw2KtkKn4gwY5
         aUAQ==
X-Gm-Message-State: AOAM531nSrj1P/Nt1j6wjKiiWGR2nzTrZHP0tUkx4f59mSBYM9gpIUew
        iZ2I733+609lAg3w8LOtb5CNUuajKUvh9gEUUYEqR0PCKpvUNkX75nHkzox/gvGc4NpzUtz/r9G
        nNZf9pv0GU4jYyJCImqIMl6A2Orws0wGuXLI+2afcWiW0MqIykciUg96lJDiltf78TJ7OSA==
X-Received: by 2002:a05:620a:91b:: with SMTP id v27mr35532999qkv.236.1621952279981;
        Tue, 25 May 2021 07:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgEx3hT8k/BWzZBQPtYn7wA3jU+STWH9mlD14ZlMro0+RGjJ4Zu5BgnthO1OZrI3DhvFeUHg==
X-Received: by 2002:a05:620a:91b:: with SMTP id v27mr35532964qkv.236.1621952279733;
        Tue, 25 May 2021 07:17:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n64sm13305126qkb.111.2021.05.25.07.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 07:17:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Julian Braha <julianbraha@gmail.com>,
        linux-arch@vger.kernel.org
References: <20210524224150.8009-1-rdunlap@infradead.org>
Message-ID: <7e4cc7da-c185-a35f-9047-615ffb222640@redhat.com>
Date:   Tue, 25 May 2021 10:17:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/24/21 6:41 PM, Randy Dunlap wrote:
> Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
> LOCKDEP.
> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
> of the arch-es that LOCKDEP depends on.
>
> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
> intend to have LOCKDEP support, replace the awkward list of
> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>
> But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
> which is already a dependency here, so LOCKDEP_SUPPORT is redundant
> and not needed.
> That leaves the FRAME_POINTER dependency, but it is part of an
> expression like this:
> 	depends on (A && B) && (FRAME_POINTER || B')
> where B' is a dependency of B so if B is true then B' is true
> and the value of FRAME_POINTER does not matter.
> Thus we can also delete the FRAME_POINTER dependency.
>
> Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)
>
> WARNING: unmet direct dependencies detected for LOCKDEP
>    Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>    Selected by [y]:
>    - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>    - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>    - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>
> Link to v1: https://lore.kernel.org/lkml/20210517034430.9569-1-rdunlap@infradead.org/
>
> Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> Cc: Julian Braha <julianbraha@gmail.com>
> Cc: linux-arch@vger.kernel.org
> ---
> @Julian: please take a look. I'm a little concerned about the
>    FRAME_POINTER dependency going away when our 2 patches are combined.
>
> v2: drop depends on LOCKDEP_SUPPORT for LOCKDEP; the use of
>      LOCK_DEBUGGING_SUPPORT already covers that dependency;
>      drop FRAME_POINTER dependency (thanks to Waiman Long
>      for both of these suggestions)
> v2: add CC: to linux-arch
>
>   lib/Kconfig.debug |    1 -
>   1 file changed, 1 deletion(-)
>
> --- linux-next-20210524.orig/lib/Kconfig.debug
> +++ linux-next-20210524/lib/Kconfig.debug
> @@ -1383,7 +1383,6 @@ config LOCKDEP
>   	bool
>   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>   	select STACKTRACE
> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>   	select KALLSYMS
>   	select KALLSYMS_ALL
>   
>
Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

