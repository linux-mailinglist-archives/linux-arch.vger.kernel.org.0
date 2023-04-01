Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2476D30AA
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjDAMLB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 1 Apr 2023 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAMLB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 08:11:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243461D937;
        Sat,  1 Apr 2023 05:10:58 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pia3u-0002IB-NC; Sat, 01 Apr 2023 14:10:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Date:   Sat, 01 Apr 2023 14:10:25 +0200
Message-ID: <2587778.7s5MMGUR32@diego>
In-Reply-To: <CAJF2gTSWETHhQFuE19H+RVX6Jbue+UAu8o94QoBFx65NABas1Q@mail.gmail.com>
References: <20230222033021.983168-1-guoren@kernel.org> <23668656.ouqheUzb2q@diego>
 <CAJF2gTSWETHhQFuE19H+RVX6Jbue+UAu8o94QoBFx65NABas1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

Am Samstag, 1. April 2023, 04:15:32 CEST schrieb Guo Ren:
> On Fri, Mar 31, 2023 at 2:47 PM Heiko Stübner <heiko@sntech.de> wrote:
> > Am Freitag, 31. März 2023, 20:41:35 CEST schrieb Conor Dooley:
> > > On Fri, Mar 31, 2023 at 07:34:38PM +0100, Conor Dooley wrote:
> > > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > This patch converts riscv to use the generic entry infrastructure from
> > > > > kernel/entry/*. The generic entry makes maintainers' work easier and
> > > > > codes more elegant. Here are the changes:
> > > > >
> > > > >  - More clear entry.S with handle_exception and ret_from_exception
> > > > >  - Get rid of complex custom signal implementation
> > > > >  - Move syscall procedure from assembly to C, which is much more
> > > > >    readable.
> > > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> > > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> > > > >  - Use the standard preemption code instead of custom
> > > >
> > > > This has unfortunately broken booting my usual NFS rootfs on both my D1
> > > > and Icicle. It's one of the Fedora images from David, I think this one:
> > > > http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/
> > > >
> > > > It gets pretty far into things, it's once systemd is operational that
> > > > things go pear shaped:
> > >
> > > Shoulda said, can share the full logs if required of course, but they're
> > > quite verbose cos systemd etc.
> >
> > I was just investigating the same thing just now. So that saves me some
> > tracking down the culprit :-) .
> >
> > My main qemu is living as a "board" in my boardfarm (also doing nfsroot)
> > as well as my d1 nezha with nfsroot was affected.
> Can you reproduce it with qemu? Could give me some tips and let me
> reproduce it on qemu?

As written the issue both happens on qemu-virt and also the d1-nezha board.
Below I've summarized my setup a bit:


(1) Qemu-commandline:
---------------------

/usr/local/bin/qemu-system-riscv64 -M virt -smp 2 -m 1G -display none \
  -cpu rv64,zbb=true,zbc=true,svpbmt=true,Zicbom=true,Zawrs=true,sscofpmf=true,v=true \
  -serial telnet:localhost:5500,server,nowait -kernel /home/devel/nfs/kernel/riscv64/Image \
  -append "earlycon=sbi root=/dev/nfs nfsroot=10.0.2.2:/home/devel/nfs/rootfs-riscv64virt ip=dhcp rw" \
  -netdev user,id=n1 -device virtio-net-pci,netdev=n1

Which does the start using a nfs-root coming from an nfs-server running
on the same host as qemu.

Though the issue does not seem to be related to the nfs. I also tried
starting with a local disk image like [0] and the issue with the journald
still persists.


(2) the rootfs-contents:
------------------------

Conor seems to be using Fedora, while my distribution of choice is Debian.
My rootfs was created following the instructions on the Debian wiki for
the debports with debootstrap [1].


This morning I also re-created a completely new and pristine rootfs using
those instructions and the issue appeared immediately on first-boot.


Hope this helps a bit
Heiko


[0] same result with a disk-image ... journald failing
/usr/local/bin/qemu-system-riscv64 -M virt -smp 2 -m 1G -display none \
  -cpu rv64,zbb=true,zbc=true,svpbmt=true,Zicbom=true,Zawrs=true,sscofpmf=true,v=true \
  -serial telnet:localhost:5500,server,nowait -kernel /home/devel/nfs/kernel/riscv64/Image \
  -append 'root=/dev/vda console=ttyS0' \
  -drive file=/home/devel/nfs/rootfs-riscv64virt.ext4,format=raw,id=hd0 \
  -device virtio-blk-pci,drive=hd0

[1] https://wiki.debian.org/RISC-V#debootstrap


