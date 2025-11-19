Return-Path: <linux-arch+bounces-14954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD03C706ED
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C7374EF447
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7830B519;
	Wed, 19 Nov 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9k5cz4h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64914309F1F
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572295; cv=none; b=Z9TkSaIdXKjt2D0bDs/c0zYylRHEr/IQaxTm3av4Z3S6vwU5HTmZDAjWusfgKR2HnNj7X/5Vd6woBtpul5M+ZyF9swih0DO6In5t9RdWd/KAOXze2ykeXISBRPwajbHxBwKrVLkWtpIgyRRJWtBsPVXzG/DRomQasmfI1pyrz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572295; c=relaxed/simple;
	bh=jTPtIDGDy47azh/mmQeEKIdg0l5Ufka+IRIZTVgwxj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJV8iq/0xZ2lhQrfU0LKBRQtslQ+MOzG/0Xfi6X2wT6wvC2Ua/gg7T+vQbfeROffoQVOUGVUCuaFdiX+F+Pif2cFLnB5+u2JJWXZIIKr9BSXNm4qC2owgKDvcuUn2DN0uAWs6NrZh09/Upf+n2WKNsKZ0IZ8CYhWthxUSl7akHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9k5cz4h; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a34702a20so57680521fa.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763572289; x=1764177089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imxsq40OzA0Ie9nuhKfzZL+VMvsrBqdZdMB6IgBRj7U=;
        b=K9k5cz4hgssaUiEXzx2hBQIG5SX3L+XrH5vpeTfUoS7KTvdkKGzkjC80M3fzplWtPi
         APWmgGrRu9IF5JCoXjidrIrvXXyE9rG9J+3fqB8qF7YKMRwtpKp9rixPS1o4CiWLMqqN
         sHedsxr2SJDD9TJEccWfIWSjd7Y7u3So7UPXqC0sRsKRiiHplcFBsVs56mrHKcLCkUN0
         SWiHDxfxaNx9aSrqgiCi489UAqIQz60hFnhHZjxOzfX/wa6ztPAUS6VKFm/ybx8/EqV7
         g869wX/d+APgksMyjmphda3V3RTpLAQiJnWBrr5bgeLQdORhSPhnK6S8kEHg9nu8i0/v
         FiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572289; x=1764177089;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imxsq40OzA0Ie9nuhKfzZL+VMvsrBqdZdMB6IgBRj7U=;
        b=ZYj5+2eLwX9Kw83L+ymzcqY7hHCm0ts0FV37BRqIsdSbrnusCWQlr58HuROSgkZS84
         A0fvpyggoE7D2xqeYNI9R3/XUM9IwbYWLggxgSXVOYjD985wniC1wpfp8/e4vMPslS6C
         cF6O4pwqFBg7mD3gJ9jlUxsqIUCU74vizbAESbRuEuwZe2Wbog7CVV2FRCmums2Dx9xa
         S44hRYgJ4igl3+YqMNGtIohHU6MSy2RFUXyGdm6kFVXTQjJ9copTjGWC8mZ7NiXMejcv
         OWBUwSIahmO43uXHu8LvtwY2mDHImBLc835Y6ONyweXntyNj9iyFKWpxcNnx8QHlO0HR
         P1aA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Bo6ZQJV9/Jnbilfm5fRtfx2RIV/vFL7HTAqF3eTxrBS6M4pXljznc63zwrUv2J8NcGSiSTYe9q8M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W6Z9rsPKmH5KoKr7dRLkOPrYqiDzlH9KtnbvJ4JdsCQGJfRy
	98AbU+U4u9NPv3+MWuU4bk+WN39SG7Buc7CyMNyNqvHkkxFD9s0AKCeFSBysgNI9/5g=
