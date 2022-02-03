Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C784A8F91
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiBCVH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiBCVH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Feb 2022 16:07:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176FC061714;
        Thu,  3 Feb 2022 13:07:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643922477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=MEMnvnHnkMf+AB94UDPq1arCDfkDjD+5MTdgspuv7Zo=;
        b=pN00G5RrVwvI04u5A1b2A0/IZQjTb944dygodJI6XOC6dIr3+rHCphyAtrrWyaOh1Tq/t+
        AQamafRT0FGzptLtRqCb4IFguXUWkdHGa80ONKChNHxUZPd89nInQbkSS6godfgitEg3r6
        z5Q9HuulzF7Nu3SsTMPwmKURNncUXvE93ze8RHi358tKTf5vHi5I6qbY9lMIoWDyMDSB3L
        Vyso4O5kHAD+4lS7PynXdrlh2N/q72s0667gmedTRYGsTvTI/Naa1Hq/CxjjOU/l6Z/+MC
        iXxBNTUda2NvpMIbO41D5i6oNC1swu26v+XY6FIj2fHqlFM8kgBsmGj9FUn4Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643922477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=MEMnvnHnkMf+AB94UDPq1arCDfkDjD+5MTdgspuv7Zo=;
        b=mNls1vlBfKONaDiFSdBE0Eu1/jn9TFsND77LSqdjJTnYiTMMgOnqf0PNyo11cRb8kNXgY9
        fGssXDi/lNCQzxCA==
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Date:   Thu, 03 Feb 2022 22:07:56 +0100
Message-ID: <87fsozek0j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rick,

On Sun, Jan 30 2022 at 13:18, Rick Edgecombe wrote:
> This is a slight reboot of the userspace CET series. I will be taking ove=
r the=20
> series from Yu-cheng. Per some internal recommendations, I=E2=80=99ve res=
et the version
> number and am calling it a new series. Hopefully, it doesn=E2=80=99t cause
> confusion.

That's fine as it seems to be a major change in course, so a reset to V1
is justified. Don't worry about confusion, we can easily confuse ourself
with minor things than that version reset :)

> The new plan is to upstream only userspace Shadow Stack support at this p=
oint.=20
> IBT can follow later, but for now I=E2=80=99ll focus solely on the most i=
n-demand and
> widely available (with the feature on AMD CPUs now) part of CET.

We just have to keep in IBT mind so that we don't add roadblocks which
we regret some time later.

> I thought as part of this reset, it might be useful to more fully write-u=
p the=20
> design and summarize the history of the previous CET series. So this slig=
htly
> long cover letter does that. The "Updates" section has the changes, if an=
yone
> doesn't want the history.

Thanks for that lengthy writeup. It's appreciated. There is too much
confusion already so a coherent summary is helpful.

> Why is Shadow Stack Wanted
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> The main use case for userspace shadow stack is providing protection agai=
nst=20
> return oriented programming attacks. Fedora and Ubuntu already have many/=
most=20
> packages enabled for shadow stack.

Which is unfortunately part of the overall problem ...

> History
> =3D=3D=3D=3D=3D=3D=3D
> The branding =E2=80=9CCET=E2=80=9D really consists of two features: =E2=
=80=9CShadow Stack=E2=80=9D and=20
> =E2=80=9CIndirect Branch Tracking=E2=80=9D. They both restrict previously=
 allowed, but rarely=20
> valid behaviors and require userspace to change to avoid these behaviors =
before=20
> enabling the protection. These raw HW features need to be assembled into =
a=20
> software solution across userspace and kernel in order to add security va=
lue.
> The kernel part of this solution has evolved iteratively starting with a =
lengthy
> RFC period.=20
>
> Until now, the enabling effort was trying to support both Shadow Stack an=
d IBT.=20
> This history will focus on a few areas of the shadow stack development hi=
story=20
> that I thought stood out.
>
> 	Signals
> 	-------
> 	Originally signals placed the location of the shadow stack restore=20
> 	token inside the saved state on the stack. This was problematic from a=20
> 	past ABI promises perspective. So the restore location was instead just=
=20
> 	assumed from the shadow stack pointer. This works because in normal=20
> 	allowed cases of calling sigreturn, the shadow stack pointer should be=20
> 	right at the restore token at that time. There is no alternate shadow=20
> 	stack support. If an alt shadow stack is added later we would
> 	need to

