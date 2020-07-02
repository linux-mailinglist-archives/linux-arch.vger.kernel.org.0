Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C714E212180
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGBKrM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGBKrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 06:47:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAFCC08C5C1;
        Thu,  2 Jul 2020 03:47:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so1898089pls.4;
        Thu, 02 Jul 2020 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7/yp0REosLZos2NH5xismEOcBs6RT4AyW+naEiQaKEQ=;
        b=Tsn7QxuQps6f4KsopBLK/6r7NKPpGUWGpS+e+NrpdDPq41xQyUqMOo+gmEQkN1qI4S
         BHxGxUV5vcdLTX0ajvZOT5Jamg+NLxMN6Yb/BLiPv7A2HCYxQWyzcDfVKcDpDuSeZI2h
         3Q8YwMmLZnrNPs0yIu+sGh20AEHX9gWyfYaMvgUHoffumVOJhg0CiYR38X8RrHCWNf5j
         Md84bVtpBpyovyhHrUoxL6XPgBDUAjA5btaePBVMEdpYH3Nhk118jOknAg9Mx4Y7MhEK
         r/vtbGGjHtUkWLzw78JG/7MLM9d7Vw8hGja8DWr9kQ3IsewCaBztynFRMMH/QNdHLtke
         fVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7/yp0REosLZos2NH5xismEOcBs6RT4AyW+naEiQaKEQ=;
        b=AEAeb2NibDClf/8kbWA+vEJxDL/xQAX0fNYJanB2evj8m+LY/afhhrtyRmGVlvg4EJ
         Zhmm5Zf2nLrNIT7IrM9HM1fwlhb4SOqwhDKoJzBwYVTemKyOF+115emF3S1CmxSpaD67
         BQykH3uo/hBsg0tNz6w09ZpPkjx0wvs61LSkhynoSf+Xg+nRa0FE6YYkPVk6bPd+VoUS
         13kAYHNci0mnY292g4MjTtIJjiWAe/C8Oi07bNr+JVkCU9r1XI/QAu6TNmuhaNxwQ+dw
         x5V6XLMQt7BjixdcQDmomHHkbunmEei/ZCXxOuP/fKQVSf5sfBZzzVUxtASNFWyDONrM
         niRg==
X-Gm-Message-State: AOAM531aol9VOv46+/xS5kfYYE+kyrBCsIgccP6Gz/azr5Pc5vhxTyCg
        vRDdnRvHP9HogL+EzAXQ5wU=
X-Google-Smtp-Source: ABdhPJwoIU+iCSn5Sb/43jebiYHxhFfNdVq9eoVNXNmFOsjzyeH63SOj20Ofhe6NtxmyHaem2+gpVQ==
X-Received: by 2002:a17:90a:a60a:: with SMTP id c10mr4463276pjq.117.1593686831628;
        Thu, 02 Jul 2020 03:47:11 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id y19sm8213367pfc.135.2020.07.02.03.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:47:11 -0700 (PDT)
Date:   Thu, 02 Jul 2020 20:47:05 +1000
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
        <1593685459.r2tfxtfdp6.astroid@bobo.none>
        <20200702103506.GA16418@willie-the-truck>
In-Reply-To: <20200702103506.GA16418@willie-the-truck>
MIME-Version: 1.0
Message-Id: <1593686722.w9psaqk7yp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Will Deacon's message of July 2, 2020 8:35 pm:
> On Thu, Jul 02, 2020 at 08:25:43PM +1000, Nicholas Piggin wrote:
>> Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
>> > On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>> >> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/incl=
ude/asm/qspinlock.h
>> >> new file mode 100644
>> >> index 000000000000..f84da77b6bb7
>> >> --- /dev/null
>> >> +++ b/arch/powerpc/include/asm/qspinlock.h
>> >> @@ -0,0 +1,20 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>> >> +#define _ASM_POWERPC_QSPINLOCK_H
>> >> +
>> >> +#include <asm-generic/qspinlock_types.h>
>> >> +
>> >> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>> >> +
>> >> +#define smp_mb__after_spinlock()   smp_mb()
>> >> +
>> >> +static __always_inline int queued_spin_is_locked(struct qspinlock *l=
ock)
>> >> +{
>> >> +	smp_mb();
>> >> +	return atomic_read(&lock->val);
>> >> +}
>> >=20
>> > Why do you need the smp_mb() here?
>>=20
>> A long and sad tale that ends here 51d7d5205d338
>>=20
>> Should probably at least refer to that commit from here, since this one=20
>> is not going to git blame back there. I'll add something.
>=20
> Is this still an issue, though?
>=20
> See 38b850a73034 (where we added a similar barrier on arm64) and then
> c6f5d02b6a0f (where we removed it).
>=20

Oh nice, I didn't know that went away. Thanks for the heads up.

I'm going to say I'm too scared to remove it while changing the
spinlock algorithm, but I'll open an issue and we should look at=20
removing it.

Thanks,
Nick

