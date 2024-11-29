Return-Path: <linux-arch+bounces-9188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4C9DC2B1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA88EB22977
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5202199254;
	Fri, 29 Nov 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/jNutQ4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656F1586C8;
	Fri, 29 Nov 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879111; cv=none; b=D58ztP9DJpQ6ZURSh+VF7QhFF4MF+9Qi7kruPaFjpoh5zfE1Gkgm16j1qLzBqgMHDtjY9kX0GUJ7fRQgJT5CcUfgeqNmTrZu+LDVVbeGBqeljuDyOT9jYEBqm5LzAzujvnTxVlvtNFkogyDMqqZnvXn0t4LwowSvr1ip90HPp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879111; c=relaxed/simple;
	bh=4AMfUYtcpnRLc2QwYbx/fZu6IxFG6owmCPVZbnSbaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOwsY9Z9dn9WUW6pdYSmN55SOJD4qQCZzMIJYT2VFr97D0jdepQSSAcimKEcJdiTXuTMSu29RqiLyl8og4iimjTPZRkwnI06ltW7ROzhHdLeUN5Xz7a1EdPw85cjUrWXSP9fmL6YzD7YGEL8PUsMugEFiKYx3udoIFtrUej/TgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/jNutQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11356C4CECF;
	Fri, 29 Nov 2024 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732879111;
	bh=4AMfUYtcpnRLc2QwYbx/fZu6IxFG6owmCPVZbnSbaC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/jNutQ4fZK6SQN3ZR1XFrV9FeEYywGnE6MyFnZyfXDE0tXVDz/OdsIb3U5gwDLb0
	 dhIYbOCvAuRRC0fhB6A+ZwmMDbiUIHowPbg5OVFmVrfKwrnBOdjryjdhKe1N3F8Orj
	 zSpFBOo1U/V6gsR4YOEL32fhXBYmd5qswgLdIUq4/NORDcaMG9r3ylkX8aNAi1zDwq
	 xCI2t0iFZbqRrbdw4HeNuc5gXmBjJb5qs83rTP/PTW7qsEzFjHtWZVrhVGa4bMXufI
	 VKMRyK2OaJiH31PHWl2gWPjrhYCX74rd/et2kDTH5BSV3Zgj53CLAIiZ+WEWEpkdOd
	 BvfL9dEOZ6qYw==
Date: Fri, 29 Nov 2024 11:18:24 +0000
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
Message-ID: <20241129-encrust-thumping-b6c6a3399b98@spud>
References: <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck>
 <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>
 <20241128-goggles-laundry-d94c23ab39a4@spud>
 <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
 <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
 <CAJF2gTSX82rGp-9xZHvg1Y3SpO516YCcqSBLKFgWEQ5G-iWR4A@mail.gmail.com>
 <CAHVXubgXiD5Bi6ytyDHXXOONovWHZTSvr4+oADCvuic5ObGXpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubCAe+RbVYt6+Gq3"
Content-Disposition: inline
In-Reply-To: <CAHVXubgXiD5Bi6ytyDHXXOONovWHZTSvr4+oADCvuic5ObGXpQ@mail.gmail.com>


--ubCAe+RbVYt6+Gq3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:31:44AM +0100, Alexandre Ghiti wrote:
> Hi everyone,
>=20
> On Fri, Nov 29, 2024 at 7:28=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Conor & Alexandre,
> >
> > On Fri, Nov 29, 2024 at 10:58=E2=80=AFAM Guo Ren <guoren@kernel.org> wr=
ote:
> > >
> > > On Fri, Nov 29, 2024 at 8:55=E2=80=AFAM Guo Ren <guoren@kernel.org> w=
rote:
> > > >
> > > > On Fri, Nov 29, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kernel=
=2Eorg> wrote:
> > > > >
> > > > > On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> > > > > > On 28/11/2024 15:14, Conor Dooley wrote:
> > > > > > > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > > > > > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrot=
e:
> > > > > > > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti=
 wrote:
