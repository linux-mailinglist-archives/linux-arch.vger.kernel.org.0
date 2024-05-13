Return-Path: <linux-arch+bounces-4364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D718C45AD
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5691C20A9F
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D71CAB1;
	Mon, 13 May 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qi94m12S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB691CFA0
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620083; cv=none; b=ih0mV3WD/masVddhXQE1OteJL9ZZdPJD/XTRhUu4yj1VJvVuqQqjqyAZhYd3/secq/EsQiqh+lxdleOz0ekOcGWqk2w6kqDjgtXMiIJkAvGklz0RqG5eWv7j+a0ml2apxo2hyILLTU+B5bMhxe4Vy6cGlfOPutxXtqu1ZWZ2zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620083; c=relaxed/simple;
	bh=7/xkmDUbYU1LADb1hqA1THAmOqRq/hd0dIZkwWpfkJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQBPxu8KuWGgAV/j1ORCY+T9l4Hs5n5/fKG7/+jtnvpcwz78a5YFZXdvGG01ih5OESnOJ4FDADZjROYCOmb5wwpEeisrTAxv5eUiQFOfKn/ziCapJoyAb7CvNPDAl0BqC27TznUB+F057gMmlH30rHQQXklSJnF9f8KEKXJ6NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qi94m12S; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so3856934b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715620080; x=1716224880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R03ALj5gMTI3HJczT8mvtLqpQZw1vQdw7W4zPWu4U5M=;
        b=qi94m12SXQWlIw1irpiCADxa/u8RNZdQHbZlMYhpFTucz4IVy+pgoKS0+7kNAlVtlH
         I/2kqpA20Ti7bt5rTxk1CWoxZkz/UwSC4eGp4y+7Xr4Gi60VlBmwZsUxoa/K0E4aHk7M
         j8xTOy8rAUTZgkD9DCahmg9zQ902BA9a4/mWlfnIaLqE8wx7CD+yra1AnUvvWd9dzdeR
         X66yyJ2ohcMl7OYHv4bIgN/ACwQZVJ1cJTYd7uvKPdGJ3BM3hlBM7aLmMoSKOY6Vns8h
         nTr9mr3OdlcOqKSyFcCjyFXatSU4IBHeiX+uipG7MlFRossKvXs7XLudQVtCbFWpl8nu
         Sr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620080; x=1716224880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R03ALj5gMTI3HJczT8mvtLqpQZw1vQdw7W4zPWu4U5M=;
        b=KQvBv3VabqNxs6MOcKgk9tuWotvUYrPICRQOwZ8fHbCUGtj+5WzhML9L03dAzLKzE4
         vepz/DNaz+NMMVQtcOSOrQRHloasOXYz5SSFpfo9MwbeSGL4vKdAn85CCJ8782cFgLwx
         tBKPYoNT4lE3xIuhbwr8m6I6RMj5yblS+3FsE3+zQbocnMr/htC6yqg76jLfHGSR3l+r
         +XmJT09AhpSIjjsN4pwwpNCe00pYCJo8H8vhlwG3Mi3TD3y43qwhIVYM1G1SyqUwkfZe
         MMsnYQI6jPnOnH0AOIfINxJKjpwhzQEWT/I1lIBvk1eXH/JGg6pkEs1pzeCqqBs7Jzdv
         /0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWfvQ/N8gq/lZaD5qSqJ9/v65beX0pOb6Fo+MMe7pbmm7Ofu4EqJNyRmC5KlJZeOi6b1+uyHPFxpHgR+LwsLdTWOcwVBUdK8q/o3g==
X-Gm-Message-State: AOJu0YwpZLdgw6JsJHEdJpTEIX9FR/dYd2uyQw15+WH2OSE9OMnVnSmC
	RBL+bFEK5KnMhr+o99xA+tEiuax4lJDQjOZUML+gDyrM7Guun7+pBiHNEQfuCdw=
X-Google-Smtp-Source: AGHT+IGgitRfxdN9c/jkn+3dztyByZuJHDxryLBrfrJDLCggaquJnKcgfWgSQwb6qIcM1QjSPmZaxA==
X-Received: by 2002:a05:6a20:431a:b0:1aa:43f4:3562 with SMTP id adf61e73a8af0-1afde0a98d8mr11383826637.11.1715620079928;
        Mon, 13 May 2024 10:07:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bccsm8222317b3a.170.2024.05.13.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:07:59 -0700 (PDT)
Date: Mon, 13 May 2024 10:07:54 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 27/29] riscv: Documentation for landing pad / indirect
 branch tracking
Message-ID: <ZkJI6lV8du1L+kE2@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-28-debug@rivosinc.com>
 <Zj6D6FqfbnEhcfqs@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zj6D6FqfbnEhcfqs@ghost>

