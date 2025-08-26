Return-Path: <linux-arch+bounces-13289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BCB37105
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F761BA3306
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F02E1C54;
	Tue, 26 Aug 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEqDWIIz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7672D47E8
	for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228499; cv=none; b=jrPu9GgfEGXnvSCPXWEmNgwImxlTsQSxQCHm6buG7XnicvnVNE64OX834UmSI2+bRBg2Q1Qobz2UB9ohXU+ITf798EsyIxkYFqVZkbruDoTwlLO5WXUywZT2EH4tHrFdjqlWXOoJTWhQjkD8N4j7j0oYty/grbuQUPnjuFPJhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228499; c=relaxed/simple;
	bh=ArstDYX96xW9DNheP44i6pqD2bzetRzTOkndXRAzhZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTsvicWrqrA2NFYdATdxcbAa5WSmQz1wpgN3crltPtNW0HTiPrKEA4PNc0jTMGjRxgN1Rnt8o979TOEqHq6kwvmEZ6sdn57STM2FtP5A4J+Ey19kiMsiGVLlfpNo3RNjs2aLzLk3Zo88+N16zgz/OShBH5UBzU5+UYaT1Jl9Drw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEqDWIIz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCQ6kl004580
	for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 17:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sIIY+Ur2rqJSQSBwUezrJ90x
	eU4rtN9bpG3yYRpDXzA=; b=HEqDWIIz/efIx5MBARqcKHWuPgHxgk4tMAm6oh6I
	++GWgbsFKgkkr3/CttCsmJ2I9tmQFIE+1tV613LvgckmMOMGxylPNxOOMLYv+5fe
	1XC50jWzSd7swI52CiaIKg60OVxe49bo0uyElkQbneIXRqBgZ4CM2du+6NAPxW+5
	kV1QMMZcXfsCLU0HVmUcAbHVCbNSmT+EWBY/0dYKDiZMjkU1dpGtPBXM7OVg5Oe5
	cS3NRaMtilkYWb5v3Jf23ZLzZy+DKy1yPmV3zDcmI9SDRxxBp4n28UVcIM3kss5L
	uYFAjewYYPqRgIeokFpV3LRYfMTeFc5QGL1PQUgPcw59/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um9v7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 17:14:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24895637fe1so251905ad.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 10:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228495; x=1756833295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIIY+Ur2rqJSQSBwUezrJ90xeU4rtN9bpG3yYRpDXzA=;
        b=KP9aT4hyVcFX+jo15UMHm8oAD339lUKHnI5eHVNMYakx2JRnY5KOQG3QVD2NhTz8BE
         5QAA3OU48u2M50lLMJPvhLxQ3F5IoXa/y41KKmxgL7uNAmTqp7NDZT7haU+BoSIs+gC6
         YWejX2AlAwJ+3Z94FMOE3cvGmbDI761w2DQ3dX7Ce+UHJfLUYWZEZD3ASz7d1sTD5LX7
         5E70Vm7cUDWgaqGGkgE5rDpwTXIzLf2uXT5+9XJ6CNv0qQZDeZarmJei/mhhqEVK7f73
         G5X3X8kN0MrsCASLDbuEghnSXNWSwprBigmRPeWeio8cIe2eN5gAVLk6UK4xZkYBYOIq
         IyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXoDo0JBl4N3XlJ8Cia0VgSFgFiTqptRKMZCA5YceMF3TPvN7zEmKdTrXMm6hZYC+UGkhLKpZhde7O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Hvq+owl9Y3z30dfLwXCl4jrdAAc3qPij5O2shqvRlHx54+Em
	3zM0H4aOn4LEUCgYrYRqpNJBfLGRaSFXWA0Tq3w/UETMktlqoc24w9hEljzSbk2Ls4MTRpVoKKN
	i9dHYSOJteXSg/uphaO0JaIywNCDvl2vCvAvKsUCwmZBmtkCrfpPN7BsJRRV2sQ/N
