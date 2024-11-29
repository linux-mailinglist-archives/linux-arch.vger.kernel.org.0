Return-Path: <linux-arch+bounces-9186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD69DBF7B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 07:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FFC1644FE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 06:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A0156872;
	Fri, 29 Nov 2024 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpMbmOie"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA133C5;
	Fri, 29 Nov 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861702; cv=none; b=WN8BFiZN7p7Dwyt1/8N65CcDNNbA2B3nRn7Q6NZsyftzCr1KpjbTYIYs2d3fuxXW5C+5FDvLku2ICu4sEVrR35LAX814bd9LmShEWlqayi45hwXIaVYP8krbWQ3Q6tmCkvC3Bw2avaILbgqsGbNIZu+7siTiJ+pY8wCfqMORo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861702; c=relaxed/simple;
	bh=m04aUMEVf5TRSOSVZM3/KV/aRJMAT5r1ActEDx2qh0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fksloPkg4O1mS9xt5SkZ6+le4FuJo5wBy3nbT72t4w8/qXlU6+ugM4AiqPtCyw/foCITsB6j0NGLxivagvoV6lwF/w7B0ByQw5wpwUum1rCogggrSaJm8j+8vSQ6iUViYER+zD1Y56J02CGEQq/LPJPNot85hrySPkYNd3BK/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpMbmOie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E088C4CEDD;
	Fri, 29 Nov 2024 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732861701;
	bh=m04aUMEVf5TRSOSVZM3/KV/aRJMAT5r1ActEDx2qh0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WpMbmOieZU5IePP6xc5HdzDc6iqcQyQe0uL9ruyCtPVqjgqt7Oj6M8niVOTqME5P7
	 hNTnF+liGcod1i/k5wBHuoVTc/OU3b4QJEEmoI+s45u/vTWm6Hwr89TayP86Dxus6q
	 dr3rLtUlZsx5DEv/Cg3zkSX1WoD/UCpNmhILqdsVlSgkmynovIbr9kKNt7OY7PZ9cp
	 sjYug/vD3hKD0ZlHB2CKVhLlCdF//pbiGPc0TV8ZQD0pK1FLOACGCEo8Ei/ri8qb4o
	 1Ebxd4htrjFleUqxkP3R/GhlVVz+2Jmj4LDXOAGgZRzzzotOoGHeIEAochrlBJN7/x
	 sm4qwfaNLP9nA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so271941266b.1;
        Thu, 28 Nov 2024 22:28:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSbiHG/+rHRidid9J5KrZvu58RIdhtno3hfcyICFfD1HOsAbW/DI2YcZkxBVcuy26D3reKmyqUog2okafl@vger.kernel.org, AJvYcCVoWNQFUp6oEGU4iOXLG46KcppkFtx2uPOSm9Msile58HXJXpIQ0Lwv9tEhQcXZU+lc81cql3JZNTPY@vger.kernel.org, AJvYcCWSWQOH9GPhbg1q8RSUgri4ZqORN3fj8GUNW8FwNIynna8P69UTtXP5OA4u0cFvu4e46rIrOU647QMN@vger.kernel.org, AJvYcCXciAwV9efIpMds1GmkoymnxwJBKzvB3dpMoirEus++dTHTCkMdGWPIB+dBFDrpXp9+S59RlFIj4A2rrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjTOZaqZ7eZKFNZcMdjP4C/uwDMJ5/9KH9v/iSLiRM0Vn2TUh
	nu4+v8t43ceu11GXTJJSB9f6ZHS0m+wBq4i5oSo8Xa33xQl6lBFElC9fXnwAx0oC+EX46IhpqUl
	jR4hhr1T244/eDWm13yAhSG6Z1Xc=
X-Google-Smtp-Source: AGHT+IGnik1gnkHg7MLIoyf8OPy4ZeBUa164q0mks7OUgZv5rzrmvUF9UG2eXlZHvDk5WykZ+0fx8gneU4S8oq4OvNA=
X-Received: by 2002:a17:907:3f85:b0:a9e:82d2:3266 with SMTP id
 a640c23a62f3a-aa5944eb160mr633289666b.4.1732861699950; Thu, 28 Nov 2024
 22:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com> <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck> <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr> <20241128-goggles-laundry-d94c23ab39a4@spud>
 <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com> <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