So how is that going to work? altstack is not an esoteric corner case.

> 	Enabling Interface
> 	------------------
> 	For the entire history of the original CET series, the design was to=20
> 	enable shadow stack automatically if the feature bit was detected in=20
> 	the elf header. Then it was userspace=E2=80=99s responsibility to turn i=
t off=20
> 	via an arch_prctl() if it was not desired, and this was handled by the=20
> 	glibc dynamic loader. Glibc=E2=80=99s standard behavior (when CET if con=
figured=20
> 	is to leave shadow stack enabled if the executable and all linked=20
> 	libraries are marked with shadow stacks.
>
> 	Many distros (Fedora and others) have binaries already marked with=20
> 	shadow stack, waiting for kernel support. Unfortunately their glibc=20
> 	binaries expect the original arch_prctl() interface for allocating=20
> 	shadow stacks, as those changes were pushed ahead of kernel support.=20
> 	The net result of it all is, when updating to a kernel with shadow=20
> 	stack these binaries would suddenly get shadow stack enabled and expect=
=20
> 	the arch_prctl() interface to be there. And so calls to makecontext()=20
> 	will fail, resulting in visible breakages. This series deals with this=20
> 	problem as described below in "Updates".

I'm really impressed by the well thought out coordination on the glibc and
distro side. Designed by committee never worked ...

> Updates
> =3D=3D=3D=3D=3D=3D=3D
> These updates were mostly driven by public comments, but a lot of the des=
ign=20
> elements are new. I would like some extra scrutiny on the updates.
>
> 	New syscall for Shadow Stack Allocation
> 	---------------------------------------
> 	A new syscall is added for allocating shadow stacks to replace=20
> 	PROT_SHADOW_STACK. Several options were considered, as described in the=
=20
> 	=E2=80=9Cx86/cet/shstk: Introduce map_shadow_stack syscall=E2=80=9D.
>
> 	Xsave Managed Supervisor State Modifications
> 	--------------------------------------------
> 	The shadow stack feature requires the kernel to modify xsaves managed=20
> 	state. On one of the last versions of Yu-cheng=E2=80=99s series Boris ha=
d=20
> 	commented on the pattern it was using to do this not necessarily being=20
> 	ideal. The pattern was to force a restore to the registers and always=20
> 	do the modification there. Then Thomas did an overhaul of the fpu code,=
=20
> 	part of which consisted of making raw access to the xsave buffer=20
> 	private to the fpu code. So this series tries to expose access again,=20
> 	and in a way that addresses Boris=E2=80=99 comments.
>
> 	The method is to provide functions like wmsrl/rdmsrl, but that can=20
> 	direct the operation to the correct location (registers or buffer),=20
> 	while giving the proper notice to the fpu subsystem so things don=E2=80=
=99t get=20
> 	clobbered or corrupted.
>
> 	In the past a solution like this was discussed as part of the PASID=20
> 	series, and Thomas was not in favor. In CET=E2=80=99s case there is a mo=
re=20
> 	logic around the CET MSR=E2=80=99s than in PASID's, and wrapping this lo=
gic=20
> 	minimizes near identical open coded logic needed to do this more=20
> 	efficiently. In addition it resolves the above described problem of=20
> 	having no access to the xsave buffer. So it is being put forward here=20
> 	under the supposition that CET=E2=80=99s usage may lead to a different=20
> 	conclusion, not to try to ignore past direction.
>
> 	The user interrupt series has similar needs as CET, and will also use
> 	this internal interface if it=E2=80=99s found acceptable.

I'll have a look.

> 	Switch Enabling Interface
> 	-------------------------
> 	But there are existing downsides to automatic elf header processing=20
> 	based enabling. The elf header feature spec is not defined by the=20
> 	kernel and there are proposals to expand it to describe additional=20
> 	logic. A simpler interface where the kernel is simply told what to=20
> 	enable, and leaves all the decision making to userspace, is more=20
> 	flexible for userspace and simpler for the kernel. There also already=20
> 	needs to be an ARCH_X86_FEATURE_ENABLE arch_prctl() for WRSS (and=20
> 	likely LAM will use it too), so it avoids there being two ways to turn=20
> 	on these types of features. The only tricky part for shadow stack, is=20
> 	that it has to be enabled very early. Wherever the shadow stack is=20
> 	enabled, the app cannot return from that point, otherwise there will be=
=20
> 	a shadow stack violation. It turns out glibc can enable shadow stack=20
> 	this early, so it works nicely. So not automatically enabling any=20
> 	features in the elf header will cleanly disable all old binaries, which=
=20
> 	expect the kernel to enable CET features automatically. Then after the=20
> 	kernel changes are upstream, glibc can be updated to use the new
> 	interface. This is the solution implemented in this series.

Makes sense.

> 	Expand Commit Logs
> 	------------------
> 	As part of spinning up on this series, I found some of the commit logs=20
> 	did not describe the changes in enough detail for me understand their=20
> 	purpose. I tried to expand the logs and comments, where I had to go=20
> 	digging. Hopefully it=E2=80=99s useful.

Proper changelogs are always appreciated.
=09
> 	Limit to only Intel Processors
> 	------------------------------
> 	Shadow stack is supported on some AMD processors, but this revision=20
> 	(with expanded HW usage and xsaves changes) has only has been tested on=
=20
> 	Intel ones. So this series has a patch to limit shadow stack support to=
=20
> 	Intel processors. Ideally the patch would not even make it to mainline,=
=20
> 	and should be dropped as soon as this testing is done. It's included=20
> 	just in case.

Ha. I can give you access to an AMD machine with CET SS supported :)

