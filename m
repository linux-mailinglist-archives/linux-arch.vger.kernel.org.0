Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE4212129
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGBKZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgGBKZu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 06:25:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A4C08C5C1;
        Thu,  2 Jul 2020 03:25:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l6so9165309pjq.1;
        Thu, 02 Jul 2020 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2dEmOOaTKGF4Qlb49VhQf6A9PlFA3b36H9rV7z7cwEs=;
        b=fwrGZyQ5ZsT9XNpr3/IOWdRZ6ocaZNwfSU2kbuorYXlEEdLE5/x5p3TVpSz28QRp1G
         Rq97XWBtS9UIquZ9RJU/9RJJsvs3vSblV7P3bcy3AJKNZxupjf8CAIH6Vx5/rgUgktkk
         duzXAxjb/9SdEDlWvBSKLc74Js/6Hemi2omyXcEecBxTRXPd6QyrD+31gJzLltU6iW8n
         JF08jA85kpDrr4bA2nZyBfxoqXA5dQqxwaS7+++ll1ExbDrK2qXYBnMpcyDzOvT90egd
         caLSXaJhoRisXKEQ9uGYLW2o3jDa/MNsoH7QZe8RRqAZWZ+dpbslBRZd5PEW6CLytugN
         5Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2dEmOOaTKGF4Qlb49VhQf6A9PlFA3b36H9rV7z7cwEs=;
        b=crHdoLsOAH+pib/GilJMwAx0lEpkC5C6Y6pFIE0yITds7lB7vvIU1greZXTVvOo9W9
         jEW3QI8howa3FG28xGVNPNTjffb51lvho76Xy52kO8QdN3OLGLR7OpAVOTjYO02nZPJC
         gFjQE8HUzb9y2N9ESGYetjJB0anbFSXaclj+ocl1wICCGsMKNUEgr4pc6F/8Fc5U7QsA
         vg5kqCF/zYBNGUQFLM5tMHwRoRjOEA9FAjA4HKbZLpVgK8lb22M4Smnogsi2qEaAyGKZ
         AJVF+dnwtaMruhGdJkv6S8mKpaqPoyakHnuukq8n2hYa4q8FK5HXunXskXPAdbpyECuo
         fC2A==
X-Gm-Message-State: AOAM531+lEe3SClN/nK0EerXq7b/drtz1hm9C+TYIgtW/eFAkVNUwCp3
        GNBKxuewwkfxjzl3IVRqAQU=
X-Google-Smtp-Source: ABdhPJx/3IphE9S504xPgr16qEBAcS0ylg8qERwwjyz6fVgDCXDiKIqknM6KTZc4U4Q2EmZZ4gfQeA==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr29264299pja.152.1593685549611;
        Thu, 02 Jul 2020 03:25:49 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id g18sm8571288pfk.40.2020.07.02.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:25:48 -0700 (PDT)
Date:   Thu, 02 Jul 2020 20:25:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
To:     Will Deacon <will@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        virtualization@lists.linux-foundation.org
References: <20200702074839.1057733-1-npiggin@gmail.com>
        <20200702074839.1057733-6-npiggin@gmail.com>
        <20200702080219.GB16113@willie-the-truck>
In-Reply-To: <20200702080219.GB16113@willie-the-truck>
MIME-Version: 1.0
Message-Id: <1593685459.r2tfxtfdp6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
> On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> new file mode 100644
>> index 000000000000..f84da77b6bb7
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>> +#define _ASM_POWERPC_QSPINLOCK_H
>> +
>> +#include <asm-generic/qspinlock_types.h>
>> +
>> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>> +
>> +#define smp_mb__after_spinlock()   smp_mb()
>> +
>> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock=
)
>> +{
>> +	smp_mb();
>> +	return atomic_read(&lock->val);
>> +}
>=20
> Why do you need the smp_mb() here?

A long and sad tale that ends here 51d7d5205d338

Should probably at least refer to that commit from here, since this one=20
is not going to git blame back there. I'll add something.

Thanks,
Nick
