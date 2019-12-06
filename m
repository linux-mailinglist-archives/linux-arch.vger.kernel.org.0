Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2670D115684
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 18:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLFR3m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 12:29:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:36000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfLFR3m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 12:29:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE2E9ABC7;
        Fri,  6 Dec 2019 17:29:39 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de
Subject: Re: [PATCH v5 0/3] sysfs: add sysfs based cpuinfo
Date:   Fri, 06 Dec 2019 18:29:39 +0100
Message-ID: <2898795.Dnvf4huJ59@skinner.arch.suse.de>
In-Reply-To: <20191206165803.GD21671@lakrids.cambridge.arm.com>
References: <20191206162421.15050-1-trenn@suse.de> <20191206165803.GD21671@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday, December 6, 2019 5:58:03 PM CET Mark Rutland wrote:
> Hi Thomas,
> 
> On Fri, Dec 06, 2019 at 05:24:18PM +0100, Thomas Renninger wrote:
> > I picked up Felix Schnizlein's work from 2017.
> > 
> > It was already reviewed by Greg-KH at this time and even
> > pushed into linux-next tree, when it came out that the mails
> > never reached lkml, even the list was added to CC.
> > 
> > ARM people then correctly complained that this needs more review
> > by ARCH people. It got reverted, Felix had no time anymore and this
> > nice patcheset was hanging around nowhere...
> 
> Can you please provide a rationale for this?

/proc moves to /sys. For years already, some data needs longer...

If you compare /proc/cpuinfo between different archs, you realize
that it is rather different and a huge mess of arbitrary info.

It would be great if people think a bit more about this...
What else could show up on which architecture to avoid different
interfaces (sys files) with the same info across architectures.

I'd like to have general CPU identification, and other info like
bugs, flags or whatever info that exists across architectures in one
sysfs file/directory.

arch=$(uname -m)
case $arch in
   x86_64)
      cat /sys/devices/system/cpu/cpu0/info/name
      ;;
   aarch64)
      cat /sys/devices/system/cpu/cpu0/regs/identification
      ::
   ...
esac

This is better than grepping on different identifiers in huge /proc/cpuinfo,
but it still is lame.

Ideal would be:
/sys/devices/system/cpu/cpu0/info/{name,vendor,flags,bugs,base_freq,...}
being avail for all CPUs on all archs.

if it does not exist yet..., it should at least show up there if it gets
implemented at some point of time.

> there's some data in /proc/cpuinfo that I think makes no sense to try to
> export export in a structured way (e.g. bogomips).

I'd be happy to remove bogomips if nobody needs this.

> 
> > Tested on aarch64:
> > 
> > /sys/devices/system/cpu/cpu1/info/:[0]# ls
> > architecture  bogomips  flags  implementer  part  revision  variant
> > 
> > ------------------------------------------------------------
> > 
> > for file in *;do echo $file; cat $file;echo;done
> > architecture
> > 8
> > 
> > bogomips
> > 40.00
> > 
> > flags
> > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> > 
> > implementer
> > 0x51
> > 
> > part
> > 0xc00
> > 
> > revision
> > 1
> > 
> > variant
> > 0x0
> 
> For arm64 we already expose the MIDR and REVIDR register values under
> /sys/devices/system/cpu/cpu*/regs/identification, and that's the bulk of
> the useful information above

I'd like to come up with an extra CONFIG which parses:

arch/arm64/include/asm/cputype.h:

#define ARM_CPU_PART_AEM_V8             0xD0F
#define ARM_CPU_PART_FOUNDATION         0xD00
#define ARM_CPU_PART_CORTEX_A57         0xD07
#define ARM_CPU_PART_CORTEX_A72         0xD08

and

#define ARM_CPU_IMP_ARM                 0x41
#define ARM_CPU_IMP_APM                 0x50
#define ARM_CPU_IMP_CAVIUM              0x43
#define ARM_CPU_IMP_BRCM                0x42
#define ARM_CPU_IMP_QCOM                0x51
#define ARM_CPU_IMP_NVIDIA              0x4E

and converts the defines to strings, same as here:

arch/x86/include/asm/intel-family.h

#define INTEL_FAM6_SKYLAKE_L            0x4E
#define INTEL_FAM6_SKYLAKE              0x5E
#define INTEL_FAM6_SKYLAKE_X            0x55
#define INTEL_FAM6_KABYLAKE_L           0x8E
#define INTEL_FAM6_KABYLAKE             0x9E

and provide the model name (and for ARM the vendor name)
compiled in a module.

At least for aarch64 and x86 it seem to be possible
to get a vendor/model string from the same defined file:
/sys/devices/system/cpu/cpu0/info/{model_name,vendor}


> (aside from the flags/hwcaps).

which make sense to add there, right?

Thanks,

      Thomas