X-Gm-Gg: ASbGnctZC5pu3/EkaiGV5bsmfDFOVxy7HuqFoeZeXTV71bW/pUGlYSjP9v0QAWwIbYO
	V96iBOAoa05hd8S6sHNnhMYhptFx+pRclXRVUKcDwOz4LjyYWI6RT8waOFKw1Yihi0cAN+19Lun
	pGKjf1nwr5//ohZSDtEd69nDKnfhHtj5/zBNiAZ8Wu8k6omtyToAGWYv4d1cJF/a2oT5VHebSuK
	8juz9iwKp2dSzJ+Tv7QMBYxaQncFgRUQsJ7KRANxSraj+QosNzKZGacXQTYNFsjFvjjbxOdc20e
	YBiNLwAKFtbDcEOMWNowlZkZqTgakitPjFObLCu9360JmL9PNtTWYAtHTheIou3ElvOooGygRJg
	ZiYACXnJgnl3+iPH5s+SdzM4gKPInM8FltTA+kSWTeTQq53IhJBBu/FZ+K0KlyM8dvffAQABWWV
	ic35Avk3faLKKC4i08IpNv
X-Google-Smtp-Source: AGHT+IEH2uVRaoWXxqf5lW4QGlbUReR2Hbmd7c6j+HPcJiq7hqxFbRM9UIfcv/r6AcUVW8EzKehpjA==
X-Received: by 2002:a2e:3217:0:b0:37b:b849:31c3 with SMTP id 38308e7fff4ca-37cc68d1bd9mr359131fa.44.1763572289379;
        Wed, 19 Nov 2025 09:11:29 -0800 (PST)
Received: from [10.101.2.140] ([93.122.165.106])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce080a6sm42198701fa.4.2025.11.19.09.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 09:11:28 -0800 (PST)
Message-ID: <19171859-94ac-4f41-b100-70a1497e62e6@linaro.org>
Date: Wed, 19 Nov 2025 19:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <6c9b0aa2-820c-4153-ad64-cd2a45f7cf32@lucifer.local>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <6c9b0aa2-820c-4153-ad64-cd2a45f7cf32@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/19/25 18:30, Lorenzo Stoakes wrote:
> Hi Eugen,
> 
> You've not run scripts/get_maintainer.pl so this is missing a ton of maintainers
> that you're required to send this to. This is not a great start for a huge 26
> patch series that seems to want to make very significant changes.
> 
> Please try to follow proper kernel procedure.

Hi Lorenzo,

I included the relevant mailing lists, but indeed I have not cc-ed every
individual maintainer. Do you think it would be appropriate to resend it
as-is to everyone cc-ed (PATCH RESEND) or just do that for the next
revision ?

