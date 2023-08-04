Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712BC770AF7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHDVaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHDVac (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 17:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9C4C05;
        Fri,  4 Aug 2023 14:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0310C61F3A;
        Fri,  4 Aug 2023 21:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23438C433C9;
        Fri,  4 Aug 2023 21:29:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iw0DQgkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691184584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZRppS8YYYNW1DE8vo/WJiSC8U8LsPa2fq+ydUpDAgY=;
        b=iw0DQgkAB8eMYmtIRwDGpp5CP+mTi6cWTMY6fBYsU2+amRVPZkbMfjZGBvbpWzMRfedPh0
        Rg/DsPpcOFzEFoJRgRIc+94doj0uTx5ZbxI1TdVLZCYrIwRO7io6KYhQ06o57rbCIe9QIF
        YKfp2o7aRyr+6DPyqFOijmyhKmnMAxc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d74180ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 4 Aug 2023 21:29:43 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so1673760241.1;
        Fri, 04 Aug 2023 14:29:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1rUXbsj9yUNIbZvMIgH1udDWK1xWyFxnjA6Q9o0h1cvm1TqhT
        WSVDYWGcpFaelGi2/usczafTJRvsTkV/em0oqdI=
X-Google-Smtp-Source: AGHT+IF1lG6rudDFve1O2mJa7z8XRunBD2b3Mqo6itQxmnVkmiR9raxvXerIG+cbT/V6Met3UwtnpA6Xx463rV+8+9c=
X-Received: by 2002:a05:6102:374a:b0:447:5662:b9c3 with SMTP id
 u10-20020a056102374a00b004475662b9c3mr487830vst.13.1691184582248; Fri, 04 Aug
 2023 14:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230614013018.2168426-1-guoren@kernel.org> <20230614013018.2168426-2-guoren@kernel.org>
 <ZM1tGgcJg0silFaJ@zx2c4.com>
In-Reply-To: <ZM1tGgcJg0silFaJ@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Aug 2023 23:28:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9p3VoZco0+io6pZDnzKVdnP4vr4XWNaAPXGew+1RmfVig@mail.gmail.com>
Message-ID: <CAHmME9p3VoZco0+io6pZDnzKVdnP4vr4XWNaAPXGew+1RmfVig@mail.gmail.com>
Subject: Re: [PATCH -next V13 1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, bjorn@kernel.org,
        cleger@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 4, 2023 at 11:28=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> Hi Guo,
>
> On Tue, Jun 13, 2023 at 09:30:16PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add independent irq stacks for percpu to prevent kernel stack overflows=
.
> > It is also compatible with VMAP_STACK by arch_alloc_vmap_stack.
> >
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> This patch broke the WireGuard test suite. I've attached the .config
> file that it uses. I'm able to fix it by setting CONFIG_EXPERT=3Dy and
> CONFIG_IRQ_STACKS=3Dn to essentially reverse the effect of this patch. Bu=
t
> I'd rather not do that.
>
> Any idea what's up?
>
> Thanks,
> Jason

And, err, I guess I failed to describe what's broken exactly. Here's
what happens:

timeout --foreground 20m qemu-system-riscv64 \
       -nodefaults \
       -nographic \
       -smp 4 \
       -cpu rv64 -machine virt \
       -m 256M \
       -serial stdio \
       -chardev
file,path=3D/home/zx2c4/Projects/wireguard-linux/tools/testing/selftests/wi=
reguard/qemu/build/riscv64/result,id=3Dresult
\
       -device virtio-serial-device -device virtserialport,chardev=3Dresult=
 \
       -no-reboot \
       -monitor none \
       -kernel /home/zx2c4/Projects/wireguard-linux/tools/testing/selftests=
/wireguard/qemu/build/riscv64/kernel/arch/riscv/boot/Image

OpenSBI v1.2
  ____                    _____ ____ _____
 / __ \                  / ____|  _ \_   _|
| |  | |_ __   ___ _ __ | (___ | |_) || |
| |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
| |__| | |_) |  __/ | | |____) | |_) || |_
 \____/| .__/ \___|_| |_|_____/|____/_____|
       | |
       |_|

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 4
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : sifive_test
Platform Shutdown Device  : sifive_test
Firmware Base             : 0x80000000
Firmware Size             : 236 KB
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*,1*,2*,3*
Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
Domain0 Region01          : 0x0000000080000000-0x000000008003ffff ()
Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x000000008fe00000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : time,sstc
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509
[terminates/hangs here]