X-Gm-Gg: ASbGncs/z6MW9L+YMXCVllOmdszS1rYRlL6/b7sIvabP5tkwTZix4pBn95ermz0AqSI
	NPGnDIV14M/HFWmYN9xP6LpzZ2UXvrx3aYj3SdZeIN9KKpm4zc/s9BRhKkMkJoewxwREcZM5ZmC
	7OhQPvt/XBjk6vRWVOUNI48tCrxOiTwaF29S2I9HURsL3YH4Gvw4Spfoow+dOXjm4TM3C4IuadY
	YlL/0npJ1iX8h13lfQpSEM2SgQq2nWyJIrb1m7tI9+zkBFbWf1r/UAorFoWwoqcr1eSpo5I+BQQ
	1in3bdkRm/W71IDxlG3nArGVyplfXxsLbsiFB0OiMw/qTOwJ+OkgP9oyQy5SBlfYwbo=
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id d9443c01a7336-2462ee8e8f4mr245573565ad.26.1756228494725;
        Tue, 26 Aug 2025 10:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHntt0G+q9NMI/UOZT8ywGbkhH4ZHMChCz25hbho9klF3RDxKSos+Um1MoE6z7OkYJ8G1s4w==
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id d9443c01a7336-2462ee8e8f4mr245573115ad.26.1756228494074;
        Tue, 26 Aug 2025 10:14:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688801bdsm101007075ad.123.2025.08.26.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:14:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 22:44:47 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        andersson@kernel.org, pmladek@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
        corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
        jonechou@google.com, tudor.ambarus@linaro.org
Subject: Re: [RFC][PATCH v2 00/29] introduce kmemdump
Message-ID: <20250826171447.6w77day5wddppy3s@hu-mojha-hyd.qualcomm.com>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68adeb90 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=vnREMb7VAAAA:8 a=COk6AnOGAAAA:8 a=bLXd17yOAAAA:8
 a=1XWaLZrsAAAA:8 a=349LBZSuyFQcu3wEsZwA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=7KeoIwV6GZqOttXkcoxL:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22 a=XOuVWTVwyKTMzSnUH6Op:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX12Sonz3NTo3y
 zo/8P1bCItUiKBlJwgSr+QokWNmTVY96eULCXV5Gc8laKhgzpEpr7/F8SHfQzFf5YwFZu3fuLX0
 5NK4AFN03CdTl4R73iQHSepxS3OtMHcelcyVdVjI4TKeWB8OpnqmjO5xhL3T6l7FBNToFEHutsT
 0epxjV1hMxceeYhdGauE0lOI4mdVGqnQGK7+Yv47fpSdF7NaoNyO66LTDYOIVoUjSQWvd9AuxT9
 Nwg2nc+4Te6CUtx4ehfCz9kJ8l9vG1sYs8QElvHL4TNIs8UHChPBt9Z98d9gJiwY4doyJkTJHhp
 3cSffhf+otzDblA9AysfkNKnCYcE0WVHiUI9c/j3n9h5tFTLhId1xGKYRN41vydXzaigoeOs4R8
 1OKp546B