On Fri, May 10, 2024 at 01:30:32PM -0700, Charlie Jenkins wrote:
>On Wed, Apr 03, 2024 at 04:35:15PM -0700, Deepak Gupta wrote:
>> Adding documentation on landing pad aka indirect branch tracking on riscv
>> and kernel interfaces exposed so that user tasks can enable it.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  Documentation/arch/riscv/zicfilp.rst | 104 +++++++++++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>>  create mode 100644 Documentation/arch/riscv/zicfilp.rst
>>
>> diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
>> new file mode 100644
>> index 000000000000..3007c81f0465
>> --- /dev/null
>> +++ b/Documentation/arch/riscv/zicfilp.rst
>> @@ -0,0 +1,104 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +:Author: Deepak Gupta <debug@rivosinc.com>
>> +:Date:   12 January 2024
>> +
>> +====================================================
>> +Tracking indirect control transfers on RISC-V Linux
>> +====================================================
>> +
>> +This document briefly describes the interface provided to userspace by Linux
>> +to enable indirect branch tracking for user mode applications on RISV-V
>> +
>> +1. Feature Overview
>> +--------------------
>> +
>> +Memory corruption issues usually result in to crashes, however when in hands of
>> +an adversary and if used creatively can result into variety security issues.
>> +
>> +One of those security issues can be code re-use attacks on program where adversary
>> +can use corrupt function pointers and chain them together to perform jump oriented
>> +programming (JOP) or call oriented programming (COP) and thus compromising control
>> +flow integrity (CFI) of the program.
>> +
>> +Function pointers live in read-write memory and thus are susceptible to corruption
>> +and allows an adversary to reach any program counter (PC) in address space. On
>> +RISC-V zicfilp extension enforces a restriction on such indirect control transfers
>> +
>> +	- indirect control transfers must land on a landing pad instruction `lpad`.
>> +	  There are two exception to this rule
>> +		- rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
>
>What is a return that is not a return from a function?
Those would be a jump or call (depending on convention of whether return is saved in x1/x5)

>
>> +		  protected using shadow stack (see zicfiss.rst)
>> +
>> +		- rs1 = x7. On RISC-V compiler usually does below to reach function
>> +		  which is beyond the offset possible J-type instruction.
>> +
>> +			"auipc x7, <imm>"
>> +			"jalr (x7)"
>> +
>> +		  Such form of indirect control transfer are still immutable and don't rely
>> +		  on memory and thus rs1=x7 is exempted from tracking and considered software
>> +		  guarded jumps.
>> +
>> +`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` and is a HINT nop. `lpad`
>
>I think this should say "x0" or instead of "rd", or mention that rd=x0.

Yeah I missed that. will fix it.

>
>> +instruction must be aligned on 4 byte boundary and compares 20 bit immediate with x7.
>> +If `imm_20bit` == 0, CPU don't perform any comparision with x7. If `imm_20bit` != 0,
>> +then `imm_20bit` must match x7 else CPU will raise `software check exception`
>> +(cause=18)with `*tval = 2`.
>> +
>> +Compiler can generate a hash over function signatures and setup them (truncated
>> +to 20bit) in x7 at callsites and function proglogs can have `lpad` with same
>
>"prologues" instead of "proglogs"

Will fix it.

>
>> +function hash. This further reduces number of program counters a call site can
>> +reach.
>> +
>> +2. ELF and psABI
>> +-----------------
>> +
>> +Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
>> +`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
>> +
>> +3. Linux enabling
>> +------------------
>> +
>> +User space programs can have multiple shared objects loaded in its address space
>> +and it's a difficult task to make sure all the dependencies have been compiled
>> +with support of indirect branch. Thus it's left to dynamic loader to enable
>> +indirect branch tracking for the program.
>> +
>> +4. prctl() enabling
>> +--------------------
>> +
>> +`PR_SET_INDIR_BR_LP_STATUS` / `PR_GET_INDIR_BR_LP_STATUS` /
>> +`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect branch
>> +tracking. prctls are arch agnostic and returns -EINVAL on other arches.
>> +
>> +`PR_SET_INDIR_BR_LP_STATUS`: If arg1 `PR_INDIR_BR_LP_ENABLE` and if CPU supports
>> +`zicfilp` then kernel will enabled indirect branch tracking for the task.
>> +Dynamic loader can issue this `prctl` once it has determined that all the objects
>> +loaded in address space support indirect branch tracking. Additionally if there is
>> +a `dlopen` to an object which wasn't compiled with `zicfilp`, dynamic loader can
>> +issue this prctl with arg1 set to 0 (i.e. `PR_INDIR_BR_LP_ENABLE` being clear)
>> +
>> +`PR_GET_INDIR_BR_LP_STATUS`: Returns current status of indirect branch tracking.
>> +If enabled it'll return `PR_INDIR_BR_LP_ENABLE`
>> +
>> +`PR_LOCK_INDIR_BR_LP_STATUS`: Locks current status of indirect branch tracking on
>> +the task. User space may want to run with strict security posture and wouldn't want
>> +loading of objects without `zicfilp` support in it and thus would want to disallow
>> +disabling of indirect branch tracking. In that case user space can use this prctl
>> +to lock current settings.
>> +
>> +5. violations related to indirect branch tracking
>> +--------------------------------------------------
>> +
>> +Pertaining to indirect branch tracking, CPU raises software check exception in
>> +following conditions
>> +	- missing `lpad` after indirect call / jmp
>> +	- `lpad` not on 4 byte boundary
>> +	- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
>> +
>> +In all 3 cases, `*tval = 2` is captured and software check exception is raised
>> +(cause=18)
>> +
>> +Linux kernel will treat this as `SIGSEV`` with code = `SEGV_CPERR` and follow
>> +normal course of signal delivery.
>> --
>> 2.43.2
>>

