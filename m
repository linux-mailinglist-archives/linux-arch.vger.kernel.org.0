Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC979F16D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjIMSy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjIMSy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 14:54:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA281986
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 11:54:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fc081cd46so120505b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694631263; x=1695236063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeNR7qwQLkJOVuge8P10O3vzgVEpbjfLDo4ctIHKwbU=;
        b=VdS/pDO4yvsVu/1ahDVz/fvHw92at1jw/ugcmAuDydR4skNEALikzcyS/QQGawmikF
         lmoenMs3SlGwHBNHJUaG/4v+Brd1jfPVGIAjq4ZctQBbK8F5xnek+enffjSfbh2LzWss
         hRVRuovwqGqYJN6cagUD1hRXmz0W3ZBCJZ+FIgTCXHXAcBBWZHxDUpUTcKkDhhI1QsIM
         PZWJjYCFnCarSn7veuCg186TNCiahJlx3v3RZudKgVj7RmbJ9D+p6ta0h2QUjUDzUtwQ
         M6w7r/lnZFac6BnlVIn3tsrninChcSUpd3lulbC3DJTTFcN1KiSd7PykZiN1WF1UUtrJ
         IZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631263; x=1695236063;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeNR7qwQLkJOVuge8P10O3vzgVEpbjfLDo4ctIHKwbU=;
        b=uYtESylw2jrYsmcKeoQKIgRwPlKf+NCNF0bzzlroJCR1EpVgIyXOiuoDkuLuTcgFrE
         hmEki4YqPeG5K4MXRZ2Z/B0KIEeD2wvO/5ZmgOVa/oCjIEzkpYAxscHcr2t/l26z9SGv
         kTEUIjVt1Mvvg5oXfHhXCkuXuAphlavx2VWOET0HBjzwdggM9P3QKzinSC30JZrbla7w
         NMv2uP8dHSrFs3lFDWldPpL/Hk2SbVvPhBsSCRWFlvBrugcNupxOwBI//qurrcSSI5jV
         YpEg3cLKS4Rb2muoqRRhPHNTqEWq1hgsZ7dX/wSd7ojC4ToqTUp+fyVydVc1rk/wdNAJ
         OBlw==
X-Gm-Message-State: AOJu0YwGbDfIByTIKklK+0tpTYXy+f3QrJBdfn1nfWOZdH6dhIyxf0bQ
        dIpml/DJyf3iQXmOhwaMWkeeAg==
X-Google-Smtp-Source: AGHT+IHWJanL/mhSZzKNrnjgZ9a4L8x4QH7mCct+onuawdEUp8h+RhW5cHMtW3sNV708kZgryFVaZg==
X-Received: by 2002:a05:6a21:329c:b0:12e:98a3:77b7 with SMTP id yt28-20020a056a21329c00b0012e98a377b7mr3872648pzb.59.1694631262697;
        Wed, 13 Sep 2023 11:54:22 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001a6d4ea7301sm10765184plg.251.2023.09.13.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:54:21 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:54:21 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Sep 2023 11:54:19 PDT (-0700)
Subject:     Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce ERRATA_THEAD_QSPINLOCK
In-Reply-To: <ae320af5-6cca-4689-aa66-9d0193713d40@app.fastmail.com>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        xiaoguang.xing@sophgo.com, Bjorn Topel <bjorn@rivosinc.com>,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     sorear@fastmail.com
Message-ID: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 06 Aug 2023 22:23:34 PDT (-0700), sorear@fastmail.com wrote:
> On Wed, Aug 2, 2023, at 12:46 PM, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> According to qspinlock requirements, RISC-V gives out a weak LR/SC
>> forward progress guarantee which does not satisfy qspinlock. But
>> many vendors could produce stronger forward guarantee LR/SC to
>> ensure the xchg_tail could be finished in time on any kind of
>> hart. T-HEAD is the vendor which implements strong forward
>> guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
>> with errata help.
>>
>> T-HEAD early version of processors has the merge buffer delay
>> problem, so we need ERRATA_WRITEONCE to support qspinlock.
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> ---
>>  arch/riscv/Kconfig.errata              | 13 +++++++++++++
>>  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
>>  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
>>  arch/riscv/include/asm/vendorid_list.h |  3 ++-
>>  arch/riscv/kernel/cpufeature.c         |  3 ++-
>>  5 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>> index 4745a5c57e7c..eb43677b13cc 100644
>> --- a/arch/riscv/Kconfig.errata
>> +++ b/arch/riscv/Kconfig.errata
>> @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
>>
>>  	  If you don't know what to do here, say "Y".
>>
>> +config ERRATA_THEAD_QSPINLOCK
>> +	bool "Apply T-Head queued spinlock errata"
>> +	depends on ERRATA_THEAD
>> +	default y
>> +	help
>> +	  The T-HEAD C9xx processors implement strong fwd guarantee LR/SC to
>> +	  match the xchg_tail requirement of qspinlock.
>> +
>> +	  This will apply the QSPINLOCK errata to handle the non-standard
>> +	  behavior via using qspinlock instead of ticket_lock.
>> +
>> +	  If you don't know what to do here, say "Y".
>
> If this is to be applied, I would like to see a detailed explanation somewhere,
> preferably with citations, of:
>
> (a) The memory model requirements for qspinlock
> (b) Why, with arguments, RISC-V does not architecturally meet (a)
> (c) Why, with arguments, T-HEAD C9xx meets (a)
> (d) Why at least one other architecture which defines ARCH_USE_QUEUED_SPINLOCKS
>     meets (a)