> 
> Here's the list:
> 
> Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION PROCESS)
> Bjorn Andersson <andersson@kernel.org> (maintainer:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
> Mathieu Poirier <mathieu.poirier@linaro.org> (maintainer:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
> Konrad Dybcio <konradybcio@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
> Mike Rapoport <rppt@kernel.org> (maintainer:MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION)
> Thomas Gleixner <tglx@linutronix.de> (maintainer:CPU HOTPLUG)
> Peter Zijlstra <peterz@infradead.org> (maintainer:CPU HOTPLUG,commit_signer:8/46=17%,removed_lines:4/63=6%)
> Kees Cook <kees@kernel.org> (maintainer:EXEC & BINFMT API, ELF,commit_signer:7/46=15%)
> Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER,commit_signer:1/2=50%)
> Juri Lelli <juri.lelli@redhat.com> (maintainer:SCHEDULER)
> Vincent Guittot <vincent.guittot@linaro.org> (maintainer:SCHEDULER)
> Dietmar Eggemann <dietmar.eggemann@arm.com> (reviewer:SCHEDULER)
> Steven Rostedt <rostedt@goodmis.org> (reviewer:SCHEDULER)
> Ben Segall <bsegall@google.com> (reviewer:SCHEDULER)
> Mel Gorman <mgorman@suse.de> (reviewer:SCHEDULER)
> Valentin Schneider <vschneid@redhat.com> (reviewer:SCHEDULER)
> Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - CORE,commit_signer:5/46=11%,commit_signer:14/22=64%)
> David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - CORE)
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
> "Liam R. Howlett" <Liam.Howlett@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Vlastimil Babka <vbabka@suse.cz> (reviewer:MEMORY MANAGEMENT - CORE)
> Suren Baghdasaryan <surenb@google.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Michal Hocko <mhocko@suse.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Petr Mladek <pmladek@suse.com> (maintainer:PRINTK,commit_signer:5/22=23%)
> John Ogness <john.ogness@linutronix.de> (reviewer:PRINTK)
> Sergey Senozhatsky <senozhatsky@chromium.org> (reviewer:PRINTK,added_lines:21/262=8%,removed_lines:9/89=10%)
> Anna-Maria Behnsen <anna-maria@linutronix.de> (maintainer:HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS)
> Frederic Weisbecker <frederic@kernel.org> (maintainer:HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS)
> Brendan Jackman <jackmanb@google.com> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
> Johannes Weiner <hannes@cmpxchg.org> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
> Zi Yan <ziy@nvidia.com> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
> Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Christoph Lameter <cl@gentwo.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Chris Li <chrisl@kernel.org> (maintainer:MEMORY MANAGEMENT - SWAP)
> Kairui Song <kasong@tencent.com> (maintainer:MEMORY MANAGEMENT - SWAP)
> Kemeng Shi <shikemeng@huaweicloud.com> (reviewer:MEMORY MANAGEMENT - SWAP)
> Nhat Pham <nphamcs@gmail.com> (reviewer:MEMORY MANAGEMENT - SWAP)
> Baoquan He <bhe@redhat.com> (reviewer:MEMORY MANAGEMENT - SWAP)
> Barry Song <baohua@kernel.org> (reviewer:MEMORY MANAGEMENT - SWAP)
> "Thomas Weißschuh" <thomas.weissschuh@linutronix.de> (added_lines:13/207=6%)
> workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS)
> linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> linux-kernel@vger.kernel.org (open list)
> linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
> linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
> linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
> linux-mm@kvack.org (open list:MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION)
> 
> On Wed, Nov 19, 2025 at 05:44:01PM +0200, Eugen Hristev wrote:
>> meminspect is a mechanism which allows the kernel to mark specific memory
>> areas for memory dumping or specific inspection, statistics, usage.
>> Once regions are marked, meminspect keeps an internal list with the regions
>> in a dedicated table.
>> Further, these regions can be accessed using specific API by any interested driver.
> 
> Instincitivley not a great fan of exposing and manipulating memory resources to
> drives in such a way but I haven't looked into this in detail here.
> 
>> Regions being marked beforehand, when the system is up and running, there
>> is no need nor dependency on a panic handler, or a working kernel that can
>> dump the debug information.
>> meminspect can be primarily used for debugging. The approach is feasible to work
>> when pstore, kdump, or another mechanism do not.
>> Pstore relies on persistent storage, a dedicated RAM area or flash, which
>> has the disadvantage of having the memory reserved all the time, or another
>> specific non volatile memory. Some devices cannot keep the RAM contents on
>> reboot so ramoops does not work. Some devices do not allow kexec to run
>> another kernel to debug the crashed one.
>> For such devices, that have another mechanism to help debugging, like
>> firmware, kmemdump is a viable solution.
>>
>> meminspect can create a core image, similar with /proc/vmcore, with only
>> the registered regions included. This can be loaded into crash tool/gdb and
>> analyzed. This happens if CRASH_DUMP=y.
>> To have this working, specific information from the kernel is registered,
>> and this is done at meminspect init time, no need for the meminspect users to
>> do anything.
>>
>> This version of the meminspect patch series includes two drivers that make use of it:
>> one is the Qualcomm Minidump, and the other one is the Debug Kinfo
>> backend for Android devices, reworked from this source here:
>> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/android/debug_kinfo.c
>> written originally by Jone Chou <jonechou@google.com>
>>
>> *** History, motivation and available online resources ***
>>
>> The patch series is based on both minidump and kmemdump previous implementations.
>>
>> After the three RFC kmemdump versions, considering the ML discussions, I decided to
>> move this into kernel/ directory and rework it into naming it meminspect, as Thomas Gleixner
>> suggested.
>> I will present this version at Plumbers conference in Tokyo on December 13th:
>> https://lpc.events/event/19/contributions/2080/
>> I am eager to discuss it there face to face.
>>
>> Initial version of kmemdump and discussion is available here:
>> https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
>>
>> Kmemdump has been presented and discussed at Linaro Connect 2025,
>> including motivation, scope, usability and feasability.
>> Video of the recording is available here for anyone interested:
>> https://www.youtube.com/watch?v=r4gII7MX9zQ&list=PLKZSArYQptsODycGiE0XZdVovzAwYNwtK&index=14
>>
>> Linaro blog on kmemdump can be found here:
>> https://www.linaro.org/blog/introduction-to-kmemdump/
>>
>> Linaro blog on kmemdump step by stem using minidump backend is available here:
>> https://www.linaro.org/blog/kmemdump-step-by-step-on-qualcomm-automotive-platform/
>>
>> The implementation is based on the initial Pstore/directly mapped zones
>> published as an RFC here:
>> https://lore.kernel.org/all/20250217101706.2104498-1-eugen.hristev@linaro.org/
>>
>> The back-end implementation for qcom_minidump is based on the minidump
>> patch series and driver written by Mukesh Ojha, thanks:
>> https://lore.kernel.org/lkml/20240131110837.14218-1-quic_mojha@quicinc.com/
>>
>> The RFC v2 version with .section creation and macro annotation kmemdump
>> is available here:
>> https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
>>
>> The RFC v3 version with making everything static, which was pretty much rejected due to
>> all reasons discussed on the public ML:
>> https://lore.kernel.org/all/20250912150855.2901211-1-eugen.hristev@linaro.org/
> 
> OK so you've sent several RFC's and not cc'd the right people in any of them :/
> 
> This isn't great kernel etiquette.

