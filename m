Return-Path: <linux-arch+bounces-9189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED169DC308
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C9C281E14
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893B199FDE;
	Fri, 29 Nov 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCjtqdNX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452238DD1;
	Fri, 29 Nov 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880631; cv=none; b=KX0ZNWDUqw3Lp12ZM6MPM20SmSSEYk5020XHk1EYNovSEhN4hX2hiLY7Vxng+HrXStIvG+nnGJ482HFJuyDkhFfUxduH7ZL6U/a6GlmHy0LD3bC0/J36gYmRoXMa1XhVXn54vhgB/+QV61JKVGQXVzVsLcV+Tx5URCntaEjKTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880631; c=relaxed/simple;
	bh=G8AqFc5LTGVRkR33K28gNMbFNkTaSvsrBPfqjLlcbIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYkULWVJbkl57HUODpwein1Wjrw6ZX5BDr0PucST2JKL+XCSZE6GSLsW1a5+zA6LgVq7PrgCXQDx3Eoc0CZwQdj2p2uIc8DJ4+v9Wipw8inpIv7RT9AOQRtywV6DH5LItVFTBYz9ijIZTjDekVE7H3fqPP9XoG4brt+54I+4ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCjtqdNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FFCC4CECF;
	Fri, 29 Nov 2024 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732880631;
	bh=G8AqFc5LTGVRkR33K28gNMbFNkTaSvsrBPfqjLlcbIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCjtqdNXg1krrgxHf2mBsdQhVDpla/aVvVui+wZDI9zoGYHVF3/y8QqGyfouDAi8E
	 /D+Khlly2aitpzq7ehMzMCrvXEEXdI7wJSADwfDXK10ij2MyUjkdDawWKTAvZwQizP
	 DcdEeGlNfxNFo5OYiIc3dYhv7+6/F2Hr3+QGoiN2swjlv1kKDzVzUaDowLtWIv25on
	 hw1AWKFTuQpVGNU/zc1QyOOcMP3m0f9m85TmguPkZ2YzwwSnzMV6GPcsw73sCp70HK
	 x5nr6tgtBwh+Nger6WvXAnp/nrE6SfLfT3jJ8ErIMquODntqKfJHJrOgz4IgiKz02F
	 i9EvL2T1/sgvw==
Date: Fri, 29 Nov 2024 11:43:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241129-clay-trimester-91a0f281a95d@spud>
References: <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck>
 <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>
 <20241128-goggles-laundry-d94c23ab39a4@spud>
 <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
 <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
 <CAJF2gTSX82rGp-9xZHvg1Y3SpO516YCcqSBLKFgWEQ5G-iWR4A@mail.gmail.com>
 <CAHVXubgXiD5Bi6ytyDHXXOONovWHZTSvr4+oADCvuic5ObGXpQ@mail.gmail.com>
 <20241129-encrust-thumping-b6c6a3399b98@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8D3RDN+sWC/y/ujQ"
Content-Disposition: inline
In-Reply-To: <20241129-encrust-thumping-b6c6a3399b98@spud>


--8D3RDN+sWC/y/ujQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:18:24AM +0000, Conor Dooley wrote:
> On Fri, Nov 29, 2024 at 11:31:44AM +0100, Alexandre Ghiti wrote:
> > Hi everyone,
> >=20
> > On Fri, Nov 29, 2024 at 7:28=E2=80=AFAM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > Hi Conor & Alexandre,
> > >
> > > On Fri, Nov 29, 2024 at 10:58=E2=80=AFAM Guo Ren <guoren@kernel.org> =
wrote:
> > > >
> > > > On Fri, Nov 29, 2024 at 8:55=E2=80=AFAM Guo Ren <guoren@kernel.org>=
 wrote:
> > > > >
> > > > > On Fri, Nov 29, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kern=
el.org> wrote:
> > > > > >
> > > > > > On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> > > > > > > On 28/11/2024 15:14, Conor Dooley wrote:
> > > > > > > > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > > > > > > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wr=
ote:
> > > > > > > > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghi=
ti wrote:
> > > > > > > > > > > In order to produce a generic kernel, a user can sele=
ct
> > > > > > > > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime=
 to the ticket
> > > > > > > > > > > spinlock implementation if Zabha or Ziccrse are not p=
resent.
> > > > > > > > > > >
> > > > > > > > > > > Note that we can't use alternatives here because the =
discovery of
> > > > > > > > > > > extensions is done too late and we need to start with=
 the qspinlock
