Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF911AD5D
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 15:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfLKOZE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 09:25:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38680 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfLKOZE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 09:25:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so1896834pfc.5
        for <linux-arch@vger.kernel.org>; Wed, 11 Dec 2019 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=098L4qWOo/dhHj7up13Q/6AGsTiEtq7zvqd33y20xho=;
        b=bFMQWnI1gXtKeiW21Ws8EHVoOcE5cqQ2w2Df6osYM/2xsfsIpAWPWYxCufyaZoj4DI
         DbCCvWw90Y+crXFC3bZL94l5YRUG0RBgiyIIz5kKgQW7pxE7sq8fpJ+ADLtnfSGsn3IH
         hE2VnMFgCaV4BtHbpbf2+z09SPak4lBeQ7Txw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=098L4qWOo/dhHj7up13Q/6AGsTiEtq7zvqd33y20xho=;
        b=J8auFIdM9OYrFm59reLEvouebONXlNnKowmmpU/piIabl0ZN8uUW3+XDh4htIcEGfZ
         GmjV8RuANAFtvxpJhaHR/X+jRNB5UG0HL7ZICPSk+wgBQ4nOCOi5vt8rYuwDcJbJac0B
         VGM3ncHWYdB5cFYt/HAVCnRhvTjYHm7o2D/BEMpoozJfOG903mExp7z1Y6qHOWJvxCd8
         W638owAzyxmH+K08zS19F7jr3Ts2/9GEKxYLxdMrbkqI3lvskv3uJAYxd9GqWX0tTkcP
         Z0jHI+7xyNHVzNoR/omB75XG13R9QLj1DmAcLIU+N+U9B7UNIfbXxn/g8vlu7pPxWeXG
         oCVw==
X-Gm-Message-State: APjAAAVAYyRRNnO/Ptzp3D0KF2q/XJjX95yEPwAG5nqN5+mu845Phbv1
        ii7mMEZHT3Mauz1vyLc/N6cm8A==
X-Google-Smtp-Source: APXvYqxPxi+KaqBazUZaoJTrv1EEot9gnqUhrYprkTIb3+HbLUJJUrb1vIdkZL8Y+vj7jHi2BsmD6w==
X-Received: by 2002:a65:6916:: with SMTP id s22mr4325069pgq.244.1576074303700;
        Wed, 11 Dec 2019 06:25:03 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b116-2689-a4a9-76f8.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b116:2689:a4a9:76f8])
        by smtp.gmail.com with ESMTPSA id j16sm3395784pfi.165.2019.12.11.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:25:02 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
References: <20191210044714.27265-1-dja@axtens.net> <20191210044714.27265-5-dja@axtens.net> <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com> <875zincu8a.fsf@dja-thinkpad.axtens.net> <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
Date:   Thu, 12 Dec 2019 01:24:59 +1100
Message-ID: <87wob3aqis.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Balbir,

>>>> +Discontiguous memory can occur when you have a machine with memory spread
>>>> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
>>>> +
>>>> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
>>>> + - then there's a gap,
>>>> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
>>>> +
>>>> +This can create _significant_ issues:
>>>> +
>>>> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
>>>> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
>>>> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
>>>> +   region. But when we try to access any of that, we'll try to access pages
>>>> +   that are not physically present.
>>>> +
>>>
>>> If we reserved memory for KASAN from each node (discontig region), we might survive
>>> this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
>>> out loud.
>> 
>> The challenge is that - AIUI - in inline instrumentation, the compiler
>> doesn't generate calls to things like __asan_loadN and
>> __asan_storeN. Instead it uses -fasan-shadow-offset to compute the
>> checks, and only calls the __asan_report* family of functions if it
>> detects an issue. This also matches what I can observe with objdump
>> across outline and inline instrumentation settings.
>> 
>> This means that for this sort of thing to work we would need to either
>> drop back to out-of-line calls, or teach the compiler how to use a
>> nonlinear, NUMA aware mem-to-shadow mapping.
>
> Yes, out of line is expensive, but seems to work well for all use cases.