> > > > > > > > > > In order to produce a generic kernel, a user can select
> > > > > > > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime t=
o the ticket
> > > > > > > > > > spinlock implementation if Zabha or Ziccrse are not pre=
sent.
> > > > > > > > > >
> > > > > > > > > > Note that we can't use alternatives here because the di=
scovery of
> > > > > > > > > > extensions is done too late and we need to start with t=
he qspinlock
> > > > > > > > > > implementation because the ticket spinlock implementati=
on would pollute
> > > > > > > > > > the spinlock value, so let's use static keys.
> > > > > > > > > >
> > > > > > > > > > This is largely based on Guo's work and Leonardo review=
s at [1].
> > > > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/linux-riscv/2023122512584=
7.2778638-1-guoren@kernel.org/ [1]
> > > > > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > > > This patch (now commit ab83647fadae2 ("riscv: Add qspinlo=
ck support"))
> > > > > > > > > breaks boot on polarfire soc. It dies before outputting a=
nything to the
> > > > > > > > > console. My .config has:
> > > > > > > > >
> > > > > > > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > > > > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > > > > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > > > > > > I pointed out some of the fragility during review:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/all/20241111164259.GA20042@willie-t=
he-truck/
> > > > > > > >
> > > > > > > > so I'm kinda surprised it got merged tbh :/
> > > > > > > Maybe it could be reverted rather than having a broken boot w=
ith the
> > > > > > > default settings in -rc1.
> > > > > >
> > > > > >
> > > > > > No need to rush before we know what's happening,I guess you bis=
ected to this
> > > > > > commit right?
> > > > >
> > > > > The symptom is a failure to boot, without any console output, of =
course
> > > > > I bisected it before blaming something specific. But I don't thin=
k it is
> > > > > "rushing" as having -rc1 broken with an option's default is a mas=
sive pain
> > > > > in the arse when it comes to testing.
> > > > >
> > > > > > I don't have this soc, so can you provide $stval/$sepc/$scause,=
 a config, a
> > > > > > kernel, anything?
> > > > >
> > > > > I don't have the former cos it died immediately on boot. config is
> > > > > attached. It reproduces in QEMU so you don't need any hardware.
> > > > If QEMU could reproduce, could you provide a dmesg by the below met=
hod?
> > > >
> > > > Qemu cmd append: -s -S
> > > > ref: https://qemu-project.gitlab.io/qemu/system/gdb.html
> > > >
> > > > Connect gdb and in console:
> > > > 1. file vmlinux
> > > > 2. source ./Documentation/admin-guide/kdump/gdbmacros.txt
> > > > 3. dmesg
> > > >
> > > > Then, we could get the kernel's early boot logs from memory.
> > > I've reproduced it on qemu, thx for the config.
> > >
> > > Reading symbols from ../build-rv64lp64/vmlinux...
> > > (gdb) tar rem:1234
> > > Remote debugging using :1234
> > > ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.=
h:49
> > > 49              atomic_cond_read_acquire(&lock->val, ticket =3D=3D (u=
16)VAL);
> > > (gdb) bt
> > > #0  ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.=
h:49
> > > #1  arch_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/arch/riscv/include/asm/spinlock.h:28
> > > #2  do_raw_spin_lock (lock=3Dlock@entry=3D0xffffffff81b9a5b8 <text_mu=
tex>)
> > > at /home/guoren/source/kernel/linux/kernel/locking/spinlock_debug.c:1=
16
> > > #3  0xffffffff80b2ea0e in __raw_spin_lock_irqsave
> > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/include/linux/spinlock_api_smp.h:111
> > > #4  _raw_spin_lock_irqsave (lock=3Dlock@entry=3D0xffffffff81b9a5b8
> > > <text_mutex>) at
> > > /home/guoren/source/kernel/linux/kernel/locking/spinlock.c:162
> > > #5  0xffffffff80b27c54 in rt_mutex_slowtrylock
> > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1393
> > > #6  0xffffffff80b295ea in rt_mutex_try_acquire
> > > (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:319
> > > #7  __rt_mutex_lock (state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex=
>) at
> > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1805
> > > #8  __mutex_lock_common (ip=3D18446744071562135170, nest_lock=3D0x0,
> > > subclass=3D0, state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) at
> > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:518
> > > #9  mutex_lock_nested (lock=3D0xffffffff81b9a5b8 <text_mutex>,
> > > subclass=3Dsubclass@entry=3D0) at
> > > /home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:529
> > > #10 0xffffffff80010682 in arch_jump_label_transform_queue
> > > (entry=3Dentry@entry=3D0xffffffff8158da28, type=3D<optimized out>) at
> > > /home/guoren/source/kernel/linux/arch/riscv/kernel/jump_label.c:39
> > > #11 0xffffffff801d86b2 in __jump_label_update
> > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>,
> > > entry=3D0xffffffff8158da28, stop=3Dstop@entry=3D0xffffffff815a5e68
> > > <__tracepoint_ptr_initcall_finish>, init=3Dinit@entry=3Dtrue)
> > >     at /home/guoren/source/kernel/linux/kernel/jump_label.c:513
> > > #12 0xffffffff801d890c in jump_label_update
> > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > /home/guoren/source/kernel/linux/kernel/jump_label.c:920
> > > #13 0xffffffff801d8be8 in static_key_disable_cpuslocked
> > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > /home/guoren/source/kernel/linux/kernel/jump_label.c:240
> > > #14 0xffffffff801d8c04 in static_key_disable
> > > (key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
> > > /home/guoren/source/kernel/linux/kernel/jump_label.c:248
> > > #15 0xffffffff80c04a1a in riscv_spinlock_init () at
> > > /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:271
> > > #16 setup_arch (cmdline_p=3Dcmdline_p@entry=3D0xffffffff81a03e88) at
> > > /home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:336
> > > #17 0xffffffff80c007a2 in start_kernel () at
> > > /home/guoren/source/kernel/linux/init/main.c:922
> > > #18 0xffffffff80001164 in _start_kernel ()
> > > Backtrace stopped: frame did not save the PC
> > > (gdb) p /x lock
> > > $1 =3D 0xffffffff81b9a5b8
> > > (gdb) p /x *lock
> > > $2 =3D {{val =3D {counter =3D 0x20000}, {locked =3D 0x0, pending =3D =
0x0},
> > > {locked_pending =3D 0x0, tail =3D 0x2}}}
> >
> > I have for you here a fast fixup for reference. (PS: I'm digging into
> > the root cause mentioned by Will Deacon.)
> >
> > diff --git a/arch/riscv/include/asm/text-patching.h
> > b/arch/riscv/include/asm/text-patching.h
> > index 7228e266b9a1..0439609f1cff 100644
> > --- a/arch/riscv/include/asm/text-patching.h
> > +++ b/arch/riscv/include/asm/text-patching.h
> > @@ -12,5 +12,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t le=
n);
> >  int patch_text(void *addr, u32 *insns, size_t len);
> >
> >  extern int riscv_patch_in_stop_machine;
> > +extern int riscv_patch_in_spinlock_init;
> >
> >  #endif /* _ASM_RISCV_PATCH_H */
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_la=
bel.c
> > index 6eee6f736f68..d9a5a5c1933d 100644
> > --- a/arch/riscv/kernel/jump_label.c
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -36,9 +36,11 @@ bool arch_jump_label_transform_queue(struct
> > jump_entry *entry,
> >                 insn =3D RISCV_INSN_NOP;
> >         }
> >
> > -       mutex_lock(&text_mutex);
> > +       if (!riscv_patch_in_spinlock_init)
> > +               mutex_lock(&text_mutex);
> >         patch_insn_write(addr, &insn, sizeof(insn));
> > -       mutex_unlock(&text_mutex);
> > +       if (!riscv_patch_in_spinlock_init)
> > +               mutex_unlock(&text_mutex);
> >
> >         return true;
> >  }
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index db13c9ddf9e3..ab009cf855c2 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -24,6 +24,7 @@ struct patch_insn {
> >  };
> >
> >  int riscv_patch_in_stop_machine =3D false;
> > +int riscv_patch_in_spinlock_init =3D false;
> >
> >  #ifdef CONFIG_MMU
> >
> > @@ -131,7 +132,7 @@ static int __patch_insn_write(void *addr, const
> > void *insn, size_t len)
> >          * safe but triggers a lockdep failure, so just elide it for th=
at
> >          * specific case.
> >          */
> > -       if (!riscv_patch_in_stop_machine)
> > +       if (!riscv_patch_in_stop_machine && !riscv_patch_in_spinlock_in=
it)
> >                 lockdep_assert_held(&text_mutex);
> >
> >         preempt_disable();
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 016b48fcd6f2..87ddf1702be4 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -268,7 +268,9 @@ static void __init riscv_spinlock_init(void)
> >         }
> >  #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> >         else {
> > +               riscv_patch_in_spinlock_init =3D 1;
> >                 static_branch_disable(&qspinlock_key);
> > +               riscv_patch_in_spinlock_init =3D 0;
> >                 pr_info("Ticket spinlock: enabled\n");
> >                 return;
> >         }
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>=20
> Thanks Guo for looking into this.
>=20
> Your solution is not very pretty but I don't have anything better :/
> Unless introducing a static_branch_XXX_nolock() API? I gave it a try
> and it fixes the issue, but not sure this will be accepted.
>=20
> The thing is the usage of static branches is temporary, we'll use
> alternatives when I finish working on getting the extensions very
> early from the ACPI tables (I have a poc that works, just needs some
> cleaning).
>=20
> So let's say that I make this early extension parsing my priority for
> 6.14, can we live with Guo's hack in this release? Or should we revert
> this commit?

I tried this diff, and it doesn't actually fix the problem - either in
QEMU or in hardware. I'll do some more poking.

--ubCAe+RbVYt6+Gq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0mjAAAKCRB4tDGHoIJi
0mrMAQDu0J0wjaAPpfwI8omx8Fr/N/9wr5rXG/2IqY3XFOHvHAEA1rj+KjV9Ur0k
M3AafRBDZUW93VE7dVlJB9XMGJhGmAI=
=ZAy+
-----END PGP SIGNATURE-----

--ubCAe+RbVYt6+Gq3--

