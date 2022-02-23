Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5C4C10DE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiBWLAW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiBWLAW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 06:00:22 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5C8C7D1;
        Wed, 23 Feb 2022 02:59:54 -0800 (PST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlfCk-1o4Ra6312w-00inTg; Wed, 23 Feb 2022 11:59:52 +0100
Received: by mail-wr1-f52.google.com with SMTP id o4so2135193wrf.3;
        Wed, 23 Feb 2022 02:59:52 -0800 (PST)
X-Gm-Message-State: AOAM532w0I/FQasSXoRn7paj/0r708sN7Hcll05a600icEtPzbVFW5nu
        NA3gFKSoZzvNLofXWNFCuRR21wXtMvkt8QI7GtY=
X-Google-Smtp-Source: ABdhPJz3tjc3IejYq+UPcpb0b0B/1/NsttPG6/6KnMrBytsQxjHYO0/p2daBPMgz1AgVYfLNcxR3Ydw+Oyz4L5S8GiA=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr23150986wri.219.1645613992251; Wed, 23
 Feb 2022 02:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <mhng-36783ff3-37c2-454b-9337-8cb124195255@palmer-ri-x1c9>
In-Reply-To: <mhng-36783ff3-37c2-454b-9337-8cb124195255@palmer-ri-x1c9>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Feb 2022 11:59:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1W3Ns1WYiSGXb3Qn6-p+SPsx1UGqXdTkk2taPB72OZUA@mail.gmail.com>
Message-ID: <CAK8P3a1W3Ns1WYiSGXb3Qn6-p+SPsx1UGqXdTkk2taPB72OZUA@mail.gmail.com>
Subject: Re: [PATCH V5 00/21] riscv: compat: Add COMPAT mode support for rv64
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fDj8UNVRV8r/eEkDy+HCLSo5oTnkzwOoBxcvqklwcRxXRwi6wUV
 6SE5GCBES+rEkqbaFiHz6aGc/CNcIz7j4g51nG2OX1z+qqp19c2xUqQAOlXIpbA/+vI2jCi
 66nCed0HrHG8pKuBjTvpQfJ7mhp2uPg7qBZSY37R2iNdBB0GFnk2uzfcY2yijMhTM9tVR5a
 82jnAWH9+MAZlTC76Larg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VYpzYxJP3NU=:KiMJ/01sPAWeZQz4PFOQPd
 EUCgAbE0c2Cin8EOQRowCayryy7BPpe5bQgq2432OdqeY3VSVKI/wNylTiMVyAmj6FT2ytEiM
 gL1j8GQTU/d4DIa8yFaX2cUj/wMx2326wezaZ/Eg+xrmMuJ22WbnjY/4ERGhOlKbe2ajo2q4j
 nB1wwbuu2/KVd3tKlRy0wp6mdIDFpfpVGcEqCqwAj/hP5wu4Bpxj+rAKgQYaWLjMjB0i8h7OV
 ODpdELWbpwXtYHT1HK6t4KipCMhxoWeyfSxoLNNTG+0iakeWXjAJm7KH4geyKsF5/dBiVLve9
 MKzdUoMmTtdVLU0sMdKfHKhCsTfnPdYQbHoCzlVJOPOWfiUsbKZBWyaJbNPiDikGERCSzNAAX
 C4eXdL1FU/X0/uSzrmBOisTs1d7tFnm4TPPjLwuvkpTeDoFyCotroxkVLOwXyLoW/6Mtt2A5L
 f7HnXCuoCVK9NDA56rC8hmP4fvF5PgPXfZ53EjoRa0KAXhkeOt6hjiioccWF8GB3wtpYCSz2Q
 x/w188d2UL8fdFCA4/qcA93GYKxVDxtyijHEs2fv4X9cjVSLS1xofqo82uQlZNOld5oQD8grR
 9xl/STptXx2jNltgonnEIU+jCcw8/C7Gq4wQYgpPWV4qU+vacJZX3kzdQKa4ngeO+Nmodh57z
 d51eBFgsR+V899w2wccXBgAg4hC1fCn0bVJEkBD2re7ZZKS51/XEGqsuqHdGgdz0vP3FvtHR9
 q8gtkkCIZPBMtMVsq/zXp0ciSyWaDJ1PcchbymzduRV9j0RoDYiuZAkhzcXQdeR8TUPw23V9y
 gjOWaejEBuP9kA/k1Ei5FfLOuljURkZ8ilqRlxgTSyUIVJnqi4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 2:43 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 01 Feb 2022 07:05:24 PST (-0800), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> > s390, mips, sparc) have supported COMPAT mode. But they all have
> > history issues and can't use standard linux unistd.h. RISC-V would
> > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> > /unistd.h.
>
> TBH, I'd always sort of hoped we wouldn't have to do this: it's a lot of
> ABI surface to keep around for a use case I'm not really sure is ever
> going to get any traction (it's not like we have legacy 32-bit
> userspaces floating around, the 32-bit userspace is newer than the
> 64-bit userspace).

The low-end embedded market isn't usually that newsworthy, but the
machines ship in huge quantities, and they all run 32-bit user
space for good reasons:

The cheapest Linux systems at the moment use a low-end MIPS or
Arm core with a single DDR2 (32MB to 128MB) or DDR3 (128MB
to 512MB) memory chip that for now is a bit cheaper than a larger
LP-DDR4 (256MB+). The smaller configurations will go away over
time as they get outpriced by systems with LP-DDR4, but a 32-bit
system with 256MB will keep beating a 64-bit-only system with
512MB on price, and will run most workloads better than a 64-bit
system with the same amount of RAM.

On the Arm side, I hope that these systems will migrate to Armv8
based designs (Cortex-A53/A35 or newer) running 64-bit kernel
with 32-bit user space to replace the currently dominant but aging
32-bit Cortex-A7 cores. As you say, RISC-V is at a disadvantage
here because there is no existing 32-bit ecosystem, but it may take
a chunk of that market anyway based on licensing cost. Between
doing this using pure 32-bit cores or on mixed 32/64-bit cores,
I found Guo Ren's explanation very sensible, it lets you use the
same chip both as a low-end embedded version with SiP
memory, or using an external DDR3/LPDDR4 chip with enough
capacity to run a generic 64-bit distro.

> My assumption is that users who actually wanted the
> memory savings (likely a very small number) would be better served with
> rv64/ilp32, as that'll allow the larger registers that the hardware
> supports.  From some earlier discussions it looks like rv64/ilp32 isn't
> going to be allowed, though, so this seems like the only way to go.

Right, between rv32 user space and a hypothetical rv64-ilp32 target,
I think it's clear that the former is better because it means introducing
only one fringe ABI rather than two incompatible ones with minor
performance differences.

        Arnd