I'm not sure this is true. Looking at scripts/Makefile.kasan, allocas,
stacks and globals will only be instrumented if you can provide
KASAN_SHADOW_OFFSET. In the case you're proposing, we can't provide a
static offset. I _think_ this is a compiler limitation, where some of
those instrumentations only work/make sense with a static offset, but
perhaps that's not right? Dmitry and Andrey, can you shed some light on
this?

Also, as it currently stands, the speed difference between inline and
outline is approximately 2x, and given that we'd like to run this
full-time in syzkaller I think there is value in trading off speed for
some limitations.

> BTW, the current set of patches just hang if I try to make the default
> mode as out of line

Do you have CONFIG_RELOCATABLE?

I've tested the following process:

# 1) apply patches on a fresh linux-next
# 2) output dir
mkdir ../out-3s-kasan

# 3) merge in the relevant config snippets
cat > kasan.config << EOF
CONFIG_EXPERT=y
CONFIG_LD_HEAD_STUB_CATCH=y

CONFIG_RELOCATABLE=y

CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y

CONFIG_PHYS_MEM_SIZE_FOR_KASAN=2048
EOF

ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- ./scripts/kconfig/merge_config.sh -O ../out-3s-kasan/ arch/powerpc/configs/pseries_defconfig arch/powerpc/configs/le.config kasan.config

# 4) make
make O=../out-3s-kasan/ ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- -j8 vmlinux

# 5) test
qemu-system-ppc64  -m 2G -M pseries -cpu power9  -kernel ../out-3s-kasan/vmlinux  -nographic -chardev stdio,id=charserial0,mux=on -device spapr-vty,chardev=charserial0,reg=0x30000000 -initrd ./rootfs-le.cpio.xz -mon chardev=charserial0,mode=readline -nodefaults -smp 4 

This boots fine for me under TCG and KVM, with both CONFIG_KASAN_OUTLINE
and CONFIG_KASAN_INLINE. You do still need to supply the size even in
outline mode - I don't have code that switches over to vmalloced space
when in outline mode. I will clarify the docs on that.


>>>> +	if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
>>>> +		kasan_memory_size =
>>>> +			((phys_addr_t)CONFIG_PHYS_MEM_SIZE_FOR_KASAN << 20);
>>>> +
>>>> +		if (top_phys_addr < kasan_memory_size) {
>>>> +			/*
>>>> +			 * We are doomed. Attempts to call e.g. panic() are
>>>> +			 * likely to fail because they call out into
>>>> +			 * instrumented code, which will almost certainly
>>>> +			 * access memory beyond the end of physical
>>>> +			 * memory. Hang here so that at least the NIP points
>>>> +			 * somewhere that will help you debug it if you look at
>>>> +			 * it in qemu.
>>>> +			 */
>>>> +			while (true)
>>>> +				;
>>>
>>> Again with the right hooks in check_memory_region_inline() these are recoverable,
>>> or so I think
>> 
>> So unless I misunderstand the circumstances in which
>> check_memory_region_inline is used, this isn't going to help with inline
>> instrumentation.
>> 
>
> Yes, I understand. Same as above?

Yes.

>>> NOTE: I can't test any of these, well may be with qemu, let me see if I can spin
>>> the series and provide more feedback
>> 
>> It's actually super easy to do simple boot tests with qemu, it works fine in TCG,
>> Michael's wiki page at
>> https://github.com/linuxppc/wiki/wiki/Booting-with-Qemu is very helpful.
>> 
>> I did this a lot in development.
>> 
>> My full commandline, fwiw, is:
>> 
>> qemu-system-ppc64  -m 8G -M pseries -cpu power9  -kernel ../out-3s-radix/vmlinux  -nographic -chardev stdio,id=charserial0,mux=on -device spapr-vty,chardev=charserial0,reg=0x30000000 -initrd ./rootfs-le.cpio.xz -mon chardev=charserial0,mode=readline -nodefaults -smp 4
>
> qemu has been crashing with KASAN enabled/ both inline/out-of-line options. I am running linux-next + the 4 patches you've posted. In one case I get a panic and a hang in the other. I can confirm that when I disable KASAN, the issue disappears

Hopefully my script above can help narrow that down.

Regards,
Daniel