I appologize for not cc-ing everyone.

> 
>>
>> *** How to use meminspect with minidump backend on Qualcomm platform guide ***
>>
>> Prerequisites:
>> Crash tool compiled with target=ARM64 and minor changes required for usual crash
>> mode (minimal mode works without the patch)
>> **A patch can be applied from here https://p.calebs.dev/1687bc **
>> This patch will be eventually sent in a reworked way to crash tool.
>>
>> Target kernel must be built with :
>> CONFIG_DEBUG_INFO_REDUCED=n ; this will have vmlinux include all the debugging
>> information needed for crash tool.
>>
>> Also, the kernel requires these as well:
>> CONFIG_MEMINSPECT,  CONFIG_CRASH_DUMP and the driver CONFIG_QCOM_MINIDUMP
>>
>> Kernel arguments:
>> Kernel firmware must be set to mode 'mini' by kernel module parameter
>> like this : qcom_scm.download_mode=mini
>>
>> After the kernel boots, and minidump module is loaded, everything is ready for
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
>> memory/md_Ktotalram4.BIN memory/md_Kcpu_poss5.BIN memory/md_Kcpu_pres6.BIN \
>> memory/md_Kcpu_onli7.BIN memory/md_Kcpu_acti8.BIN memory/md_Kmem_sect9.BIN \
>> memory/md_Kjiffies10.BIN memory/md_Klinux_ba11.BIN memory/md_Knr_threa12.BIN \
>> memory/md_Knr_irqs13.BIN memory/md_Ktainted_14.BIN memory/md_Ktaint_fl15.BIN \
>> memory/md_Knode_sta16.BIN memory/md_K__per_cp17.BIN memory/md_Knr_swapf18.BIN \
>> memory/md_Kinit_uts19.BIN memory/md_Kprintk_r20.BIN memory/md_Kprintk_r21.BIN \
>> memory/md_Kprb22.BIN memory/md_Kprb_desc23.BIN memory/md_Kprb_info24.BIN \
>> memory/md_Kprb_data25.BIN  memory/md_Khigh_mem26.BIN memory/md_Kinit_mm27.BIN \
>> memory/md_Kunknown29.BIN memory/md_Kunknown30.BIN memory/md_Kunknown31.BIN \
>> memory/md_Kunknown32.BIN memory/md_Kunknown33.BIN memory/md_Kunknown34.BIN \
>> memory/md_Kunknown35.BIN memory/md_Kunknown36.BIN memory/md_Kunknown37.BIN \
>> memory/md_Kunknown38.BIN memory/md_Kunknown39.BIN memory/md_Kunknown40.BIN \
>> memory/md_Kunknown41.BIN memory/md_Kunknown42.BIN memory/md_Kunknown43.BIN \
>> memory/md_Kunknown44.BIN memory/md_Kunknown45.BIN  memory/md_Kunknown46.BIN \
>> memory/md_Kunknown47.BIN memory/md_Kunknown48.BIN memory/md_Kunknown49.BIN \
>> memory/md_Kunknown50.BIN memory/md_Kunknown51.BIN memory/md_Kunknown52.BIN \
>> memory/md_Kunknown53.BIN memory/md_Kunknown54.BIN memory/md_Kunknown55.BIN \
>> memory/md_Kunknown56.BIN memory/md_Kunknown57.BIN > ~/minidump_image`
>>
>> Once you have the resulted file, use `crash` tool to load it, like this:
>> `./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image`
>>
>> There is also a --minimal mode for ./crash that would work without any patch applied
>> to crash tool, but you can't inspect symbols, etc.
>>
>> Once you load crash you will see something like this :
>>       KERNEL: /home/eugen/linux-minidump/vmlinux  [TAINTED]
>>     DUMPFILE: /home/eugen/a
>>         CPUS: 8 [OFFLINE: 6]
>>         DATE: Thu Jan  1 02:00:00 EET 1970
>>       UPTIME: 00:00:25
>>        TASKS: 0
>>     NODENAME: qemuarm64
>>      RELEASE: 6.18.0-rc2-00030-g65df2b8a0dde
>>      VERSION: #33 SMP PREEMPT Mon Nov 17 13:30:54 EET 2025
>>      MACHINE: aarch64  (unknown Mhz)
>>       MEMORY: 0
>>        PANIC: ""
>> crash> log
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b2]
>> [    0.000000] Linux version 6.18.0-rc2-00030-g65df2b8a0dde
>>
>> *** Debug Kinfo backend driver ***
>> I don't have any device to actually test this. So I have not.
>> I hacked the driver to just use a kmalloc'ed area to save things instead
>> of the shared memory, and dumped everything there and checked whether it is identical
>> with what the downstream driver would have saved.
>> So this synthetic test passed and memories are identical.
>> Anyone who actually wants to test this, feel free to reply to the patch.
>> I have also written a simple DT binding for the driver.
>>
>> Thanks for everyone reviewing and bringing ideas into the discussion.
>>
>> Eugen
>>
>> Changelog for meminspect v1:
>> - rename to meminspect
>> - start on top of v2 actually, with the section and all.
>> - remove the backend thing, change the API to access the table
>> - move everything to kernel/
>> - add dependency to CRASH_DUMP instead of a separate knob
>> - move the minidump driver to soc/qcom
>> - integrate the meminspect better into memblock by using a new memblock flag
>> - minor fixes : use dev_err_probe everywhere, rearrange variable declarations,
>> remove some useless code, etc.
>>
>> Changelog for RFC v3:
>> - V2 available here : https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
>> - Removed the .section as requested by David Hildenbrand.
>> - Moved all kmemdump registration(when possible) to vmcoreinfo.
>> - Because of this, some of the variables that I was registering had to be non-static
>> so I had to modify this as per David Hildenbrand suggestion.
>> - Fixed minor things in the Kinfo driver: one field was broken, fixed some
>> compiler warnings, fixed the copyright and remove some useless includes.
>> - Moved the whole kmemdump from drivers/debug into mm/ and Kconfigs into mm/Kconfig.debug
>> and it's now available in kernel hacking, as per Randy Dunlap review
>> - Reworked some of the Documentation as per review from Jon Corbet
>>
>>
>> Changelog for RFC v2:
>> - V1 available here: https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
>> - Reworked the whole minidump implementation based on suggestions from Thomas Gleixner.
>> This means new API, macros, new way to store the regions inside kmemdump
>> (ditched the IDR, moved to static allocation, have a static default backend, etc)
>> - Reworked qcom_minidump driver based on review from Bjorn Andersson
>> - Reworked printk log buffer registration based on review from Petr Mladek
>>
>> I appologize if I missed any review comments.
>> Patches are sent on top on 6.18-rc2
>>
>> Eugen Hristev (26):
>>   kernel: Introduce meminspect
>>   init/version: Annotate static information into meminspect
>>   mm/percpu: Annotate static information into meminspect
>>   cpu: Annotate static information into meminspect
>>   genirq/irqdesc: Annotate static information into meminspect
>>   timers: Annotate static information into meminspect
>>   kernel/fork: Annotate static information into meminspect
>>   mm/page_alloc: Annotate static information into meminspect
>>   mm/show_mem: Annotate static information into meminspect
>>   mm/swapfile: Annotate static information into meminspect
>>   kernel/vmcore_info: Register dynamic information into meminspect
>>   kernel/configs: Register dynamic information into meminspect
>>   mm/init-mm: Annotate static information into meminspect
>>   panic: Annotate static information into meminspect
>>   kallsyms: Annotate static information into meminspect
>>   mm/mm_init: Annotate static information into meminspect
>>   sched/core: Annotate runqueues into meminspect
>>   mm/memblock: Add MEMBLOCK_INSPECT flag
>>   mm/numa: Register information into meminspect
>>   mm/sparse: Register information into meminspect
>>   printk: Register information into meminspect
>>   remoteproc: qcom: Extract minidump definitions into a header
>>   soc: qcom: Add minidump driver
>>   soc: qcom: smem: Add minidump device
>>   dt-bindings: reserved-memory: Add Google Kinfo Pixel reserved memory
>>   meminspect: Add Kinfo compatible driver
>>
>>  Documentation/dev-tools/index.rst             |   1 +
>>  Documentation/dev-tools/meminspect.rst        | 139 ++++++
>>  .../reserved-memory/google,kinfo.yaml         |  49 ++
>>  MAINTAINERS                                   |  13 +
>>  drivers/remoteproc/qcom_common.c              |  56 +--
>>  drivers/soc/qcom/Kconfig                      |  13 +
>>  drivers/soc/qcom/Makefile                     |   1 +
>>  drivers/soc/qcom/minidump.c                   | 272 ++++++++++
>>  drivers/soc/qcom/smem.c                       |  10 +
>>  include/asm-generic/vmlinux.lds.h             |  13 +
>>  include/linux/memblock.h                      |   7 +
>>  include/linux/meminspect.h                    | 261 ++++++++++
>>  include/linux/soc/qcom/minidump.h             |  72 +++
>>  init/Kconfig                                  |   2 +
>>  init/version-timestamp.c                      |   3 +
>>  init/version.c                                |   3 +
>>  kernel/Makefile                               |   1 +
>>  kernel/configs.c                              |   6 +
>>  kernel/cpu.c                                  |   5 +
>>  kernel/fork.c                                 |   2 +
>>  kernel/irq/irqdesc.c                          |   2 +
>>  kernel/kallsyms.c                             |  10 +
>>  kernel/meminspect/Kconfig                     |  30 ++
>>  kernel/meminspect/Makefile                    |   4 +
>>  kernel/meminspect/kinfo.c                     | 289 +++++++++++
>>  kernel/meminspect/meminspect.c                | 470 ++++++++++++++++++
>>  kernel/panic.c                                |   4 +
>>  kernel/printk/printk.c                        |  12 +
>>  kernel/sched/core.c                           |   2 +
>>  kernel/time/timer.c                           |   2 +
>>  kernel/vmcore_info.c                          |   4 +
>>  mm/init-mm.c                                  |  11 +
>>  mm/memblock.c                                 |  36 ++
>>  mm/mm_init.c                                  |   2 +
>>  mm/numa.c                                     |   2 +
>>  mm/page_alloc.c                               |   2 +
>>  mm/percpu.c                                   |   2 +
>>  mm/show_mem.c                                 |   2 +
>>  mm/sparse.c                                   |   4 +
>>  mm/swapfile.c                                 |   2 +
>>  40 files changed, 1766 insertions(+), 55 deletions(-)
>>  create mode 100644 Documentation/dev-tools/meminspect.rst
>>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>>  create mode 100644 drivers/soc/qcom/minidump.c
>>  create mode 100644 include/linux/meminspect.h
>>  create mode 100644 include/linux/soc/qcom/minidump.h
>>  create mode 100644 kernel/meminspect/Kconfig
>>  create mode 100644 kernel/meminspect/Makefile
>>  create mode 100644 kernel/meminspect/kinfo.c
>>  create mode 100644 kernel/meminspect/meminspect.c
>>
>> --
>> 2.43.0
>>
>>
>>
+


