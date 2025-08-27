Return-Path: <linux-arch+bounces-13295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47DB37A9B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 08:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BDA7B266F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Aug 2025 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732E53128A5;
	Wed, 27 Aug 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUXpN5Ff"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1942FAC1F
	for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276953; cv=none; b=S3bD0cppm05kcGrzGKKwk4Q9Kt9AW29MAqnlb/fCn1SNIhqr++leUybu5i164ATzPNN08JrJly+0kbjcJYTQFVL1mE2yC9N+pM11lf0/0DPtNO3pZugynncHW0PqRdAWq8dEAZ+aUtOT3ZNOZsRRcsUJVAGpfTQc4nxkW/MxMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276953; c=relaxed/simple;
	bh=QN2W3dvP8dha/wBP+V6kbG0lQVJkXvPwGE4aduyhZfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDQBMCvfTyezytr1s+4oWlCy0J3uSB9OL5zONhjq3sVm5uXF8xjURBIG7EXPo/5JvDuiPfkGHOkAVn9p+lE9XFX0dfVqthZrnwgFSJ8GjEwd/5KmPkbj9LOXBTVzW3+Cvh55/hoYNExAzZRBHqkXbdbt7WBEjVEn/6cO5orfOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUXpN5Ff; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso7575204a12.1
        for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756276948; x=1756881748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4AF+Z8QELxaFzdK5UESWjmAKEccgiFEItCe+oHlNao=;
        b=WUXpN5Ff0gaH5nvweD2mb6K/+vhpEFmgkT7dWXJ3jDAZ3aWNY6aoDHW7HikjQgrbu6
         EFw+w4LCDT4uWPcDKzH7D3Hwrv0aqsxxcScABhgRSzDmgBot/Q3Su3t7hmOpnPYWEqRj
         EN057kxNWTqce2ylZyGDofCd3f1d3zkXghcr3WM5qiqbHTRAKkMUa5IbeSGJowQbsA9l
         HbmFhcHmp2hkYMIHu7FZdsPCt2Z1eZLue7020VDgIib1G3iGHzgjQu0+z8L9+ifV4gLy
         UU3AWYX6BTD6qbR1Gr4IJzLipBDPutIoAFWKZz9Dt2G05BPz8oZyQd4DQg5TITpPe1io
         NVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756276948; x=1756881748;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4AF+Z8QELxaFzdK5UESWjmAKEccgiFEItCe+oHlNao=;
        b=ps0FHWZ8AkotipA01QZ9ais9ULOE+q0fRApKGgClzufkZ0J9vRxEQpkufYzkDm1hTC
         0xQF7cmWOLju0O0+Zq3diRkDf5aL3mz8tZEp03uBbGCwZb1PpKZ6pSgyrkDqw3JVARj2
         u3Isux6IDgkTTVEWDWHUP+fHUOMBQ36tzBeA/sASjcxVoT+OkWrW32mFd4WErYD42iDM
         8AhmifY/V7D1KSQG0w48575Fb01z9h5eixj9FcdUtRRue5/+rKQOGT3TWiyrNDVkx+W+
         /cLFJo36KOVL+73ieo2yt0tJZk1n/MZkPtdNT9itiI8RJJX7ZboVFaauPrWeBbEnpncu
         QQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUa8Q4zkdL2QPvYUmPlzNJTmOy4ONCm2MymhVGiC5IV3IT5mnQLRpHx9Ni8aOkciWkykp6ciOWCeDID@vger.kernel.org
X-Gm-Message-State: AOJu0YyK75yEqAWYy4vro2FeF2c0MVCToUi4i6E63EyJ8CQ78z/zY0Wh
	gf9EYN+GAvGNuyKva0jkpLYn8in9t2m4rOs2nm+aQEalJ8wlH0KMDKmmiXwIG5DlUoA=
