Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18F2A3269
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgKBR7E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 12:59:04 -0500
Received: from foss.arm.com ([217.140.110.172]:35720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgKBR7D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 12:59:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29351139F;
        Mon,  2 Nov 2020 09:59:03 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3923F719;
        Mon,  2 Nov 2020 09:59:01 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:58:59 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] arm64: kvm: Handle Asymmetric AArch32 systems
Message-ID: <20201102175859.22flailfpntacan6@e107158-lin.cambridge.arm.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-2-qais.yousef@arm.com>
 <4035e634eb2bfce4b88a159b2ec2f267@kernel.org>
 <20201021133543.zeyghjzujivnds2d@e107158-lin>
 <87587dbfb7bee53eca4d1b837fd8194a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87587dbfb7bee53eca4d1b837fd8194a@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc

On 10/21/20 14:51, Marc Zyngier wrote:
> > > >
> > > > 	# ./test
> > > > 	error: kvm run failed Invalid argument
> > > > 	 PC=ffff800010945080 X00=ffff800016a45014 X01=ffff800010945058
> > > > 	X02=ffff800016917190 X03=0000000000000000 X04=0000000000000000
> > > > 	X05=00000000fffffffb X06=0000000000000000 X07=ffff80001000bab0
> > > > 	X08=0000000000000000 X09=0000000092ec5193 X10=0000000000000000
> > > > 	X11=ffff80001608ff40 X12=ffff000075fcde86 X13=ffff000075fcde88
> > > > 	X14=ffffffffffffffff X15=ffff00007b2105a8 X16=ffff00007b006d50
> > > > 	X17=0000000000000000 X18=0000000000000000 X19=ffff00007a82b000
> > > > 	X20=0000000000000000 X21=ffff800015ccd158 X22=ffff00007a82b040
> > > > 	X23=ffff00007a82b008 X24=0000000000000000 X25=ffff800015d169b0
> > > > 	X26=ffff8000126d05bc X27=0000000000000000 X28=0000000000000000
> > > > 	X29=ffff80001000ba90 X30=ffff80001093f3dc  SP=ffff80001000ba90
> > > > 	PSTATE=60000005 -ZC- EL1h
> > > > 	qemu-system-aarch64: Failed to get KVM_REG_ARM_TIMER_CNT
> > > 
> > > It'd be worth working out:
> > > - why does this show an AArch64 mode it we caught the vcpu in AArch32?
> > > - why does QEMU shout about the timer register?
> > 
> > /me puts a monocular on
> > 
> > Which bit is the AArch64?
> 
> It clearly spits out "EL1h", and PSTATE.M is 5, also consistent with EL1h.

Apologies for the delay to look at the reason on failing to read the timer
register.

Digging into the qemu 5.0.0 code, the error message is printed from
kvm_arm_get_virtual_time() which in turn is called from
kvm_arm_vm_state_change(). The latter is a callback function that is called
when a vm starts/stop.

So the sequence of events is:

	VM runs 32bit apps
	  host resets vcpu->arch.target to -1
	    qemu::kvm_cpu_exec() hits -EINVAL error (somewhere I didn't trace)
	      kvm_cpu_exec()::cpu_dump_state()
	      kvm_cpu_exec()::vm_stop()
	        ..
	          kvm_arm_vm_state_change()
	            kvm_arm_get_virtual_time()
	              host return -ENOEXEC
	                above error message is printed
	                abort()

I admit I didn't trace qemu to see what's going inside it. It was only
statically analysing the code. To verify the theory I applied the following
hack to hide the timer register error

	diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
	index 5d2a1caf55a0..1c8fdf6566ea 100644
	--- a/arch/arm64/kvm/arm.c
	+++ b/arch/arm64/kvm/arm.c
	@@ -1113,7 +1113,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
		case KVM_GET_ONE_REG: {
			struct kvm_one_reg reg;

	-               r = -ENOEXEC;
	+               r = 0;
			if (unlikely(!kvm_vcpu_initialized(vcpu)))
				break;

With that I see the following error from qemu after which it seems to have
'hanged'. I can terminate qemu with the usual <ctrl-a>x. So it's not dead, just
the vm has exited I suppose and qemu went into monitor mode or something.

	error: kvm run failed Invalid argument
	 PC=ffff8000109ca100 X00=ffff800016ff5014 X01=ffff8000109ca0d8
	X02=ffff800016daae80 X03=0000000000000000 X04=0000000000000003
	X05=0000000000000000 X06=0000000000000000 X07=ffff800016e2bae0
	X08=00000000ffffffff X09=ffff8000109c4410 X10=0000000000000000
	X11=ffff8000164fb9c8 X12=ffff0000458ad186 X13=ffff0000458ad188
	X14=ffffffffffffffff X15=ffff000040268560 X16=0000000000000000
	X17=0000000000000001 X18=0000000000000000 X19=ffff0000458c0000
	X20=0000000000000000 X21=ffff0000458c0048 X22=ffff0000458c0008
	X23=ffff800016103a38 X24=0000000000000000 X25=ffff800016150a38
	X26=ffff800012a510d8 X27=ffff8000129504e0 X28=0000000000000000
	X29=ffff800016e2bac0 X30=ffff8000109c4410  SP=ffff000040268000
	PSTATE=834853a0 N--- EL0t

Which hopefully is what you expected to see in the first place.

Note that qemu v4.1.0 code didn't have this kvm_arm_get_virtual_time()
function. It seems to be a relatively new addition.

Also note that kvm_cpu_exec() in qemu completely ignores ARM_EXCEPTION_IL; the
kvm_arch_handle_exit() for arm only catches KVM_EXIT_DEBUG and returns 0 for
everything else. So kvm_cpu_exec() will jump back the loop to reenter the
guest. I haven't traced it but it seems to fail before calling:

	run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);

where return -ENOEXEC for invalid kvm_vcpu_initialized() in this path not
-EINVAL.

So all in all, a lot of qemu specific handling and not sure if there's any
guarantee how things will fail for different virtualization software. But
I think there's a guarantee that they will fail.

Thanks

--
Qais Yousef
