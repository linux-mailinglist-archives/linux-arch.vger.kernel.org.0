Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8026D30F1
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDANTb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Apr 2023 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 09:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860501C1CD;
        Sat,  1 Apr 2023 06:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AFD60E03;
        Sat,  1 Apr 2023 13:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FCC433EF;
        Sat,  1 Apr 2023 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680355167;
        bh=62febkaNQnAPXtdyR9VpUShs/vCJRfylF056sOOKvKM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=upWKPQmZHPtKFqP2Djjw38dQywaVjwuQ0YfIxJqy6uaBjMYTghJuWxPWnyKJepKaY
         SZ3R7lj9gAzvTJ+ZvZv61bGdQ7L/Qgi1qfPAGntT8tV457aMsONrxIvgx0g//Doz0Z
         IXU5ZFfR13im+N2Mx1Df7FRnMpnGAL6QtKoW0XPM+zhxYcT4Syp12nIqDh9pBB+xLM
         316UVaUBNdzlvo6FXA3PQ6X0hSU6cXkmi4kBSCKAWQgLS7NnhzS5FbcexvKWx8BL84
         1DnCpjCSCV0zJ6T58lBwqUto6yd7/EDjIVdOVTTMJJ0Rz317uQCex0lJk/VKsU07NR
         OTNeHRLt9rJ5A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, palmer@dabbelt.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
In-Reply-To: <2587778.7s5MMGUR32@diego>
References: <20230222033021.983168-1-guoren@kernel.org>
 <23668656.ouqheUzb2q@diego>
 <CAJF2gTSWETHhQFuE19H+RVX6Jbue+UAu8o94QoBFx65NABas1Q@mail.gmail.com>
 <2587778.7s5MMGUR32@diego>
Date:   Sat, 01 Apr 2023 15:19:24 +0200
Message-ID: <87mt3rloyr.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> > > > This has unfortunately broken booting my usual NFS rootfs on both my D1
>> > > > and Icicle. It's one of the Fedora images from David, I think this one:
>> > > > http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/
>> > > >
>> > > > It gets pretty far into things, it's once systemd is operational that
>> > > > things go pear shaped:
>> > >
>> > > Shoulda said, can share the full logs if required of course, but they're
>> > > quite verbose cos systemd etc.
>> >
>> > I was just investigating the same thing just now. So that saves me some
>> > tracking down the culprit :-) .
>> >
>> > My main qemu is living as a "board" in my boardfarm (also doing nfsroot)
>> > as well as my d1 nezha with nfsroot was affected.
>> Can you reproduce it with qemu? Could give me some tips and let me
>> reproduce it on qemu?

FWIW, I'm getting the systemd issue w/o NFS, on a regular 9p virtfs.

| $ sudo mmdebstrap --architecture=riscv64 lunar rv-rootfs http://ports.ubuntu.com

and the rootfs qemu config:
 |  -fsdev local,id=root,path=/path/to/rv-rootfs/,security_model=none \
 |  -device virtio-9p-pci,fsdev=root,mount_tag=/dev/root \
 |  -append "root=/dev/root rw rootfstype=9p rootflags=version=9p2000.L,trans=virtio,cache=mmap,access=any security=none earlycon console=tty0 console=ttyS0"

