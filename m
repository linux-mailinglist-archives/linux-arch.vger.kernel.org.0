Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15803BE91C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhGGN7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhGGN7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 09:59:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA37C061574
        for <linux-arch@vger.kernel.org>; Wed,  7 Jul 2021 06:56:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso3173805pjz.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Jul 2021 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7fv4uLttZwhDSsC+EExeOU5dzSADAjT7ErLk7BLY1tw=;
        b=btgIhUwz6FzHYUD0mLFwLra0cEdNzy8tVLR42Sj34JUGlRW0WA+9QGnpRup6PFBSUG
         1uPFJkqT8xApcTEHxiXm22oEHL681FlwPVopXtYwpHu15W46NVAm1bxcevV7jnqwtPKd
         DxyDKvB1FA+XGCbEkJlPXkFRHp+9bEKZ4CohB5ixa+OCRFWZRDwM/E9FNpDzK26HIIhu
         z95WWVWDPv4lnVNPMB79fPt/Uunmd6jIQ7fQA9nRUQKVato7aTAUYG7ycEYrEDhxWAcc
         DCvw3xGoo7drIiG9IHJGdKDT/3XlK+R7cjSLeg7e29H5FFypRbZ9R9APyq9nubKEiAJb
         PTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7fv4uLttZwhDSsC+EExeOU5dzSADAjT7ErLk7BLY1tw=;
        b=NS3R+TXFmgf4tCQQYEuvPLCiGbj8cSYLChlaoQxgjidYLx7C9eEz0q7YWHTNB0PCvp
         eyJg+C3DrllilSzyOMt+6xnaU/TIG4Sm9sphFKEZk4moPP7vpzrPY5l1AdmOfTunQc20
         snLF/kyj8RfI3Sj9czQkhqirKpxmCDYVHvQYsE2lWC1RQo+XRnKIC6ZGkKuBUrxRhUj5
         S1GSEdrBtJJtwLyICl6HtgdWDMM300IiXcBCbOe3Mj8Sxwsqc/Mn8kVYLZLS1Uxzb3q5
         bs2Y93H6aXlvRd4GI7V7fMr1dUJtO9dVdnzQDpDsMZde6RqbWiINvSJf+8sRBpaNpML4
         MRPA==
X-Gm-Message-State: AOAM5318hT1tp9GownawigcQo7ErSCgBgGy7rw0VAzyZbYnZsxMhIN7B
        GUlukBy+aGe62BEvfSysTZk=
X-Google-Smtp-Source: ABdhPJzJYjw5AaA6VzAzi+7p+GdXb/YH8brisEJIVk3hrAZN6YAMgwWEfS+kf3WxjxAsNvf5oHHG+g==
X-Received: by 2002:a17:90a:ee8e:: with SMTP id i14mr6175408pjz.29.1625666204064;
        Wed, 07 Jul 2021 06:56:44 -0700 (PDT)
Received: from localhost (14-203-186-173.tpgi.com.au. [14.203.186.173])
        by smtp.gmail.com with ESMTPSA id q5sm13398648pgt.46.2021.07.07.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:56:43 -0700 (PDT)
Date:   Wed, 07 Jul 2021 23:56:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
        <20210706041820.1536502-7-chenhuacai@loongson.cn>
        <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
In-Reply-To: <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1625665981.7hbs7yesxx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 6, 2021 9:06 pm:
> On Tue, Jul 06, 2021 at 12:18:07PM +0800, Huacai Chen wrote:
>> +	.align	5	/* 32 byte rollback region */
>> +SYM_FUNC_START(__arch_cpu_idle)
>> +	/* start of rollback region */
>> +	LONG_L	t0, tp, TI_FLAGS
>> +	nop
>> +	andi	t0, t0, _TIF_NEED_RESCHED
>> +	bnez	t0, 1f
>> +	nop
>> +	nop
>> +	nop
>> +	idle	0
>> +	/* end of rollback region */
>> +1:
>> +	jirl	zero, ra, 0
>> +SYM_FUNC_END(__arch_cpu_idle)
>=20
>> +/*
>> + * Common Vectored Interrupt
>> + * Complete the register saves and invoke the do_vi() handler
>> + */
>> +SYM_FUNC_START(except_vec_vi_handler)
>> +	la	t1, __arch_cpu_idle
>> +	LONG_L  t0, sp, PT_EPC
>> +	/* 32 byte rollback region */
>> +	ori	t0, t0, 0x1f
>> +	xori	t0, t0, 0x1f
>> +	bne	t0, t1, 1f
>> +	LONG_S  t0, sp, PT_EPC
>=20
> Seriously, you're having your interrupt handler recover from the idle
> race? On a *new* architecture?

It's heavily derived from MIPS (does that make the wholesale replacement=20
of arch/mips copyright headers a bit questionable?).

I don't think it's such a bad trick though -- restartable sequences=20
before they were cool. It can let you save an irq disable in some
cases (depending on the arch of course).

Thanks,
Nick