X-Proofpoint-GUID: L-YvBC_w0TyKlYL6UASxxMXuNQuHII_F
X-Proofpoint-ORIG-GUID: L-YvBC_w0TyKlYL6UASxxMXuNQuHII_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Thu, Jul 24, 2025 at 04:54:43PM +0300, Eugen Hristev wrote:
> kmemdump is a mechanism which allows the kernel to mark specific memory
> areas for dumping or specific backend usage.
> Once regions are marked, kmemdump keeps an internal list with the regions
> and registers them in the backend.
> Further, depending on the backend driver, these regions can be dumped using
> firmware or different hardware block.
> Regions being marked beforehand, when the system is up and running, there
> is no need nor dependency on a panic handler, or a working kernel that can
> dump the debug information.
> The kmemdump approach works when pstore, kdump, or another mechanism do not.
> Pstore relies on persistent storage, a dedicated RAM area or flash, which
> has the disadvantage of having the memory reserved all the time, or another
> specific non volatile memory. Some devices cannot keep the RAM contents on
> reboot so ramoops does not work. Some devices do not allow kexec to run
> another kernel to debug the crashed one.
> For such devices, that have another mechanism to help debugging, like
> firmware, kmemdump is a viable solution.
> 
> kmemdump can create a core image, similar with /proc/vmcore, with only
> the registered regions included. This can be loaded into crash tool/gdb and
> analyzed.
> To have this working, specific information from the kernel is registered,
> and this is done at kmemdump init time, no need for the kmemdump user to
> do anything.
> 
> This version of the kmemdump patch series includes two backend drivers:
> one is the Qualcomm Minidump backend, and the other one is the Debug Kinfo
> backend for Android devices, reworked from this source here:
> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/android/debug_kinfo.c
> written originally by Jone Chou <jonechou@google.com>
> 
> Initial version of kmemdump and discussion is available here:
> https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
> 
> Kmemdump has been presented and discussed at Linaro Connect 2025,
> including motivation, scope, usability and feasability.
> Video of the recording is available here for anyone interested:
> https://www.youtube.com/watch?v=r4gII7MX9zQ&list=PLKZSArYQptsODycGiE0XZdVovzAwYNwtK&index=14
> 
> The implementation is based on the initial Pstore/directly mapped zones
> published as an RFC here:
> https://lore.kernel.org/all/20250217101706.2104498-1-eugen.hristev@linaro.org/
> 
> The back-end implementation for qcom_minidump is based on the minidump
> patch series and driver written by Mukesh Ojha, thanks:
> https://lore.kernel.org/lkml/20240131110837.14218-1-quic_mojha@quicinc.com/
> 
> *** How to use kmemdump with minidump backend on Qualcomm platform guide ***
> 
> Prerequisites:
> Crash tool with target=ARM64 and minor changes required for usual crash mode
> (minimal mode works without the patch)
> A patch can be applied from here https://p.calebs.dev/49a048
> This patch will be eventually sent in a reworked way to crash tool.
> 
> Target kernel must be built with :
> CONFIG_DEBUG_INFO_REDUCED=n ; this will have vmlinux include all the debugging
> information needed for crash tool.
> 
> Otherwise, the kernel requires these as well:
> CONFIG_KMEMDUMP, CONFIG_KMEMDUMP_COREIMAGE, and the backend
> CONFIG_KMEMDUMP_QCOM_MINIDUMP_BACKEND
> 
> Kernel arguments:
> Kernel firmware must be set to mode 'mini' by kernel module parameter
> like this : qcom_scm.download_mode=mini
> 
> After the kernel boots, and qcom_minidump module is loaded, everything is ready for
> a possible crash.
> 
> Once the crash happens, the firmware will kick in and you will see on
> the console the message saying Sahara init, etc, that the firmware is
> waiting in download mode. (this is subject to firmware supporting this
> mode, I am using sa8775p-ride board)
> 
> Example of log on the console:
> "
> [...]
> B -   1096414 - usb: init start
> B -   1100287 - usb: qusb_dci_platform , 0x19
> B -   1105686 - usb: usb3phy: PRIM success: lane_A , 0x60
> B -   1107455 - usb: usb2phy: PRIM success , 0x4
> B -   1112670 - usb: dci, chgr_type_det_err
> B -   1117154 - usb: ID:0x260, value: 0x4
> B -   1121942 - usb: ID:0x108, value: 0x1d90
> B -   1124992 - usb: timer_start , 0x4c4b40
> B -   1129140 - usb: vbus_det_pm_unavail
> B -   1133136 - usb: ID:0x252, value: 0x4
> B -   1148874 - usb: SUPER , 0x900e
> B -   1275510 - usb: SUPER , 0x900e
> B -   1388970 - usb: ID:0x20d, value: 0x0
> B -   1411113 - usb: ENUM success
> B -   1411113 - Sahara Init
> B -   1414285 - Sahara Open
> "
> 
> Once the board is in download mode, you can use the qdl tool (I
> personally use edl , have not tried qdl yet), to get all the regions as
> separate files.
> The tool from the host computer will list the regions in the order they
> were downloaded.
> 
> Once you have all the files simply use `cat` to put them all together,
> in the order of the indexes.
> For my kernel config and setup, here is my cat command : (you can use a script
> or something, I haven't done that so far):
> 
> `cat memory/md_KELF1.BIN memory/md_Kvmcorein2.BIN memory/md_Kconfig3.BIN \
> memory/md_Kmemsect4.BIN memory/md_Ktotalram5.BIN memory/md_Kcpu_poss6.BIN \
> memory/md_Kcpu_pres7.BIN memory/md_Kcpu_onli8.BIN memory/md_Kcpu_acti9.BIN \
> memory/md_Kjiffies10.BIN memory/md_Klinux_ba11.BIN memory/md_Knr_threa12.BIN \
>  memory/md_Knr_irqs13.BIN memory/md_Ktainted_14.BIN memory/md_Ktaint_fl15.BIN \
> memory/md_Kmem_sect16.BIN memory/md_Knode_dat17.BIN memory/md_Knode_sta18.BIN \
> memory/md_K__per_cp19.BIN memory/md_Knr_swapf20.BIN memory/md_Kinit_uts21.BIN \
> memory/md_Kprintk_r22.BIN memory/md_Kprintk_r23.BIN memory/md_Kprb24.BIN \
> memory/md_Kprb_desc25.BIN memory/md_Kprb_info26.BIN memory/md_Kprb_data27.BIN \
> memory/md_Krunqueue28.BIN memory/md_Khigh_mem29.BIN memory/md_Kinit_mm30.BIN \
> memory/md_Kinit_mm_31.BIN memory/md_Kunknown32.BIN memory/md_Kunknown33.BIN \
> memory/md_Kunknown34.BIN  memory/md_Kunknown35.BIN memory/md_Kunknown36.BIN \
> memory/md_Kunknown37.BIN memory/md_Kunknown38.BIN memory/md_Kunknown39.BIN \
> memory/md_Kunknown40.BIN memory/md_Kunknown41.BIN memory/md_Kunknown42.BIN \
> memory/md_Kunknown43.BIN memory/md_Kunknown44.BIN memory/md_Kunknown45.BIN \
> memory/md_Kunknown46.BIN memory/md_Kunknown47.BIN  memory/md_Kunknown50.BIN \
> memory/md_Kunknown51.BIN memory/md_Kunknown52.BIN \
> memory/md_Kunknown53.BIN > ~/minidump_image`
> 
> Once you have the resulted file, use `crash` tool to load it, like this:
> `./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image`
> 
> There is also a --minimal mode for ./crash that would work without any patch applied
> to crash tool, but you can't inspect symbols, etc.

Unfortunately for me, only with --minimal option, I could see the 'log'.

./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image

WARNING: kernel version inconsistency between vmlinux and dumpfile

crash: read error: kernel virtual address: ffffff8ed7f380d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7f510d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7f6a0d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7f830d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7f9c0d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7fb50d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7fce0d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffff8ed7fe70d8  type: "IRQ stack pointer"
crash: read error: kernel virtual address: ffffffc0817c5d80  type: "maple_init read mt_slots"
crash: read error: kernel virtual address: ffffffc0817c5d78  type: "maple_init read mt_pivots"
crash: read error: kernel virtual address: ffffff8efb89e2c0  type: "memory section root table"

Looks like something more you are using in your setup to make it work.

-Mukesh

> 
> Once you load crash you will see something like this :
> 
>    KERNEL: /home/eugen/linux-minidump/vmlinux  [TAINTED]
>     DUMPFILE: /home/eugen/new
>         CPUS: 8 [OFFLINE: 7]
>         DATE: Thu Jan  1 02:00:00 EET 1970
>       UPTIME: 00:00:29
>        TASKS: 0
>     NODENAME: qemuarm64
>      RELEASE: 6.16.0-rc7-next-20250721-00029-gf8cffdbf0479-dirty
>      VERSION: #5 SMP PREEMPT Tue Jul 22 18:44:57 EEST 2025
>      MACHINE: aarch64  (unknown Mhz)
>       MEMORY: 34.2 GB
>        PANIC: ""
> crash> log
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b2]
> [    0.000000] Linux version 6.16.0-rc7-next-20250721-00029-gf8cffdbf0479-dirty (eugen@eugen-station) (aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 13.3.1 20240614, GNU ld (Arm GNU Toolchain 13.3.Rel1 (Build arm-13.24)) 2.42.0.20240614) #5 SMP PREEMPT Tue Jul 22 18:44:57 EEST 2025
> 
> 
> *** Debug Kinfo backend driver ***
> I don't have any device to actually test this. So I have not.
> I hacked the driver to just use a kmalloc'ed area to save things instead
> of the shared memory, and dumped everything there and checked whether it looks
> sane. If someone is willing to try it out, thanks ! and let me know.
> I know there is no binding documentation for the compatible either.
> 
> Thanks for everyone reviewing and bringing ideas into the discussion.
> 
> Eugen
> 
> Changelog since the v1 of the RFC:
> - Reworked the whole minidump implementation based on suggestions from Thomas Gleixner.
> This means new API, macros, new way to store the regions inside kmemdump
> (ditched the IDR, moved to static allocation, have a static default backend, etc)
> - Reworked qcom_minidump driver based on review from Bjorn Andersson
> - Reworked printk log buffer registration based on review from Petr Mladek
> 
> I appologize if I missed any review comments. I know there is still lots of work
> on this series and hope I will improve it more and more.
> Patches are sent on top of next-20250721
> 
> Eugen Hristev (29):
>   kmemdump: introduce kmemdump
>   Documentation: add kmemdump
>   kmemdump: add coreimage ELF layer
>   Documentation: kmemdump: add section for coreimage ELF
>   kmemdump: introduce qcom-minidump backend driver
>   soc: qcom: smem: add minidump device
>   init/version: Annotate static information into Kmemdump
>   cpu: Annotate static information into Kmemdump
>   genirq/irqdesc: Annotate static information into Kmemdump
>   panic: Annotate static information into Kmemdump
>   sched/core: Annotate static information into Kmemdump
>   timers: Annotate static information into Kmemdump
>   kernel/fork: Annotate static information into Kmemdump
>   mm/page_alloc: Annotate static information into Kmemdump
>   mm/init-mm: Annotate static information into Kmemdump
>   mm/show_mem: Annotate static information into Kmemdump
>   mm/swapfile: Annotate static information into Kmemdump
>   mm/percpu: Annotate static information into Kmemdump
>   mm/mm_init: Annotate static information into Kmemdump
>   printk: Register information into Kmemdump
>   kernel/configs: Register dynamic information into Kmemdump
>   mm/numa: Register information into Kmemdump
>   mm/sparse: Register information into Kmemdump
>   kernel/vmcore_info: Register dynamic information into Kmemdump
>   kmemdump: Add additional symbols to the coreimage
>   init/version: Annotate init uts name separately into Kmemdump
>   kallsyms: Annotate static information into Kmemdump
>   mm/init-mm: Annotate additional information into Kmemdump
>   kmemdump: Add Kinfo backend driver
> 
>  Documentation/debug/index.rst      |  17 ++
>  Documentation/debug/kmemdump.rst   | 104 +++++++++
>  MAINTAINERS                        |  18 ++
>  drivers/Kconfig                    |   4 +
>  drivers/Makefile                   |   2 +
>  drivers/debug/Kconfig              |  55 +++++
>  drivers/debug/Makefile             |   6 +
>  drivers/debug/kinfo.c              | 304 +++++++++++++++++++++++++
>  drivers/debug/kmemdump.c           | 239 +++++++++++++++++++
>  drivers/debug/kmemdump_coreimage.c | 223 ++++++++++++++++++
>  drivers/debug/qcom_minidump.c      | 353 +++++++++++++++++++++++++++++
>  drivers/soc/qcom/smem.c            |  10 +
>  include/asm-generic/vmlinux.lds.h  |  13 ++
>  include/linux/kmemdump.h           | 219 ++++++++++++++++++
>  init/version.c                     |   6 +
>  kernel/configs.c                   |   6 +
>  kernel/cpu.c                       |   5 +
>  kernel/fork.c                      |   2 +
>  kernel/irq/irqdesc.c               |   2 +
>  kernel/kallsyms.c                  |  10 +
>  kernel/panic.c                     |   4 +
>  kernel/printk/printk.c             |  28 ++-
>  kernel/sched/core.c                |   2 +
>  kernel/time/timer.c                |   3 +-
>  kernel/vmcore_info.c               |   3 +
>  mm/init-mm.c                       |  12 +
>  mm/mm_init.c                       |   2 +
>  mm/numa.c                          |   5 +-
>  mm/page_alloc.c                    |   2 +
>  mm/percpu.c                        |   3 +
>  mm/show_mem.c                      |   2 +
>  mm/sparse.c                        |  16 +-
>  mm/swapfile.c                      |   2 +
>  33 files changed, 1670 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/debug/index.rst
>  create mode 100644 Documentation/debug/kmemdump.rst
>  create mode 100644 drivers/debug/Kconfig
>  create mode 100644 drivers/debug/Makefile
>  create mode 100644 drivers/debug/kinfo.c
>  create mode 100644 drivers/debug/kmemdump.c
>  create mode 100644 drivers/debug/kmemdump_coreimage.c
>  create mode 100644 drivers/debug/qcom_minidump.c
>  create mode 100644 include/linux/kmemdump.h
> 
> -- 
> 2.43.0
> 

-- 
-Mukesh Ojha