> > > > > > > > > > > implementation because the ticket spinlock implementa=
tion would pollute
> > > > > > > > > > > the spinlock value, so let's use static keys.
> > > > > > > > > > >
> > > > > > > > > > > This is largely based on Guo's work and Leonardo revi=
ews at [1].
> > > > > > > > > > >
> > > > > > > > > > > Link: https://lore.kernel.org/linux-riscv/20231225125=
847.2778638-1-guoren@kernel.org/ [1]
> > > > > > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.co=
m>
> > > > > > > > > > This patch (now commit ab83647fadae2 ("riscv: Add qspin=
lock support"))
> > > > > > > > > > breaks boot on polarfire soc. It dies before outputting=
 anything to the
> > > > > > > > > > console. My .config has:
> > > > > > > > > >
> > > > > > > > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > > > > > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > > > > > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > > > > > > > I pointed out some of the fragility during review:
> > > > > > > > >
> > > > > > > > > https://lore.kernel.org/all/20241111164259.GA20042@willie=
-the-truck/
> > > > > > > > >
> > > > > > > > > so I'm kinda surprised it got merged tbh :/
> > > > > > > > Maybe it could be reverted rather than having a broken boot=
 with the
> > > > > > > > default settings in -rc1.
> > > > > > >
> > > > > > >
> > > > > > > No need to rush before we know what's happening,I guess you b=
isected to this
> > > > > > > commit right?
> > > > > >
> > > > > > The symptom is a failure to boot, without any console output, o=
f course
> > > > > > I bisected it before blaming something specific. But I don't th=
ink it is
> > > > > > "rushing" as having -rc1 broken with an option's default is a m=
assive pain
> > > > > > in the arse when it comes to testing.
> > > > > >
> > > > > > > I don't have this soc, so can you provide $stval/$sepc/$scaus=
e, a config, a
> > > > > > > kernel, anything?
> > > > > >
> > > > > > I don't have the former cos it died immediately on boot. config=
 is
> > > > > > attached. It reproduces in QEMU so you don't need any hardware.
> > > > > If QEMU could reproduce, could you provide a dmesg by the below m=
ethod?
> > > > >
> > > > > Qemu cmd append: -s -S
> > > > > ref: https://qemu-project.gitlab.io/qemu/system/gdb.html
> > > > >
> > > > > Connect gdb and in console:
> > > > > 1. file vmlinux
> > > > > 2. source ./Documentation/admin-guide/kdump/gdbmacros.txt
> > > > > 3. dmesg
> > > > >
> > > > > Then, we could get the kernel's early boot logs from memory.
> > > > I've reproduced it on qemu, thx for the config.
> > > >
> > > > Reading symbols from ../build-rv64lp64/vmlinux...
> > > > (gdb) tar rem:1234
> > > > Remote debugging using :1234
> > > > ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinloc=
k.h:49
> > > > 49              atomic_cond_read_acquire(&lock->val, ticket =3D=3D =
(u16)VAL);
> > > > (gdb) bt
> > > > #0  ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinloc=
k.h:49
> > > > #1  arch_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/arch/riscv/include/asm/spinlock.h:=
28
> > > > #2  do_raw_spin_lock (lock=3Dlock@entry=3D0xffffffff81b9a5b8 <text_=
mutex>)
> > > > at /home/guoren/source/kernel/linux/kernel/locking/spinlock_debug.c=
:116
> > > > #3  0xffffffff80b2ea0e in __raw_spin_lock_irqsave
> > > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/include/linux/spinlock_api_smp.h:1=
11
> > > > #4  _raw_spin_lock_irqsave (lock=3Dlock@entry=3D0xffffffff81b9a5b8
> > > > <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/spinlock.c:162
> > > > #5  0xffffffff80b27c54 in rt_mutex_slowtrylock
> > > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1393
> > > > #6  0xffffffff80b295ea in rt_mutex_try_acquire
> > > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:319
> > > > #7  __rt_mutex_lock (state=3D2, lock=3D0xffffffff81b9a5b8 <text_mut=
ex>) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1805
> > > > #8  __mutex_lock_common (ip=3D18446744071562135170, nest_lock=3D0x0,
> > > > subclass=3D0, state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:518
> > > > #9  mutex_lock_nested (lock=3D0xffffffff81b9a5b8 <text_mutex>,
> > > > subclass=3Dsubclass@entry=3D0) at
> > > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:529
> > > > #10 0xffffffff80010682 in arch_jump_label_transform_queue
> > > > (entry=3Dentry@entry=3D0xffffffff8158da28, type=3D<optimized out>) =
at
> > > > /home/guoren/source/kernel/linux/arch/riscv/kernel/jump_label.c:39
> > > > #11 0xffffffff801d86b2 in __jump_label_update
> > > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>,
> > > > entry=3D0xffffffff8158da28, stop=3Dstop@entry=3D0xffffffff815a5e68
> > > > <__tracepoint_ptr_initcall_finish>, init=3Dinit@entry=3Dtrue)
> > > >     at /home/guoren/source/kernel/linux/kernel/jump_label.c:513
> > > > #12 0xffffffff801d890c in jump_label_update
> > > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > > /home/guoren/source/kernel/linux/kernel/jump_label.c:920
> > > > #13 0xffffffff801d8be8 in static_key_disable_cpuslocked
> > > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > > /home/guoren/source/kernel/linux/kernel/jump_label.c:240
> > > > #14 0xffffffff801d8c04 in static_key_disable
> > > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > > /home/guoren/source/kernel/linux/kernel/jump_label.c:248
> > > > #15 0xffffffff80c04a1a in riscv_spinlock_init () at
> > > > /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:271
> > > > #16 setup_arch (cmdline_p=3Dcmdline_p@entry=3D0xffffffff81a03e88) at
> > > > /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:336
> > > > #17 0xffffffff80c007a2 in start_kernel () at
> > > > /home/guoren/source/kernel/linux/init/main.c:922
> > > > #18 0xffffffff80001164 in _start_kernel ()
> > > > Backtrace stopped: frame did not save the PC
> > > > (gdb) p /x lock
> > > > $1 =3D 0xffffffff81b9a5b8
> > > > (gdb) p /x *lock
> > > > $2 =3D {{val =3D {counter =3D 0x20000}, {locked =3D 0x0, pending =
=3D 0x0},
> > > > {locked_pending =3D 0x0, tail =3D 0x2}}}
> > >
> > > I have for you here a fast fixup for reference. (PS: I'm digging into
> > > the root cause mentioned by Will Deacon.)
> > >
> > > diff --git a/arch/riscv/include/asm/text-patching.h
> > > b/arch/riscv/include/asm/text-patching.h
> > > index 7228e266b9a1..0439609f1cff 100644
> > > --- a/arch/riscv/include/asm/text-patching.h
> > > +++ b/arch/riscv/include/asm/text-patching.h
> > > @@ -12,5 +12,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len);
> > >  int patch_text(void *addr, u32 *insns, size_t len);
> > >
> > >  extern int riscv_patch_in_stop_machine;
> > > +extern int riscv_patch_in_spinlock_init;
> > >
> > >  #endif /* _ASM_RISCV_PATCH_H */
> > > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_=
label.c
> > > index 6eee6f736f68..d9a5a5c1933d 100644
> > > --- a/arch/riscv/kernel/jump_label.c
> > > +++ b/arch/riscv/kernel/jump_label.c
> > > @@ -36,9 +36,11 @@ bool arch_jump_label_transform_queue(struct
> > > jump_entry *entry,
> > >                 insn =3D RISCV_INSN_NOP;
> > >         }
> > >
> > > -       mutex_lock(&text_mutex);
> > > +       if (!riscv_patch_in_spinlock_init)
> > > +               mutex_lock(&text_mutex);
> > >         patch_insn_write(addr, &insn, sizeof(insn));
> > > -       mutex_unlock(&text_mutex);
> > > +       if (!riscv_patch_in_spinlock_init)
> > > +               mutex_unlock(&text_mutex);
> > >
> > >         return true;
> > >  }
> > > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > > index db13c9ddf9e3..ab009cf855c2 100644
> > > --- a/arch/riscv/kernel/patch.c
> > > +++ b/arch/riscv/kernel/patch.c
> > > @@ -24,6 +24,7 @@ struct patch_insn {
> > >  };
> > >
> > >  int riscv_patch_in_stop_machine =3D false;
> > > +int riscv_patch_in_spinlock_init =3D false;
> > >
> > >  #ifdef CONFIG_MMU
> > >
> > > @@ -131,7 +132,7 @@ static int __patch_insn_write(void *addr, const
> > > void *insn, size_t len)
> > >          * safe but triggers a lockdep failure, so just elide it for =
that
> > >          * specific case.
> > >          */
> > > -       if (!riscv_patch_in_stop_machine)
> > > +       if (!riscv_patch_in_stop_machine && !riscv_patch_in_spinlock_=
init)
> > >                 lockdep_assert_held(&text_mutex);
> > >
> > >         preempt_disable();
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 016b48fcd6f2..87ddf1702be4 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -268,7 +268,9 @@ static void __init riscv_spinlock_init(void)
> > >         }
> > >  #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > >         else {
> > > +               riscv_patch_in_spinlock_init =3D 1;
> > >                 static_branch_disable(&qspinlock_key);
> > > +               riscv_patch_in_spinlock_init =3D 0;
> > >                 pr_info("Ticket spinlock: enabled\n");
> > >                 return;
> > >         }
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> >=20
> > Thanks Guo for looking into this.
> >=20
> > Your solution is not very pretty but I don't have anything better :/
> > Unless introducing a static_branch_XXX_nolock() API? I gave it a try
> > and it fixes the issue, but not sure this will be accepted.
> >=20
> > The thing is the usage of static branches is temporary, we'll use
> > alternatives when I finish working on getting the extensions very
> > early from the ACPI tables (I have a poc that works, just needs some
> > cleaning).
> >=20
> > So let's say that I make this early extension parsing my priority for
> > 6.14, can we live with Guo's hack in this release? Or should we revert
> > this commit?
>=20
> I tried this diff, and it doesn't actually fix the problem - either in
> QEMU or in hardware. I'll do some more poking.

Looks like it might have been my fault, typo while hand-applying the
diff pasted above cos it was corrupted :/ Rebuilding..


--8D3RDN+sWC/y/ujQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0mo8AAKCRB4tDGHoIJi
0q26APwK38frDwHBEPG1LVhfSrxH2viC9XJIFs1SeoRddcrkKAEAz2yoRk3oBdSG
7i00W5kraUTFBYZaVj1lxtNJRmDqHgw=
=aEjS
-----END PGP SIGNATURE-----

--8D3RDN+sWC/y/ujQ--