> Future Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Even though this is now exclusively a shadow stack series, there is still=
 some=20
> remaining shadow stack work to be done.
>
> 	Ptrace
> 	------
> 	Early in the series, there was a patch to allow IA32_U_CET and
> 	IA32_PL3_SSP to be set. This patch was dropped and planned as a follow
> 	up to basic support, and it remains the plan. It will be needed for
> 	in-progress gdb support.

It's pretty much a prerequisite for enabling it, right?

> 	CRIU Support
> 	------------
> 	In the past there was some speculation on the mailing list about=20
> 	whether CRIU would need to be taught about CET. It turns out, it does.=20
> 	The first issue hit is that CRIU calls sigreturn directly from its=20
> 	=E2=80=9Cparasite code=E2=80=9D that it injects into the dumper process.=
 This violates
> 	this shadow stack implementation=E2=80=99s protection that intends to pr=
event
> 	attackers from doing this.
>
> 	With so many packages already enabled with shadow stack, there is=20
> 	probably desire to make it work seamlessly. But in the meantime if=20
> 	distros want to support shadow stack and CRIU, users could manually=20
> 	disabled shadow stack via =E2=80=9CGLIBC_TUNABLES=3Dglibc.cpu.x86_shstk=
=3Doff=E2=80=9D for=20
> 	a process they will wants to dump. It=E2=80=99s not ideal.
>
> 	I=E2=80=99d like to hear what people think about having shadow stack in =
the=20
> 	kernel without this resolved. Nothing would change for any users until=20
> 	they enable shadow stack in the kernel and update to a glibc configured
> 	with CET. Should CRIU userspace be solved before kernel support?

Definitely yes. Making CRIU users add a glibc tunable is not really an
option. We can't break CRIU systems with a kernel upgrade.

Thanks,

        tglx


