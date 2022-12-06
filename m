Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE0643D06
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 07:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiLFGNN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 01:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLFGNM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 01:13:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D82CE2D;
        Mon,  5 Dec 2022 22:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63701B81211;
        Tue,  6 Dec 2022 06:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26887C43470;
        Tue,  6 Dec 2022 06:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670307188;
        bh=th1V6+SkiuIfCPI17AmYfQBHSNCfb55wpqFcgPM9EAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NeV48oS7O6faZtRUsQrOrRKSVEssKcQHHkq6wEL3h8Bz95BsmenU2jbMig1oOGJEm
         k4XYw+LaaEu6oO1qsV7j4IGq1hHg6PO5h5ovFAfzelcxwgasgKhYTJN0Uj5epulRd7
         p+lY5+ZlJoo+LyRGchxuuotHduvoEk31ue6o/Ik8e0JqeBqWPSx2ESBzX8Y3spZ+AL
         jio3gsth7v5sVEZn6b2xhwA02E43cqhdizeaGqDjOWMuSuUQZrAxX/6J0aUSCjskXS
         cOLpjxgi1yO4Ft81G/uZBaGwcR8r3MLxsMGZjmC9qrbyJ5JLtB6H0cBBeo8hZnCG/6
         23HluqiB7ewOw==
Received: by mail-ed1-f48.google.com with SMTP id c66so12572324edf.5;
        Mon, 05 Dec 2022 22:13:08 -0800 (PST)
X-Gm-Message-State: ANoB5pmPYe1GMWhLmzQ4KaOMnTyU6HbfGtCDlhmIDZcNdtNxi8fkobUK
        sjtwTW+fDC6GKMsKAgtxjlqzlfHTTwJl8A4iiP8=
X-Google-Smtp-Source: AA0mqf4Sdb09rPxgcsGDOHwTXPlNPlrB8zHFwXBW2+mnGaoopW1W/6+v9PyzrnVbfHcutZsp1vv3yvEtJaXjGdiuoz8=
X-Received: by 2002:a05:6402:22db:b0:46c:c16b:b4c4 with SMTP id
 dm27-20020a05640222db00b0046cc16bb4c4mr6428173edb.419.1670307186319; Mon, 05
 Dec 2022 22:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20221103075047.1634923-1-guoren@kernel.org> <877cz69o8f.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <877cz69o8f.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Dec 2022 14:12:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSgvKV3Oh6t2dpbJGnt3cDZU14Qk_CxKPMXmEmgvMg8-Q@mail.gmail.com>
Message-ID: <CAJF2gTSgvKV3Oh6t2dpbJGnt3cDZU14Qk_CxKPMXmEmgvMg8-Q@mail.gmail.com>
Subject: Re: [PATCH -next V8 00/14] riscv: Add GENERIC_ENTRY support and
 related features
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 5:46 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patches convert riscv to use the generic entry infrastructure from
> > kernel/entry/*. Additionally, add independent irq stacks (IRQ_STACKS)
> > for percpu to prevent kernel stack overflows. Add generic_entry based
> > STACKLEAK support. Some optimization for entry.S with new .macro and
> > merge ret_from_kernel_thread into ret_from_fork.
> >
> > We have tested it with rv64, rv32, rv64 + 32rootfs, all are passed.
> >
> > You can directly try it with:
> > [1] https://github.com/guoren83/linux/tree/generic_entry_v8
>
> Guo, this is a really nice work, and I'm looking forward having generic
> entry support for RV. However, there are many patches in this series
> that really shouldn't be part of the series.
>
> Patch 2, 3, 4, and 10 should defintely be pulled out.
Okay.

>
> I'm not sure 7, 8, and 9 belong to series, as it's really a separate
> feature.
The separate irq/softirq stack patches dpend on generic_entry tightly,
so I recommand put them together.

>
> Dito for patch 11, it just makes the series harder to review.
The 11 is not so necessary as above, I would remove it from this
series. And send it again after generic_entry merged.

>
> For GENERIC_ENTRY support only patch 1, 5, 6, 12, 13, and 14, really
> required. The others are unrelated.
Thx for the reminder; I will re-organize them.

>
>
> Thanks,
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