X-Gm-Gg: ASbGncvjKAnFv8MtU+uHQ+ZfB5Kvw3SJoukskElXllEXm/lHmzwu2GTWewvKywKrti6
	AAFDKNEieQefb1mC/Dut+Vde4ixSxotgvDAk17JFkR4iNScldI7G7bg8wyCvyT9jJcMOn/wE8ko
	QKTh96bG1RNWP08RIETNMHo0HOgM/W4zlemKhGpN3bB+CdQh6qNKMyXXaogzKuQNW7o5gGnC0y7
	++ryeRj1L6pLIdb3EKmvD7a5ek054OwiPQ1rsSkv1SFIQzRxUw0giy/s9OvG88NDaOFgYfDpqLA
	SUwJSvWodi7qVC6HP0c5t2DOvVn/m0jZ+h0huH0Q+C9w8wcqHpNfStNHB1OdiL8g82JTUo1IeQC
	+OselvwBw3bXOoma2seXKH8HROyLxqA==
X-Google-Smtp-Source: AGHT+IHPbx6kF83A+w0Q0/C0fjKETavqKUnu7JIyVYNCZOoMZP02b1AqvPznvJa3PXMc/mDqyr/CTg==
X-Received: by 2002:a17:906:478a:b0:afe:c027:cfd4 with SMTP id a640c23a62f3a-afec027dffcmr146211766b.41.1756276947856;
        Tue, 26 Aug 2025 23:42:27 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe73cf6d99sm697061266b.0.2025.08.26.23.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 23:42:27 -0700 (PDT)