In-Reply-To: <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 29 Nov 2024 14:28:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSX82rGp-9xZHvg1Y3SpO516YCcqSBLKFgWEQ5G-iWR4A@mail.gmail.com>
Message-ID: <CAJF2gTSX82rGp-9xZHvg1Y3SpO516YCcqSBLKFgWEQ5G-iWR4A@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Will Deacon <will@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor & Alexandre,

On Fri, Nov 29, 2024 at 10:58=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Nov 29, 2024 at 8:55=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Fri, Nov 29, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> > > > On 28/11/2024 15:14, Conor Dooley wrote:
> > > > > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > > > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> > > > > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wro=
te:
> > > > > > > > In order to produce a generic kernel, a user can select
> > > > > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to th=
e ticket
> > > > > > > > spinlock implementation if Zabha or Ziccrse are not present=
.
> > > > > > > >
> > > > > > > > Note that we can't use alternatives here because the discov=
ery of
> > > > > > > > extensions is done too late and we need to start with the q=
spinlock
> > > > > > > > implementation because the ticket spinlock implementation w=
ould pollute
> > > > > > > > the spinlock value, so let's use static keys.
> > > > > > > >
> > > > > > > > This is largely based on Guo's work and Leonardo reviews at=
 [1].
> > > > > > > >
> > > > > > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.27=
78638-1-guoren@kernel.org/ [1]
> > > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > This patch (now commit ab83647fadae2 ("riscv: Add qspinlock s=
upport"))
> > > > > > > breaks boot on polarfire soc. It dies before outputting anyth=
ing to the
> > > > > > > console. My .config has:
> > > > > > >
> > > > > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > > > > I pointed out some of the fragility during review:
> > > > > >
> > > > > > https://lore.kernel.org/all/20241111164259.GA20042@willie-the-t=
ruck/
> > > > > >
> > > > > > so I'm kinda surprised it got merged tbh :/
> > > > > Maybe it could be reverted rather than having a broken boot with =
the
> > > > > default settings in -rc1.
> > > >
> > > >
> > > > No need to rush before we know what's happening,I guess you bisecte=
d to this
> > > > commit right?
> > >
> > > The symptom is a failure to boot, without any console output, of cour=
se
> > > I bisected it before blaming something specific. But I don't think it=
 is
> > > "rushing" as having -rc1 broken with an option's default is a massive=
 pain
> > > in the arse when it comes to testing.
> > >
> > > > I don't have this soc, so can you provide $stval/$sepc/$scause, a c=
onfig, a
> > > > kernel, anything?
> > >
> > > I don't have the former cos it died immediately on boot. config is
> > > attached. It reproduces in QEMU so you don't need any hardware.
> > If QEMU could reproduce, could you provide a dmesg by the below method?
> >
> > Qemu cmd append: -s -S
> > ref: https://qemu-project.gitlab.io/qemu/system/gdb.html
> >
> > Connect gdb and in console:
> > 1. file vmlinux
> > 2. source ./Documentation/admin-guide/kdump/gdbmacros.txt
> > 3. dmesg
> >
> > Then, we could get the kernel's early boot logs from memory.
> I've reproduced it on qemu, thx for the config.
>
> Reading symbols from ../build-rv64lp64/vmlinux...
> (gdb) tar rem:1234
> Remote debugging using :1234
> ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.h:49
> 49              atomic_cond_read_acquire(&lock->val, ticket =3D=3D (u16)V=
AL);
> (gdb) bt
> #0  ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.h:49
> #1  arch_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/arch/riscv/include/asm/spinlock.h:28
> #2  do_raw_spin_lock (lock=3Dlock@entry=3D0xffffffff81b9a5b8 <text_mutex>=
)
> at /home/guoren/source/kernel/linux/kernel/locking/spinlock_debug.c:116
> #3  0xffffffff80b2ea0e in __raw_spin_lock_irqsave
> (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/include/linux/spinlock_api_smp.h:111
> #4  _raw_spin_lock_irqsave (lock=3Dlock@entry=3D0xffffffff81b9a5b8
> <text_mutex>) at
> /home/guoren/source/kernel/linux/kernel/locking/spinlock.c:162
> #5  0xffffffff80b27c54 in rt_mutex_slowtrylock
> (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1393
> #6  0xffffffff80b295ea in rt_mutex_try_acquire
> (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:319
> #7  __rt_mutex_lock (state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) a=
t
> /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1805
> #8  __mutex_lock_common (ip=3D18446744071562135170, nest_lock=3D0x0,
> subclass=3D0, state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:518
> #9  mutex_lock_nested (lock=3D0xffffffff81b9a5b8 <text_mutex>,
> subclass=3Dsubclass@entry=3D0) at
> /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:529
> #10 0xffffffff80010682 in arch_jump_label_transform_queue
> (entry=3Dentry@entry=3D0xffffffff8158da28, type=3D<optimized out>) at
> /home/guoren/source/kernel/linux/arch/riscv/kernel/jump_label.c:39
> #11 0xffffffff801d86b2 in __jump_label_update
> (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>,
> entry=3D0xffffffff8158da28, stop=3Dstop@entry=3D0xffffffff815a5e68
> <__tracepoint_ptr_initcall_finish>, init=3Dinit@entry=3Dtrue)
>     at /home/guoren/source/kernel/linux/kernel/jump_label.c:513
> #12 0xffffffff801d890c in jump_label_update
> (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> /home/guoren/source/kernel/linux/kernel/jump_label.c:920
> #13 0xffffffff801d8be8 in static_key_disable_cpuslocked
> (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> /home/guoren/source/kernel/linux/kernel/jump_label.c:240
> #14 0xffffffff801d8c04 in static_key_disable
> (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> /home/guoren/source/kernel/linux/kernel/jump_label.c:248
> #15 0xffffffff80c04a1a in riscv_spinlock_init () at
> /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:271
> #16 setup_arch (cmdline_p=3Dcmdline_p@entry=3D0xffffffff81a03e88) at
> /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:336
> #17 0xffffffff80c007a2 in start_kernel () at
> /home/guoren/source/kernel/linux/init/main.c:922
> #18 0xffffffff80001164 in _start_kernel ()
> Backtrace stopped: frame did not save the PC
> (gdb) p /x lock
> $1 =3D 0xffffffff81b9a5b8
> (gdb) p /x *lock
> $2 =3D {{val =3D {counter =3D 0x20000}, {locked =3D 0x0, pending =3D 0x0}=
,
> {locked_pending =3D 0x0, tail =3D 0x2}}}

I have for you here a fast fixup for reference. (PS: I'm digging into
the root cause mentioned by Will Deacon.)

diff --git a/arch/riscv/include/asm/text-patching.h
b/arch/riscv/include/asm/text-patching.h
index 7228e266b9a1..0439609f1cff 100644
--- a/arch/riscv/include/asm/text-patching.h
+++ b/arch/riscv/include/asm/text-patching.h
@@ -12,5 +12,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, size_t len);

 extern int riscv_patch_in_stop_machine;
+extern int riscv_patch_in_spinlock_init;

 #endif /* _ASM_RISCV_PATCH_H */
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.=
c
index 6eee6f736f68..d9a5a5c1933d 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -36,9 +36,11 @@ bool arch_jump_label_transform_queue(struct
jump_entry *entry,
                insn =3D RISCV_INSN_NOP;
        }

-       mutex_lock(&text_mutex);
+       if (!riscv_patch_in_spinlock_init)
+               mutex_lock(&text_mutex);
        patch_insn_write(addr, &insn, sizeof(insn));
-       mutex_unlock(&text_mutex);
+       if (!riscv_patch_in_spinlock_init)
+               mutex_unlock(&text_mutex);

        return true;
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index db13c9ddf9e3..ab009cf855c2 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -24,6 +24,7 @@ struct patch_insn {
 };

 int riscv_patch_in_stop_machine =3D false;
+int riscv_patch_in_spinlock_init =3D false;

 #ifdef CONFIG_MMU

@@ -131,7 +132,7 @@ static int __patch_insn_write(void *addr, const
void *insn, size_t len)
         * safe but triggers a lockdep failure, so just elide it for that
         * specific case.
         */
-       if (!riscv_patch_in_stop_machine)
+       if (!riscv_patch_in_stop_machine && !riscv_patch_in_spinlock_init)
                lockdep_assert_held(&text_mutex);

        preempt_disable();
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 016b48fcd6f2..87ddf1702be4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -268,7 +268,9 @@ static void __init riscv_spinlock_init(void)
        }
 #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
        else {
+               riscv_patch_in_spinlock_init =3D 1;
                static_branch_disable(&qspinlock_key);
+               riscv_patch_in_spinlock_init =3D 0;
                pr_info("Ticket spinlock: enabled\n");
                return;
        }



--=20
Best Regards
 Guo Ren