I agree.

Just having a magic fence that makes qspinlocks stop livelocking on some 
processors is going to lead to a mess -- I'd argue this means those 
processors just don't provide the forward progress guarantee, but we'd 
really need something written down about what this new custom 
instruction aliasing as a fence does.

> As far as I can tell, the RISC-V guarantees concerning constrained LR/SC loops
> (livelock freedom but no starvation freedom) are exactly the same as those in
> Armv8 (as of 0487F.c) for equivalent loops, and xchg_tail compiles to a
> constrained LR/SC loop with guaranteed eventual success (with -O1).  Clearly you
> disagree; I would like to see your perspective.

It sounds to me like this processor might be quite broken: if it's 
permanently holding stores in a buffer we're going to have more issues 
than just qspinlock, pretty much anything concurrent is going to have 
issues -- and that's not just in the kernel, there's concurrent 
userspace code as well.

> -s
>
>> +
>>  endmenu # "CPU errata selection"
>> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
>> index 881729746d2e..d560dc45c0e7 100644
>> --- a/arch/riscv/errata/thead/errata.c
>> +++ b/arch/riscv/errata/thead/errata.c
>> @@ -86,6 +86,27 @@ static bool errata_probe_write_once(unsigned int stage,
>>  	return false;
>>  }
>>
>> +static bool errata_probe_qspinlock(unsigned int stage,
>> +				   unsigned long arch_id, unsigned long impid)
>> +{
>> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_QSPINLOCK))
>> +		return false;
>> +
>> +	/*
>> +	 * The queued_spinlock torture would get in livelock without
>> +	 * ERRATA_THEAD_WRITE_ONCE fixup for the early versions of T-HEAD
>> +	 * processors.
>> +	 */
>> +	if (arch_id == 0 && impid == 0 &&
>> +	    !IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
>> +		return false;
>> +
>> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  static u32 thead_errata_probe(unsigned int stage,
>>  			      unsigned long archid, unsigned long impid)
>>  {
>> @@ -103,6 +124,9 @@ static u32 thead_errata_probe(unsigned int stage,
>>  	if (errata_probe_write_once(stage, archid, impid))
>>  		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
>>
>> +	if (errata_probe_qspinlock(stage, archid, impid))
>> +		cpu_req_errata |= BIT(ERRATA_THEAD_QSPINLOCK);
>> +
>>  	return cpu_req_errata;
>>  }
>>
>> diff --git a/arch/riscv/include/asm/errata_list.h
>> b/arch/riscv/include/asm/errata_list.h
>> index fbb2b8d39321..a696d18d1b0d 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -141,6 +141,26 @@ asm volatile(ALTERNATIVE(						\
>>  	: "=r" (__ovl) :						\
>>  	: "memory")
>>
>> +static __always_inline bool
>> +riscv_has_errata_thead_qspinlock(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
>> +		asm_volatile_goto(
>> +		ALTERNATIVE(
>> +		"j	%l[l_no]", "nop",
>> +		THEAD_VENDOR_ID,
>> +		ERRATA_THEAD_QSPINLOCK,
>> +		CONFIG_ERRATA_THEAD_QSPINLOCK)
>> +		: : : : l_no);
>> +	} else {
>> +		goto l_no;
>> +	}
>> +
>> +	return true;
>> +l_no:
>> +	return false;
>> +}
>> +
>>  #endif /* __ASSEMBLY__ */
>>
>>  #endif
>> diff --git a/arch/riscv/include/asm/vendorid_list.h
>> b/arch/riscv/include/asm/vendorid_list.h
>> index 73078cfe4029..1f1d03877f5f 100644
>> --- a/arch/riscv/include/asm/vendorid_list.h
>> +++ b/arch/riscv/include/asm/vendorid_list.h
>> @@ -19,7 +19,8 @@
>>  #define	ERRATA_THEAD_CMO 1
>>  #define	ERRATA_THEAD_PMU 2
>>  #define	ERRATA_THEAD_WRITE_ONCE 3
>> -#define	ERRATA_THEAD_NUMBER 4
>> +#define	ERRATA_THEAD_QSPINLOCK 4
>> +#define	ERRATA_THEAD_NUMBER 5
>>  #endif
>>
>>  #endif
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index f8dbbe1bbd34..d9694fe40a9a 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
>>  		 * spinlock value, the only way is to change from queued_spinlock to
>>  		 * ticket_spinlock, but can not be vice.
>>  		 */
>> -		if (!force_qspinlock) {
>> +		if (!force_qspinlock &&
>> +		    !riscv_has_errata_thead_qspinlock()) {
>>  			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
>>  		}
>>  #endif
>> --
>> 2.36.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