Message-ID: <495394bb-6f0a-4300-ac77-e3193eb14ca4@linaro.org>
Date: Wed, 27 Aug 2025 09:42:26 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 00/29] introduce kmemdump
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250826171447.6w77day5wddppy3s@hu-mojha-hyd.qualcomm.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250826171447.6w77day5wddppy3s@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 20:14, Mukesh Ojha wrote:
> On Thu, Jul 24, 2025 at 04:54:43PM +0300, Eugen Hristev wrote:
>> kmemdump is a mechanism which allows the kernel to mark specific memory
>> areas for dumping or specific backend usage.
>> Once regions are marked, kmemdump keeps an internal list with the regions
>> and registers them in the backend.
>> Further, depending on the backend driver, these regions can be dumped using
>> firmware or different hardware block.
>> Regions being marked beforehand, when the system is up and running, there
>> is no need nor dependency on a panic handler, or a working kernel that can
>> dump the debug information.
>> The kmemdump approach works when pstore, kdump, or another mechanism do not.
>> Pstore relies on persistent storage, a dedicated RAM area or flash, which
>> has the disadvantage of having the memory reserved all the time, or another
>> specific non volatile memory. Some devices cannot keep the RAM contents on
>> reboot so ramoops does not work. Some devices do not allow kexec to run
>> another kernel to debug the crashed one.
>> For such devices, that have another mechanism to help debugging, like
>> firmware, kmemdump is a viable solution.
>>
>> kmemdump can create a core image, similar with /proc/vmcore, with only
>> the registered regions included. This can be loaded into crash tool/gdb and
>> analyzed.
>> To have this working, specific information from the kernel is registered,
>> and this is done at kmemdump init time, no need for the kmemdump user to
>> do anything.
>>
>> This version of the kmemdump patch series includes two backend drivers:
>> one is the Qualcomm Minidump backend, and the other one is the Debug Kinfo
>> backend for Android devices, reworked from this source here:
>> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/android/debug_kinfo.c
>> written originally by Jone Chou <jonechou@google.com>
>>
>> Initial version of kmemdump and discussion is available here:
>> https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
>>
>> Kmemdump has been presented and discussed at Linaro Connect 2025,
>> including motivation, scope, usability and feasability.
>> Video of the recording is available here for anyone interested:
>> https://www.youtube.com/watch?v=r4gII7MX9zQ&list=PLKZSArYQptsODycGiE0XZdVovzAwYNwtK&index=14
>>
>> The implementation is based on the initial Pstore/directly mapped zones
>> published as an RFC here:
>> https://lore.kernel.org/all/20250217101706.2104498-1-eugen.hristev@linaro.org/
>>
>> The back-end implementation for qcom_minidump is based on the minidump
>> patch series and driver written by Mukesh Ojha, thanks:
>> https://lore.kernel.org/lkml/20240131110837.14218-1-quic_mojha@quicinc.com/
>>
>> *** How to use kmemdump with minidump backend on Qualcomm platform guide ***
>>
>> Prerequisites:
>> Crash tool with target=ARM64 and minor changes required for usual crash mode
>> (minimal mode works without the patch)
>> A patch can be applied from here https://p.calebs.dev/49a048
>> This patch will be eventually sent in a reworked way to crash tool.
>>
>> Target kernel must be built with :
>> CONFIG_DEBUG_INFO_REDUCED=n ; this will have vmlinux include all the debugging
>> information needed for crash tool.
>>
>> Otherwise, the kernel requires these as well:
>> CONFIG_KMEMDUMP, CONFIG_KMEMDUMP_COREIMAGE, and the backend
>> CONFIG_KMEMDUMP_QCOM_MINIDUMP_BACKEND
>>
>> Kernel arguments:
>> Kernel firmware must be set to mode 'mini' by kernel module parameter
>> like this : qcom_scm.download_mode=mini
>>
>> After the kernel boots, and qcom_minidump module is loaded, everything is ready for
>> a possible crash.
>>
>> Once the crash happens, the firmware will kick in and you will see on
>> the console the message saying Sahara init, etc, that the firmware is
>> waiting in download mode. (this is subject to firmware supporting this
>> mode, I am using sa8775p-ride board)
>>
>> Example of log on the console:
>> "
>> [...]
>> B -   1096414 - usb: init start
>> B -   1100287 - usb: qusb_dci_platform , 0x19
>> B -   1105686 - usb: usb3phy: PRIM success: lane_A , 0x60
>> B -   1107455 - usb: usb2phy: PRIM success , 0x4
>> B -   1112670 - usb: dci, chgr_type_det_err
>> B -   1117154 - usb: ID:0x260, value: 0x4
>> B -   1121942 - usb: ID:0x108, value: 0x1d90
>> B -   1124992 - usb: timer_start , 0x4c4b40
>> B -   1129140 - usb: vbus_det_pm_unavail
>> B -   1133136 - usb: ID:0x252, value: 0x4
>> B -   1148874 - usb: SUPER , 0x900e
>> B -   1275510 - usb: SUPER , 0x900e
>> B -   1388970 - usb: ID:0x20d, value: 0x0
>> B -   1411113 - usb: ENUM success
>> B -   1411113 - Sahara Init
>> B -   1414285 - Sahara Open
>> "
>>
>> Once the board is in download mode, you can use the qdl tool (I
>> personally use edl , have not tried qdl yet), to get all the regions as
>> separate files.
>> The tool from the host computer will list the regions in the order they
>> were downloaded.
>>
>> Once you have all the files simply use `cat` to put them all together,
>> in the order of the indexes.
>> For my kernel config and setup, here is my cat command : (you can use a script
>> or something, I haven't done that so far):
>>
>> `cat memory/md_KELF1.BIN memory/md_Kvmcorein2.BIN memory/md_Kconfig3.BIN \
>> memory/md_Kmemsect4.BIN memory/md_Ktotalram5.BIN memory/md_Kcpu_poss6.BIN \
>> memory/md_Kcpu_pres7.BIN memory/md_Kcpu_onli8.BIN memory/md_Kcpu_acti9.BIN \
>> memory/md_Kjiffies10.BIN memory/md_Klinux_ba11.BIN memory/md_Knr_threa12.BIN \
>>  memory/md_Knr_irqs13.BIN memory/md_Ktainted_14.BIN memory/md_Ktaint_fl15.BIN \
>> memory/md_Kmem_sect16.BIN memory/md_Knode_dat17.BIN memory/md_Knode_sta18.BIN \
>> memory/md_K__per_cp19.BIN memory/md_Knr_swapf20.BIN memory/md_Kinit_uts21.BIN \
>> memory/md_Kprintk_r22.BIN memory/md_Kprintk_r23.BIN memory/md_Kprb24.BIN \
>> memory/md_Kprb_desc25.BIN memory/md_Kprb_info26.BIN memory/md_Kprb_data27.BIN \
>> memory/md_Krunqueue28.BIN memory/md_Khigh_mem29.BIN memory/md_Kinit_mm30.BIN \
>> memory/md_Kinit_mm_31.BIN memory/md_Kunknown32.BIN memory/md_Kunknown33.BIN \
>> memory/md_Kunknown34.BIN  memory/md_Kunknown35.BIN memory/md_Kunknown36.BIN \
>> memory/md_Kunknown37.BIN memory/md_Kunknown38.BIN memory/md_Kunknown39.BIN \
>> memory/md_Kunknown40.BIN memory/md_Kunknown41.BIN memory/md_Kunknown42.BIN \
>> memory/md_Kunknown43.BIN memory/md_Kunknown44.BIN memory/md_Kunknown45.BIN \
>> memory/md_Kunknown46.BIN memory/md_Kunknown47.BIN  memory/md_Kunknown50.BIN \
>> memory/md_Kunknown51.BIN memory/md_Kunknown52.BIN \
>> memory/md_Kunknown53.BIN > ~/minidump_image`
>>
>> Once you have the resulted file, use `crash` tool to load it, like this:
>> `./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image`
>>
>> There is also a --minimal mode for ./crash that would work without any patch applied
>> to crash tool, but you can't inspect symbols, etc.
> 
> Unfortunately for me, only with --minimal option, I could see the 'log'.
> 
> ./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image
> 
> WARNING: kernel version inconsistency between vmlinux and dumpfile
> 
> crash: read error: kernel virtual address: ffffff8ed7f380d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7f510d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7f6a0d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7f830d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7f9c0d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7fb50d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7fce0d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffff8ed7fe70d8  type: "IRQ stack pointer"
> crash: read error: kernel virtual address: ffffffc0817c5d80  type: "maple_init read mt_slots"
> crash: read error: kernel virtual address: ffffffc0817c5d78  type: "maple_init read mt_pivots"
> crash: read error: kernel virtual address: ffffff8efb89e2c0  type: "memory section root table"
> 
> Looks like something more you are using in your setup to make it work.

Hello Mukesh,

Thanks for trying this out. Have you applied the indicated patch to the
crash tool before compiling it ?
If yes and still facing issues, can you run it with "-d 31" to enable
debug mode, then send me the output log please.

Eugen
> 
> -Mukesh
> 
>>
>> Once you load crash you will see something like this :
>>
>>    KERNEL: /home/eugen/linux-minidump/vmlinux  [TAINTED]
>>     DUMPFILE: /home/eugen/new
>>         CPUS: 8 [OFFLINE: 7]
>>         DATE: Thu Jan  1 02:00:00 EET 1970
>>       UPTIME: 00:00:29
>>        TASKS: 0
>>     NODENAME: qemuarm64
>>      RELEASE: 6.16.0-rc7-next-20250721-00029-gf8cffdbf0479-dirty
>>      VERSION: #5 SMP PREEMPT Tue Jul 22 18:44:57 EEST 2025
>>      MACHINE: aarch64  (unknown Mhz)
>>       MEMORY: 34.2 GB
>>        PANIC: ""
>> crash> log
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b2]
>> [    0.000000] Linux version 6.16.0-rc7-next-20250721-00029-gf8cffdbf0479-dirty (eugen@eugen-station) (aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 13.3.1 20240614, GNU ld (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 2.42.0.20240614) #5 SMP PREEMPT Tue Jul 22 18:44:57 EEST 2025
>>
>>
>> *** Debug Kinfo backend driver ***
>> I don't have any device to actually test this. So I have not.
>> I hacked the driver to just use a kmalloc'ed area to save things instead
>> of the shared memory, and dumped everything there and checked whether it looks
>> sane. If someone is willing to try it out, thanks ! and let me know.
>> I know there is no binding documentation for the compatible either.
>>
>> Thanks for everyone reviewing and bringing ideas into the discussion.
>>
>> Eugen
>>
>> Changelog since the v1 of the RFC:
>> - Reworked the whole minidump implementation based on suggestions from Thomas Gleixner.
>> This means new API, macros, new way to store the regions inside kmemdump
>> (ditched the IDR, moved to static allocation, have a static default backend, etc)
>> - Reworked qcom_minidump driver based on review from Bjorn Andersson
>> - Reworked printk log buffer registration based on review from Petr Mladek
>>
>> I appologize if I missed any review comments. I know there is still lots of work
>> on this series and hope I will improve it more and more.
>> Patches are sent on top of next-20250721
>>
>> Eugen Hristev (29):
>>   kmemdump: introduce kmemdump
>>   Documentation: add kmemdump
>>   kmemdump: add coreimage ELF layer
>>   Documentation: kmemdump: add section for coreimage ELF
>>   kmemdump: introduce qcom-minidump backend driver
>>   soc: qcom: smem: add minidump device
>>   init/version: Annotate static information into Kmemdump
>>   cpu: Annotate static information into Kmemdump
>>   genirq/irqdesc: Annotate static information into Kmemdump
>>   panic: Annotate static information into Kmemdump
>>   sched/core: Annotate static information into Kmemdump
>>   timers: Annotate static information into Kmemdump
>>   kernel/fork: Annotate static information into Kmemdump
>>   mm/page_alloc: Annotate static information into Kmemdump
>>   mm/init-mm: Annotate static information into Kmemdump
>>   mm/show_mem: Annotate static information into Kmemdump
>>   mm/swapfile: Annotate static information into Kmemdump
>>   mm/percpu: Annotate static information into Kmemdump
>>   mm/mm_init: Annotate static information into Kmemdump
>>   printk: Register information into Kmemdump
>>   kernel/configs: Register dynamic information into Kmemdump
>>   mm/numa: Register information into Kmemdump
>>   mm/sparse: Register information into Kmemdump
>>   kernel/vmcore_info: Register dynamic information into Kmemdump
>>   kmemdump: Add additional symbols to the coreimage
>>   init/version: Annotate init uts name separately into Kmemdump
>>   kallsyms: Annotate static information into Kmemdump
>>   mm/init-mm: Annotate additional information into Kmemdump
>>   kmemdump: Add Kinfo backend driver
>>
>>  Documentation/debug/index.rst      |  17 ++
>>  Documentation/debug/kmemdump.rst   | 104 +++++++++
>>  MAINTAINERS                        |  18 ++
>>  drivers/Kconfig                    |   4 +
>>  drivers/Makefile                   |   2 +
>>  drivers/debug/Kconfig              |  55 +++++
>>  drivers/debug/Makefile             |   6 +
>>  drivers/debug/kinfo.c              | 304 +++++++++++++++++++++++++
>>  drivers/debug/kmemdump.c           | 239 +++++++++++++++++++
>>  drivers/debug/kmemdump_coreimage.c | 223 ++++++++++++++++++
>>  drivers/debug/qcom_minidump.c      | 353 +++++++++++++++++++++++++++++
>>  drivers/soc/qcom/smem.c            |  10 +
>>  include/asm-generic/vmlinux.lds.h  |  13 ++
>>  include/linux/kmemdump.h           | 219 ++++++++++++++++++
>>  init/version.c                     |   6 +
>>  kernel/configs.c                   |   6 +
>>  kernel/cpu.c                       |   5 +
>>  kernel/fork.c                      |   2 +
>>  kernel/irq/irqdesc.c               |   2 +
>>  kernel/kallsyms.c                  |  10 +
>>  kernel/panic.c                     |   4 +
>>  kernel/printk/printk.c             |  28 ++-
>>  kernel/sched/core.c                |   2 +
>>  kernel/time/timer.c                |   3 +-
>>  kernel/vmcore_info.c               |   3 +
>>  mm/init-mm.c                       |  12 +
>>  mm/mm_init.c                       |   2 +
>>  mm/numa.c                          |   5 +-
>>  mm/page_alloc.c                    |   2 +
>>  mm/percpu.c                        |   3 +
>>  mm/show_mem.c                      |   2 +
>>  mm/sparse.c                        |  16 +-
>>  mm/swapfile.c                      |   2 +
>>  33 files changed, 1670 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/debug/index.rst
>>  create mode 100644 Documentation/debug/kmemdump.rst
>>  create mode 100644 drivers/debug/Kconfig
>>  create mode 100644 drivers/debug/Makefile
>>  create mode 100644 drivers/debug/kinfo.c
>>  create mode 100644 drivers/debug/kmemdump.c
>>  create mode 100644 drivers/debug/kmemdump_coreimage.c
>>  create mode 100644 drivers/debug/qcom_minidump.c
>>  create mode 100644 include/linux/kmemdump.h
>>
>> -- 
>> 2.43.0
>>
> 


