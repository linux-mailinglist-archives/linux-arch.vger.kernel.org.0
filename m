Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11B643D65
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 08:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiLFHDo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 02:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLFHDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 02:03:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED762C0;
        Mon,  5 Dec 2022 23:03:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179FB6158C;
        Tue,  6 Dec 2022 07:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06436C433C1;
        Tue,  6 Dec 2022 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670310221;
        bh=uyC7NDu0kYuneC2q0Yg1F4ZMc2RuAARWGUstvb0JORM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Xn0Ab43zudPFmTTpXzfogCXfEG9sHc9qr/83uOa40cYmeLmV1HysQqWTNTRZM5wPn
         7fl/dgbAz4N2Go8+npeThW4igE+uhIsQLxsCU4EhmZtgjCZRwq0FIdauvqkxBiZsRU
         gKGokIDnQLOH9BBmdZDj+5LgBB7A4cPwEs9i/nwAavkqzZU739kOuHAQCZL2B0+U05
         cM6uV0N5o9LFnfGwpNeUuKHFtC0AwYFXcP/8W1MOC+JsZX4Cv3qrGhB8AkJGYectLn
         PbJAoIcCmHWIxk8sspJAJUx13xmRpWWtvZw1WTCmcnFTa3ADHSnh0nqq5XXN+Cmp9h
         HiXcN3PhUkaEw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V8 00/14] riscv: Add GENERIC_ENTRY support and
 related features
In-Reply-To: <CAJF2gTSgvKV3Oh6t2dpbJGnt3cDZU14Qk_CxKPMXmEmgvMg8-Q@mail.gmail.com>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <877cz69o8f.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTSgvKV3Oh6t2dpbJGnt3cDZU14Qk_CxKPMXmEmgvMg8-Q@mail.gmail.com>
Date:   Tue, 06 Dec 2022 08:03:38 +0100
Message-ID: <875yep3tf9.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Mon, Dec 5, 2022 at 5:46 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
>>
>> guoren@kernel.org writes:
>>
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > The patches convert riscv to use the generic entry infrastructure from
>> > kernel/entry/*. Additionally, add independent irq stacks (IRQ_STACKS)
>> > for percpu to prevent kernel stack overflows. Add generic_entry based
>> > STACKLEAK support. Some optimization for entry.S with new .macro and
>> > merge ret_from_kernel_thread into ret_from_fork.
>> >
>> > We have tested it with rv64, rv32, rv64 + 32rootfs, all are passed.
>> >
>> > You can directly try it with:
>> > [1] https://github.com/guoren83/linux/tree/generic_entry_v8
>>
>> Guo, this is a really nice work, and I'm looking forward having generic
>> entry support for RV. However, there are many patches in this series
>> that really shouldn't be part of the series.
>>
>> Patch 2, 3, 4, and 10 should defintely be pulled out.
> Okay.
>
>>
>> I'm not sure 7, 8, and 9 belong to series, as it's really a separate
>> feature.
> The separate irq/softirq stack patches dpend on generic_entry tightly,
> so I recommand put them together.

I'd say *depends* on the series, not required for generic entry. Again,
keeping the series orthogonal and small is a good thing.

>> For GENERIC_ENTRY support only patch 1, 5, 6, 12, 13, and 14, really
>> required. The others are unrelated.
> Thx for the reminder; I will re-organize them.

This is a really nice clean up, and the reason I'm pushing for removing
unrelated patches in the series, is because I want to see it land in the
RV tree sooner, rather than later. Send these as follow-ups to generic
entry, once it lands in the tree.


Thank you for the hard work!
Bj=C3=B6rn
